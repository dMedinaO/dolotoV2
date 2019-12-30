def loadGold(nameFile, net, inDegree, outDegree, tfall, nodeall, threshold):

    #definicion de variables auxiliares
    contTrue = 0
    contNot = 0
    tfs = {}
    outnet = {}
    outnetnodes = {}

    #inicia lectura de archivo
    fileOpen = open(nameFile, 'r')
    line = fileOpen.readline()

    #buffer de lectura
    while line:

        line = fileOpen.readline()
        data = line.replace("\n", "").split("\t")

        if len(data) == 3:#validacion de cantidad de elementos

            tfs.update({data[0]:1})
            tfall.update({data[0]:1})
            nodeall.update({data[0]:1})
            nodeall.update({data[1]:1})

            #evaluacion de la existencia de regulacion gen1 -> gen2
            if float(data[2])> threshold:

                #adicion de elementos al diccionario net
                if data[0] not in net["true"].keys():
                    net["true"].update({data[0]:{data[1]:1}})#no existe se crea con elemento nuevo
                else:
                    net["true"][data[0]].update({data[1]:1})#si existe solo se actualiza la clave del que esta regulando

                #trabajamos con la variable outnet
                if data[0] not in outnet.keys():
                    outnet.update({data[0]:{data[1]:['P', 'A']}})
                else:
                    outnet[data[0]].update({data[1]:['P', 'A']})

                #trabajamos con la variable outnetnodes --> el gen1
                if data[0] not in outnetnodes.keys():
                    outnetnodes.update({data[0]:{data[1]:['TF', 'P']}})
                else:
                    outnetnodes[data[0]].update({data[1]:['TF', 'P']})

                #trabajamos con la variable outnetnodes --> el gen2
                if data[0] not in outnetnodes.keys():
                    outnetnodes.update({data[1]:{data[0]:['nTF', 'P']}})
                else:
                    outnetnodes[data[1]].update({data[0]:['nTF', 'P']})

                #trabajamos con las variables inDegree y outDegree
                if data[1] not in inDegree["true"].keys():
                    inDegree["true"].update({data[1]: []})
                inDegree["true"][data[1]].append(data[0])

                if data[0] not in outDegree["true"].keys():
                    inDegree["true"].update({data[0]: []})
                inDegree["true"][data[0]].append(data[1])

            else:
                if data[0] not in net["true"].keys():
                    net["true"].update({data[0]:{data[1]:0}})
                else:
                    net["true"][data[0]].update({data[1]:0})

    fileOpen.close()
