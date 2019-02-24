# conf

### _Simple configuration file manipulator for projects._

### Getting Started in conf

### Dependencies

[cl-fad](https://github.com/edicl/cl-fad)

### Installation

**1 - Download conf system**

By quicklisp:

```
IN PROGRESS...
```

or directly from github:

```
git clone https://github.com/noloop/conf.git
```

**2 - Install conf**

By quicklisp:

```
IN PROGRESS...
```

or directly from asdf:

```lisp
(asdf:load-system :conf)
```

_**Note: Remember to configure asdf to find your directory where you downloaded the libraries (asdf call them "systems") above, if you do not know how to make a read at: https://lisp-lang.org/learn/writing-libraries.**_

### Initialize conf

```lisp
(init-conf "~/lisp/config/" "my-system.conf")

```

### Set conf directory

```lisp
(let ((conf (init-conf "~/lisp/config/" "my-system.conf")))
     (set-conf-directory conf "/home/your/some/"))
```

### Get conf directory

```lisp
(let ((conf (init-conf "~/lisp/config/" "my-system.conf")))
     (get-conf-directory conf)
     (set-conf-directory conf "/home/your/some/")
     (get-conf-directory conf))

;; CL-USER> "~/lisp/config/"
;; CL-USER> "/home/your/some"
```

### Set conf file

```lisp
(let ((conf (init-conf "~/lisp/config/" "my-system.conf")))
     (set-conf-file conf "my-file.conf"))
```

### Get conf file

```lisp
(let ((conf (init-conf "~/lisp/config/" "my-system.conf")))
     (get-conf-file conf)
     (set-conf-file conf "my-file.conf")
     (get-conf-file conf))

;; CL-USER> "my-system.conf"
;; CL-USER> "my-file.conf"
```

### Get conf full path

```lisp
(let ((conf (init-conf "~/lisp/config/" "my-system.conf")))
     (get-conf-full-path conf)
     (set-conf-directory conf "/home/your/some/")
     (set-conf-file conf "my-file.conf")
     (get-conf-full-path conf))

;; CL-USER> "~/lisp/config/my-system.conf"
;; CL-USER> "/home/your/some/my-file.conf"
```

### Get conf hash

```lisp
(let ((conf (init-conf "~/lisp/config/" "my-system.conf")))
     (get-conf-hash conf))

;; #<HASH-TABLE :TEST EQL :COUNT 5 {10033E4713}>
```

### Replace conf
The replace-conf is a function that requires user interaction, so you will have to answer some questions she will ask you to configure your file. It works like this:

The replace-conf function will only ask you what you have in your configuration file. Example of a configuration file called "something.conf":

```lisp
(:author "Unknown"
:maintainer "you"
:license "UNLICENSED"
:version "0.0.0"
:git-service "github")
```

So in that case replace-conf will ask you to replace the five fields :author, :maintainer, :license, :version and :git-service, if you add more fields, it will ask you all what you write in your file configuration. By default the conf will not create the configuration file, so there will be no default fields to be overridden with replace-conf if you do not configure a config file, then you should start conf with init-conf showing where to find the file you wrote.

Sample questions from the "something.conf" file:

```lisp
CL-USER> (defvar *c* (conf:init-conf "/home/your/lisp/projects/test-project/" "test-project.conf"))
CL-USER> (conf:replace-conf *c*)
AUTHOR?(actual your) I
MAINTAINER?(actual your) I
LICENSE?(actual GPL v3) 
VERSION?(actual 0.1.0) 
GIT-SERVICE?(actual github) 

File saved successfully.
NIL
```

#### Keep current configuration in replace-conf

Note that you can set the field you want to leave as the current configuration that is already in your configuration file. Como é mostrado abaixo:

```lisp
CL-USER> (conf:replace-conf c)
AUTHOR?(actual your) I
MAINTAINER?(actual your) I
LICENSE?(actual GPL v3) 
```

The LICENSE field will continue to have the current value of "GPL v3", so you only have to enter enter without adding any characters for the read-line to read.

## API

function **(init-conf directory file-name)**

function **(set-conf-directory conf new-directory)**

function **(get-conf-directory conf)**

function **(set-conf-file conf new-file-name)**

function **(get-conf-file conf)**

function **(get-conf-full-path conf)**

function **(get-conf-hash conf)**

function **(replace-conf conf)**


