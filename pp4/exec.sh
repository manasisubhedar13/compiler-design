

SPIM=spim
COMPILER=dcc

if [ $# -lt 1 ]; then
  # echo "Run script error: The run script takes one argument, the path to a Decaf file."
  exit 1;
fi
if [ ! -x $COMPILER ]; then
  echo "Run script error: Cannot find $COMPILER executable!"
  echo "(You must run this script from the directory containing your $COMPILER executable.)"
  exit 1;
fi
if [ ! -r $1 ]; then
  echo "Run script error: Cannot find Decaf input file named '$1'."
  exit 1;
fi

# echo "-- $COMPILER <$1 >tmp.asm"
./$COMPILER < $1 > tmp.asm 2>tmp.errors
if [ $? -ne 0 -o -s tmp.errors ]; then
  # echo "Run script error: errors reported from $COMPILER compiling '$1'."
  # echo " "
  cat tmp.errors
  exit 1;
fi

#append the defs to the end
cat defs.asm >> tmp.asm

# echo "-- spim -file tmp.asm"
# echo " "
$SPIM -file tmp.asm

# echo " "
# echo " "
exit 0;
