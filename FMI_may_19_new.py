#!user/bin/python
import itertools
import sys, os
import time
#start = time.clock()
bases=['A','T','G','C']
num = 6
m=int(sys.argv[2])
l=[''.join(p) for p in itertools.product(bases, repeat=num)]
apk={}
for i in l:
	l1=[]
	for j in l:
		mm=0
		for k in range(len(i)):
			if i[k]!=j[k]:
				mm=mm+1
		if mm<=m:
			l1.append(j)		
	x={i:l1}
	apk.update(x)
infile=[x.strip() for x in open(sys.argv[1]).readlines()]#Input sequence or reads file
fastadict={}
for line in infile:
    if not line:
        continue
    if line.startswith('>'):
        sname = line
        if line not in fastadict:
            fastadict[line] = ''
        continue
    fastadict[sname] += line
ids = list(fastadict.keys())
seq = list(fastadict.values())
#print ids,seq #To print list of sequence_name and respective sequences line from fasta file
seqid=0
for read1 in seq:
	kmer1=[read1[i:i+num] for i in range(len(read1) - (num-1))]
	km=set(kmer1)
	read = "%s$" % read1
	def KmersearchViaFMindex(read):
		counts = {}
		pos=0
		position=[]
		B1=[]
		for i in range(0,len(read),1):
			pos=pos+1
			counts[read[i:i+200]]=pos
		for key in sorted(counts.iterkeys()):
			position.append(counts[key]-1)
			B1.append(read[counts[key]-2])	
		BWT=''.join(B1)
		#print BWT
		Basecount, TallyDict= {},{}
		for k in BWT:
			if k not in Basecount:
				Basecount[k] = 0 
				TallyDict[k]=[]
		for k in BWT:
			Basecount[k]+=1
			for k in Basecount.iterkeys():
				TallyDict[k].append(Basecount[k])
		#print TallyDict, Basecount
		firstcol = {}
		tc = 0
		for c, count in sorted(Basecount.iteritems()):
			firstcol[c] = (tc, tc + count)
			tc += count
		#print firstcol
		poslist={}
		for p in km:
			x=0
			for j in range(len(p)):
				if p[j] not in firstcol.keys(): x=1
			if x==0:
				lo,hi=firstcol[p[-1]]
				i = len(p)-2
				while i >= 0 and hi > lo:
					c = p[i]
					lo = firstcol[c][0] + TallyDict[c][lo-1]
					hi = firstcol[c][0] + TallyDict[c][hi-1]
					i-= 1
				countmatch=(hi - lo)
				if countmatch>=1:
					result={p:position[lo:hi]}
					#print result
				poslist.update(result)
		return poslist

	results=KmersearchViaFMindex(read)
	kmer2=[]
	for i in results.keys():
		kmer2.extend(apk[i])
	uniq_kmer=sorted(set(kmer2))
	#print uniq_kmer
	var=0
	for i in uniq_kmer:
		kmerposlist=[]
		for j in apk[i]:
			if j in results:
				kmerposlist.extend(results[j])
		print ids[seqid].strip(),":",uniq_kmer[var],":", kmerposlist
		var=var+1
	seqid=seqid+1	
#print time.clock() - start'''	
