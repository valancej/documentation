---
title: Elixir
tags:
  - elixir
  - languages
category: Languages &amp; Frameworks
---
We currently don't have Elixir pre-installed on our build VMs so we'd recommend using our [Docker]({{ site.baseurl }}/docker/) platform or downloading Elixir via the shell commands during project setup. The easiest way to do this is by using our [scripts repository](https://github.com/codeship/scripts), specifically the [Erlang](https://github.com/codeship/scripts/blob/master/languages/erlang.sh) and [Elixir](https://github.com/codeship/scripts/blob/master/languages/elixir.sh) scripts both. After connecting your repository, you can add these setup commands that will automatically download Elixir and Erlang. Both are needed to be able to run Elixir.

```
source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/languages/erlang.sh)"
source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/languages/elixir.sh)"
```

The setup looks like this:
![Elixir Setup]({{ site.baseurl }}/images/languages/setupelixir.png)

<div class="info-block">
Both downloads are cached for future builds and there are no compile steps, so this is a straightforward process and should not impact your build times. *Please note* that we can't officially support software that is not pre-installed on the VMs by us.
</div>
