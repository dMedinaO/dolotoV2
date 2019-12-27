'''
script que permite ejecutar Loto en su version python, con respecto a lo
implementado en su version perl.
'''

import argparse

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

#funcion auxiliar que permite formar la key correspondiente
def createKeyData(arrayElement, pos1, pos2, pos3):

    keyData = "%s %s %s" % (arrayElement[pos1], arrayElement[pos2], arrayElement[pos3])
    return keyData

#funcion que permite encontrar los motivos en red gold
def findMotives_gold(tf, done, outDegree, net, res):
    donegraph = {}
    contError=0
    contOK=0
    #i= key1 l=key2 j=key3
    for key1 in tf:
        for key2 in done['true']:
            for key3 in outDegree["true"][key1]:
                try:
                    responseTriplete = dotriplet_noij(net["true"][key1][key2], net["true"][key3][key2], net["true"][key2][key3], net["true"][key3][key1], net["true"][key2][key1], key1, key3, key2)
                    print responseTriplete
                    contOK+=1
                except:
                    contError+=1
    print contOK, " --- ", contError

    return donegraph

#funcion que permite leer un archivo y retornar un array con la data del documento...
def readDocFile(docFile):

    dataInFile = []
    fileOpen = open(docFile, 'r')

    line = fileOpen.readline()

    while line:
        dataInFile.append(line.replace("\n", ""))
        line = fileOpen.readline()
    fileOpen.close()

    return dataInFile

#obtener informacion desde la red de referencia
def loadGold(referenceFile, tfall, nodeall, threshold, net, outnet, outnetnodes, res, inDegree, outDegree, done, node, case, tf):

    #definicion de variables auxiliares a utilizar
    cc = 0
    cc0 = 0
    nodes = []
    tfs = {}

    dataInFile = readDocFile(referenceFile)#lectura de documento

    for element in dataInFile:
        dataRow = element.replace("\n", "").split("\t")

        if len(dataRow) == 3:#solo si cumple con la cantidad de elementos generados

            #obtenemos informacion de los nodos y la data en la red, adicionando como 1 cuando nodo existe
            tfs.update({dataRow[0]:1})
            tfall.update({dataRow[0]:1})
            nodeall.update({dataRow[0]:1})
            nodeall.update({dataRow[1]:1})

            #preguntamos por el valor si supera el umbral ingresado...
            if float(dataRow[2])>threshold:

                net["true"].update({dataRow[0]: {dataRow[1]:1}})#la red existe y presenta node1 -> node2 -> 1!
                outnet.update({dataRow[0]:{dataRow[1]:['P', 'A']}})#generamos el diccionario
                outnetnodes.update({dataRow[0]: ['TF','p']})#es in array de tamano 2... no se trabaja con numpy para disminuir consumo de recursos
                outnetnodes.update({dataRow[1]: ['nTF','p']})#es in array de tamano 2... no se trabaja con numpy para disminuir consumo de recursos

                res["motNode"].update({dataRow[0]: {"true": [0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0]}})
                res["motNode"].update({dataRow[1]: {"true": [0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0]}})
                cc+=1

                if dataRow[1] not in inDegree["true"].keys():
                    inDegree["true"].update({dataRow[1]: []})

                if dataRow[0] not in outDegree["true"].keys():
                    outDegree["true"].update({dataRow[0]: []})

                outDegree["true"][dataRow[0]].append(dataRow[1])
                inDegree["true"][dataRow[1]].append(dataRow[0])

            else:
                if case == 1:
                    net["true"].update({dataRow[0]: {dataRow[1]:0}})
                    cc0+=1

            if dataRow[0] not in done["true"].keys():
                node+=1
                done["true"].update({dataRow[0]:dataRow[0]})

            if dataRow[1] not in done["true"].keys():
                node+=1
                done["true"].update({dataRow[1]:dataRow[1]})

    if case == 2:
        for element1 in done["true"]:
            for element2 in done["true"]:
                net["true"].update({element1:{element2:0}})
                cc0+=1

    tf = tfs.keys()
    tf.sort()
    tmp = len(tf)
    TNG  = cc0
    print "           \t#TFs\tn\t#P\t#N\n"
    print "REFERENCE :\t%d\t%d\t%d\t%d\n" % (tmp, node, cc, cc0)
    #$outtxttable .= "      \t#TFs\tn\t#P\t#N\n";
    #$outtxttable .= "REFERENCE :\t$tmp\t$node\t$cc\t$cc0\n";
    #$countgl[0] = $cc;
    return cc, cc0, nodes, tfs, tf

#manipulamos los parametros con argparse para un mejor control de los datos
parser = argparse.ArgumentParser()#esto sustituye a la funcion getopt!!!

#agregamos los parametros de interes
parser.add_argument('--reference', '-g', help='reference file (tsv TF\tGENE\t1)', required=True)
parser.add_argument('--input', '-i', help='input file (tsv TF\tGENE\t1)', required=True)
parser.add_argument('--threshold', '-t', help='threshold to consider an edge in input file as existing (default 0)', type=float, default=0)
parser.add_argument('--case', '-c', help='case 1 (ref and input contain all TP and TN, only those interactions in ref are considered)\ncase 2 (ref and input contain only all TP, negatives are assumed to happen among all nodes without a true between them, default 2)', type=int, default=2, choices=[1, 2])
parser.add_argument('--folder', '-f', help='folder where the output file will be placed', required=True)
parser.add_argument('--output', '-o', help='name of output file', default='output')

args = parser.parse_args()

#variables desde linea de comando
referenceFile = args.reference
inputFile = args.input
threshold = args.threshold
case = args.case
folder = args.folder
outfile = args.output

#variables adicionales
fg_value = referenceFile.split("/")[-1]
ffg_value = inputFile.split("/")[-1]
id_value = "%s_%s" % (fg_value, ffg_value)

#definicion de diccionarios
net = {"true": {}, "pred": {}}#tf->gene 1, 0 else /// #p(tf->gene)>threshold 1, 0 else
inDegree = {"true": {}, "pred": {}}#indegree
outDegree = {"true": {}, "pred": {}}#outDegree
done = {"true": {}, "pred": {}}#all nodes
res = {"true": {}, "pred": {}, "mot": {}, "motNode": {}, "gm": [0,0,0,0,0], "global": [0,0,0,0]};#motives

#definicion de arreglos
tf = []#true TFs
tf0 = []#pred TFs

#definicion diccionarios auxiliares
tfall= {}#all TFs
nodeall= {}#all TFs
outnet = {}
outnetnodes={}
countt = {}#motive counts
countp = {}
countlist = {}#to store lists of graphlets TP, FP and FN

#contadores y array de contadores
node=0#contador de nodos
TNG = 0#contador
countgl = [0,0]

#defincion variables de formato
colorTFTP = '#ff6f00'
colorTFFN = '#bf008f'
colorTFFP = '#ffb300'
colorEFTP = '#0276cf'
colorEFFN = '#3b3176'
colorEFFP = '#ffffff'
coloredgeTP = '#000000'
coloredgeFN = '#bf008f'
coloredgeFP = '#ffb300'

#defincion variables de texto
outtxt = ""
outtxttable = ""

#formato de impresion data input
formatLine = "\nREFERENCE\t:\t%s\nINPUT\t\t:\t%s\nThreshold\t:\t%f\nCase\t\t:\t%d\n\n" % (fg_value, ffg_value, threshold, case)
print formatLine

cc_gold, cc0_gold, nodes_gold, tfs_gold, tf = loadGold(referenceFile, tfall, nodeall, threshold, net, outnet, outnetnodes, res, inDegree, outDegree, done, node, case, tf)

donegraph = findMotives_gold(tf, done, outDegree, net, res)
