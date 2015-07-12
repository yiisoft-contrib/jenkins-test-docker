#!/bin/sh


ld_lib_path=`printenv LD_LIBRARY_PATH` || echo "LD_LIBRARY_PATH is empty"
if [ "$ld_lib_path" = "" ]
then
	LD_LIBRARY_PATH=$CUBRID/lib
else
	LD_LIBRARY_PATH=$CUBRID/lib:$LD_LIBRARY_PATH
fi

SHLIB_PATH=$LD_LIBRARY_PATH
LIBPATH=$LD_LIBRARY_PATH
PATH=$CUBRID/bin:$CUBRID/cubridmanager:$PATH

export CUBRID
export CUBRID_DATABASES
export CUBRID_LANG
export LD_LIBRARY_PATH
export SHLIB_PATH
export LIBPATH
export PATH

# put databases in a tmpfs
mkdir -p $CUBRID_DATABASES
mount -t tmpfs -o size=1G,nr_inodes=10k,mode=0700 tmpfs $CUBRID_DATABASES

# start cubrid
echo "starting cubrid..."
cubrid service start || echo "starting CUBRID services failed with exit code $?"
# create and start the demo db
$CUBRID/demo/make_cubrid_demo.sh || echo "setting up CUBRID demodb failed with exit code $?"
cubrid server start demodb || (echo "starting CUBRID demodb failed with exit code $?" && cat demodb_loaddb.log)

