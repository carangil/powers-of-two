#!/bin/bash

nasm power2.asm -fbin -o power2.com
base64 power2.com >power2.b64
ndisasm power2.com > power2.dis


nasm p2small.asm -fbin -o p2small.com
base64 p2small.com > p2small.b64
ndisasm p2small.com > p2small.dis



nasm p2mov.asm -fbin -o p2mov.com
ndisasm p2mov.com > p2mov.dis

