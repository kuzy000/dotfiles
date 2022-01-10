#!/usr/bin/python

import re
import sys
import subprocess

def dbusWidget(monitor, data):
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

def dockWindow(monitor, data):
    if data['tokens'][-2] == 'T=':
        subprocess.call(['xdo', 'hide', data['dock']])
    else:
        subprocess.call(['xdo', 'show', data['dock']])

    if data['tokens'][0][0] == 'M':
        subprocess.call(['picom-trans', '-w', data['dock'], '100'])
    else:
        subprocess.call(['picom-trans', '-w', data['dock'], '75'])


def getPosition(wnd):
    text = subprocess.check_output([
        'xdotool', 'getwindowgeometry', wnd
        ]).decode('utf-8')
    pos = re.search('Position: ([0-9,]+)', text).group(1).split(',')
    return [int(s) for s in pos]

if __name__ == '__main__':
    docks = subprocess.check_output([
        'xdotool', 'search', '--onlyvisible', '--class', 'lattedock'
        ]).decode('utf-8').rstrip('\n').split('\n')

    if getPosition(docks[0])[0] >= 1920:
        docks[0], docks[1] = docks[1], docks[0]

    monitors = {v: {'dbus': i + 1, 'tokens': [], 'dock': docks[i]} for i, v in enumerate(sys.argv[1:])}

    while True:
        tokens = sys.stdin.readline().rstrip('\n')[1:].split(':')
        
        idxs = []
        for i, token in enumerate(tokens):
            if token[1:] in monitors:
                idxs.append(i)

        idxs.sort()
        for a, b in zip(idxs, idxs[1:] + [len(tokens)]):
            monitors[tokens[a][1:]]['tokens'] = tokens[a:b]

        for monitor, data in monitors.items():
            dbusWidget(monitor, data)
            dockWindow(monitor, data)

