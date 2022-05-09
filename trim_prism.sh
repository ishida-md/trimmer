#$ -cwd
#$ -pe def_slot 16
#$ -l s_vmem=2G,mem_req=2G
#$ -e log/
#$ -o log/

module use /usr/local/package/modulefiles/
module load fastp


READ1=${2}
READ2=${3}

READ1T=`basename ${READ1} .fq.gz`_trimmed.fq
READ2T=`basename ${READ2} .fq.gz`_trimmed.fq

FASTQ_BASE=`basename ${READ1} _1.fq.gz`

mkdir -p ${1}

fastp -i ${READ1} -I ${READ2} -o ${1}/${READ1T} -O ${1}/${READ2T} --detect_adapter_for_pe -f 8 -F 8 --thread 16 -h ${1}/${FASTQ_BASE}.html -j ${1}/${FASTQ_BASE}.json

pigz -p 8 ${1}/${READ1T} & pigz -p 8 ${1}/${READ2T}
