'''
script que permite ejecutar Loto en su version python, con respecto a lo
implementado en su version perl.
'''

import argparse

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
def loadGold(referenceFile, tfall, nodeall, threshold, net, outnet, outnetnodes, res, inDegree, outDegree, done, node, case):

    #obtenemos la informacion del archivo de referencia
    referenceData = readDocFile(referenceFile)

    #definicion de variables a utilizar
    cc = 0;
    cc0 = 0;
    nodes = [];
    tfs = {};

    #recorremos el arreglo y obtenemos los valores asociados a la data de la red
    for element in referenceData:
        if len(element.split("\t")) == 3:#solo si cumple con la cantidad de elementos generados
            dataRow = element.split("\t")

            #obtenemos informacion de los nodos y la data en la red
            tfs.update({dataRow[0]:1})
            tfall.update({dataRow[0]:1})
            nodeall.update({dataRow[0]:1})
            nodeall.update({dataRow[1]:1})

            #preguntamos por el valor si supera el umbral ingresado...
            if float(dataRow[2])>threshold:

                if dataRow[0] not in net["true"].keys():#evaluamos si el nodo existe en el diccionario
                    net["true"].update({dataRow[0]: {}})
                net["true"][dataRow[0]].update({dataRow[1]:1})#actualizamos el valor de la key con respecto al nodo de conexion

                if dataRow[0] not in outnet.keys():
                    outnet.update({dataRow[0]:{}})#generamos el diccionario
                #if dataRow[1] not in outnet[dataRow[0]].keys():
                outnet[dataRow[0]].update({dataRow[1]:['P', 'A']})

                if dataRow[0] not in outnetnodes.keys():
                    outnetnodes.update({dataRow[0]: ['-','-']})#es in array de tamano 2... no se trabaja con numpy para disminuir consumo de recursos
                    outnetnodes[dataRow[0]][0] = 'TF'
                elif outnetnodes[dataRow[0]][0] != 'TF':
                    outnetnodes[dataRow[0]][0] = 'TF'

                if dataRow[1] not in outnetnodes.keys():
                    outnetnodes.update({dataRow[1]: ['-','-']})#es in array de tamano 2... no se trabaja con numpy para disminuir consumo de recursos
                    outnetnodes[dataRow[1]][0] = 'nTF'

                outnetnodes[dataRow[0]][1] = 'P'
                outnetnodes[dataRow[1]][1] = 'P'

                res["motNode"].update({dataRow[0]: {}})
                res["motNode"].update({dataRow[1]: {}})
                res["motNode"][dataRow[0]].update({"true": [0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0]})
                res["motNode"][dataRow[1]].update({"true": [0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,12,0,"rec",0,"tot",0]})
                cc+=1

                if dataRow[1] not in inDegree["true"]:
                    inDegree["true"].update({dataRow[1]: []})

                if dataRow[0] not in outDegree["true"]:
                    outDegree["true"].update({dataRow[0]: []})

                outDegree["true"][dataRow[0]].append(dataRow[1])
                inDegree["true"][dataRow[1]].append(dataRow[0])

            else:
                if case == 1:
                    if dataRow[0] not in net["true"].keys():#evaluamos si el nodo existe en el diccionario
                        net["true"].update({dataRow[0]: {}})
                    net["true"][dataRow[0]].update({dataRow[1]:0})#actualizamos el valor de la key con respecto al nodo de conexion
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
                if element1 not in net["true"].keys():
                    net["true"].update({element1:{}})
                net["true"][element1].update({element2:0})
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

#obtener informacion desde la red input
def loadPred(inputFile):

    #obtenemos la informacion del archivo de input
    inputData = readDocFile(inputFile)

    #definicion de variables temporales
    cc = 0
    cc0 = 0
    nodes = []
    tfs = {}
    node = 0

    #recorremos el arreglo y obtenemos los valores asociados a la data de la red
    for element in inputData:
        if len(element.split("\t")) == 3:#solo si cumple con la cantidad de elementos generados
            dataRow = element.split("\t")

            #obtenemos informacion de los nodos y la data en la red
            tfs.update({dataRow[0]:1})
            tfall.update({dataRow[0]:1})
            nodeall.update({dataRow[0]:1})
            nodeall.update({dataRow[1]:1})



#manipulamos los parametros con argparse para un mejor control de los datos
parser = argparse.ArgumentParser()#esto sustituye a la funcion getopt!!!

#agregamos los parametros de interes
parser.add_argument('--reference', '-g', help='reference file (tsv TF\tGENE\t1)', required=True)
parser.add_argument('--input', '-i', help='rinput file (tsv TF\tGENE\t1)', required=True)
parser.add_argument('--threshold', '-t', help='threshold to consider an edge in input file as existing (default 0)', type=float, default=0)
parser.add_argument('--case', '-c', help='case 1 (ref and input contain all TP and TN, only those interactions in ref are considered)\ncase 2 (ref and input contain only all TP, negatives are assumed to happen among all nodes without a true between them, default 2)', type=int, default=2, choices=[1, 2])
parser.add_argument('--folder', '-f', help='folder where the output file will be placed', required=True)
parser.add_argument('--output', '-o', help='name of output file', default='output')

args = parser.parse_args()

#chequeamos las variables de entrada
referenceFile = args.reference
inputFile = args.input
threshold = args.threshold
case = args.case
folder = args.folder
outfile = args.output

#variables adicionales, REVISAR SI SON NECESARIAS O NO
fg_value = referenceFile.split("/")[-1]
ffg_value = inputFile.split("/")[-1]
id_value = "%s_%s" % (fg_value, ffg_value)

#definicion de variables relevantes para obtener informacion sobre los TFs
tfall= {}#all TFs
nodeall= {}#all TFs
net = {"true": {}, "pred": {}}#tf->gene 1, 0 else /// #p(tf->gene)>threshold 1, 0 else
outnet = {}
outnetnodes={}
res = {"true": {}, "pred": {}, "mot": {}, "motNode": {}, "gm": [0,0,0,0,0], "global": [0,0,0,0]};#motives
inDegree = {"true": {}, "pred": {}}#indegree
outDegree = {"true": {}, "pred": {}}#outDegree
done = {"true": {}, "pred": {}}#all nodes
node=0#contador de nodos
#formato de impresion data input
formatLine = "\nREFERENCE\t:\t%s\nINPUT\t\t:\t%s\nThreshold\t:\t%f\nCase\t\t:\t%d\n\n" % (fg_value, ffg_value, threshold, case)
print formatLine

loadGold(referenceFile, tfall, nodeall, threshold, net, outnet, outnetnodes, res, inDegree, outDegree, done, node, case)
