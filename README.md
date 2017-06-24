# Alf

A little friend that handles your todo list.


Note: Alf is still in its early stages so usage is a work in progress.

## Usage

Clone this repo and `cd` into your `alf`'s directory.

Let's add an item to your todo list,

```shell
$ alf --add "PR review"
```

And you should immediately see your todo list!

```shell
To do
=====
[1] PR review
```

Let's add a couple more things,

```shell
$ alf --add "1-1 meeting"
$ alf -a "finish feature"
$ alf -a "Buy bread"

To do
======
[1] PR review
[2] 1-1 meeting
[3] finish feature
[4] Buy bread

```

Now let's check off the items in the list once we've completed them,

```shell
$ alf --complete 3

To do
======
[1] PR review
[2] 1-1 meeting
[3] Buy bread

```

Typing `--complete` can get old very quickly, so you can use `-c` instead,

```shell
$ alf -c 2

To do
======
[1] PR review
[2] Buy bread

```

Alf automatically saves your todo list, so if you close out of your terminal
and open a new session, you should see your todo list just the way you left it.

For a full list of commands, please see `alf --help`

