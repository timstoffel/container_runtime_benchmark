import yaml
import os

# WORK IN PROGRESS - script that gets all variables from all inventories to compare them.

# Set the directory you want to start from
rootDir = '../inventories'

inventories = dict()

for inventory in os.listdir(rootDir):

    current_inventory = rootDir + os.sep + inventory
    variables = {}

    for dirName, subdirList, fileList in os.walk(current_inventory):
        for name in fileList:
            if name.endswith(".yml") and name != "hosts.yml" and name != "vault.yml":
                with open(dirName + os.sep + name, 'r') as stream:
                    try:
                        data = yaml.load(stream)
                        variables.update(data)
                    except Exception as exc:
                        print(exc)

    inventories[inventory] = variables

print inventories

