#!/usr/bin/python

import re
import sys
import subprocess

def dbus_widget(monitor, data):
    desktops = data['tokens'][1:next(i for i, v in enumerate(data['tokens']) if v[0] == 'L')]
    msg=''
    for i, desktop in enumerate(desktops):
        state  = desktop[0]
        name   = desktop[1:]
        switch = f'bspc desktop -f {monitor}:^{i + 1}'

        if   state == 'O':
            msg += f'| C | {name} | | {switch} |'
        elif state == 'o':
            msg += f'| B | {name} | | {switch} |'
        elif state == 'F':
            msg += f'| C | {name} | | {switch} |'
        elif state == 'f':
            msg += f'| A | {name} | | {switch} |'
        elif state == 'U':
            msg += f'| C | <font color="#9b59b6">{name}</font>| | {switch} |'
        elif state == 'u':
            msg += f'| B | <font color="#9b59b6">{name}</font>| | {switch} |'

    subprocess.call(['qdbus', 
            'org.kde.plasma.doityourselfbar', f'/id_{data["dbus"]}',
            'org.kde.plasma.doityourselfbar.pass', msg])

def dock_window(monitor, data):
    if data['tokens'][-2] == 'T=':
        subprocess.call(['xdo', 'hide', data['dock']])
    else:
        subprocess.call(['xdo', 'show', data['dock']])

    if data['tokens'][0][0] == 'M':
        subprocess.call(['picom-trans', '-w', data['dock'], '100'])
    else:
        subprocess.call(['picom-trans', '-w', data['dock'], '75'])

def get_monitor_names():
    r = subprocess.check_output([
        'xrandr', '--listmonitors'
        ]).decode('utf-8').rstrip('\n').split('\n')[1:]
    r = [e.strip() for e in r]
    r = [re.match('^.: \\+\\**(.*) \\d+/\\d+x\\d+/\\d+\\+(\\d+)\\+\\d+.*$', e).group(1, 2) for e in r]
    r.sort(key=lambda x: x[1])
    r = [e[0] for e in r]

    return r

def get_pos_x(wnd):
    text = subprocess.check_output([
        'xdotool', 'getwindowgeometry', wnd
        ]).decode('utf-8')
    posX = re.search('Position: ([0-9,]+)', text).group(1).split(',')[0]

    return int(posX)

def get_dock_ids():
    r = subprocess.check_output([
        'xdotool', 'search', '--onlyvisible', '--class', 'lattedock'
        ]).decode('utf-8').rstrip('\n').split('\n')

    r = [(d, get_pos_x(d)) for d in r]
    r.sort(key=lambda x: x[1])
    r = [d[0] for d in r]

    return r

if __name__ == '__main__':
    monitor_names = get_monitor_names()
    dock_ids = get_dock_ids()

    monitor_names = monitor_names[:len(dock_ids)]
    dock_ids = dock_ids[:len(monitor_names)]

    monitors = {v: {'dbus': i + 1, 'tokens': [], 'dock': dock_ids[i]} for i, v in enumerate(monitor_names)}

    while True:
        tokens = sys.stdin.readline().rstrip('\n')[1:].split(':')
        
        idxs = []
        for i, token in enumerate(tokens):
            if token[0].lower() == 'm':
                idxs.append(i)

        idxs.sort()
        for a, b in zip(idxs, idxs[1:] + [len(tokens)]):
            monitor = tokens[a][1:]
            if monitor in monitors:
                monitors[monitor]['tokens'] = tokens[a:b]

        for monitor, data in monitors.items():
            dbus_widget(monitor, data)
            dock_window(monitor, data)

