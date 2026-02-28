##Bandit Solutuions & Notes

#Level 0

**Challenge:** Log into game using ssh
- Host: bandit.labs.overthewire.org
- Port: 2220
- Username: bandit0
- Password: bandit0

**Solution:**
```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

**Explanation:**
-'bandit0' is the username
'bandit.labs.overthewire.org' is the host name
'-p 2220' uses port 2220


#level 0 -> level 1

**Challenge:** Log in and read from 'readme' file

**Solution:**
```bash
cat readme
```

**Explanation:**
-'cat' command reads from stated file

**Password:** ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If


#level 1 -> level 2

**Challenge:** Read from 'dashed' filename

**Solution:**
```bash
cat ./-
```

**Explanation:**
-'cat' command followed by dash - Shell expects argument/command, rather than filename
-'./' tells shell that filename will follow it

**Password:** 263JGJPfgU6LtdEvgfWU1XP5yac29mFx


#level 2 -> level 3

**Challenge:** Read from filename with spaces

**Solution:**
```bash
cat "./--spaces in this filename--" 
```

**Explanation:**
-'cat' command cannot read files with spaces in name
-"" tells shell that file name is contained within quotes

**Password:** MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx


#level 3 -> level 4

**Challenge:** Locate and read from hidden file

**Solution:**
```bash
cd inhere
ls -a
cat ...Hiding-From-You
```

**Explanation:**
-'ls -a' lists all contentts of a directory, including hidden files

**Password:** 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ


#level 4 -> level 5

**Challenge:** Locate and read from only human-readable file

**Solution:**
```bash
cd inhere
ls
file ./*
cat ./-file07
```

**Explanation:**
-'file' states type of file - looking for ASCII text (human-readable)
'*' is the wildcard command - command will apply to all files

**Password:** 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw


#level 5 -> level 6

**Challenge:** Find a file with these properties:
-human-readable
-1033 bytes in size
-not executable

**Solution:**
```bash
find inhere -type f -size 1033c ! -executable
cat inhere/maybehere07/.file2
```

**Explanation:**
-'find' command allows you to find contents with specific parameters
'-type' filters type of file - in this case, 'f' meaning regular human-readable file
'-size' filters size of file - '1033c' meaning 1033 bytes
'!' -executable' excludes executable files

**Password:** HWasnPhtq9AVKe0dmk45nxy20cvUa6EG


#level 6 -> level 7

**Challenge:** Find a file with these properties:
-owned by user bandit7
-owned by group bandit6
-33 bytes in size

**Solution:**
```bash
find / -user bandit7 -group bandit6 -size 33c
cat /var/lib/dpkg/info/bandit7.password
```

**Explanation:**
-'find /' command searches entire server from root directory
'-user' filters by user ownership
'-group' filters by group ownership

**Password:** morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj


#level 7 -> level 8

**Challenge:** Find a password within large file next to word 'millionth'

**Solution:**
```bash
cat data.txt | grep "millionth"
```

**Explanation:**
-'grep' command searches for input within a file & prints entire line

**Password:** dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc


#level 8 -> level 9

**Challenge:** Find password - a line within data file that only occurs once

**Solution:**
```bash
sort data.txt | uniq -u
```

**Explanation:**
-'sort' command sorts lines of  atext file
-'uniq' used in conjunction with 'sort', filters based on identical output
'-u' flag tells computer to sort unique lines

**Password:** 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM


#level 9 -> level 10

**Challenge:** Password located in one of few human-readable strings within file, preceded by several "=" characters

**Solution:**
```bash
strings data.txt | grep "=="
```

**Explanation:**
-'strings' command finds human-readable strings in data file

**Password:** FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey


#level 10 -> level 11

**Challenge:** Decode base64-encoded data file which contains password

**Solution:**
```bash
base64 -d data.txt
```

**Explanation:**
-'base64 -d' reverses ('decodes" base64 encoding in data file

**Password:** dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
