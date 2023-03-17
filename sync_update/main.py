import os
import time
import shutil
import threading
import sys
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class Watcher:
    def __init__(self, src_dir, dest_dir):
        self.src_dir = src_dir
        self.dest_dir = dest_dir

    def run(self):
        event_handler = Handler(self.src_dir, self.dest_dir)
        observer = Observer()
        observer.schedule(event_handler, self.src_dir, recursive=True)
        observer.schedule(event_handler, self.dest_dir, recursive=True)
        observer.start()
        try:
            while True:
                time.sleep(5)
        except KeyboardInterrupt:
            observer.stop()
        observer.join()

class Handler(FileSystemEventHandler):
    def __init__(self, dir1, dir2):
        self.dir1 = dir1
        self.dir2 = dir2
        self.pause = False
        self.protect_t = threading.Thread(target=self.protect_thread)
        self.protect_t.start()


    def protect_thread(self):
        while True:
            if self.pause == True:
                time.sleep(0.3)
                self.pause = False

    def confirm_dest_path(self, src_path):
        dest_path = ''
        if src_path.startswith(self.dir1):
            dest_path = src_path.replace(self.dir1, self.dir2)
        elif src_path.startswith(self.dir2):
            dest_path = src_path.replace(self.dir2, self.dir1)
        return dest_path

    def on_created(self, event):
        if self.pause:
            return
        src_path = event.src_path
        dest_path = self.confirm_dest_path(src_path)
        try:
            if os.path.isdir(src_path):
                shutil.copytree(src_path, dest_path)
            else:
                shutil.copy2(src_path, dest_path)
        except:
            pass
        self.pause = True

    def on_deleted(self, event):
        if self.pause:
            return
        src_path = event.src_path
        dest_path = self.confirm_dest_path(src_path)
        try:
            if os.path.isdir(dest_path):
                shutil.rmtree(dest_path)
            else:
                os.remove(dest_path)
        except:
            pass
        self.pause = True

    def on_modified(self, event):
        if self.pause:
            return
        src_path = event.src_path
        dest_path = self.confirm_dest_path(src_path)
        try:
            shutil.copy2(src_path, dest_path)
        except:
            pass
        self.pause = True

    def on_moved(self, event):
        if self.pause:
            return
        src_path = event.src_path
        dest_path = self.confirm_dest_path(src_path)
        try:
            if os.path.exists(dest_path):
                if os.path.isdir(dest_path):
                    shutil.rmtree(dest_path)
                else:
                    os.remove(dest_path)
            if os.path.isdir(src_path):
                shutil.copytree(src_path, dest_path)
            else:
                shutil.copy2(src_path, dest_path)
        except:
            pass
        self.pause = True

if __name__ == '__main__':
    if len(sys.argv) == 3:
        dir1 = sys.argv[1]
        dir2 = sys.argv[2]
        watcher = Watcher(dir1, dir2)
        print(f'对\n{dir1}\n{dir2}\n监听开始')
        watcher.run()
