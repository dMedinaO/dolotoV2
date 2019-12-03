import argparse

def loadGold(referenceFile):

    #definicion de variables de temporales
    cc = 0
	cc0 = 0
	nodes = []
	tfs = {}
    
    #hacemos lectura del archivo
    fileOpen = open(referenceFile, 'r')
    lineData = fileOpen.readline()

    while lineData:

        rowInFile = lineData.replace("\n").split("\t")


    fileOpen.close()


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

#chequeamos las variables de entrada
referenceFile = args.reference
inputFile = args.input
threshold = args.threshold
case = args.case
folder = args.folder
outfile = args.output
