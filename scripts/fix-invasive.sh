
# This fixes all issues with your Mac, with some
# significant manual changes that you have made beng disrupted

# Delete all .DS_Store files on the system, custom appended info for files will get wiped
find / -name '.DS_Store' -depth -exec rm {} \;

