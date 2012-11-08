# -*- coding: UTF-8 -*-
'chrome应用扩展辅助程序'
import re
import os
import shutil
import pyinotify
from jinja2 import Environment, FileSystemLoader
from slimit import minify
from slimmer import css_slimmer

class ChromeDev(pyinotify.ProcessEvent):
    'chrome开发工具'
    def __init__(self, src='src', out='out', debug = False, ver=0):
        self.env = Environment(loader=FileSystemLoader([
            '/',
            os.path.join(os.getcwd(), 'src'), ]))
        self.debug = debug
        if debug:
            print '开发模式，不压缩js、css和html'
        self.ver = ver + 1
        self.src = os.path.join(os.getcwd(), src)
        print '监听目录 %s' % self.src
        self.out = os.path.join(os.getcwd(), out)
        print '输出目录 %s' % self.out
        print '初始化chrome开发工具'

    def process_IN_DELETE(self, event):
        '删除'
        src = event.pathname
        delfile = '%s%s' % (self.out, event.pathname[len(self.src):])
        if os.path.isfile(delfile):
            print '删除 %s' % delfile
            os.remove(delfile)
        if os.path.isdir(delfile):
            print '删除 %s' % delfile
            shutil.rmtree(delfile)

    def process_IN_CLOSE_WRITE(self, event):
        '修改'
        self.copy(event.pathname)

    def build(self):
        '建设'
        if os.path.isdir(self.out):
            print '删除输出目录'
            shutil.rmtree(self.out)

        print '整体目录构建'
        list_dirs = os.walk(self.src)
        for root, dirs, files in os.walk(self.src):
            for f in files:
                self.copy(os.path.join(root, f))

    def copy(self, src):
        '复制'
        des = '%s%s' % (self.out, src[len(self.src):])
        type = os.path.splitext(src)[1]
        commands = self.get_commands()
        if type in commands:
            commands[type](src, des)
        else:
            self._copy(src, des)

    def _ignore(self, src, des):
        '忽略'
        print '忽略 %s' % src

    def run(self):
        print '运行开发工具'
        wm = pyinotify.WatchManager()
        mask = pyinotify.IN_DELETE | pyinotify.IN_CLOSE_WRITE
        notifier = pyinotify.Notifier(wm, self)
        wdd = wm.add_watch(self.src, mask, rec=True, auto_add=True)
        print '监听开始'
        notifier.loop()

    def _compress(self, html):
        "HTML文本压缩"
        if self.debug:
            return html
        print '文本压缩'
        ret = ' '.join(html.split())
        return re.sub('<!--(.|[\r\n])*?-->', '', ret)

    def _html(self, src, des):
        'html输出'
        self._mkdir(des)
        print '生成html 文件 %s' % des
        template = self.env.get_template(src)
        data = template.render(ver=self.ver)
        des_file = open(des, 'w')
        des_file.write(self._compress(data.encode('utf-8')))
        des_file.close()

    def _js(self, src, des):
        'js 压缩'
        if self.debug:
            self._copy(src, des)
            return
        self._mkdir(des)
        print '压缩js 文件 %s' % des
        src_file = open(src, 'r')
        data = src_file.read()
        src_file.close()
        des_file = open(des, 'w')
        des_file.write(minify(data, mangle=True))
        des_file.close()
        #os.system('java -jar ~/tools/yuicompressor-2.4.7.jar --type js -o %s %s' % (des, src))

    def _css(self, src, des):
        'css 压缩'
        if self.debug:
            self._copy(src, des)
            return
        self._mkdir(des)
        print '压缩css 文件 %s' % des
        src_file = open(src, 'r')
        data = src_file.read()
        src_file.close()
        des_file = open(des, 'w')
        des_file.write(css_slimmer(data))
        des_file.close()
        #os.system('java -jar ~/tools/yuicompressor-2.4.7.jar --type css -o %s %s' % (des, src))

    def _mkdir(self, des):
        '创建目录'
        dir = os.path.split(des)[0]
        if not os.path.isdir(dir):
            print '创建目录 %s' % dir
            os.makedirs(dir)

    def _copy(self, src, des):
        '复制文件'
        self._mkdir(des)
        print 'copy %s to %s' % (src, des)
        shutil.copy(src, des)

    def get_commands(self):
        '返回命令字典'
        return {
                '.css': self._css,
                '.js': self._js,
                '.html': self._html,
                '.htm': self._ignore,
                '.json': self._html,
                }
