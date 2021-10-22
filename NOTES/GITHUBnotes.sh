# Author: BESP
# Date: 2020 07 10

#--------------------------------- My firsts steps with Git ---------------------------------#
## Git init ##
# In the directory where you are going to locate the files make:
git init

# To see the status of each file in the directory
git status

# To add to the stagging area
git add [FILEname]
git add -A   # Every file

# To remove files from stagging area
git reset [FILEname]

# To make changes in our local repository
git commit -m "[What changes do you have made?]"


## Git clone ##
git clone [URL] [PATH]

# Actualize teh changes of the last version of the repo
git pull origin [branch *main]

git add - A

git commit -m "[WCHYM?]"

git pull origin main

git push origin main


## Branching
# Create a branch
git branch [BRANCHname]
# Move to that branch
git check out [BRANCHname]

# Wich branches do I have?
git branch

### Make changes. No efect on master branch
add... commit...

# To update the changes in that branch
git push -u origin [BRANCHname]

# To see the branches in my local repo and the remote repo
git branch -a


# Merge
git checkout main # You are now in main, not in the branch
git pull origin main # Just in case
git branch --merged # To know
git merge [BRANCHname] # To merge the main and the new branch

git push origin main # To make the changes in the remote repo










git log
git diff
git

