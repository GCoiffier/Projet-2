import random
import sys

ope = ["\/", "/\\", "X", "<=>", "=>", "~"]

def cl(L): #fait une close de ET!! de la liste L
	string = "("
	k=1
	for i in L:
		if k==1:
			k=0
		else:
			string+=ope[1]
		string += str(i)
	return string + ")"

def cl_ou(L):
	string = "("
	k=1
	for i in L:
		if k==1:
			k=0
		else:
			string+=ope[0]
		string += str(i)
	return string + ")"

def impair(n):
	if n==2:
		return "("+cl([1,-2])+ope[0]+cl([-1,2])+")"
	elif n==1:
		return "1"
	else:
		str2 = parite(n-2)
		str1 = impair(n-2)
		return "((("+cl([n-1,n])+ope[0]+cl([1-n,-n])+")"+ope[1]+str1+")"+ope[0]+"(("+cl([n-1,-n])+ope[0]+cl([1-n,n])+")"+ope[1]+str2+"))"

def parite(n):
	if n==2:
		return "("+cl([1,2])+ope[0]+cl([-1,-2])+")"
	elif n==1:
		return "-1"
	else:
		str1 = parite(n-2)
		str2 = impair(n-2)
		return "((("+cl([n-1,n])+ope[0]+cl([1-n,-n])+")"+ope[1]+str1+")"+ope[0]+"(("+cl([n-1,-n])+ope[0]+cl([1-n,n])+")"+ope[1]+str2+")))"

def add_1bit(e1, e2, s, re, rs) : #additioneur 1bit et c'est deja pas beau
	string = "("+str(s)+"<=>"+cl([e1,-e2,-re])+ope[0]+cl([-e1,e2,-re])+ope[0]+cl([-e1,-e2,re])+ope[0]+cl([e1,e2,re])+")"
	return string+ope[1]+"("+str(rs)+"<=>"+cl([e1,e2])+ope[0]+cl([e1,re])+ope[0]+cl([e2,re]) + ")"

def additionneur(n) : #nombre1 de 1 à n nombre2 de n+1 à 2n, sortie de 2n+1 à 3n et retenue de 3n+1 à 4n
	string = "("+str(n+n+1)+"<=>"+cl([1,-(n+1)])+ope[0]+cl([-1,n+1])+")"+ope[1]+"("+str(3*n+1)+"<=>"+cl([1,n+1])+")"
	#on met le premier additioneur qui est plus simple
	for i in range(2,n+1):
		string += ope[1] + add_1bit(i,n+i,n+n+i,3*n+(i-1),3*n+i)
	return string+" 0"

def mult_1bit(): #je refuse de la faire pour n ^^ 1 et 2 entree 3 sortie
	return str(1)+ope[1]+str(2)

def rotation(n): # 1 à n entree, n+1 à 2n sortie
	string = ""
	for i in range(1,n):
		string += "("+str(i)+"<=>"+str(n+i+1)+")"+ope[1]
	return string + "("+str(n)+"<=>"+str(n+1)+")"

def cl_oubis(L1,L2):
	string = "("
	k=1
	for i in range(len(L1)):
		if k==1:
			k=0
		else:
			string+=ope[0]
		string += "("+str(L1[i])+ope[1]+str(L2[i])+")"
	return string + ")"

def pomme(n): #besoin de n+1*n variable :-(
	string = "(" + cl_ou([i*n+1 for i in range(0,n)])
	for i in range(2,n+2):
		string += ope[1]+cl_ou(j*n+i for j in range(0,n))
	string += ") => ("

	for p in range(1,n+1):
		string+="("
		if(p!=1):
			string += ope[0]
		for q in range(1,n+2):
			if(q!=1):
				string += ope[0]
			string += cl_oubis([t*n+p for t in range(0,n)],[t*n+q for t in range(0,n)])
		string+=")"
	return string + ")"

if __name__ == "__main__":
	arg = sys.argv
	with open("Inputs/pomme.form",'w') as file :
		file.write(pomme(int(arg[1]))+ " 0")
	with open("Inputs/rotation.form",'w') as file :
		file.write(rotation(int(arg[1]))+ " 0")
	with open("Inputs/additionneur.form",'w') as file :
		file.write(additionneur(int(arg[1]))+ " 0")
	with open("Inputs/parite.form",'w') as file :
		file.write(parite(int(arg[1]))+ " 0")
