wget -O java_kwds.html -E https://docs.oracle.com/javase/tutorial/java/nutsandbolts/_keywords.html
grep -oP '(?<=\<code\>)[\w]+(?=\<\/code\>)' java_kwds.html > kwds.txt
rm java_kwds.html