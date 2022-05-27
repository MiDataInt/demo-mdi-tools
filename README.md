# Michigan Data Interface

The [Michigan Data Interface](https://midataint.github.io/) (MDI) 
is a framework for developing, installing and running 
HPC data analysis pipelines and interactive visualization 
applications within a standardized design interface.

The MDI is separated into 
[two stages of code execution](https://midataint.github.io/docs/analysis-flow/) 
called Stage 1 HPC **pipelines** and Stage 2 web applications (i.e., **apps**).
Collectively, pipelines and apps are known as **tools**.

## Repository contents

This repository is a **demo tools suite** you can use to:
- validate your MDI installation with a simple demo pipeline and app
- see what a working tool suite looks like

---
## Quick Start: public app server instance

To see this demo app server running live:
- go to: <https://mdi-demo.wilsonte-umich.io/>
- enter the access key: <code>mdi-demo</code>
- click <code>Load from Server</code> and select a data package or bookmark to load

---
## Quick Start 1: suite-centric installation

In suite-centric mode, you will:
- clone this tool suite repository
- call its 'install.sh' script to create a suite-specific MDI installation
- OPTIONAL: call 'alias.pl' to create an alias to the suite's 'run' utility
- call its 'run' utility to use its tools

### Install this tool suite

```bash
git clone https://github.com/MiDataInt/demo-mdi-tools.git
cd demo-mdi-tools
./install.sh
```

### Execute a Stage 1 pipeline from the command line

For help, call the 'run' utility with no arguments.

```bash
./run
```

### Launch the Stage 2 web server

Launch the apps server as follows - in a few seconds a web browser 
will open and you will be ready to load your data and run an associated app.

```bash
./run server --help
./run server
```

---
## Quick Start 2: mdi-centric installation

In mdi-centric mode, you will:
- clone and install the MDI
- add this tool suite (and potentially others) to your configuration file
- re-install the MDI to add this tool suite to your MDI installation
- call the 'mdi' utility to use its tools

### Install the MDI framework

Please read the 'install.sh' menu options and the 
[MDI installer instructions](https://github.com/MiDataInt/mdi.git) to decide
which installation option is best for you. Briefly, choose option 1
if you will only run Stage 1 HPC pipelines from your installation.

```bash
git clone https://github.com/MiDataInt/mdi.git
cd mdi
./install.sh
```

### Add an alias to .bashrc (optional)

These commands will help you create a permanent named alias to the 'mdi'
target script in your new installation.

```bash
./mdi alias --help
./mdi alias --alias mdi # change the alias name if you'd like 
`./mdi alias --alias mdi --get` # activate the alias in the current shell (or log back in)
mdi
```

### Add this tool suite to your MDI installation

Edit file 'mdi/config/suites.yml' as follows:

```yml
# mdi/config/suites.yml
suites:
    - MiDataInt/demo-mdi-tools
```

and re-run <code>install.sh</code>. 
Alternatively, you can install this suite from within the 
Stage 2 web server, or run the following from the command line:

```bash
mdi add -p -s MiDataInt/demo-mdi-tools 
```

### Execute a Stage 1 pipeline from the command line

For help, call the 'mdi' utility with no arguments.

```bash
mdi
```

### Launch the Stage 2 web server

Launch the apps server as follows - in a few seconds a web browser 
will open and you will be ready to load your data and run an associated app.

```bash
mdi server --help
mdi server
```
