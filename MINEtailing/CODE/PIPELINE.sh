# -------------------------------------------   CODE :))   -----------------------------------------
# Compilation of the codes in project comparision microbiomes
# BESP 21 09 - 21 09

##### PROGRAMS #####
# SRAtools
# FASTQC
# FASTX-toolkit
# BBmap
# MEGAHIT
# QUAST
# PRODIGAL
# bowtie2
# DIAMOND
# MG-RAST-tools


##### SCRIPTS ######
# qSRAtodos
# CHANGEname
# qQUALITY
# qTRIMMING
# qBBMAP
# qTRANSFORM
# qMEGAHIT
# qUAST
# qPRODIGAL
# qCHANGENUMERATE
# qDIAMOND
# qBESTS
# qCUENTASlen
## PROTEINlenCount.py
# qBOWTIE
# qM5NR
# qHITTER
## hitter.py
# hitter_table.py





##### INPUT FILES #####
NOMBRES.txt
INFILEbbmap.txt
NAMEStoCHANGE.txt


qsub qSRAdown -i NOMBRES.txt -o "/home/brenda/MAIN/DATA/SRA" -pp "/home/brenda/MAIN/bin/sratoolkit.2.10.9-ubuntu64/bin/"
CHANGEname NOMBRES.txt
qsub qQUALITY -i "*.fastq" -s "/usr/bin/"
qsub qTRIMING
                /usr/bin/fastx_trimmer -f 1 -l 250 -i /home/brenda/MAIN/SRA/DATA/FASTQ/LA2MS4SS01_S1_L001_R1_001_2-quality.fastq -o /home/brenda/MAIN/SRA/DATA/FASTQ/LA2MS4SS01_S1_L001_R1_001_2-trimming.fastq

mkdir ../FASTXfinal
for file in *quality*; do echo $file; echo ../FASTXfinal/${file/-quality/}; mv $file ../FASTXfinal/${file/-quality/}; done
mv /LA2MS4SS01_S1_L001_R1_001_2-trimming.fastq ../FASTXfinal/LA2MS4SS01_S1_L001_R1_001_2.fastq
mv qQUALITY ../FASTXfinal
mv qTRIMMING ../FASTXfinal



cd FASTXfinal
mkdir CONTAMINATEDreads
qsub qBBMAP INFILEbbmap.txt

mkdir ../CONTAMINATIONbbmap
for file in *filtered*; do echo $file; echo ../CONTAMINATIONbbmap/${file/-filtered/}; done
mv CONTAMINATEDreads ../CONTAMINATIONbbmap
mv qBBMAP ../CONTAMINATIONbbmap
mv INFILEbbmap ../CONTAMINATIONbbmap



cd ../CONTAMINATIONbbmap
mkdir UNORDER
mv *fastq* UNORDER
cd UNORDER
qsub qTRANSFORM
mkdir MEGAHIT
qsub qMEGAHIT "*.fastq*"
mkdir ../READSfinales
mv *fastq* ../READSfinales

mkdir ../CONTIGS
mv MEGAHIT ../CONTIGS
mv qMEGAHIT ../CONTIGS



cd ../CONTIGS
################### QUAST #######################
for file in "MEGAHIT/00[0-9]/*contigs.fa"; do echo $file; mv $file ..; done
mv MEGAHIT MEGAHITapendix
mkdir PRODIGAL
qsub qPRODIGAL "*fa"

mkdir ../PROPREprodigal
mv PRODIGAL ../PROPREprodigal
mv qPRODIGAL ../PROPREprodigal



cd ../PROPREprodigal/PRODIGAL
qsub qCHANGENUMERATE NAMEStoCHANGE.txt
for file in *.new; do echo $file; echo ../${file/.new/}; mv $file ../${file/.new/}



cd ..
qsub qDIAMOND ".faa"

mkdir ../DIAMOND
mv *.bot ../DIAMOND
mv qDIAMOND ../DIAMOND

cd ../DIAMOND
qsub qBEST "*bout"
mkdir ../TABLAS
mkdir ../TABLAS/TEMP
mv *best.simple.tsv ../TABLAS
mv *best_uniq ../TABLAS/TEMP



cd ../CONTIGS
qsub qBOWTIE "*_1.faa"

mkdir ../BOWTIEreadsMap
mv *.sam ../BOWTIEreadsMap
mv qBOWTIE ../BOWTIEreadsMap
cd ../BOWTIEreadsMap
for file in *.sam; do cut -f3 $file | sort | uniq -c > ../TABLAS/${file/_mapped*/.hits}
#mv ../PRODIGAL/*.faa
#qsub qCUENTASlen "*.sam"
#mv *.hits2 ../TABLAS
#mv qCUENTASlen ../TABLAS
#mv PROTEINlenCount.py ../TABLAS
mv *.hits ../TABLAS



cd ../TABLAS
qsub qHITTER "*_best*"
mkdir ../HITables
mv *.hout ../HITables
mv tabla_genes ../HITables
mv hitter* ../HITables


cd ../HITables
ls *.hout > LISTA
python3 hitter_table.py LISTA JalesRizo-AbundanciaProteinas

mkdir ANOTACIONm5nr
cut -f1 JalesRizo-AbundanciaProteinas.tsv | sed "1d" > ../ANOTACIONm5nr/IDm5nr.txt
cd ../ANOTACIONm5nr
for DATABASE in KO SEED EGGnog; qsub qM5NR "IDm5nr.txt" $DATABASE; done


mkdir ../DIVERSITYPhSeq
mv ../HITables/JalesRizo-AbundanciaProteinas.tsv ../DIVERSITYPhSeq

cd ../DIVERSITYPhSeq
########### PhyloSeq #############

