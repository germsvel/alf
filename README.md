# Alf

A little friend that handles your todo list.

## Usage

Alf is still in its early stages so usage is a work in progress. 

Clone the repo and open up `iex`, 

```shell
iex -S mix
```

The simplest way to use it is to `import` the todo list module, 

```elixir
iex> import Alf.TodoList
```

Now you should be good to edit your todo list: 

```elixir
iex> add "PR review"
iex> add "Interview candidates"
iex> add "Do research to implement X"

iex> print()

To do
======
[1] PR review
[2] Interview candidates
[3] Do research to implement X

```

Once you're done with a task, you cancomplete the item in your todo list by providing its position in the list or its description, 

```elixir
iex> complete 2
iex> print()

To do
======
[1] PR review
[2] Do research to implement X

iex> complete "PR review"
iex> print()

To do
======
[1] Do research to implement X

```

Alf automatically saves your todo list, so if you close out of `iex` and open a new session, you should see your todo list just the way you left it. 
