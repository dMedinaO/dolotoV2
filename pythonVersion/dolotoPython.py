import argparse

def printres_gold(dictGraphlet, tf, res, outnetnodes, folder, outfile):
    tmpoutall = ''
    tmpout = ''
    tmpNOG = "TFs not in graphlets:\n"
    tmpoutn = ''
    tmpNOGn = "Genes (no TF) not in graphlets:\n"

    print "\nGRAPHLETS:\n"
    print "Type:",
    tmpoutall  += "\nGRAPHLETS:\n"
    tmpoutall  += "Type:"
    for j in range (13):
        print "\t",
        print str(j+1),
        tmpoutall += "\t"
        tmpoutall += str(j+1)

    print "\ttotal\ncount",
    tmpoutall  += "\ttotal\ncount"
    i = 0
    for j in range (13):
        print "\t",
        print dictGraphlet[j],
        tmpoutall  += "\t"
        tmpoutall  += str(dictGraphlet[j])
        i += dictGraphlet[j]

    print "\t%s\n\n" % str(i)
    tmpoutall  += "\t"+str(i)
    tmpout  += "TFs in graphlets:\nTF"
    for j in range (13):
        tmpout  += "\t"
        tmpout  += str(j+1)

    tmpout  += "\ttotal\n"

    for element in tf:
        if(0 != res["motNode"][element]["true"]["tot"]):
            tmpout  += element
            for j in range(13):
                data = res["motNode"][element]["true"][str(j)]
                tmpout  += "\t%d" % data
            data = res["motNode"][element]["true"]["tot"]
            tmpout = tmpout+ "\t"+str(data)+"\n"
            outnetnodes[element][3] =  res["motNode"][element]["true"]["tot"]
        else:
            tmpNOG = tmpNOG+ element+ "\n"
            outnetnodes[element][3] = 0

        del res["motNode"][element]

	tmpoutn+= "Genes (no TF) in graphlets:\ngene"
    for j in range (6):
        tmpoutn+= "\t"
        tmpoutn+= str(j+1)

	tmpoutn+= "\ttotal\n"

    keysD = res["motNode"].keys()
    keysD.sort()
    for element in keysD:
        if(0 != res["motNode"][element]["true"]["tot"]):
            tmpoutn+= element
            for j in range(6):
                data = res["motNode"][element]["true"][str(j)]
                tmpoutn+= "\t"+str(data)
            data = res["motNode"][element]["true"]["tot"]
            tmpoutn+= "\t"+str(data)+"\n";
            outnetnodes[element][3] = res["motNode"][element]["true"]["tot"]
        else:
            tmpNOGn += element+"\n"
            outnetnodes[element][3] = 0

    #hacemos la escritura en el archivo de texto
    fileExport = open(folder+"/"+outfile, 'w')

    fileExport.write(tmpoutall+"\n\n")
    fileExport.write(tmpNOG+"\n\n")
    fileExport.write(tmpNOGn+"\n\n")
    fileExport.write(tmpout+"\n\n")
    fileExport.write(tmpoutn+"\n\n")

    fileExport.write("GRAPHLETS:\n\n")
    for i in range(13):
        fileExport.write("Type ")
        fileExport.write(str(i+1)+":\n")

        for element in tf:
            try:
                for key in res["true"][element][str(i)]:
                    fileExport.write(element+" "+key+"\n")
            except:
                pass
        fileExport.write("\n")
    fileExport.close()

#funcion que permite identificar el patron o motivo del triplete correspondiente asociado al tipo de graphlet
def dotriplet_noij(value1, value2, value3, value4, value5, key1, key2, key3):

    #$net{"true"}{$i}{$l}, $net{"true"}{$j}{$l}, $net{"true"}{$l}{$j}, $net{"true"}{$j}{$i}, $net{"true"}{$l}{$i}, $i, $j, $l
    arrayResponse = []
    if (key1 != key2) and (key1 != key3) and (key2 != key3):
		if(value1 == 1) and (value2 == 0) and (value3 == 0) and (value4 == 0) and (value5 == 0):#type 1
			arrayResponse = [0,key1,key2,key3]
		elif (value1 == 0) and (value2 == 0) and (value3 == 0) and (value4 == 0) and (value5 == 1):#type 2
			arrayResponse = [1,key1,key2,key3]
		elif (value1 == 1) and (value2 == 0) and (value3 == 0) and (value4 == 1) and (value5 == 0):#type 3
			arrayResponse = [2,key1,key2,key3]
		elif (value1 == 0) and (value2 == 0) and (value3 == 1) and (value4 == 0) and (value5 == 0):#type 4
			arrayResponse = [3,key1,key2,key3]
		elif (value1 == 1) and (value2 == 1) and (value3 == 0) and (value4 == 0) and (value5 == 0):#type 5
			arrayResponse = [4,key1,key2,key3]
		elif (value1 == 1) and (value2 == 1) and (value3 == 0) and (value4 == 1) and (value5 == 0):#type 6
			arrayResponse = [5,key1,key2,key3]
		elif (value1 == 0) and (value2 == 0) and (value3 == 0) and (value4 == 1) and (value5 == 1):#type 7
			arrayResponse = [6,key1,key2,key3]
		elif (value1 == 1) and (value2 == 0) and (value3 == 0) and (value4 == 1) and (value5 == 1):#type 8
			arrayResponse = [7,key1,key2,key3]
		elif (value1 == 0) and (value2 == 1) and (value3 == 0) and (value4 == 0) and (value5 == 1):#type 9
			arrayResponse = [8,key1,key2,key3]
		elif (value1 == 1) and (value2 == 0) and (value3 == 1) and (value4 == 1) and (value5 == 0):#type 10
			arrayResponse = [9,key1,key2,key3]
		elif(value1 == 1 and value2 == 1 and value3 == 1 and value4 == 0 and value5 == 0):#type 11
			arrayResponse = [10,key1,key2,key3]
		elif(value1 == 1 and value2 == 0 and value3 == 1 and value4 == 1 and value5 == 1):#type 12
			arrayResponse = [11,key1,key2,key3]
		elif(value1 == 1 and value2 == 1 and value3 == 1 and value4 == 1 and value5 == 1):#type 13
			arrayResponse = [12,key1,key2,key3]

    return arrayResponse

#funcion que permite encontrar los motivos de graphlets
def findMotives_gold(tf, done, outDegree, net, res):

    donegraph = {}
    dictGraphlet = []
    for i in range(13):
        dictGraphlet.append(0)

    for key1 in tf:
        for key2 in done["true"].keys():
            for key3 in outDegree["true"][key1]:
                try:
                    #obtenemos el valor del triplete
                    response = dotriplet_noij(net["true"][key1][key2], net["true"][key3][key2], net["true"][key2][key3], net["true"][key3][key1], net["true"][key2][key1], key1, key3, key2)
                    keyData = "%s %s %s" % (key1, key2, key3)
                    if len(response) == 4 and keyData not in donegraph.keys():

                        keyData1 = "%s %s %s" % (key1, key2, key3)
                        keyData2 = "%s %s %s" % (key1, key3, key2)
                        keyData3 = "%s %s %s" % (key2, key1, key3)
                        keyData4 = "%s %s %s" % (key2, key3, key1)
                        keyData5 = "%s %s %s" % (key3, key1, key2)
                        keyData6 = "%s %s %s" % (key3, key2, key1)

                        donegraph.update({keyData1:response[0]})
                        donegraph.update({keyData2:response[0]})
                        donegraph.update({keyData3:response[0]})
                        donegraph.update({keyData4:response[0]})
                        donegraph.update({keyData5:response[0]})
                        donegraph.update({keyData6:response[0]})
                        res["motNode"][response[1]]["true"][str(response[0])]+=1
                        res["motNode"][response[2]]["true"][str(response[0])]+=1
                        res["motNode"][response[3]]["true"][str(response[0])]+=1
                        res["motNode"][response[1]]["true"]["tot"]+=1
                        res["motNode"][response[2]]["true"]["tot"]+=1
                        res["motNode"][response[3]]["true"]["tot"]+=1

                        if response[1] not in res["true"]:
                            res["true"].update({response[1]:{}})

                        res["true"][response[1]].update({str(response[0]):{response[2]+" "+response[3]:1}})
                        dictGraphlet[response[0]]+=1#aumentamos el contador
                except:
                    pass

    return dictGraphlet, donegraph

#funcion auxiliar que permite crear el diccionario para los graphlets
def createdDicForGraphles():

    dictData = {}
    for i in range(13):
        dictData.update({str(i):0})

    return dictData

#funcion que permite cargar la red de referencia, genera estructuras de datos para soportar las relaciones y mantener la data de los nodos
def loadGold(referenceFile, threshold, net, outDegree, done, res):

    #variables para la manipulacion de datos
    tf = {}
    outnetnodes = {}
    nodes = []
    contTrue = 0
    contFalse = 0

    #hacemos la lectura de la informacion...
    fileOpen = open(referenceFile, 'r')
    line = fileOpen.readline()

    while line:

        dataInLine = line.replace("\n", "").split("\t")#is a tsv format file
        if len(dataInLine)==3:#validacion de division de elementos correcta

            tf.update({dataInLine[0]:1})
            nodes.append(dataInLine[0])
            nodes.append(dataInLine[1])

            if float(dataInLine[2]) > threshold:
                contTrue+=1
                #trabajamos con la data de elementos en net
                if dataInLine[0] not in net["true"].keys():
                    net["true"].update({dataInLine[0]:{}})
                    net["true"][dataInLine[0]].update({dataInLine[1]:1})
                else:
                    net["true"][dataInLine[0]].update({dataInLine[1]:1})

                #agregamos la informacion al dict done
                if dataInLine[0] not in done["true"].keys():
                    done["true"].update({dataInLine[0]:dataInLine[0]})

                if dataInLine[1] not in done["true"].keys():
                    done["true"].update({dataInLine[1]:dataInLine[1]})

                #trabajamos con el diccionario outDegree....
                if dataInLine[0] not in outDegree["true"].keys():
                    outDegree["true"].update({dataInLine[0]:[]})
                outDegree["true"][dataInLine[0]].append(dataInLine[1])

                #trabajamos con el diccionario res
                dictGrapah = createdDicForGraphles()
                dictGrapah.update({"rec":0})
                dictGrapah.update({"tot":0})

                res["motNode"].update({dataInLine[0]: {"true": dictGrapah}})
                res["motNode"].update({dataInLine[1]: {"true": dictGrapah}})

                #trabajamos con la variable outnetnodes
                outnetnodes.update({dataInLine[0]: ['TF','p',0,0]})#es in array de tamano 2... no se trabaja con numpy para disminuir consumo de recursos
                outnetnodes.update({dataInLine[1]: ['nTF','p',0,0]})#es in array de tamano 2... no se trabaja con numpy para disminuir consumo de recursos

            else:
                contFalse+=1
                if dataInLine[0] not in net["true"].keys():
                    net["true"].update({dataInLine[0]:{}})
                    net["true"][dataInLine[0]].update({dataInLine[1]:0})#la red existe y presenta node1 -> node2 -> 1!
                else:
                    net["true"][dataInLine[0]].update({dataInLine[1]:0})#la red existe y presenta node1 -> node2 -> 1!

        line = fileOpen.readline()
    fileOpen.close()

    #obtenemos los valores finales para hacer el resumen
    tf = tf.keys()
    tf.sort()
    nodes = list(set(nodes))
    print "           \t#TFs\tn\t#P\t#N\n"
    print "REFERENCE :\t%d\t%d\t%d\t%d\n" % (len(tf), len(nodes), contTrue, contFalse)

    return tf, nodes, outnetnodes

#definicion de variables provenientes de consola, se trabajan con argparse para una mejor manipulacion
parser = argparse.ArgumentParser()
#agregamos los parametros de interes
parser.add_argument('--reference', '-g', help='reference file (tsv TF\tGENE\t1)', required=True)
parser.add_argument('--input', '-i', help='input file (tsv TF\tGENE\t1)', default="NO")
parser.add_argument('--threshold', '-t', help='threshold to consider an edge in input file as existing (default 0)', type=float, default=0)
parser.add_argument('--case', '-c', help='case 1 (ref and input contain all TP and TN, only those interactions in ref are considered)\ncase 2 (ref and input contain only all TP, negatives are assumed to happen among all nodes without a true between them, default 2)', type=int, default=2, choices=[1, 2])
parser.add_argument('--folder', '-f', help='folder where the output file will be placed', required=True)
parser.add_argument('--output', '-o', help='name of output file', default='output')

args = parser.parse_args()#compilacion de argparse con las variables definidas

#obtener variables a partir de linea de comando
referenceFile = args.reference
inputFile = args.input
threshold = args.threshold
case = args.case
folder = args.folder
outfile = args.output

#evaluamos si folder viene con / en caso de que si... lo eliminamos
if folder[-1] == "/":
    folder = folder[:-1]

#definicion de variables adicionales asociadas al ID y otros elementos de interes
#variables adicionales
fg_value = referenceFile.split("/")[-1]

if inputFile != "NO":
    ffg_value = inputFile.split("/")[-1]
    id_value = "%s_%s" % (fg_value, ffg_value)
else:
    ffg_value = ""
    id_value = fg_value

#definicion de diccionarios y variables auxiliares
net = {"true": {}, "pred": {}}
outDegree = {"true": {}, "pred": {}}
done = {"true": {}, "pred": {}}
res = {"true": {}, "pred": {}, "mot": {}, "motNode": {}, "gm": [0,0,0,0,0], "global": [0,0,0,0]};#motives

#defincion variables de texto
outtxt = ""
outtxttable = ""

#formato de impresion data input
outtxttable = "\nREFERENCE\t:\t%s\nINPUT\t\t:\t%s\nThreshold\t:\t%.2f\nCase\t\t:\t%d\n\n" % (fg_value, ffg_value, threshold, case)
print outtxttable

#cargamos la data de la red...
tf, nodes, outnetnodes = loadGold(referenceFile, threshold, net, outDegree, done, res)

#hacemos la busqueda de los motivos en base a las referencias entregadas y a las combinaciones generadas...
dictGraphlet, donegraph= findMotives_gold(tf, done, outDegree, net, res)

printres_gold(dictGraphlet, tf, res, outnetnodes, folder, outfile)
