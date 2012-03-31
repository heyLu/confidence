# lu's little tools (and unfancy symlinks)

If you have this directory in your `PATH` then you'll have all of the
following at your disposal.

## rt

`rt` (*r*epository *t*ool) is a nice little utility script for [VCS][]s
such as `git` or `hg`. It detects the type of repository it operates on
and chooses the appropriate command. I mostly use it for cloning
repositories, but it should be able to do other VCS tasks aswell.

    lu ~$ rt
    Usage: /home/lu/.bin/rt <cmd> <repo> [<args>]
      executes <cmd> for <repo> (passing <args> through)
    
    lu ~$ rt c hub:anapple/confidence
    # Clones a repository from GitHub (see <../.gitconfig> for the `hub` alias)

## events

`events` is a logs window manager events to various services (currently
`~/.eventstream` and [statsd][]). Someday I might live out my
statistical fetish and get carried away by years of weird logs to
analyze.

## git-ln

`git-ln` (use as `git ln`) is a git command that displays a numbered
(descending) log of commits in a git repository. Use it as you'd use
`git log` itself.

## update-planet.sh

`update-planet.sh` does what it's name says: It delivers a new planet
(usually called "earth") with updated parameters using a template file
called `~/t/venus/config.ini`.

In a boring parallel universe it updates my planet of RSS/ATOM feeds and
creates `~/t/venus/www/planet/index.html` in which the titles of the
various posts are displayed, waiting for me to click them and enjoy
what's behind them.

It gets invoked every two hours by the venerable `cron`.

## warn-if-low.sh

`warn-if-low.sh` constantly nudges me when my battery runs low. It
spawns up windows everytime it is called and thinks that my battery is a
little bit neglected. I then get annoyed by it and plug the AC adapter
in. *Mission accomplished!* (No, any other solution that doesn't create
a big annoying window right in front of my eyes doesn't work.)

It's called periodically (every minute) by `cron`.

## xkbswap

`xkbswap` swaps the current keyboard layout (from `de` to `us` and the
other way around).
