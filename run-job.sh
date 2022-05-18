# Variabel-variabel
FILE_JAR=target/kuis2-bigdata-1.0-SNAPSHOT.jar
HADOOP_USERNAME=hadoopuser
IP_NAMENODE=192.168.0.10
HOME_DIR=/home/hadoopuser/
NAMA_JAR_TUJUAN=kuis2.jar
PACKAGE_ID=org.example.App
INPUT_FOLDER=/muzakidian/input
OUTPUT_FOLDER=/muzakidian/output-kuis

# Bersihkan console
clear

# Jalankan SCP
SCP_ARG="${HADOOP_USERNAME}@${IP_NAMENODE}:${HOME_DIR}${NAMA_JAR_TUJUAN}"
echo "Running SCP.."
echo "${SCP_ARG}"
scp $FILE_JAR $SCP_ARG

# SSH ke Name Node dan jalankan MapReduce job
echo "Connecting to Namenode and execute MapReduce Job.."
HADOOP_JAR_COMMAND="hadoop jar ${NAMA_JAR_TUJUAN} ${PACKAGE_ID} ${INPUT_FOLDER} ${OUTPUT_FOLDER}"
LS_OUTPUT_COMMAND="hadoop fs -ls ${OUTPUT_FOLDER}"
CAT_OUTPUT_COMMAND="hadoop fs -cat ${OUTPUT_FOLDER}/part-r-00000"
DELETE_OUTPUT_COMMAND="hadoop fs -rm -r ${OUTPUT_FOLDER}"
ssh "${HADOOP_USERNAME}@${IP_NAMENODE}" "${HADOOP_JAR_COMMAND}; ${LS_OUTPUT_COMMAND}; ${CAT_OUTPUT_COMMAND}; ${DELETE_OUTPUT_COMMAND}; exit"
echo "Selesai."

