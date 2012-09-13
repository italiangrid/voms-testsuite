import os
import sys

class MyLibrary:

  def __init__(self):
    self._status = ''

  def _run_command(self, command, *args):
        process = os.popen(command)
        self._status = process.read().strip()
        process.close()
