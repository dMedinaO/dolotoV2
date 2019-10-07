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

def loadGold(referenceFile):

    #obtenemos la informacion del archivo de referencia
    referenceData = readDocFile(referenceFile)

    print referenceData[0]

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

#formato de impresion data input
formatLine = "\nREFERENCE\t:\t%s\nINPUT\t\t:\t%s\nThreshold\t:\t%f\nCase\t\t:\t%d\n\n" % (fg_value, ffg_value, threshold, case)
print formatLine

loadGold(referenceFile)
