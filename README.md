# About Kickoff

Kickoff is a framework for Jobvite CWS team to make starting a new site easier and quicker to setup. It uses SCSS, Gulp, and your favorite editor to make producing styles easier.

## Table of Contents
* [Documentation](/documentation/README.md)
* [Start A New Project](#start)
* [Get Setup](#setup)

## Start A New Project <a name="start"></a>

1. In the terminal, navigate to your CWS project directory then checkout the `starter_branch`.

    >    `git checkout starter_branch`

2. Add your new worktree branch with the following command. The `<customer branch name>` will be the folder name.

    >    `git worktree add <customer branch name>`

3. Checkout the root branch again in the CWS project directory.

    >    `git checkout root`

4. Navigate into the new customer project directory

    >    `cd <customer branch name>`

5. Set upstream directory in Github. This associates your folder with the respective Github folder.

    >    `git push -u origin <customer branch name>`

6. Check the status to make sure everything is setup right. Fix issues if needed.

    >    `git status`

\** **Kickoff v1.4.0** Create a folder for `Desktop, Mobile, and Images` in the `<customer branch name>` folder.

\** **Kickoff v2.3.0** The `Desktop, Mobile, and Images` folders are already created for you.


## Kickoff v1.4.0 Update

- With this version update, add folders for Desktop and Mobile in the customer root folder to keep Velocity and JavaScript files in. Any JavaScript file will be automatically minified and output to the Dist folder. 

## Kickoff v2.0.0 Update

- Big changes to file framework with change to dart-sass to support @use. From SASS website, "The Sass team discourages the continued use of the @import rule. Sass will gradually phase it out over the next few years, and eventually remove it from the language entirely. Prefer the @use rule instead."
- Moved WebP image conversion out to the root folder in the `convert` folder.

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
