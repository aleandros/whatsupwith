# Whatsupwith

## Introduction and purpose

This is a command line application intended to solve common questions
about the programs that you may have installed. If you take a look at your
`PATH` environment variable, it is usually a very long list. 

What's in it? Why do I have so many programs and executables installed?
When did program `x` showed up? Is it running? These are the kind of questions
that the program attempts to solve, providing a simple, unix friendly ouput.

This is probably not a life saving application or any sort of game changer,
but if you find it useful, please give it a try. Or even better, provide
some feedback or contribute!

## Installation

Right now this is a very manual process. You need to have `elixir` installed.
Technically you just need the `erlang` to run it, but for building the executable
you do need `elixir` in your system.

Then you execute the following (inside the repo folder of course):

```
$ mix escript.build
```

Which will generate the file `whatsupwith`. Put it in your path and enjoy.

## Usage

If run with no arguments, it will print a (probably) very long output information
about every executable found in your `PATH`.

You can also provide a target. The following searches all programs that contain
the substring `java` in their names.

```
$ whatsupwith java
```

You can also search programs within a certain path. The following command
searches all programs that are contained in a directory that has the substring
`rbenv` somewhere in their paths.

```
$ whatsupwith --property path rbenv
```

Finally, you can use different search strategies. The next example searches
programs that match the name `python2` exactly.

```
$ whatsupwith --strategy exact python2
```
