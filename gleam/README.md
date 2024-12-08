# Advent Of Code 2024 - Gleam

## Prerequisites

- Install Gleam, Erlang, Rebar3:
  - Using Gleam recommendations: <https://gleam.run/getting-started/installing/>
  - Using **asdf**

```sh
ASDF_PLUGINS=(gleam erlang rebar)

for plugin in ${ASDF_PLUGINS[@]}
do
  asdf plugin add $plugin \
    && asdf install $plugin latest
    && asdf global $plugin latest
done
```

## Running the project

### Run solutions for every days

```sh
gleam run
```

### Run solution for a specific day

```sh
# example: running solution for day 1
gleam run -m day1
```

### Run tests

```sh
gleam test
```
