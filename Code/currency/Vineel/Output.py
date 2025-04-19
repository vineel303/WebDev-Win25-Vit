from pathlib import Path
import shutil
import os
import subprocess
import sys
import zipfile

RESET = "\033[0m"
DIM = "\033[2m"
BOLD = "\033[1m"
MAGENTA = "\033[35m"
YELLOW = "\033[33m"
CYAN = "\033[36m"
BLUE = "\033[34m"
def print_unresolvableError(string):
    print(f"{DIM}Vin: {RESET}{MAGENTA}{BOLD}{string}{RESET}")
def print_resolvableError(string):
    print(f"{DIM}Vin: {RESET}{YELLOW}{BOLD}{string}{RESET}")
def print_process(string):
    print(f"{DIM}Vin: {RESET}{CYAN}{BOLD}{string}{RESET}")
def print_userInput(string):
    print(f"{DIM}Vin: {RESET}{BLUE}{BOLD}{string}{RESET}")
def input_userInput(string):
    return input(f"{DIM}Vin: {RESET}{BLUE}{BOLD}{string}{RESET}")

try:
    from natsort import natsorted
except ImportError:
    print_resolvableError("Python library 'natsort' is not installed. Installing it now.")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "natsort"])
    except subprocess.CalledProcessError as e:
        print_unresolvableError(f"Failed to install 'natsort'. Error: {e}")
        input("The program cannot continue. Press enter to exit.")
        sys.exit(1)
    print_process("Finished installing 'natsort'.")
    from natsort import natsorted

def copyFile(source:Path, destination:Path, printIfSuccess:str, printIfException:str, printIfFileDoesNotExist:str) -> None:
    if source.exists():
        try:
            shutil.copy2(source, destination)
            print_process(printIfSuccess)
        except Exception as e:
            print_unresolvableError(printIfException + ": " + str(e))
    else:
        print_unresolvableError(printIfFileDoesNotExist)

def copyFolder(source:Path, destination:Path, printIfSuccess:str, printIfException:str, printIfFolderDoesNotExist:str) -> None:
    if source.exists():
        try:
            if destination.exists():
                shutil.rmtree(destination)
            shutil.copytree(source, destination)
            print_process(printIfSuccess)
        except Exception as e:
            print_unresolvableError(printIfException + ": " + str(e))
    else:
        print_unresolvableError(printIfFolderDoesNotExist)

def folderToZip(source:Path, destination:Path, printIfSuccess:str, printIfException:str, printIfFileDoesNotExist:str) -> None:
    if source.exists():
        try:
            #main.start

            with zipfile.ZipFile(destination, "w", zipfile.ZIP_DEFLATED) as zipFile:
                for root, folders, files in os.walk(source):
                    folders[:] = natsorted(folders)
                    files = natsorted(files) # doesn't need [:] because each instance of files is being used only once

                    #only needed to add empty folders
                    for folder in folders:
                        folderPath = os.path.join(root, folder)
                        folderPath_inZip = os.path.relpath(folderPath, source) + "/"
                        zipFile.writestr(folderPath_inZip, "")

                    for file in files:
                        filePath = os.path.join(root, file)
                        filePath_inZip = os.path.relpath(filePath, source) # filePath_inZip is relative
                        zipFile.write(filePath, filePath_inZip)

            #main.end
            print_process(printIfSuccess)
        except Exception as e:
            print_unresolvableError(printIfException + ": " + str(e))
    else:
        print_unresolvableError(printIfFileDoesNotExist)

def getDataFrom_pubspecYaml(filePath):
    with open(filePath, "rt") as file:
        lines = file.readlines()
        for i in lines:
            if i.startswith("name: "):
                appName = i.split(":")[1].strip()
            if i.startswith("description: "):
                appDesc = i.split(":")[1].strip()
            if i.startswith("version: "):
                appVersion = i.split(":")[1].strip()
    return appName, appDesc[1:-1], appVersion

def updateDataIn_pubspecYaml(filePath, appName, appDesc, appVersion):
    lines = []
    with open(filePath, "rt") as file:
        lines = file.readlines()
    with open(filePath, "rt") as file:
        for i in lines:
            if i.startswith("name: "):
                file.write(f"name: {appName}")
            elif i.startswith("description: "):
                file.write(f'name: "{appDesc}"')
            elif i.startswith("version: "):
                file.write(f"name: {appVersion}")
            else:
                file.write(i)

if __name__ == "__main__":
    # Getting all folder paths
    thisFolder = Path(__file__).parent.resolve()
    projectFolder = thisFolder.parents[1]
    os.chdir(projectFolder)
    outputFolder = thisFolder / "Output"
    outputFolder.mkdir(exist_ok=True)


    # Updating android details.start
    pubspecYaml_filePath = projectFolder / "pubspec.yaml"
    lastAppName, lastAppDesc, lastAppVersion = getDataFrom_pubspecYaml(pubspecYaml_filePath)

    print("FILL THESE CAREFULLY!")
    print()
    print_userInput(f"Last app name = {lastAppName}.")
    appName = input_userInput("Enter new app name: ")
    print()
    appName_inBundleId = input_userInput("Enter bundleId\appName: com.shirayurivineel.")
    print()
    print_userInput(f"Last app description = {lastAppDesc}.")
    appDesc = input_userInput("Enter new app description: ")
    print()
    print_userInput(f"Last app version = {lastAppVersion}.")
    appVersion = input_userInput("Enter new app version: ")
    print()
    
    subprocess.run('flutter pub global activate rename')
    subprocess.run(f'flutter pub global run rename --appname "{appName}"')
    subprocess.run(f'flutter pub global run rename --bundleId com.shirayuri.{appName_inBundleId}')
    updateDataIn_pubspecYaml(pubspecYaml_filePath, appName, appDesc, appVersion)
    # Updating android details.end


    # Android APK
    #generate releaseObject
    print_process("Generating APK release object.")
    subprocess.run("flutter build apk --release", shell=True)
    print_process("Finished generating APK release object.")
    #copy releaseObject
    source = projectFolder / "build" / "app" / "outputs" / "flutter-apk" / "app-release.apk"
    destination = outputFolder / "Android.apk"
    copyFile(
        source, destination,
        "APK file copied.",
        "Exception while copying the APK file",
        "No APK file found."
    )
    print("--- --- ---")

    # Android AAB
    #generate releaseObject
    print_process("Generating AAB release object.")
    subprocess.run("flutter build appbundle --release", shell=True)
    print_process("Finished generating AAB release object.")
    #copy releaseObject
    source = projectFolder / "build" / "app" / "outputs" / "bundle" / "release" / "app-release.aab"
    destination = outputFolder / "Android.aab"
    copyFile(
        source, destination,
        "AAB file copied.",
        "Exception while copying the AAB file",
        "No AAB file found."
    )
    print("--- --- ---")

    # Windows
    #generate releaseObject
    print_process("Generating EXE release object.")
    subprocess.run("flutter build windows --release", shell=True)
    print_process("Finished generating EXE release object.")
    #copy releaseObject
    source = projectFolder / "build" / "windows" / "x64" / "runner" / "Release"
    destination = outputFolder / "Windows"
    copyFolder(
        source, destination,
        "EXE folder copied.",
        "Exception while copying the EXE folder",
        "No EXE folder found."
    )
    #generate zipFile
    source = destination
    destination = outputFolder / "Windows.zip"
    folderToZip(
        source, destination,
        "EXE folder's zip file created.",
        "Exception while creating the EXE folder's zip file.",
        "No EXE folder found."
    )
    print("--- --- ---")

    # Web
    #generate releaseObject
    print_process("Generating WEB release object.")
    subprocess.run("flutter build web --release", shell=True)
    print_process("Finished generating WEB release object.")
    #copy releaseObject
    source = projectFolder / "build" / "web"
    destination = outputFolder / "Web"
    copyFolder(
        source, destination,
        "WEB folder copied.",
        "Exception while copying the WEB folder",
        "No WEB folder found."
    )
    #generate zipFile
    source = destination
    destination = outputFolder / "Web.zip"
    folderToZip(
        source, destination,
        "WEB folder's zip file created.",
        "Exception while creating the WEB folder's zip file.",
        "No WEB folder found."
    )
    print("--- --- ---")

    # The end
    input("Finished. Press enter to exit.")
