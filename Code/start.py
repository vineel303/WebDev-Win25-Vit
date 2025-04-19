from subprocess import Popen
from os import chdir
from webbrowser import open as openWeb

chdir(r"D:\000 Temp\del after DAs-3\core\calculator")
Popen("python -m http.server 8080")

chdir(r"D:\000 Temp\del after DAs-3\core\currency")
Popen("python -m http.server 8081")

chdir(r"D:\000 Temp\del after DAs-3\core\forum")
Popen("python -m http.server 8082")

openWeb(r'file:///D:/000 Temp/del after DAs-3/core/index.html')

input("Done")
