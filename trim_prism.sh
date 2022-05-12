#$ -cwd
#$ -pe def_slot 16
#$ -l s_vmem=2G,mem_req=2G
#$ -e log/
#$ -o log/

module use /usr/local/package/modulefiles/
module load fastp


READ1=${2}
READ2=${3}


READ1C=`basename ${READ1} .fq.gz`_clipped.fq
READ2C=`basename ${READ2} .fq.gz`_clipped.fq

READ1T=`basename ${READ1} .fq.gz`_trimmed.fq
READ2T=`basename ${READ2} .fq.gz`_trimmed.fq

FASTQ_BASE=`basename ${READ1} _1.fq.gz`

mkdir -p ${1}

fastp -i ${READ1} -I ${READ2} -o ${1}/${READ1C} -O ${1}/${READ2C} -f 8 -F 8 --thread 16 -h qc/${FASTQ_BASE}.html -j qc/${FASTQ_BASE}.json --disable_adapter_trimming

fastp -i ${1}/${READ1C} -I ${1}/${READ2C} -o ${1}/${READ1T} -O ${1}/${READ2T} --detect_adapter_for_pe --thread 16 -h qc/${FASTQ_BASE}_2.html -j qc/${FASTQ_BASE}_2.json

rm ${1}/${READ1C}
rm ${1}/${READ2C}

pigz -p 16 ${1}/${READ1T}
pigz -p 16 ${1}/${READ2T}
