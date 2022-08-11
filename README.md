# MDI Demo Tools Suite

The [Michigan Data Interface](https://midataint.github.io/) (MDI) 
is a framework for developing, installing and running 
Stage 1 HPC **pipelines** and Stage 2 interactive web applications 
(i.e., **apps**) in a standardized design interface.

This repository is a **demo tools suite** you can use to:
- validate your MDI installation with a simple demo pipeline and app
- see what a working tool suite looks like

---
## Quick Start 1: public app server instance

To see this demo app server running live:
- go to: <https://mdi-demo.wilsonte-umich.io/>
- enter the access key: <code>mdi-demo</code>
- click <code>Load from Server</code> and select a data package or bookmark to load

---
## Quick Start 2: single-suite installation

In single-suite mode, you will:
- clone this tool suite repository
- call its _install.sh_ script to create a suite-specific MDI installation
- OPTIONAL: call _alias.pl_ to create an alias to the suite's _run_ utility
- call its _run_ utility to use its tools

### Install this tool suite

```bash
git clone https://github.com/MiDataInt/demo-mdi-tools.git
cd demo-mdi-tools
./install.sh
```

### Create an alias to the suite's _run_ utility

```bash
perl alias.pl mdi-demo # you can use a different alias name if you'd like
```

### Execute a Stage 1 pipeline from the command line

For help, call the _run_ utility with no arguments.

```bash
./run
mdi-demo # if you created the alias above
```

### Launch the Stage 2 web server

While you can launch the MDI web server using the command line utility,
it is much better to use the [MDI Desktop app](https://midataint.github.io/mdi-desktop-app),
which allows you to control both local and remote MDI web servers.

---
## Quick Start 3: multi-suite installation

In multi-suite mode, you will:
- clone and install the MDI
- add this tool suite (and potentially others) to your configuration file
- re-install the MDI to add this tool suite to your MDI installation
- call the _mdi_ utility to use its tools

### Install the MDI framework

Please read the _install.sh_ menu options and the 
[MDI installer instructions](https://github.com/MiDataInt/mdi.git) to decide
which installation option is best for you. Briefly, choose option 1
if you will only run Stage 1 HPC pipelines from your installation.

```bash
git clone https://github.com/MiDataInt/mdi.git
cd mdi
./install.sh
```

### Add an alias to _.bashrc_ (optional)

These commands will help you create a permanent named alias to the _mdi_
target script in your new installation.

```bash
./mdi alias --help
./mdi alias --alias mdi # change the alias name if you'd like 
`./mdi alias --alias mdi --get` # activate the alias in the current shell (or log back in)
mdi
```

### Add this tool suite to your MDI installation

Edit file _mdi/config/suites.yml_ as follows:

```yml
# mdi/config/suites.yml
suites:
    - MiDataInt/demo-mdi-tools
```

and re-run _install.sh_. 
Alternatively, you can install this suite from within the 
Stage 2 web server, or run the following from the command line:

```bash
mdi add -p -s MiDataInt/demo-mdi-tools 
```

### Execute a Stage 1 pipeline from the command line

For help, call the _mdi_ utility with no arguments.

```bash
mdi
```

### Launch the Stage 2 web server

While you can launch the MDI web server using the command line utility,
it is much better to use the [MDI Desktop app](https://midataint.github.io/mdi-desktop-app),
which allows you to control both local and remote MDI web servers.
