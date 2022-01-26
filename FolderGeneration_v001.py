
import datetime
import math
import os
import sys

######FUNCTIONS######

def shotGen(_ProjDrive, _projectNameFull):

    projectPath = _ProjDrive + "/" + _projectNameFull
    #print ("projectPath = " + projectPath)
    dirStructure = []
    dirStructure.append("/01-Projects")
    dirStructure.append("/02-Renders")
    dirStructure.append("/03-PreProduction")
    dirStructure.append("/04-Production")
    dirStructure.append("/05-FX")
    dirStructure.append("/06-Rushes")
    dirStructure.append("/07-Personal")
    dirStructure.append("/08-Dev")
    dirStructure.append("/Archive")
    dirStructure.append("/01-Projects/2D")
    dirStructure.append("/01-Projects/3D")
    dirStructure.append("/01-Projects/3dVista")
    dirStructure.append("/01-Projects/AfterEffects")
    dirStructure.append("/01-Projects/Nuke")
    dirStructure.append("/01-Projects/Premiere")
    dirStructure.append("/01-Projects/2D/Illustrator")
    dirStructure.append("/01-Projects/2D/PSD")
    dirStructure.append("/01-Projects/3D/ASSETS")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers")
    dirStructure.append("/01-Projects/3D/SCENES")
    dirStructure.append("/01-Projects/3D/Textures")
    dirStructure.append("/01-Projects/3D/ASSETS/LightAndCameraRigs")
    dirStructure.append("/01-Projects/3D/ASSETS/Models")
    dirStructure.append("/01-Projects/3D/ASSETS/Rigs")
    dirStructure.append("/01-Projects/3D/ASSETS/Zbrush")
    dirStructure.append("/01-Projects/3D/ASSETS/LightAndCameraRigs/Archive")
    dirStructure.append("/01-Projects/3D/ASSETS/Models/Characters")
    dirStructure.append("/01-Projects/3D/ASSETS/Models/Environments")
    dirStructure.append("/01-Projects/3D/ASSETS/Models/Props")
    dirStructure.append("/01-Projects/3D/ASSETS/Models/Characters/Archive")
    dirStructure.append("/01-Projects/3D/ASSETS/Models/Environments/Archive")
    dirStructure.append("/01-Projects/3D/ASSETS/Models/Props/Archive")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers/ABC")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers/FBX")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers/Max")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers/Proxies")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers/ABC/Archive")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers/FBX/Archive")
    dirStructure.append("/01-Projects/3D/ExportsAndTransfers/Proxies/Archive")
    dirStructure.append("/01-Projects/3D/Textures/HDRI")
    dirStructure.append("/01-Projects/3D/Textures/MaterialLibraries")
    dirStructure.append("/01-Projects/3D/Textures/ProductionTextures")
    dirStructure.append("/01-Projects/3dVista/Builds")
    dirStructure.append("/01-Projects/3dVista/Projects")
    dirStructure.append("/01-Projects/Nuke/Scenes")
    dirStructure.append("/01-Projects/Nuke/Tests")
    dirStructure.append("/01-Projects/Premiere/TimelineExports")
    dirStructure.append("/02-Renders/2D")
    dirStructure.append("/02-Renders/3D")
    dirStructure.append("/02-Renders/3dVista")
    dirStructure.append("/02-Renders/AfterEffects")
    dirStructure.append("/02-Renders/Animatic")
    dirStructure.append("/02-Renders/FullLengthRenders")
    dirStructure.append("/02-Renders/Nuke")
    dirStructure.append("/02-Renders/Premiere")
    dirStructure.append("/02-Renders/RenderedShots")
    dirStructure.append("/02-Renders/2D/Final")
    dirStructure.append("/02-Renders/2D/Tests")
    dirStructure.append("/02-Renders/3D/Final")
    dirStructure.append("/02-Renders/3D/HDRI")
    dirStructure.append("/02-Renders/3D/Tests")
    dirStructure.append("/02-Renders/3dVista/CharacterVideos")
    dirStructure.append("/02-Renders/3dVista/HotspotContent")
    dirStructure.append("/02-Renders/3dVista/Images")
    dirStructure.append("/02-Renders/3dVista/Images/Backgrounds")
    dirStructure.append("/02-Renders/3dVista/Images/Icons")
    dirStructure.append("/02-Renders/AfterEffects/Final")
    dirStructure.append("/02-Renders/AfterEffects/Tests")
    dirStructure.append("/02-Renders/Animatic/FullAnimatic")
    dirStructure.append("/02-Renders/Animatic/Shots")
    dirStructure.append("/02-Renders/FullLengthRenders/Final")
    dirStructure.append("/02-Renders/FullLengthRenders/Tests")
    dirStructure.append("/02-Renders/Nuke/Final")
    dirStructure.append("/02-Renders/Nuke/Tests")
    dirStructure.append("/02-Renders/Premiere/Final")
    dirStructure.append("/02-Renders/Premiere/Tests")
    dirStructure.append("/02-Renders/RenderedShots/Final")
    dirStructure.append("/02-Renders/RenderedShots/Tests")
    dirStructure.append("/03-PreProduction/CharacterDesign")
    dirStructure.append("/03-PreProduction/Moodboards")
    dirStructure.append("/03-PreProduction/SetDesign")
    dirStructure.append("/03-PreProduction/Storyboards")
    dirStructure.append("/04-Production/Audio")
    dirStructure.append("/04-Production/InternalAssets")
    dirStructure.append("/04-Production/IT")
    dirStructure.append("/04-Production/Scripts")
    dirStructure.append("/04-Production/ThirdPartyAssets")
    dirStructure.append("/04-Production/TitleCards")
    dirStructure.append("/04-Production/Audio/Interviews")
    dirStructure.append("/04-Production/Audio/Music")
    dirStructure.append("/04-Production/Audio/SFX")
    dirStructure.append("/04-Production/Audio/VoiceOver")
    dirStructure.append("/04-Production/Audio/Music/Final")
    dirStructure.append("/04-Production/Audio/Music/Old")
    dirStructure.append("/04-Production/Audio/VoiceOver/Pro")
    dirStructure.append("/04-Production/Audio/VoiceOver/Scratch")
    dirStructure.append("/04-Production/Audio/VoiceOver/Pro/Shots")
    dirStructure.append("/04-Production/Audio/VoiceOver/Scratch/Shots")
    dirStructure.append("/04-Production/Scripts/Current")
    dirStructure.append("/04-Production/Scripts/Old")
    dirStructure.append("/04-Production/Scripts/ReferencedFiles")
    dirStructure.append("/04-Production/ThirdPartyAssets/StockFootage")
    dirStructure.append("/04-Production/ThirdPartyAssets/StockPhotos")
    dirStructure.append("/05-FX/Caches")
    dirStructure.append("/05-FX/FXProjects")
    dirStructure.append("/06-Rushes/360Files")
    dirStructure.append("/06-Rushes/Shoots")
    dirStructure.append("/07-Personal/Eoin")
    dirStructure.append("/07-Personal/Jaime")
    dirStructure.append("/07-Personal/Jamie")
    dirStructure.append("/07-Personal/Jimmy")
    dirStructure.append("/07-Personal/Keith")
    dirStructure.append("/07-Personal/Sabina")
    dirStructure.append("/07-Personal/SimonG")
    dirStructure.append("/07-Personal/SimonO")
    dirStructure.append("/08-Dev/Unity")
    dirStructure.append("/08-Dev/Unreal")


    isExist = os.path.isdir(projectPath)
    if isExist == False:
        for ds in dirStructure:
            try:
                outputDir = projectPath + ds
                os.makedirs(outputDir, exist_ok=True)
                #print(outputDir)
            except OSError as err:
                print("error making directory")
                pass
    else:
        print("Project Folder already exists exist")


######DATE######
cd = datetime.datetime.now()

yearString = cd.year
yearList = [(yearString//(10**i))%10 for i in range(math.ceil(math.log(yearString, 10))-1, -1, -1)]
yearTens = str(yearList[2])
yearUnits = str(yearList[3])

fillMonth = str(cd.month).zfill(2)
fillDay = str(cd.day).zfill(2)

yearShort = str(yearList[2]) + str(yearList[3])
currentdate = yearShort + fillMonth + fillDay

#projDriveLetter = input("Enter Drive Letter: ")
#projDrive = projDriveLetter + ":"


######JobCode######
JobCode = input("Enter Job Code - formatted to:ABC123: ")
#JobCode = "ABC123"


######JobName######
JobName = input("Enter Job Name - No Underscores: ")
#JobName = "TestJobName"

rootFolder = currentdate + "_" + JobCode + "_" + JobName
projDrive = sys.argv[1]


shotGen(projDrive, rootFolder)
