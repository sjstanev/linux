grep -E 'match_word' match_file.txt

echo $? 
if result == 0 :
   -success == this mean there are match and the file exist
elif result == 1:
    no success - this mean there are NO match between the match_word in the match_file, but the file still exist
else result ==2 :
    againt NO success - but, this also mean the match_file.txt thas NOT exist
