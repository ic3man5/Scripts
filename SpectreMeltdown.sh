
#Copyright 2018 John Bennett

#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#!/bin/bash
#echo "Checking cpu architecture and status..." (can be useful on certain hardware)
#cat /proc/cpuinfo

echo "Checking whether cpu is affected by meltdown/spectre"
grep cpu_insecure /proc/cpuinfo

echo "If kernel config file exists in /boot check status of kpti..."
grep CONFIG_PAGE_TABLE_ISOLATION=y /boot/config-`uname -r` && 
echo "patched :)" || echo "unpatched :("

echo "If kernel config file does not exist in /boot check status of kpti via dmesg..."
dmesg | grep "Kernel/User page tables isolation: enabled" && echo "patched" || echo "unpatched" 
 

# Alternate method if config file does not exist (enable if needed)
# grep -sq "x86/pti" /var/log/dmesg && echo "Patched"


