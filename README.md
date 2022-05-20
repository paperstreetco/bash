# bash

All things bash. Please comment your code.

## Style Guidelines

Please don't hesitate to submit any and all code, snippets, oneliners or whatever it is
you're inspired about that's written in shell to this repository. The first goal here is
to learn, get feedback, share ideas, and contribute something to the community.

If in doubt submit a pull-request first, ask questions later!

If you're a new coder, please submit whatever you have. Style be damned. Nobody learned
by first having good style. 

### Recommended Style

But, for our more advanced scripters, please use good style. 

We recommend [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
as our preferred style for shell anywhere in the PaperStreet project. 

### ShellCheck

For intermediate or advanced scripters please use a _linter_. Our recommendation is 
[ShellCheck](https://www.shellcheck.net/). There's plugins for most editors.

### Be safe, fail early

Fail hard and fail early for safer scripts. (And code that's easier to develop/maintain over the long run.)

`set -euxo pipefail` near the beginning of your script. Read more about 
[why you should do this](https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/).
