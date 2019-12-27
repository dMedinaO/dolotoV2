import argparse

#funcion auxiliar que permite revisar si existe una key en un diccionario, return 0 en caso default
def checkKeyInDict(key1, key2, dictNet):

    response=0
    try:
        response = dictNet[key1][key2]
    except:
        response=0
        pass

    return response

#funcion que permite obtener el tipo de graphlet, si es que existe uno entre los tres nodos
def dotriplet_noij(node1, node2, node3, dictNet):

    #pregunto si estan definidas y me quedo solo con ellas... por default el resto es 0
    v1_v3 = checkKeyInDict(node1, node3, dictNet)
    v1_v2 = checkKeyInDict(node1, node2, dictNet)
    v2_v1 = checkKeyInDict(node2, node1, dictNet)
    v2_v3 = checkKeyInDict(node2, node3, dictNet)
    v3_v1 = checkKeyInDict(node3, node1, dictNet)
    v3_v2 = checkKeyInDict(node3, node2, dictNet)

    #formamos un string y obtenemos el tipo de graphlet
    stringdata = "0"+str(v1_v2)+str(v1_v3)+str(v2_v1)+"0"+str(v2_v3)+str(v3_v1)+str(v3_v2)+"0"
    type=0
    if stringdata == "010000000":#g1->g2
        type=1
    elif stringdata == "001000000":#g1->g3
        type=2
    elif stringdata == "000100000":#g2->g1
        type=3
    elif stringdata == "000001000":#g2->g3
        type=4
    elif stringdata == "000000100":#g3->g1
        type=5
    elif stringdata == "000000010":#g3->g2
        type=6
    elif stringdata == "011000000":#g1->g2 g1->g3
        type=7
    elif stringdata == "000101000":#g2->g1 g2->g3
        type=8
    elif stringdata == "000000110":#g3-> g1 g3->g2
        type=9
    elif stringdata == "000100100":#g2->g1 g3->g1
        type=10
    elif stringdata == "010000100":#g1->g2 g3->g1
        type=11
    elif stringdata == "001100000":#g1->g3 g2->g1
        type=12
    else:
        type=13

    return type

def findMotives_gold(nodesIn, allNodes, dictNet):

    contGraphlet = []
    for i in range(13):
        contGraphlet.append(0)

    for node1 in nodesIn:
        for node2 in allNodes:
            for node3 in dictNet[node1]:
                if (node1 != node2) and (node1 != node3) and (node2 != node3):#los nodos deben ser distintos!!!
                    #evaluamos la existencia de graphlet y su tipo en base a esta combinacion
                    response = dotriplet_noij(node1, node2, node3, dictNet)
                    contGraphlet[response-1]+=1

    print contGraphlet

#funcion que permite cargar la red de referencia, genera estructuras de datos para soportar las relaciones y mantener la data de los nodos
#inputs: referenceFile => archivo red de referencia, threshold => umbral minimo de aceptacion dos genes se encuentran regulados
def loadGold(referenceFile, threshold):

    #hacemos la lectura del archivo de referencia
    fileData = open(referenceFile, 'r')
    line = fileData.readline()
    nodesIn = []
    nodesOut = []
    dictNet = {}
    contEdge = 0
    contNotEdge = 0
    while line:

        dataInLine = line.replace("\n", "").split("\t")#reemplazar y dividir

        if len(dataInLine) == 3:#validacion para poseer tres elementos en array --> gen1;gen2;value
            nodesIn.append(dataInLine[0])
            nodesOut.append(dataInLine[1])

            if float(dataInLine[2])>threshold:
                if dataInLine[0] not in dictNet.keys():
                    dictNet.update({dataInLine[0]:{}})
                dictNet[dataInLine[0]].update({dataInLine[1]:1})
                contEdge+=1
            else:
                if dataInLine[0] not in dictNet.keys():
                    dictNet.update({dataInLine[0]:{}})
                dictNet[dataInLine[0]].update({dataInLine[1]:0})
                contNotEdge+=1

        line = fileData.readline()

    nodesIn = list(set(nodesIn))
    nodesOut = list(set(nodesOut))

    allNodes = list(set(nodesIn+nodesOut))
    print len(allNodes), " All nodes"
    print len(list(set(nodesIn))), " Nodes In"
    print len(list(set(nodesOut))), " Nodes Out"
    print contEdge, " edges in graph"
    print  contNotEdge, " not edges in graph"

    fileData.close()

    return allNodes, nodesIn, nodesOut, contEdge, contNotEdge, dictNet

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

#definicion de variables adicionales asociadas al ID y otros elementos de interes
#variables adicionales
fg_value = referenceFile.split("/")[-1]

if inputFile != "NO":
    ffg_value = inputFile.split("/")[-1]
    id_value = "%s_%s" % (fg_value, ffg_value)
else:
    ffg_value = ""
    id_value = fg_value

#defincion variables de texto
outtxt = ""
outtxttable = ""

#formato de impresion data input
outtxttable = "\nREFERENCE\t:\t%s\nINPUT\t\t:\t%s\nThreshold\t:\t%.2f\nCase\t\t:\t%d\n\n" % (fg_value, ffg_value, threshold, case)
print outtxttable

#cargamos la data de la red...
allNodes_gold, nodesIn_gold, nodesOut_gold, contEdge_gold, contNotEdge_gold, dictNet_gold = loadGold(referenceFile, threshold)

#hacemos la busqueda de los motivos en base a las referencias entregadas y a las combinaciones generadas...
findMotives_gold(nodesIn_gold, allNodes_gold, dictNet_gold)
