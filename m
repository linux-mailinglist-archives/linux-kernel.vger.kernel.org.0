Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6F6F234
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 09:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfGUH6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 03:58:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37659 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfGUH6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 03:58:06 -0400
Received: by mail-io1-f71.google.com with SMTP id v3so39873222ios.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 00:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rBxRGKs1Z4xj/L1cZMcBQCBlmkFblCZx6yedL8N5neo=;
        b=BebE12XSiC2Q0AtZOY5ECHvthA9rjND2D6OzAPtXaNW166XrkgmhhOeCPqyHAy7f9E
         PGp5DUykfVu84Ge6mfmgiu9kDPLLvIH5jy7lbpljHzBQDoR+rEr2etPsS6UXz6HCN3lo
         PcdrYWZsY53TOLlt1I4BoNAiJYiKScByGK9Pw1x99CwfPe/St+eHygSLY69Jr2Trfu6X
         YzxZo73l0b0k4h62RgMpudXsNxAREkL8UhTmgdMkAOAx/Bmso638vWm/RwCf90su8nO2
         X6AQ8tCb2/J9tjxkbZA6kKp4JZDk/XAAuuMUfvJUfRfRbncgGuMogiedlghzFSBg3pas
         VQMg==
X-Gm-Message-State: APjAAAXbHC1yv0ByaSNNcP+K7Cbvzg/8kbYyVuznzNbZgg82baUqA4ro
        C7/sN9kxGwmi6HZiWMtaMs2hOGhOaDJ+E+fCoz21f6oo0gKh
X-Google-Smtp-Source: APXvYqxakqzf8syiw3Lx9LbI6nXEE2d9IZ3+mCx/X2otm6CUe1h3kXR6Dtrecf6EC89i+rfMewJKdemptpAXDd7OYyMP198T8xg5
MIME-Version: 1.0
X-Received: by 2002:a5d:85c3:: with SMTP id e3mr19946323ios.265.1563695885481;
 Sun, 21 Jul 2019 00:58:05 -0700 (PDT)
Date:   Sun, 21 Jul 2019 00:58:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc503058e2c5177@google.com>
Subject: upstream boot error: WARNING: workqueue cpumask: online intersect >
 possible intersect
From:   syzbot <syzbot+617bb3fa2faf71627289@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f1a3b43c Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1456d348600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19dd7cf81d8c8469
dashboard link: https://syzkaller.appspot.com/bug?extid=617bb3fa2faf71627289
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+617bb3fa2faf71627289@syzkaller.appspotmail.com

smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f,  
stepping: 0x0)
Performance Events: unsupported p6 CPU model 63 no PMU driver, software  
events only.
rcu: Hierarchical SRCU implementation.
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
MDS CPU bug present and SMT on, data leak possible. See  
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for  
more details.
smp: Brought up 2 nodes, 2 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 2 processors activated (9200.00 BogoMIPS)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:  
19112604462750000 ns
futex hash table entries: 512 (order: 4, 65536 bytes, vmalloc)
xor: automatically using best checksumming function   avx
PM: RTC time: 23:47:05, date: 2019-07-20
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
cpuidle: using governor menu
ACPI: bus type PCI registered
dca service started, version 1.12.1
PCI: Using configuration type 1 for base access
WARNING: workqueue cpumask: online intersect > possible intersect
HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
cryptd: max_cpu_qlen set to 1000
raid6: avx2x4   gen() 12030 MB/s
raid6: avx2x4   xor()  6604 MB/s
raid6: avx2x2   gen()  7204 MB/s
raid6: avx2x2   xor()  3631 MB/s
raid6: avx2x1   gen()  3894 MB/s
raid6: avx2x1   xor()  1973 MB/s
raid6: sse2x4   gen()  5678 MB/s
raid6: sse2x4   xor()  3254 MB/s
raid6: sse2x2   gen()  3598 MB/s
raid6: sse2x2   xor()  1878 MB/s
raid6: sse2x1   gen()  1864 MB/s
raid6: sse2x1   xor()   986 MB/s
raid6: using algorithm avx2x4 gen() 12030 MB/s
raid6: .... xor() 6604 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 2 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and  
report a bug
ACPI: Enabled 16 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended  
PCI configuration space under this bridge.
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
pci 0000:00:01.0: [8086:7110] type 00 class 0x060100
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000
pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
pci 0000:00:03.0: reg 0x14: [mem 0xfebfe000-0xfebfe07f]
pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000
pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
pci 0000:00:04.0: reg 0x14: [mem 0xfebff000-0xfebff07f]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
vgaarb: loaded
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti  
<giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
PCI: Using ACPI for IRQ routing
Bluetooth: Core ver 2.22
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
NET: Registered protocol family 8
NET: Registered protocol family 20
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
nfc: nfc_init: NFC Core ver 0.1
NET: Registered protocol family 39
clocksource: Switched to clocksource kvm-clock
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
FS-Cache: Loaded
*** VALIDATE hugetlbfs ***
CacheFiles: Loaded
TOMOYO: 2.6.0
Mandatory Access Control activated.
AppArmor: AppArmor Filesystem Enabled
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns:  
2085701024 ns
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes,  
vmalloc)
TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
TCP bind hash table entries: 65536 (order: 10, 4194304 bytes, vmalloc)
TCP: Hash tables configured (established 65536 bind 65536)
UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NET: Registered protocol family 44
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
PCI: CLS 0 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0xaa800000-0xae800000] (64MB)
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl  
timer
kvm: already loaded the other module
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x212735223b2,  
max_idle_ns: 440795277976 ns
clocksource: Switched to clocksource tsc
mce: Machine check injector initialized
check: Scanning for low memory corruption every 60 seconds
Initialise system trusted keyrings
workingset: timestamp_bits=40 max_order=21 bucket_order=0
zbud: loaded
DLM installed
squashfs: version 4.0 (2009/01/31) Phillip Lougher
FS-Cache: Netfs 'nfs' registered for caching
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ntfs: driver 2.1.32 [Flags: R/W].
fuse: init (API version 7.31)
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, realtime, no debug enabled
9p: Installing v9fs 9p2000 file system support
FS-Cache: Netfs '9p' registered for caching
gfs2: GFS2 installed
FS-Cache: Netfs 'ceph' registered for caching
ceph: loaded (mds proto 32)
NET: Registered protocol family 38
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Asymmetric key parser 'tpm_parser' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
PCI Interrupt Link [LNKC] enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
PCI Interrupt Link [LNKD] enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
HDLC line discipline maxframe=4096
N_HDLC line discipline registered.
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
usbcore: registered new interface driver udl
brd: module loaded
loop: module loaded
zram: Added device: zram0
null: module loaded
nfcsim 0.2 initialized
Loading iSCSI transport class v2.0-870.
scsi host0: Virtio SCSI HBA
st: Version 20160209, fixed bufsize 32768, s/g segs 256
kobject: 'sd' (00000000b49c372c): kobject_uevent_env
kobject: 'sd' (00000000b49c372c): fill_kobj_path: path  
= '/bus/scsi/drivers/sd'
kobject: 'sr' (00000000a6862356): kobject_add_internal: parent: 'drivers',  
set: 'drivers'
kobject: 'sr' (00000000a6862356): kobject_uevent_env
kobject: 'sr' (00000000a6862356): fill_kobj_path: path  
= '/bus/scsi/drivers/sr'
kobject: 'scsi_generic' (00000000d8a5b23f): kobject_add_internal:  
parent: 'class', set: 'class'
kobject: 'scsi_generic' (00000000d8a5b23f): kobject_uevent_env
kobject: 'scsi_generic' (00000000d8a5b23f): fill_kobj_path: path  
= '/class/scsi_generic'
kobject: 'nvme-wq' (000000007f0c1f5a): kobject_add_internal:  
parent: 'workqueue', set: 'devices'
kobject: 'nvme-wq' (000000007f0c1f5a): kobject_uevent_env
kobject: 'nvme-wq' (000000007f0c1f5a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'nvme-wq' (000000007f0c1f5a): kobject_uevent_env
kobject: 'nvme-wq' (000000007f0c1f5a): fill_kobj_path: path  
= '/devices/virtual/workqueue/nvme-wq'
kobject: 'nvme-reset-wq' (0000000096836f26): kobject_add_internal:  
parent: 'workqueue', set: 'devices'
kobject: 'nvme-reset-wq' (0000000096836f26): kobject_uevent_env
kobject: 'nvme-reset-wq' (0000000096836f26): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'nvme-reset-wq' (0000000096836f26): kobject_uevent_env
kobject: 'nvme-reset-wq' (0000000096836f26): fill_kobj_path: path  
= '/devices/virtual/workqueue/nvme-reset-wq'
kobject: 'nvme-delete-wq' (000000003683ec6a): kobject_add_internal:  
parent: 'workqueue', set: 'devices'
kobject: 'nvme-delete-wq' (000000003683ec6a): kobject_uevent_env
kobject: 'nvme-delete-wq' (000000003683ec6a): kobject_uevent_env:  
uevent_suppress caused the event to drop!
kobject: 'nvme-delete-wq' (000000003683ec6a): kobject_uevent_env
kobject: 'nvme-delete-wq' (000000003683ec6a): fill_kobj_path: path  
= '/devices/virtual/workqueue/nvme-delete-wq'
kobject: 'nvme' (00000000d89c8145): kobject_add_internal: parent: 'class',  
set: 'class'
kobject: 'nvme' (00000000d89c8145): kobject_uevent_env
kobject: 'nvme' (00000000d89c8145): fill_kobj_path: path = '/class/nvme'
kobject: 'nvme-subsystem' (0000000043898737): kobject_add_internal:  
parent: 'class', set: 'class'
kobject: 'nvme-subsystem' (0000000043898737): kobject_uevent_env
kobject: 'nvme-subsystem' (0000000043898737): fill_kobj_path: path  
= '/class/nvme-subsystem'
kobject: 'nvme' (0000000036e1f73d): kobject_add_internal:  
parent: 'drivers', set: 'drivers'
kobject: 'drivers' (00000000cb9e764c): kobject_add_internal:  
parent: 'nvme', set: '<NULL>'
kobject: 'nvme' (0000000036e1f73d): kobject_uevent_env
kobject: 'nvme' (0000000036e1f73d): fill_kobj_path: path  
= '/bus/pci/drivers/nvme'
kobject: 'ahci' (00000000928dd74b): kobject_add_internal:  
parent: 'drivers', set: 'drivers'
kobject: 'drivers' (00000000b51b8ff3): kobject_add_internal:  
parent: 'ahci', set: '<NULL>'
kobject: 'ahci' (00000000928dd74b): kobject_uevent_env
kobject: 'ahci' (00000000928dd74b): fill_kobj_path: path  
= '/bus/pci/drivers/ahci'
kobject: 'ata_piix' (00000000810e7425): kobject_add_internal:  
parent: 'drivers', set: 'drivers'
kobject: 'drivers' (00000000ad49f648): kobject_add_internal:  
parent: 'ata_piix', set: '<NULL>'
kobject: 'ata_piix' (00000000810e7425): kobject_uevent_env
kobject: 'ata_piix' (00000000810e7425): fill_kobj_path: path  
= '/bus/pci/drivers/ata_piix'
kobject: 'pata_amd' (00000000aa4ed36e): kobject_add_internal:  
parent: 'drivers', set: 'drivers'
kobject: 'drivers' (000000007e085244): kobject_add_internal:  
parent: 'pata_amd', set: '<NULL>'
kobject: 'pata_amd' (00000000aa4ed36e): kobject_uevent_env
kobject: 'pata_amd' (00000000aa4ed36e): fill_kobj_path: path  
= '/bus/pci/drivers/pata_amd'
kobject: 'pata_oldpiix' (000000005d80b7b2): kobject_add_internal:  
parent: 'drivers', set: 'drivers'
kobject: 'drivers' (000000008000d66e): kobject_add_internal:  
parent: 'pata_oldpiix', set: '<NULL>'
kobject: 'pata_oldpiix' (000000005d80b7b2): kobject_uevent_env
kobject: 'pata_oldpiix' (000000005d80b7b2): fill_kobj_path: path  
= '/bus/pci/drivers/pata_oldpiix'
kobject: 'pata_sch' (00000000bb97bce7): kobject_add_internal:  
parent: 'drivers', set: 'drivers'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
