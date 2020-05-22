# Kickoff

Kickoff is a framework for Jobvite CWS team to make starting a new site easier and quicker to setup. It uses SCSS, Gulp, and your favorite editor to make producing styles easier.

## Table of Contents
* [Get Setup](#setup)
* [Start A New Project](#start)

## Get Setup <a name="setup"></a>

1. Select an editor

Select an editor like [Atom](https://atom.io/), [Visual Studio Code](https://code.visualstudio.com/), [Dreamweaver](https://www.adobe.com/products/dreamweaver.html), [Sublime](https://www.sublimetext.com/)... whatever floats your boat!

2. Select a command-line

Select a command-line interface like Terminal (Mac), Command Prompt (Win), or others. [Learn more about the command line](https://css-tricks.com/reasonable-approach-getting-comfortable-command-line/)

3. Get Node.js

[Go to the NodeJS website](https://nodejs.org/en/) and install the current version.

4. Install Gulp

Install Gulp from your terminal app, [follow this article from CSS-Tricks, Gulp for Beginners](https://css-tricks.com/gulp-for-beginners/), for help getting this setup.

5. Setup Github

6. Get a copy of kickoff

Checkout the [starter_branch](https://github.com/brettwbyron-jobvite/CWS/tree/starter_branch/jv-kickoff) and pull down any updates. 


## Start A New Project <a name="start"></a>

1. In your terminal, checkout the starter_branch from your CWS project directory.

2. Add your new worktree branch.

    `git worktree add <customer branch name>`

3. Checkout the root branch again in the CWS project directory.

4. Go into the new customer project directory

    `cd <customer branch name>`

5. Set upstream directory in Github

    `git push -u origin <customer branch name>`

6. Check the status to make sure everything is setup right. Fix issues if needed.

    `git status`

7. **Kickoff v1.4.0** Create a folder for `Desktop, Mobile, and Images` in the `<customer branch name>` folder.


## Kickoff v1.4.0 Update

With this version update, add folders for Desktop and Mobile in the customer root folder to keep Velocity and JavaScript files in. Any JavaScript file will be automatically minified and output to the Dist folder. 