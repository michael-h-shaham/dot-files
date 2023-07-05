# Miscellaneous

These notes will likely only be used by Michael for his benefit.

## Map caps lock to esc/ctrl

I use `keyd` for this (though there's probably other ways). 
The instructions below are copied from the 
[keyd GitHub page](https://github.com/rvaiya/keyd).

```bash
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable keyd && sudo systemctl start keyd
sudo vim /etc/keyd/default.conf
```

Paste

```
[ids]

*

[main]

# Maps capslock to escape when (double?) pressed and control when held.
capslock = overload(control, esc)
```

into the `default.conf` file. Then run

```sudo systemctl restart keyd```

one more time.
