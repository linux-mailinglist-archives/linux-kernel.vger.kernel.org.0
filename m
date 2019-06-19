Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1B4C2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 23:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfFSVDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 17:03:32 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:41046 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSVDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:03:31 -0400
From:   Meelis Roos <mroos@linux.ee>
Subject: Bootup percpu allocation failures/crashes and idle crashes on Sun
 T5140
To:     "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <d203cd3e-94f1-d9a7-9b99-4979ebcf8bb4@linux.ee>
Date:   Thu, 20 Jun 2019 00:01:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 5.2-git kernels on my T5140 (where 5.1.0 worked fine). It does not boot but the symptoms vary:

* Sometimes there are just cascading allocation failkures and it gets nowhere.

* Sometimes it gets into idle and spews different crashes from there
(similar to the Sun V445 idle crash I just reported)

* Sometimes there is stream of different oopses.

Will try to bisect but mught not have much time.

Dmesg with percpu allocation failures + random oopses:

[    0.000022] PROMLIB: Sun IEEE Boot Prom 'OBP 4.33.6.h 2017/05/04 14:23'

[    0.000030] PROMLIB: Root node compatible: sun4v

[    0.000066] Linux version 5.2.0-rc5 (mroos@t5140) (gcc version 8.3.0 (Debian 8.3.0-7)) #220 SMP Mon Jun 17 16:53:23 EEST 2019

[    0.000147] printk: debug: ignoring loglevel setting.

[    0.004082] printk: bootconsole [earlyprom0] enabled

[    0.004437] ARCH: SUN4V

[    0.005042] Ethernet address: 00:21:28:05:3a:a4

[    0.005379] MM: PAGE_OFFSET is 0xffff800000000000 (max_phys_bits == 39)

[    0.006195] MM: VMALLOC [0x0000000100000000 --> 0x0000600000000000]

[    0.006634] MM: VMEMMAP [0x0000600000000000 --> 0x0000c00000000000]

[    0.098911] Kernel: Using 3 locked TLB entries for main kernel image.

[    0.099764] Remapping the kernel...

[    0.099787] done.

[    1.961451] OF stdout device is: /virtual-devices@100/console@1

[    1.962592] PROM: Built device tree with 188124 bytes of memory.

[    1.963014] MDESC: Size is 74544 bytes.

[    1.965188] PLATFORM: banner-name [T5140]

[    1.965682] PLATFORM: name [SUNW,T5140]

[    1.966334] PLATFORM: hostid [85053aa4]

[    1.966986] PLATFORM: serial# [00ab4130]

[    1.967642] PLATFORM: stick-frequency [457656f0]

[    1.968342] PLATFORM: mac-address [2128053aa4]

[    1.968824] PLATFORM: watchdog-resolution [1000 ms]

[    1.969443] PLATFORM: watchdog-max-timeout [31536000000 ms]

[    1.970350] PLATFORM: max-cpus [128]

[    2.043628] Allocated 16384 bytes for kernel page tables.

[    2.044797] Zone ranges:

[    2.044997]   Normal   [mem 0x000000000e400000-0x00000001ffb8dfff]

[    2.045444] Movable zone start for each node

[    2.045742] Early memory node ranges

[    2.046048]   node   0: [mem 0x000000000e400000-0x000000003fffffff]

[    2.046524]   node   1: [mem 0x0000000040000000-0x000000007fffffff]

[    2.047049]   node   0: [mem 0x0000000080000000-0x00000000bfffffff]

[    2.047525]   node   1: [mem 0x00000000c0000000-0x00000000ffffffff]

[    2.048037]   node   0: [mem 0x0000000100000000-0x000000013fffffff]

[    2.048562]   node   1: [mem 0x0000000140000000-0x000000017fffffff]

[    2.049074]   node   0: [mem 0x0000000180000000-0x00000001bfffffff]

[    2.049550]   node   1: [mem 0x00000001c0000000-0x00000001ffa81fff]

[    2.050024]   node   1: [mem 0x00000001ffa92000-0x00000001ffaa5fff]

[    2.050598]   node   1: [mem 0x00000001ffb80000-0x00000001ffb8dfff]

[    2.057977] Zeroed struct page in unavailable ranges: 29301 pages

[    2.057987] Initmem setup node 0 [mem 0x000000000e400000-0x00000001bfffffff]

[    2.060031] On node 0 totalpages: 495104

[    2.060360]   Normal zone: 4352 pages used for memmap

[    2.060758]   Normal zone: 0 pages reserved

[    2.061103]   Normal zone: 495104 pages, LIFO batch:31

[    2.260113] Initmem setup node 1 [mem 0x0000000040000000-0x00000001ffb8dfff]

[    2.261453] On node 1 totalpages: 523602

[    2.262973]   Normal zone: 4602 pages used for memmap

[    2.263702]   Normal zone: 0 pages reserved

[    2.264378]   Normal zone: 523602 pages, LIFO batch:31

[    2.481479] Booting Linux...

[    2.482137] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]

[    2.484411] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit]

[    3.093097] percpu: Embedded 11 pages/cpu s46168 r8192 d35752 u131072

[    3.100933] pcpu-alloc: s46168 r8192 d35752 u131072 alloc=1*4194304

[    3.101769] pcpu-alloc: [0] 000 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031

[    3.103883] pcpu-alloc: [0] 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058 059 060 061 062 063

[    3.105814] pcpu-alloc: [0] 072 073 074 075 076 077 078 079 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127

[    3.106827] pcpu-alloc: [1] 064 065 066 067 068 069 070 071 080 081 082 083 084 085 086 087 088 089 090 091 092 093 094 095 096 097 098 099 100 101 102 103

[    3.125385] SUN4V: Mondo queue sizes [cpu(16384) dev(16384) r(8192) nr(256)]

[    3.131544] Built 2 zonelists, mobility grouping on.  Total pages: 1009752

[    3.132416] Policy zone: Normal

[    3.132648] Kernel command line: root=/dev/sda1 ro console=ttyS1 ignore_loglevel initcall_debug

[    3.134136] printk: log_buf_len individual max cpu contribution: 4096 bytes

[    3.134866] printk: log_buf_len total cpu_extra contributions: 520192 bytes

[    3.135348] printk: log_buf_len min size: 65536 bytes

[    3.138984] printk: log_buf_len: 1048576 bytes

[    3.139655] printk: early log buf free: 60880(92%)

[    3.140381] Sorting __ex_table...

[    3.351967] Memory: 8050376K/8149648K available (5795K kernel code, 319K rwdata, 1632K rodata, 264K init, 275K bss, 99272K reserved, 0K cma-reserved)

[    3.357582] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=128, Nodes=16

[    3.364283] rcu: Hierarchical RCU implementation.

[    3.364975] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.

[    3.366267] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1

[    3.367017] SUN4V: Using IRQ API major 1, cookie only virqs disabled

[    3.378170] clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x10cc5eb20f1, max_idle_ns: 440795243037 ns

[    3.379259] clocksource: mult[dbab92] shift[24]

[    3.379932] clockevent: mult[952b4894] shift[31]

[    3.381632] Console: colour dummy device 80x25

[    3.530847] Calibrating delay using timer specific routine.. 2333.52 BogoMIPS (lpj=11667635)

[    3.533309] pid_max: default: 131072 minimum: 1024

[    3.536800] LSM: Security Framework initializing

[    3.538036] AppArmor: AppArmor initialized

[    3.548582] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)

[    3.555651] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)

[    3.557092] Mount-cache hash table entries: 16384 (order: 4, 131072 bytes)

[    3.557727] Mountpoint-cache hash table entries: 16384 (order: 4, 131072 bytes)

[    3.566808] calling  cpu_type_probe+0x0/0x3a4 @ 1

[    3.567890] initcall cpu_type_probe+0x0/0x3a4 returned 0 after 0 usecs

[    3.568710] calling  spawn_ksoftirqd+0x0/0x54 @ 1

[    3.569188] initcall spawn_ksoftirqd+0x0/0x54 returned 0 after 0 usecs

[    3.569656] calling  migration_init+0x0/0x44 @ 1

[    3.570002] initcall migration_init+0x0/0x44 returned 0 after 0 usecs

[    3.570461] calling  srcu_bootup_announce+0x0/0x3c @ 1

[    3.570828] rcu: Hierarchical SRCU implementation.

[    3.571203] initcall srcu_bootup_announce+0x0/0x3c returned 0 after 9765 usecs

[    3.571724] calling  rcu_sysrq_init+0x0/0x30 @ 1

[    3.572067] initcall rcu_sysrq_init+0x0/0x30 returned 0 after 0 usecs

[    3.572525] calling  check_cpu_stall_init+0x0/0x20 @ 1

[    3.572903] initcall check_cpu_stall_init+0x0/0x20 returned 0 after 0 usecs

[    3.573407] calling  rcu_spawn_gp_kthread+0x0/0x12c @ 1

[    3.574189] initcall rcu_spawn_gp_kthread+0x0/0x12c returned 0 after 0 usecs

[    3.574686] calling  cpu_stop_init+0x0/0xcc @ 1

[    3.575175] initcall cpu_stop_init+0x0/0xcc returned 0 after 0 usecs

[    3.575995] calling  jump_label_init_module+0x0/0x14 @ 1

[    3.576381] initcall jump_label_init_module+0x0/0x14 returned 0 after 0 usecs

[    3.577580] calling  initialize_ptr_random+0x0/0x64 @ 1

[    3.578317] initcall initialize_ptr_random+0x0/0x64 returned 0 after 0 usecs

[    3.587289] smp: Bringing up secondary CPUs ...

[    3.659519] smp: Brought up 2 nodes, 64 CPUs

[    3.669972] devtmpfs: initialized

[    3.678293] calling  init_hw_perf_events+0x0/0x1d4 @ 1

[    3.679005] Performance events:

[    3.679120] Testing NMI watchdog ...

[    3.880256] OK.

[    3.881380] Supported PMU type is 'niagara2'

[    3.882291] initcall init_hw_perf_events+0x0/0x1d4 returned 0 after 9765 usecs

[    3.883522] calling  bpf_jit_charge_init+0x0/0x40 @ 1

[    3.884243] initcall bpf_jit_charge_init+0x0/0x40 returned 0 after 0 usecs

[    3.885092] calling  ipc_ns_init+0x0/0x40 @ 1

[    3.885781] random: get_random_u32 called from bucket_table_alloc.isra.27+0x58/0x160 with crng_init=0

[    3.891545] initcall ipc_ns_init+0x0/0x40 returned 0 after 9765 usecs

[    3.895239] calling  init_mmap_min_addr+0x0/0x18 @ 1

[    3.895957] initcall init_mmap_min_addr+0x0/0x18 returned 0 after 0 usecs

[    3.898856] calling  pci_realloc_setup_params+0x0/0x24 @ 1

[    3.900788] initcall pci_realloc_setup_params+0x0/0x24 returned 0 after 0 usecs

[    3.904996] calling  net_ns_init+0x0/0x138 @ 1

[    3.905965] initcall net_ns_init+0x0/0x138 returned 0 after 0 usecs

[    3.907447] calling  sparc_sysrq_init+0x0/0x38 @ 1

[    3.908237] initcall sparc_sysrq_init+0x0/0x38 returned 0 after 0 usecs

[    3.909421] calling  sstate_init+0x0/0x88 @ 1

[    3.909837] initcall sstate_init+0x0/0x88 returned 0 after 0 usecs

[    3.910969] calling  wq_sysfs_init+0x0/0x38 @ 1

[    3.911794] initcall wq_sysfs_init+0x0/0x38 returned 0 after 0 usecs

[    3.912411] kworker/u257:0 (334) used greatest stack depth: 9000 bytes left

[    3.912614] calling  ksysfs_init+0x0/0x94 @ 1

[    3.914136] initcall ksysfs_init+0x0/0x94 returned 0 after 0 usecs

[    3.915212] calling  pm_init+0x0/0x58 @ 1

[    3.916536] initcall pm_init+0x0/0x58 returned 0 after 0 usecs

[    3.917201] calling  rcu_set_runtime_mode+0x0/0x14 @ 1

[    3.917665] initcall rcu_set_runtime_mode+0x0/0x14 returned 0 after 0 usecs

[    3.918243] calling  init_jiffies_clocksource+0x0/0x1c @ 1

[    3.918723] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns

[    3.919485] initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 0 usecs

[    3.920082] calling  futex_init+0x0/0xdc @ 1

[    3.920859] futex hash table entries: 32768 (order: 8, 2097152 bytes)

[    3.929312] initcall futex_init+0x0/0xdc returned 0 after 0 usecs

[    3.930115] calling  cgroup_wq_init+0x0/0x44 @ 1

[    3.931360] initcall cgroup_wq_init+0x0/0x44 returned 0 after 0 usecs

[    3.932289] calling  cgroup1_wq_init+0x0/0x40 @ 1

[    3.933229] initcall cgroup1_wq_init+0x0/0x40 returned 0 after 0 usecs

[    3.933744] calling  init_zero_pfn+0x0/0x44 @ 1

[    3.934081] initcall init_zero_pfn+0x0/0x44 returned 0 after 0 usecs

[    3.934533] calling  init_per_zone_wmark_min+0x0/0x98 @ 1

[    3.934975] initcall init_per_zone_wmark_min+0x0/0x98 returned 0 after 0 usecs

[    3.935496] calling  fsnotify_init+0x0/0x50 @ 1

[    3.936231] initcall fsnotify_init+0x0/0x50 returned 0 after 0 usecs

[    3.936687] calling  filelock_init+0x0/0xb4 @ 1

[    3.937215] initcall filelock_init+0x0/0xb4 returned 0 after 0 usecs

[    3.937669] calling  init_misc_binfmt+0x0/0x34 @ 1

[    3.938031] initcall init_misc_binfmt+0x0/0x34 returned 0 after 0 usecs

[    3.938512] calling  init_script_binfmt+0x0/0x20 @ 1

[    3.938927] initcall init_script_binfmt+0x0/0x20 returned 0 after 0 usecs

[    3.939407] calling  init_elf_binfmt+0x0/0x20 @ 1

[    3.939813] initcall init_elf_binfmt+0x0/0x20 returned 0 after 0 usecs

[    3.940278] calling  init_compat_elf_binfmt+0x0/0x20 @ 1

[    3.940691] initcall init_compat_elf_binfmt+0x0/0x20 returned 0 after 0 usecs

[    3.941262] calling  debugfs_init+0x0/0x64 @ 1

[    3.941633] initcall debugfs_init+0x0/0x64 returned 0 after 0 usecs

[    3.942130] calling  securityfs_init+0x0/0x7c @ 1

[    3.942872] initcall securityfs_init+0x0/0x7c returned 0 after 0 usecs

[    3.943393] calling  prandom_init+0x0/0xe8 @ 1

[    3.943837] initcall prandom_init+0x0/0xe8 returned 0 after 0 usecs

[    3.944349] calling  component_debug_init+0x0/0x28 @ 1

[    3.944956] initcall component_debug_init+0x0/0x28 returned 0 after 0 usecs

[    3.945500] calling  sock_init+0x0/0xb4 @ 1

[    3.946639] initcall sock_init+0x0/0xb4 returned 0 after 0 usecs

[    3.947073] calling  net_inuse_init+0x0/0x2c @ 1

[    3.947557] initcall net_inuse_init+0x0/0x2c returned 0 after 0 usecs

[    3.948017] calling  net_defaults_init+0x0/0x2c @ 1

[    3.948429] initcall net_defaults_init+0x0/0x2c returned 0 after 0 usecs

[    3.948916] calling  init_default_flow_dissectors+0x0/0x58 @ 1

[    3.949340] initcall init_default_flow_dissectors+0x0/0x58 returned 0 after 0 usecs

[    3.949938] calling  netpoll_init+0x0/0x1c @ 1

[    3.950258] initcall netpoll_init+0x0/0x1c returned 0 after 0 usecs

[    3.950776] calling  netlink_proto_init+0x0/0x15c @ 1

[    3.951270] NET: Registered protocol family 16

[    3.951672] initcall netlink_proto_init+0x0/0x15c returned 0 after 0 usecs

[    3.952278] calling  scan_of_devices+0x0/0x3c @ 1

[    3.980896] initcall scan_of_devices+0x0/0x3c returned 0 after 29296 usecs

[    3.981428] calling  irq_sysfs_init+0x0/0xb8 @ 1

[    3.983235] initcall irq_sysfs_init+0x0/0xb8 returned 0 after 0 usecs

[    3.983706] calling  audit_init+0x0/0x168 @ 1

[    3.984058] audit: initializing netlink subsys (disabled)

[    3.984714] initcall audit_init+0x0/0x168 returned 0 after 0 usecs

[    3.984721] audit: type=2000 audit(0.400:1): state=initialized audit_enabled=0 res=1

[    3.985752] calling  bdi_class_init+0x0/0x5c @ 1

[    3.986152] initcall bdi_class_init+0x0/0x5c returned 0 after 0 usecs

[    3.986617] calling  mm_sysfs_init+0x0/0x30 @ 1

[    3.987013] initcall mm_sysfs_init+0x0/0x30 returned 0 after 0 usecs

[    3.987467] calling  pcibus_class_init+0x0/0x1c @ 1

[    3.987908] initcall pcibus_class_init+0x0/0x1c returned 0 after 0 usecs

[    3.988392] calling  pci_driver_init+0x0/0x30 @ 1

[    3.988869] initcall pci_driver_init+0x0/0x30 returned 0 after 0 usecs

[    3.989396] calling  tty_class_init+0x0/0x4c @ 1

[    3.989771] initcall tty_class_init+0x0/0x4c returned 0 after 0 usecs

[    3.990282] calling  vtconsole_class_init+0x0/0xe8 @ 1

[    3.990801] initcall vtconsole_class_init+0x0/0xe8 returned 0 after 0 usecs

[    3.991349] calling  software_node_init+0x0/0x34 @ 1

[    3.991725] initcall software_node_init+0x0/0x34 returned 0 after 0 usecs

[    3.992242] calling  register_node_type+0x0/0x1c @ 1

[    3.992718] initcall register_node_type+0x0/0x1c returned 0 after 0 usecs

[    3.993200] calling  kobject_uevent_init+0x0/0x14 @ 1

[    3.993639] initcall kobject_uevent_init+0x0/0x14 returned 0 after 0 usecs

[    3.994227] calling  report_memory+0x0/0x174 @ 1

[    3.994625] initcall report_memory+0x0/0x174 returned 0 after 0 usecs

[    3.995082] calling  hugetlbpage_init+0x0/0x30 @ 1

[    3.995449] initcall hugetlbpage_init+0x0/0x30 returned 0 after 0 usecs

[    3.995915] calling  cryptomgr_init+0x0/0x14 @ 1

[    3.996258] initcall cryptomgr_init+0x0/0x14 returned 0 after 0 usecs

[    3.996841] calling  topology_init+0x0/0x110 @ 1

[    4.021654] initcall topology_init+0x0/0x110 returned 0 after 29296 usecs

[    4.022222] calling  sbus_init+0x0/0x43c @ 1

[    4.022653] initcall sbus_init+0x0/0x43c returned 0 after 0 usecs

[    4.023147] calling  pcibios_init+0x0/0x14 @ 1

[    4.023478] initcall pcibios_init+0x0/0x14 returned 0 after 0 usecs

[    4.023922] calling  psycho_init+0x0/0x18 @ 1

[    4.025052] initcall psycho_init+0x0/0x18 returned 0 after 0 usecs

[    4.025494] calling  sabre_init+0x0/0x18 @ 1

[    4.026361] initcall sabre_init+0x0/0x18 returned 0 after 0 usecs

[    4.026811] calling  schizo_init+0x0/0x18 @ 1

[    4.027819] initcall schizo_init+0x0/0x18 returned 0 after 0 usecs

[    4.028273] calling  pci_sun4v_init+0x0/0x18 @ 1

[    4.028947] pci_sun4v: Registered hvapi major[2] minor[0]

[    4.030614] pci@400: SUN4V PCI Bus Module

[    4.030919] pci@400: On NUMA node 0

[    4.031179] pci@400: PCI IO [io  0xc0f0000000-0xc0ffffffff] offset c0f0000000

[    4.031734] pci@400: PCI MEM [mem 0xc100000000-0xc17ffeffff] offset c100000000

[    4.032237] pci@400: PCI MEM64 [mem 0xc200000000-0xc5fffeffff] offset c200000000

[    4.032818] pci@400: Unable to request IOMMU resource.

[    4.083179] pci@400: Imported 3 TSB entries from OBP

[    4.088857] pci@400: MSI Queue first[0] num[36] count[128] devino[0x18]

[    4.089324] pci@400: MSI first[0] num[256] mask[0xff] width[32]

[    4.089744] pci@400: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]

[    4.090261] pci@400: MSI queues at RA [00000001fb500000]

[    4.090653] PCI: Scanning PBM /pci@400

[    4.091157] pci_sun4v f028cf80: PCI host bridge to bus 0000:02

[    4.091586] pci_bus 0000:02: root bus resource [io  0xc0f0000000-0xc0ffffffff] (bus address [0x0000-0xfffffff])

[    4.092290] pci_bus 0000:02: root bus resource [mem 0xc100000000-0xc17ffeffff] (bus address [0x00000000-0x7ffeffff])

[    4.093033] pci_bus 0000:02: root bus resource [mem 0xc200000000-0xc5fffeffff] (bus address [0x00000000-0x3fffeffff])

[    4.093768] pci_bus 0000:02: root bus resource [bus 02-09]

[    4.094352] pci 0000:02:00.0: [10b5:8548] type 01 class 0x060400

[    4.094787] pci 0000:02:00.0: reg 0x10: [mem 0xc100100000-0xc10011ffff]

[    4.095495] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold

[    4.096650] pci 0000:03:01.0: [10b5:8548] type 01 class 0x060400

[    4.097500] pci 0000:03:01.0: PME# supported from D0 D3hot D3cold

[    4.098632] pci 0000:04:00.0: [10b5:8112] type 01 class 0x060400

[    4.099193] pci 0000:04:00.0: enabling Extended Tags

[    4.099829] pci 0000:04:00.0: supports D1

[    4.100207] pci 0000:04:00.0: PME# supported from D0 D1 D3hot

[    4.101069] pci_bus 0000:05: extended config space not accessible

[    4.101810] pci 0000:05:00.0: [1033:0035] type 00 class 0x0c0310

[    4.102368] pci 0000:05:00.0: reg 0x10: [mem 0xc100200000-0xc100201fff]

[    4.102976] pci 0000:05:00.0: supports D1 D2

[    4.103382] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot

[    4.104216] pci 0000:05:00.1: [1033:0035] type 00 class 0x0c0310

[    4.104651] pci 0000:05:00.1: reg 0x10: [mem 0xc100202000-0xc100203fff]

[    4.105284] pci 0000:05:00.1: supports D1 D2

[    4.105605] pci 0000:05:00.1: PME# supported from D0 D1 D2 D3hot

[    4.106393] pci 0000:05:00.2: [1033:00e0] type 00 class 0x0c0320

[    4.106875] pci 0000:05:00.2: reg 0x10: [mem 0xc100204000-0xc100205fff]

[    4.107446] pci 0000:05:00.2: supports D1 D2

[    4.107767] pci 0000:05:00.2: PME# supported from D0 D1 D2 D3hot

[    4.108605] pci 0000:03:08.0: [10b5:8548] type 01 class 0x060400

[    4.109309] pci 0000:03:08.0: PME# supported from D0 D3hot D3cold

[    4.110407] pci 0000:06:00.0: [1000:0058] type 00 class 0x010000

[    4.110899] pci 0000:06:00.0: reg 0x10: [io  0xc0f0000000-0xc0f00000ff]

[    4.111379] pci 0000:06:00.0: reg 0x14: [mem 0xc100300000-0xc10030ffff]

[    4.111898] pci 0000:06:00.0: reg 0x1c: [mem 0xc100310000-0xc10031ffff]

[    4.112366] pci 0000:06:00.0: reg 0x30: [mem 0xc100400000-0xc1007fffff]

[    4.112860] pci 0000:06:00.0: enabling Extended Tags

[    4.113443] pci 0000:06:00.0: supports D1 D2

[    4.114209] pci 0000:03:09.0: [10b5:8548] type 01 class 0x060400

[    4.114926] pci 0000:03:09.0: PME# supported from D0 D3hot D3cold

[    4.116036] pci 0000:07:00.0: [8086:10b9] type 00 class 0x020000

[    4.116520] pci 0000:07:00.0: reg 0x10: [mem 0xc100800000-0xc10081ffff]

[    4.117000] pci 0000:07:00.0: reg 0x14: [mem 0xc100820000-0xc10083ffff]

[    4.117518] pci 0000:07:00.0: reg 0x18: [io  0xc0f0001000-0xc0f000101f]

[    4.117986] pci 0000:07:00.0: reg 0x30: [mem 0xc100840000-0xc10085ffff]

[    4.118679] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold

[    4.119662] pci 0000:03:0c.0: [10b5:8548] type 01 class 0x060400

[    4.120394] pci 0000:03:0c.0: PME# supported from D0 D3hot D3cold

[    4.121516] pci 0000:03:0d.0: [10b5:8548] type 01 class 0x060400

[    4.122183] pci 0000:03:0d.0: PME# supported from D0 D3hot D3cold

[    4.123346] probe of f028cf80 returned 1 after 100000 usecs

[    4.123902] pci@500: SUN4V PCI Bus Module

[    4.124251] pci@500: On NUMA node 1

[    4.124521] pci@500: PCI IO [io  0xc4f0000000-0xc4ffffffff] offset c4f0000000

[    4.125054] pci@500: PCI MEM [mem 0xc500000000-0xc57ffeffff] offset c500000000

[    4.125555] pci@500: PCI MEM64 [mem 0xc600000000-0xc9fffeffff] offset c600000000

[    4.126095] pci@500: Unable to request IOMMU resource.

[    4.181852] pci@500: MSI Queue first[0] num[36] count[128] devino[0x18]

[    4.182389] pci@500: MSI first[0] num[256] mask[0xff] width[32]

[    4.182821] pci@500: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]

[    4.183326] pci@500: MSI queues at RA [00000001b6580000]

[    4.183710] PCI: Scanning PBM /pci@500

[    4.184219] pci_sun4v f0296b40: PCI host bridge to bus 0001:02

[    4.184648] pci_bus 0001:02: root bus resource [io  0xc4f0000000-0xc4ffffffff] (bus address [0x0000-0xfffffff])

[    4.185353] pci_bus 0001:02: root bus resource [mem 0xc500000000-0xc57ffeffff] (bus address [0x00000000-0x7ffeffff])

[    4.186134] pci_bus 0001:02: root bus resource [mem 0xc600000000-0xc9fffeffff] (bus address [0x00000000-0x3fffeffff])

[    4.186881] pci_bus 0001:02: root bus resource [bus 02-07]

[    4.187454] pci 0001:02:00.0: [10b5:8548] type 01 class 0x060400

[    4.187938] pci 0001:02:00.0: reg 0x10: [mem 0xc500100000-0xc50011ffff]

[    4.188691] pci 0001:02:00.0: PME# supported from D0 D3hot D3cold

[    4.189938] pci 0001:03:08.0: [10b5:8548] type 01 class 0x060400

[    4.190714] pci 0001:03:08.0: PME# supported from D0 D3hot D3cold

[    4.191894] pci 0001:04:00.0: [108e:abcd] type 00 class 0x020000

[    4.192329] pci 0001:04:00.0: reg 0x10: [mem 0xc501000000-0xc501ffffff]

[    4.192810] pci 0001:04:00.0: reg 0x18: [mem 0xc500200000-0xc500207fff]

[    4.193333] pci 0001:04:00.0: reg 0x20: [mem 0xc500208000-0xc50020ffff]

[    4.193802] pci 0001:04:00.0: reg 0x30: [mem 0xc500300000-0xc5003fffff]

[    4.195104] pci 0001:04:00.1: [108e:abcd] type 00 class 0x020000

[    4.195540] pci 0001:04:00.1: reg 0x10: [mem 0xc502000000-0xc502ffffff]

[    4.196056] pci 0001:04:00.1: reg 0x18: [mem 0xc500210000-0xc500217fff]

[    4.196536] pci 0001:04:00.1: reg 0x20: [mem 0xc500218000-0xc50021ffff]

[    4.197040] pci 0001:04:00.1: reg 0x30: [mem 0xc500400000-0xc5004fffff]

[    4.198228] pci 0001:04:00.2: [108e:abcd] type 00 class 0x020000

[    4.198725] pci 0001:04:00.2: reg 0x10: [mem 0xc503000000-0xc503ffffff]

[    4.199193] pci 0001:04:00.2: reg 0x18: [mem 0xc500220000-0xc500227fff]

[    4.199699] pci 0001:04:00.2: reg 0x20: [mem 0xc500228000-0xc50022ffff]

[    4.200179] pci 0001:04:00.2: reg 0x30: [mem 0xc500500000-0xc5005fffff]

[    4.201390] pci 0001:04:00.3: [108e:abcd] type 00 class 0x020000

[    4.201825] pci 0001:04:00.3: reg 0x10: [mem 0xc504000000-0xc504ffffff]

[    4.202358] pci 0001:04:00.3: reg 0x18: [mem 0xc500230000-0xc500237fff]

[    4.202826] pci 0001:04:00.3: reg 0x20: [mem 0xc500238000-0xc50023ffff]

[    4.203295] pci 0001:04:00.3: reg 0x30: [mem 0xc500600000-0xc5006fffff]

[    4.204547] pci 0001:03:09.0: [10b5:8548] type 01 class 0x060400

[    4.205314] pci 0001:03:09.0: PME# supported from D0 D3hot D3cold

[    4.206491] pci 0001:03:0c.0: [10b5:8548] type 01 class 0x060400

[    4.207209] pci 0001:03:0c.0: PME# supported from D0 D3hot D3cold

[    4.208392] pci 0001:03:0d.0: [10b5:8548] type 01 class 0x060400

[    4.209117] pci 0001:03:0d.0: PME# supported from D0 D3hot D3cold

[    4.210324] probe of f0296b40 returned 1 after 80000 usecs

[    4.210852] initcall pci_sun4v_init+0x0/0x18 returned 0 after 175781 usecs

[    4.211409] calling  fire_init+0x0/0x18 @ 1

[    4.212383] initcall fire_init+0x0/0x18 returned 0 after 0 usecs

[    4.212852] calling  init_vdso+0x0/0x48 @ 1

[    4.213227] initcall init_vdso+0x0/0x48 returned 0 after 0 usecs

[    4.213659] calling  uid_cache_init+0x0/0x8c @ 1

[    4.214232] initcall uid_cache_init+0x0/0x8c returned 0 after 0 usecs

[    4.214741] calling  param_sysfs_init+0x0/0x1f4 @ 1

[    4.222252] initcall param_sysfs_init+0x0/0x1f4 returned 0 after 9765 usecs

[    4.222789] calling  user_namespace_sysctl_init+0x0/0x50 @ 1

[    4.223245] initcall user_namespace_sysctl_init+0x0/0x50 returned 0 after 0 usecs

[    4.223830] calling  pm_sysrq_init+0x0/0x20 @ 1

[    4.224830] initcall pm_sysrq_init+0x0/0x20 returned 0 after 0 usecs

[    4.225293] calling  crash_save_vmcoreinfo_init+0x0/0x514 @ 1

[    4.225950] initcall crash_save_vmcoreinfo_init+0x0/0x514 returned 0 after 0 usecs

[    4.226482] calling  cgroup_sysfs_init+0x0/0x1c @ 1

[    4.226859] initcall cgroup_sysfs_init+0x0/0x1c returned 0 after 0 usecs

[    4.227398] calling  cgroup_namespaces_init+0x0/0x8 @ 1

[    4.227782] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs

[    4.228275] calling  user_namespaces_init+0x0/0x30 @ 1

[    4.228854] initcall user_namespaces_init+0x0/0x30 returned 0 after 0 usecs

[    4.229413] calling  hung_task_init+0x0/0x58 @ 1

[    4.229909] initcall hung_task_init+0x0/0x58 returned 0 after 0 usecs

[    4.230418] calling  dev_map_init+0x0/0x1c @ 1

[    4.230773] initcall dev_map_init+0x0/0x1c returned 0 after 0 usecs

[    4.231222] calling  stack_map_init+0x0/0x74 @ 1

[    4.231585] initcall stack_map_init+0x0/0x74 returned 0 after 0 usecs

[    4.232089] calling  oom_init+0x0/0x3c @ 1

[    4.232556] initcall oom_init+0x0/0x3c returned 0 after 0 usecs

[    4.233030] calling  cgwb_init+0x0/0x30 @ 1

[    4.233987] initcall cgwb_init+0x0/0x30 returned 0 after 0 usecs

[    4.234418] calling  default_bdi_init+0x0/0x84 @ 1

[    4.235544] initcall default_bdi_init+0x0/0x84 returned 0 after 0 usecs

[    4.236076] calling  percpu_enable_async+0x0/0x14 @ 1

[    4.236445] initcall percpu_enable_async+0x0/0x14 returned 0 after 0 usecs

[    4.236930] calling  init_reserve_notifier+0x0/0x8 @ 1

[    4.237303] initcall init_reserve_notifier+0x0/0x8 returned 0 after 0 usecs

[    4.237864] calling  init_admin_reserve+0x0/0x40 @ 1

[    4.238230] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs

[    4.238759] calling  init_user_reserve+0x0/0x40 @ 1

[    4.239119] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs

[    4.239595] calling  swap_init_sysfs+0x0/0x6c @ 1

[    4.239957] initcall swap_init_sysfs+0x0/0x6c returned 0 after 0 usecs

[    4.240481] calling  swapfile_init+0x0/0xb0 @ 1

[    4.240849] initcall swapfile_init+0x0/0xb0 returned 0 after 0 usecs

[    4.241360] calling  hugetlb_init+0x0/0x570 @ 1

[    4.241700] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages

[    4.242169] HugeTLB registered 8.00 MiB page size, pre-allocated 0 pages

[    4.242686] HugeTLB registered 256 MiB page size, pre-allocated 0 pages

[    4.243162] HugeTLB registered 2.00 GiB page size, pre-allocated 0 pages

[    4.244118] initcall hugetlb_init+0x0/0x570 returned 0 after 0 usecs

[    4.244586] calling  mem_cgroup_swap_init+0x0/0x90 @ 1

[    4.244967] initcall mem_cgroup_swap_init+0x0/0x90 returned 0 after 0 usecs

[    4.245457] calling  mem_cgroup_init+0x0/0x1b4 @ 1

[    4.246489] initcall mem_cgroup_init+0x0/0x1b4 returned 0 after 0 usecs

[    4.247027] calling  crypto_wq_init+0x0/0x30 @ 1

[    4.248071] initcall crypto_wq_init+0x0/0x30 returned 0 after 0 usecs

[    4.248589] calling  seqiv_module_init+0x0/0x14 @ 1

[    4.248950] initcall seqiv_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.249421] calling  hmac_module_init+0x0/0x14 @ 1

[    4.249773] initcall hmac_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.250300] calling  crypto_null_mod_init+0x0/0x7c @ 1

[    4.252549] initcall crypto_null_mod_init+0x0/0x7c returned 0 after 9765 usecs

[    4.253057] calling  md5_mod_init+0x0/0x14 @ 1

[    4.253764] initcall md5_mod_init+0x0/0x14 returned 0 after 0 usecs

[    4.254230] calling  sha1_generic_mod_init+0x0/0x14 @ 1

[    4.254999] initcall sha1_generic_mod_init+0x0/0x14 returned 0 after 0 usecs

[    4.255560] calling  sha256_generic_mod_init+0x0/0x18 @ 1

[    4.256817] initcall sha256_generic_mod_init+0x0/0x18 returned 0 after 0 usecs

[    4.257380] calling  crypto_ecb_module_init+0x0/0x14 @ 1

[    4.257766] initcall crypto_ecb_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.258277] calling  crypto_cbc_module_init+0x0/0x14 @ 1

[    4.258699] initcall crypto_cbc_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.259212] calling  crypto_cts_module_init+0x0/0x14 @ 1

[    4.259610] initcall crypto_cts_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.260108] calling  crypto_module_init+0x0/0x14 @ 1

[    4.260471] initcall crypto_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.261022] calling  crypto_ctr_module_init+0x0/0x18 @ 1

[    4.261426] initcall crypto_ctr_module_init+0x0/0x18 returned 0 after 0 usecs

[    4.261925] calling  aes_init+0x0/0x14 @ 1

[    4.262766] initcall aes_init+0x0/0x14 returned 0 after 0 usecs

[    4.263192] calling  crc32c_mod_init+0x0/0x14 @ 1

[    4.263899] initcall crc32c_mod_init+0x0/0x14 returned 0 after 0 usecs

[    4.264418] calling  drbg_init+0x0/0xc4 @ 1

[    4.267784] initcall drbg_init+0x0/0xc4 returned 0 after 0 usecs

[    4.268267] calling  init_bio+0x0/0xbc @ 1

[    4.269117] initcall init_bio+0x0/0xbc returned 0 after 0 usecs

[    4.269592] calling  blk_settings_init+0x0/0x30 @ 1

[    4.269953] initcall blk_settings_init+0x0/0x30 returned 0 after 0 usecs

[    4.270424] calling  blk_ioc_init+0x0/0x30 @ 1

[    4.270874] initcall blk_ioc_init+0x0/0x30 returned 0 after 0 usecs

[    4.271340] calling  blk_softirq_init+0x0/0xa4 @ 1

[    4.271775] initcall blk_softirq_init+0x0/0xa4 returned 0 after 0 usecs

[    4.272242] calling  blk_mq_init+0x0/0x30 @ 1

[    4.272566] initcall blk_mq_init+0x0/0x30 returned 0 after 0 usecs

[    4.273072] calling  genhd_device_init+0x0/0x80 @ 1

[    4.274522] initcall genhd_device_init+0x0/0x80 returned 0 after 0 usecs

[    4.275008] calling  pci_slot_init+0x0/0x60 @ 1

[    4.275360] initcall pci_slot_init+0x0/0x60 returned 0 after 0 usecs

[    4.275869] calling  misc_init+0x0/0xd0 @ 1

[    4.276252] initcall misc_init+0x0/0xd0 returned 0 after 0 usecs

[    4.276691] calling  vga_arb_device_init+0x0/0x1a0 @ 1

[    4.277333] vgaarb: loaded

[    4.277562] initcall vga_arb_device_init+0x0/0x1a0 returned 0 after 0 usecs

[    4.278053] calling  init_scsi+0x0/0xc8 @ 1

[    4.278828] SCSI subsystem initialized

[    4.279120] initcall init_scsi+0x0/0xc8 returned 0 after 0 usecs

[    4.279550] calling  input_init+0x0/0x108 @ 1

[    4.279928] initcall input_init+0x0/0x108 returned 0 after 0 usecs

[    4.296589] calling  rtc_init+0x0/0x54 @ 1

[    4.298956] initcall rtc_init+0x0/0x54 returned 0 after 0 usecs

[    4.300398] calling  power_supply_class_init+0x0/0x54 @ 1

[    4.301843] initcall power_supply_class_init+0x0/0x54 returned 0 after 0 usecs

[    4.304385] calling  ras_init+0x0/0x14 @ 1

[    4.305727] initcall ras_init+0x0/0x14 returned 0 after 0 usecs

[    4.307173] calling  nvmem_init+0x0/0x14 @ 1

[    4.308567] initcall nvmem_init+0x0/0x14 returned 0 after 0 usecs

[    4.310017] calling  proto_init+0x0/0x14 @ 1

[    4.311411] initcall proto_init+0x0/0x14 returned 0 after 0 usecs

[    4.312855] calling  net_dev_init+0x0/0x25c @ 1

[    4.316170] initcall net_dev_init+0x0/0x25c returned 0 after 0 usecs

[    4.317661] calling  neigh_init+0x0/0xa0 @ 1

[    4.317979] initcall neigh_init+0x0/0xa0 returned 0 after 0 usecs

[    4.321507] calling  fib_notifier_init+0x0/0x14 @ 1

[    4.321869] initcall fib_notifier_init+0x0/0x14 returned 0 after 0 usecs

[    4.323350] calling  fib_rules_init+0x0/0xc4 @ 1

[    4.324709] initcall fib_rules_init+0x0/0xc4 returned 0 after 0 usecs

[    4.326178] calling  bpf_lwt_init+0x0/0x18 @ 1

[    4.327518] initcall bpf_lwt_init+0x0/0x18 returned 0 after 0 usecs

[    4.328984] calling  pktsched_init+0x0/0x124 @ 1

[    4.330355] initcall pktsched_init+0x0/0x124 returned 0 after 0 usecs

[    4.331884] calling  tc_filter_init+0x0/0x138 @ 1

[    4.333302] initcall tc_filter_init+0x0/0x138 returned 0 after 0 usecs

[    4.334776] calling  tc_action_init+0x0/0x60 @ 1

[    4.337140] initcall tc_action_init+0x0/0x60 returned 0 after 0 usecs

[    4.338605] calling  genl_init+0x0/0x48 @ 1

[    4.339965] initcall genl_init+0x0/0x48 returned 0 after 0 usecs

[    4.341410] calling  watchdog_init+0x0/0xa4 @ 1

[    4.343972] initcall watchdog_init+0x0/0xa4 returned 0 after 0 usecs

[    4.346541] calling  clock_init+0x0/0x78 @ 1

[    4.347970] initcall clock_init+0x0/0x78 returned 0 after 0 usecs

[    4.350448] calling  sunfire_init+0x0/0x30 @ 1

[    4.352424] initcall sunfire_init+0x0/0x30 returned 0 after 0 usecs

[    4.353880] calling  auxio_init+0x0/0x18 @ 1

[    4.355425] initcall auxio_init+0x0/0x18 returned 0 after 0 usecs

[    4.356880] calling  clocksource_done_booting+0x0/0x48 @ 1

[    4.358847] clocksource: Switched to clocksource stick

[    4.360238] initcall clocksource_done_booting+0x0/0x48 returned 0 after 1488 usecs

[    4.363863] calling  bpf_init+0x0/0x50 @ 1

[    4.364250] initcall bpf_init+0x0/0x50 returned 0 after 15 usecs

[    4.366756] calling  init_pipe_fs+0x0/0x4c @ 1

[    4.367338] initcall init_pipe_fs+0x0/0x4c returned 0 after 240 usecs

[    4.368841] calling  cgroup_writeback_init+0x0/0x30 @ 1

[    4.370827] initcall cgroup_writeback_init+0x0/0x30 returned 0 after 569 usecs

[    4.372357] calling  inotify_user_setup+0x0/0x50 @ 1

[    4.373750] initcall inotify_user_setup+0x0/0x50 returned 0 after 17 usecs

[    4.374298] calling  eventpoll_init+0x0/0x94 @ 1

[    4.376834] initcall eventpoll_init+0x0/0x94 returned 0 after 146 usecs

[    4.378314] calling  anon_inode_init+0x0/0x60 @ 1

[    4.380903] initcall anon_inode_init+0x0/0x60 returned 0 after 199 usecs

[    4.383410] calling  proc_locks_init+0x0/0x30 @ 1

[    4.384773] initcall proc_locks_init+0x0/0x30 returned 0 after 5 usecs

[    4.387251] calling  proc_cmdline_init+0x0/0x30 @ 1

[    4.388624] initcall proc_cmdline_init+0x0/0x30 returned 0 after 5 usecs

[    4.391141] calling  proc_consoles_init+0x0/0x30 @ 1

[    4.392527] initcall proc_consoles_init+0x0/0x30 returned 0 after 5 usecs

[    4.396041] calling  proc_cpuinfo_init+0x0/0x28 @ 1

[    4.397415] initcall proc_cpuinfo_init+0x0/0x28 returned 0 after 5 usecs

[    4.398920] calling  proc_devices_init+0x0/0x30 @ 1

[    4.401308] initcall proc_devices_init+0x0/0x30 returned 0 after 5 usecs

[    4.403868] calling  proc_interrupts_init+0x0/0x30 @ 1

[    4.406265] initcall proc_interrupts_init+0x0/0x30 returned 0 after 5 usecs

[    4.407802] calling  proc_loadavg_init+0x0/0x30 @ 1

[    4.408169] initcall proc_loadavg_init+0x0/0x30 returned 0 after 5 usecs

[    4.409672] calling  proc_meminfo_init+0x0/0x30 @ 1

[    4.411053] initcall proc_meminfo_init+0x0/0x30 returned 0 after 5 usecs

[    4.413557] calling  proc_stat_init+0x0/0x28 @ 1

[    4.414913] initcall proc_stat_init+0x0/0x28 returned 0 after 5 usecs

[    4.417386] calling  proc_uptime_init+0x0/0x30 @ 1

[    4.419779] initcall proc_uptime_init+0x0/0x30 returned 0 after 4 usecs

[    4.421266] calling  proc_version_init+0x0/0x30 @ 1

[    4.422641] initcall proc_version_init+0x0/0x30 returned 0 after 5 usecs

[    4.426149] calling  proc_softirqs_init+0x0/0x30 @ 1

[    4.427527] initcall proc_softirqs_init+0x0/0x30 returned 0 after 4 usecs

[    4.430043] calling  proc_kcore_init+0x0/0xc8 @ 1

[    4.431428] initcall proc_kcore_init+0x0/0xc8 returned 0 after 18 usecs

[    4.434931] calling  proc_kmsg_init+0x0/0x28 @ 1

[    4.435269] initcall proc_kmsg_init+0x0/0x28 returned 0 after 5 usecs

[    4.437754] calling  proc_page_init+0x0/0x64 @ 1

[    4.440145] initcall proc_page_init+0x0/0x64 returned 0 after 10 usecs

[    4.441631] calling  init_ramfs_fs+0x0/0x34 @ 1

[    4.443985] initcall init_ramfs_fs+0x0/0x34 returned 0 after 0 usecs

[    4.445445] calling  init_hugetlbfs_fs+0x0/0x130 @ 1

[    4.448824] initcall init_hugetlbfs_fs+0x0/0x130 returned 0 after 973 usecs

[    4.451347] calling  aa_create_aafs+0x0/0x370 @ 1

[    4.453573] AppArmor: AppArmor Filesystem Enabled

[    4.454931] initcall aa_create_aafs+0x0/0x370 returned 0 after 2175 usecs

[    4.456416] calling  blk_scsi_ioctl_init+0x0/0xd4 @ 1

[    4.458822] initcall blk_scsi_ioctl_init+0x0/0xd4 returned 0 after 1 usecs

[    4.462347] calling  chr_dev_init+0x0/0xd4 @ 1

[    4.475540] initcall chr_dev_init+0x0/0xd4 returned 0 after 12562 usecs

[    4.476088] calling  firmware_class_init+0x0/0x48 @ 1

[    4.476504] initcall firmware_class_init+0x0/0x48 returned 0 after 42 usecs

[    4.477006] calling  sysctl_core_init+0x0/0x2c @ 1

[    4.477427] initcall sysctl_core_init+0x0/0x2c returned 0 after 61 usecs

[    4.477972] calling  eth_offload_init+0x0/0x1c @ 1

[    4.478328] initcall eth_offload_init+0x0/0x1c returned 0 after 1 usecs

[    4.478834] calling  inet_init+0x0/0x308 @ 1

[    4.480853] NET: Registered protocol family 2

[    4.485160] tcp_listen_portaddr_hash hash table entries: 4096 (order: 3, 65536 bytes)

[    4.486282] TCP established hash table entries: 65536 (order: 6, 524288 bytes)

[    4.490268] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)

[    4.495098] TCP: Hash tables configured (established 65536 bind 65536)

[    4.497067] UDP hash table entries: 4096 (order: 4, 131072 bytes)

[    4.498212] UDP-Lite hash table entries: 4096 (order: 4, 131072 bytes)

[    4.501494] initcall inet_init+0x0/0x308 returned 0 after 20807 usecs

[    4.501960] calling  ipv4_offload_init+0x0/0x90 @ 1

[    4.502325] initcall ipv4_offload_init+0x0/0x90 returned 0 after 1 usecs

[    4.503818] calling  af_unix_init+0x0/0x5c @ 1

[    4.505267] NET: Registered protocol family 1

[    4.507629] initcall af_unix_init+0x0/0x5c returned 0 after 2414 usecs

[    4.510128] calling  ipv6_offload_init+0x0/0x98 @ 1

[    4.511506] initcall ipv6_offload_init+0x0/0x98 returned 0 after 2 usecs

[    4.512989] calling  vlan_offload_init+0x0/0x28 @ 1

[    4.514356] initcall vlan_offload_init+0x0/0x28 returned 0 after 1 usecs

[    4.517862] calling  xsk_init+0x0/0x6c @ 1

[    4.520199] NET: Registered protocol family 44

[    4.520530] initcall xsk_init+0x0/0x6c returned 0 after 318 usecs

[    4.524002] calling  pci_apply_final_quirks+0x0/0x160 @ 1

[    4.525497] pci 0000:05:00.0: calling  quirk_usb_early_handoff+0x0/0x7c0 @ 1

[    4.528139] pci 0000:05:00.0: quirk_usb_early_handoff+0x0/0x7c0 took 120 usecs

[    4.530725] pci 0000:05:00.1: calling  quirk_usb_early_handoff+0x0/0x7c0 @ 1

[    4.532296] pci 0000:05:00.1: quirk_usb_early_handoff+0x0/0x7c0 took 49 usecs

[    4.536868] pci 0000:05:00.2: calling  quirk_usb_early_handoff+0x0/0x7c0 @ 1

[    4.539414] pci 0000:05:00.2: enabling device (0000 -> 0002)

[    4.540994] pci 0000:05:00.2: quirk_usb_early_handoff+0x0/0x7c0 took 1552 usecs

[    4.544584] pci 0000:06:00.0: CLS mismatch (64 != 512), using 64 bytes

[    4.557193] pci 0000:07:00.0: calling  quirk_e100_interrupt+0x0/0x200 @ 1

[    4.558700] pci 0000:07:00.0: quirk_e100_interrupt+0x0/0x200 took 0 usecs

[    4.561371] initcall pci_apply_final_quirks+0x0/0x160 returned 0 after 35109 usecs

[    4.563923] calling  default_rootfs+0x0/0x88 @ 1

[    4.565434] initcall default_rootfs+0x0/0x88 returned 0 after 156 usecs

[    4.568022] calling  power_driver_init+0x0/0x18 @ 1

[    4.570860] initcall power_driver_init+0x0/0x18 returned 0 after 433 usecs

[    4.571405] calling  mdesc_misc_init+0x0/0x14 @ 1

[    4.573936] initcall mdesc_misc_init+0x0/0x14 returned 0 after 162 usecs

[    4.575432] calling  of_pci_slot_init+0x0/0x150 @ 1

[    4.577111] initcall of_pci_slot_init+0x0/0x150 returned 0 after 301 usecs

[    4.580670] calling  audit_classes_init+0x0/0xb0 @ 1

[    4.581112] initcall audit_classes_init+0x0/0xb0 returned 0 after 14 usecs

[    4.583615] calling  proc_execdomains_init+0x0/0x30 @ 1

[    4.585013] initcall proc_execdomains_init+0x0/0x30 returned 0 after 7 usecs

[    4.588544] calling  register_warn_debugfs+0x0/0x30 @ 1

[    4.589976] initcall register_warn_debugfs+0x0/0x30 returned 0 after 18 usecs

[    4.591496] calling  ioresources_init+0x0/0x5c @ 1

[    4.593876] initcall ioresources_init+0x0/0x5c returned 0 after 9 usecs

[    4.597383] calling  timekeeping_init_ops+0x0/0x1c @ 1

[    4.598770] initcall timekeeping_init_ops+0x0/0x1c returned 0 after 1 usecs

[    4.601305] calling  init_clocksource_sysfs+0x0/0x34 @ 1

[    4.602930] initcall init_clocksource_sysfs+0x0/0x34 returned 0 after 212 usecs

[    4.605485] calling  init_timer_list_procfs+0x0/0x38 @ 1

[    4.606930] initcall init_timer_list_procfs+0x0/0x38 returned 0 after 6 usecs

[    4.608455] calling  alarmtimer_init+0x0/0xf4 @ 1

[    4.611150] probe of alarmtimer returned 1 after 49 usecs

[    4.612567] initcall alarmtimer_init+0x0/0xf4 returned 0 after 1685 usecs

[    4.615078] calling  init_posix_timers+0x0/0x30 @ 1

[    4.617600] initcall init_posix_timers+0x0/0x30 returned 0 after 140 usecs

[    4.619122] calling  clockevents_init_sysfs+0x0/0xd8 @ 1

[    4.633859] initcall clockevents_init_sysfs+0x0/0xd8 returned 0 after 12020 usecs

[    4.634478] calling  proc_modules_init+0x0/0x28 @ 1

[    4.634853] initcall proc_modules_init+0x0/0x28 returned 0 after 10 usecs

[    4.635337] calling  modules_wq_init+0x0/0x40 @ 1

[    4.635740] initcall modules_wq_init+0x0/0x40 returned 0 after 0 usecs

[    4.636219] calling  kallsyms_init+0x0/0x28 @ 1

[    4.636552] initcall kallsyms_init+0x0/0x28 returned 0 after 5 usecs

[    4.637015] calling  pid_namespaces_init+0x0/0x30 @ 1

[    4.638449] initcall pid_namespaces_init+0x0/0x30 returned 0 after 54 usecs

[    4.639968] calling  audit_watch_init+0x0/0x3c @ 1

[    4.641338] initcall audit_watch_init+0x0/0x3c returned 0 after 2 usecs

[    4.644839] calling  audit_fsnotify_init+0x0/0x3c @ 1

[    4.646217] initcall audit_fsnotify_init+0x0/0x3c returned 0 after 1 usecs

[    4.648715] calling  audit_tree_init+0x0/0x7c @ 1

[    4.650114] initcall audit_tree_init+0x0/0x7c returned 0 after 19 usecs

[    4.651599] calling  seccomp_sysctl_init+0x0/0x30 @ 1

[    4.653000] initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 22 usecs

[    4.656524] calling  utsname_sysctl_init+0x0/0x1c @ 1

[    4.658949] initcall utsname_sysctl_init+0x0/0x1c returned 0 after 19 usecs

[    4.660455] calling  perf_event_sysfs_init+0x0/0xc4 @ 1

[    4.663099] initcall perf_event_sysfs_init+0x0/0xc4 returned 0 after 238 usecs

[    4.665642] calling  kswapd_init+0x0/0xac @ 1

[    4.667265] initcall kswapd_init+0x0/0xac returned 0 after 281 usecs

[    4.669772] calling  mm_compute_batch_init+0x0/0x5c @ 1

[    4.671171] initcall mm_compute_batch_init+0x0/0x5c returned 0 after 0 usecs

[    4.674702] calling  slab_proc_init+0x0/0x28 @ 1

[    4.675039] initcall slab_proc_init+0x0/0x28 returned 0 after 6 usecs

[    4.678528] calling  workingset_init+0x0/0xb8 @ 1

[    4.680937] workingset: timestamp_bits=42 max_order=20 bucket_order=0

[    4.682433] initcall workingset_init+0x0/0xb8 returned 0 after 1455 usecs

[    4.683922] calling  proc_vmalloc_init+0x0/0x3c @ 1

[    4.686301] initcall proc_vmalloc_init+0x0/0x3c returned 0 after 6 usecs

[    4.689832] calling  procswaps_init+0x0/0x28 @ 1

[    4.691198] initcall procswaps_init+0x0/0x28 returned 0 after 5 usecs

[    4.693673] calling  slab_sysfs_init+0x0/0x120 @ 1

[    4.710572] initcall slab_sysfs_init+0x0/0x120 returned 0 after 15151 usecs

[    4.711160] calling  fcntl_init+0x0/0x30 @ 1

[    4.711493] initcall fcntl_init+0x0/0x30 returned 0 after 20 usecs

[    4.711950] calling  proc_filesystems_init+0x0/0x30 @ 1

[    4.712345] initcall proc_filesystems_init+0x0/0x30 returned 0 after 10 usecs

[    4.712902] calling  start_dirtytime_writeback+0x0/0x48 @ 1

[    4.713311] initcall start_dirtytime_writeback+0x0/0x48 returned 0 after 3 usecs

[    4.713844] calling  blkdev_init+0x0/0x20 @ 1

[    4.714261] initcall blkdev_init+0x0/0x20 returned 0 after 49 usecs

[    4.714712] calling  dio_init+0x0/0x30 @ 1

[    4.717389] initcall dio_init+0x0/0x30 returned 0 after 340 usecs

[    4.718865] calling  dnotify_init+0x0/0x7c @ 1

[    4.721530] initcall dnotify_init+0x0/0x7c returned 0 after 298 usecs

[    4.722055] calling  fanotify_user_setup+0x0/0x58 @ 1

[    4.724710] initcall fanotify_user_setup+0x0/0x58 returned 0 after 259 usecs

[    4.727298] calling  userfaultfd_init+0x0/0x38 @ 1

[    4.729958] initcall userfaultfd_init+0x0/0x38 returned 0 after 260 usecs

[    4.731462] calling  aio_setup+0x0/0x80 @ 1

[    4.733116] initcall aio_setup+0x0/0x80 returned 0 after 318 usecs

[    4.734570] calling  io_uring_init+0x0/0x30 @ 1

[    4.736947] initcall io_uring_init+0x0/0x30 returned 0 after 21 usecs

[    4.740475] calling  fscrypt_init+0x0/0xac @ 1

[    4.743148] initcall fscrypt_init+0x0/0xac returned 0 after 1286 usecs

[    4.743653] calling  init_sys32_ioctl+0x0/0x30 @ 1

[    4.746262] initcall init_sys32_ioctl+0x0/0x30 returned 0 after 233 usecs

[    4.747750] calling  mbcache_init+0x0/0x38 @ 1

[    4.750377] initcall mbcache_init+0x0/0x38 returned 0 after 248 usecs

[    4.751855] calling  init_devpts_fs+0x0/0x30 @ 1

[    4.754263] initcall init_devpts_fs+0x0/0x30 returned 0 after 46 usecs

[    4.756757] calling  ext4_init_fs+0x0/0x210 @ 1

[    4.760597] initcall ext4_init_fs+0x0/0x210 returned 0 after 1428 usecs

[    4.761078] calling  journal_init+0x0/0x164 @ 1

[    4.763264] initcall journal_init+0x0/0x164 returned 0 after 815 usecs

[    4.764746] calling  init_autofs_fs+0x0/0x34 @ 1

[    4.766388] initcall init_autofs_fs+0x0/0x34 returned 0 after 280 usecs

[    4.769927] calling  fuse_init+0x0/0x1e0 @ 1

[    4.770240] fuse: init (API version 7.31)

[    4.773232] initcall fuse_init+0x0/0x1e0 returned 0 after 2909 usecs

[    4.775721] calling  cuse_init+0x0/0xb8 @ 1

[    4.776221] initcall cuse_init+0x0/0xb8 returned 0 after 186 usecs

[    4.779726] calling  ipc_init+0x0/0x38 @ 1

[    4.781093] initcall ipc_init+0x0/0x38 returned 0 after 35 usecs

[    4.783541] calling  ipc_sysctl_init+0x0/0x1c @ 1

[    4.784927] initcall ipc_sysctl_init+0x0/0x1c returned 0 after 26 usecs

[    4.787412] calling  init_mqueue_fs+0x0/0xdc @ 1

[    4.789419] initcall init_mqueue_fs+0x0/0xdc returned 0 after 636 usecs

[    4.790894] calling  key_proc_init+0x0/0x74 @ 1

[    4.793251] initcall key_proc_init+0x0/0x74 returned 0 after 9 usecs

[    4.796734] calling  crypto_algapi_init+0x0/0x14 @ 1

[    4.799138] initcall crypto_algapi_init+0x0/0x14 returned 0 after 5 usecs

[    4.800634] calling  jent_mod_init+0x0/0x3c @ 1

[    4.805962] initcall jent_mod_init+0x0/0x3c returned 0 after 2907 usecs

[    4.806487] calling  proc_genhd_init+0x0/0x58 @ 1

[    4.806842] initcall proc_genhd_init+0x0/0x58 returned 0 after 8 usecs

[    4.810360] calling  bsg_init+0x0/0x114 @ 1

[    4.811729] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)

[    4.814269] initcall bsg_init+0x0/0x114 returned 0 after 2514 usecs

[    4.815764] calling  iolatency_init+0x0/0x14 @ 1

[    4.818134] initcall iolatency_init+0x0/0x14 returned 0 after 14 usecs

[    4.821647] calling  btree_module_init+0x0/0x30 @ 1

[    4.823048] initcall btree_module_init+0x0/0x30 returned 0 after 23 usecs

[    4.825541] calling  percpu_counter_startup+0x0/0x88 @ 1

[    4.830226] initcall percpu_counter_startup+0x0/0x88 returned 0 after 2229 usecs

[    4.830805] calling  sg_pool_init+0x0/0xe0 @ 1

[    4.833579] initcall sg_pool_init+0x0/0xe0 returned 0 after 419 usecs

[    4.835045] calling  pci_proc_init+0x0/0x88 @ 1

[    4.911129] initcall pci_proc_init+0x0/0x88 returned 0 after 206 usecs

[    4.912607] calling  pcie_portdrv_init+0x0/0x4c @ 1

[    4.915716] probe of 0000:02:00.0 returned 0 after 516 usecs

[    4.916452] probe of 0000:03:01.0 returned 0 after 323 usecs

[    4.917933] probe of 0000:04:00.0 returned 0 after 62 usecs

[    4.921769] probe of 0000:03:08.0 returned 0 after 368 usecs

[    4.922573] probe of 0000:03:09.0 returned 0 after 340 usecs

[    4.924337] probe of 0000:03:0c.0 returned 0 after 342 usecs

[    4.926099] probe of 0000:03:0d.0 returned 0 after 342 usecs

[    4.929132] probe of 0001:02:00.0 returned 0 after 606 usecs

[    4.929929] probe of 0001:03:08.0 returned 0 after 384 usecs

[    4.932734] probe of 0001:03:09.0 returned 0 after 361 usecs

[    4.934515] probe of 0001:03:0c.0 returned 0 after 361 usecs

[    4.936297] probe of 0001:03:0d.0 returned 0 after 362 usecs

[    4.938782] initcall pcie_portdrv_init+0x0/0x4c returned 0 after 23234 usecs

[    4.940315] calling  n_null_init+0x0/0x38 @ 1

[    4.941650] initcall n_null_init+0x0/0x38 returned 0 after 1 usecs

[    4.945122] calling  pty_init+0x0/0x210 @ 1

[    4.945595] initcall pty_init+0x0/0x210 returned 0 after 167 usecs

[    4.948067] calling  sysrq_init+0x0/0x68 @ 1

[    4.949454] initcall sysrq_init+0x0/0x68 returned 0 after 15 usecs

[    4.951918] calling  suncore_init+0x0/0x8 @ 1

[    4.953251] initcall suncore_init+0x0/0x8 returned 0 after 0 usecs

[    4.955703] calling  sunhv_init+0x0/0x30 @ 1

[    4.957323] f0286ce8: ttyS0 at I/O 0x0 (irq = 33, base_baud = 115200) is a SUN4V HCONS

[    4.960251] probe of f0286ce8 returned 1 after 2994 usecs

[    4.963462] initcall sunhv_init+0x0/0x30 returned 0 after 6277 usecs

[    4.963921] calling  sunsu_init+0x0/0x1d4 @ 1

[    4.966756] f02a1874: ttyS1 at MMIO 0xfff0ca0000 (irq = 46, base_baud = 115387) is a 16550A

[    4.968367] Console: ttyS2 (SU)

[    4.968844] probe of f02a1874 returned 1 after 2486 usecs

[    4.970331] initcall sunsu_init+0x0/0x1d4 returned 0 after 4952 usecs

[    4.972825] calling  sunsab_init+0x0/0x114 @ 1

[    4.975694] initcall sunsab_init+0x0/0x114 returned 0 after 506 usecs

[    4.976220] calling  topology_sysfs_init+0x0/0x40 @ 1

[    4.980335] initcall topology_sysfs_init+0x0/0x40 returned 0 after 1684 usecs

[    4.980840] calling  cacheinfo_sysfs_init+0x0/0x30 @ 1

[    4.982257] initcall cacheinfo_sysfs_init+0x0/0x30 returned -2 after 30 usecs

[    4.985796] calling  loop_init+0x0/0x144 @ 1

[    5.011788] loop: module loaded

[    5.012047] initcall loop_init+0x0/0x144 returned 0 after 24324 usecs

[    5.012554] calling  sas_transport_init+0x0/0xd0 @ 1

[    5.013238] initcall sas_transport_init+0x0/0xd0 returned 0 after 308 usecs

[    5.013736] calling  init_sd+0x0/0x1d4 @ 1

[    5.014287] initcall init_sd+0x0/0x1d4 returned 0 after 184 usecs

[    5.014725] calling  net_olddevs_init+0x0/0x80 @ 1

[    5.015095] initcall net_olddevs_init+0x0/0x80 returned 0 after 17 usecs

[    5.015580] calling  niu_init+0x0/0x88 @ 1

[    5.016531] niu: niu.c:v1.1 (Apr 22, 2010)

[    5.024176] niu: niu0: Found PHY 002063b0 type MII at phy_port 26

[    5.025019] niu: niu0: Found PHY 002063b0 type MII at phy_port 27

[    5.025795] niu: niu0: Found PHY 002063b0 type MII at phy_port 28

[    5.026570] niu: niu0: Found PHY 002063b0 type MII at phy_port 29

[    5.027768] niu: niu0: Port 0 [4 RX chans] [6 TX chans]

[    5.028144] niu: niu0: Port 1 [4 RX chans] [6 TX chans]

[    5.028569] niu: niu0: Port 2 [4 RX chans] [6 TX chans]

[    5.028968] niu: niu0: Port 3 [4 RX chans] [6 TX chans]

[    5.029346] niu: niu0: Port 0 RDC tbl(0) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]

[    5.029859] niu: niu0: Port 0 RDC tbl(1) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]

[    5.030417] niu: niu0: Port 1 RDC tbl(2) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]

[    5.030940] niu: niu0: Port 1 RDC tbl(3) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]

[    5.031450] niu: niu0: Port 2 RDC tbl(4) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]

[    5.034085] niu: niu0: Port 2 RDC tbl(5) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]

[    5.037675] niu: niu0: Port 3 RDC tbl(6) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]

[    5.039303] niu: niu0: Port 3 RDC tbl(7) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]

[    5.282243] kworker/u258:0 (1306) used greatest stack depth: 8808 bytes left

[    5.284523] niu: eth0: NIU Ethernet 00:21:28:05:3a:a4

[    5.284907] niu: eth0: Port type[XMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    5.285487] probe of 0001:04:00.0 returned 1 after 268921 usecs

[    5.504398] niu: eth1: NIU Ethernet 00:21:28:05:3a:a5

[    5.505119] niu: eth1: Port type[XMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    5.506051] probe of 0001:04:00.1 returned 1 after 220050 usecs

[    5.734463] niu: eth2: NIU Ethernet 00:21:28:05:3a:a6

[    5.735182] niu: eth2: Port type[BMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    5.736153] probe of 0001:04:00.2 returned 1 after 229585 usecs

[    5.964499] niu: eth3: NIU Ethernet 00:21:28:05:3a:a7

[    5.965218] niu: eth3: Port type[BMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    5.967367] probe of 0001:04:00.3 returned 1 after 230342 usecs

[    5.968557] initcall niu_init+0x0/0x88 returned 0 after 930012 usecs

[    5.971021] calling  fusion_init+0x0/0x114 @ 1

[    5.972004] Fusion MPT base driver 3.04.20

[    5.973224] Copyright (c) 1999-2008 LSI Corporation

[    5.973952] initcall fusion_init+0x0/0x114 returned 0 after 1893 usecs

[    5.975122] calling  mptsas_init+0x0/0x130 @ 1

[    5.975798] Fusion MPT SAS Host driver 3.04.20

[    5.978111] mptbase: ioc0: Initiating bringup

[    8.220145] ioc0: LSISAS1068E B2: Capabilities={Initiator}

[   27.820878] scsi host0: ioc0: LSISAS1068E B2, FwRev=01170400h, Ports=1, MaxQ=286, IRQ=36

[   27.866097] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 0, phy 0, sas_addr 0x5000cca00076eb05

[   27.874531] scsi 0:0:0:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   27.880442] probe of 0:0:0:0 returned 1 after 391 usecs

[   27.883283] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 1, phy 1, sas_addr 0x5000cca00076ebf9

[   27.886788] sd 0:0:0:0: [sda] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   27.890954] sd 0:0:0:0: [sda] Write Protect is off

[   27.891659] sd 0:0:0:0: [sda] Mode Sense: eb 00 10 08

[   27.893784] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA

[   27.895374] scsi 0:0:1:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   27.902537] probe of 0:0:1:0 returned 1 after 452 usecs

[   27.905680] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 2, phy 2, sas_addr 0x5000cca0009006c5

[   27.905709]  sda: sda1 sda2 sda3

[   27.906695] sd 0:0:1:0: [sdb] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   27.908958] sd 0:0:1:0: [sdb] Write Protect is off

[   27.909343] sd 0:0:1:0: [sdb] Mode Sense: eb 00 10 08

[   27.911175] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA

[   27.914330] sd 0:0:0:0: [sda] Attached SCSI disk

[   27.914626] scsi 0:0:2:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   27.919511] probe of 0:0:2:0 returned 1 after 502 usecs

[   27.922090] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 3, phy 3, sas_addr 0x5000cca000936c6d

[   27.922106] sd 0:0:2:0: [sdc] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   27.924792] sd 0:0:2:0: [sdc] Write Protect is off

[   27.925465] sd 0:0:2:0: [sdc] Mode Sense: eb 00 10 08

[   27.926162] sd 0:0:1:0: [sdb] Attached SCSI disk

[   27.927566] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA

[   27.931961] scsi 0:0:3:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   27.937468] probe of 0:0:3:0 returned 1 after 444 usecs

[   27.940973] probe of 0000:06:00.0 returned 1 after 21956745 usecs

[   27.941216] sd 0:0:3:0: [sdd] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   27.942250] initcall mptsas_init+0x0/0x130 returned 0 after 21443803 usecs

[   27.943708] sd 0:0:2:0: [sdc] Attached SCSI disk

[   27.943846] calling  bq4802_driver_init+0x0/0x18 @ 1

[   27.944465] sd 0:0:3:0: [sdd] Write Protect is off

[   27.944807] initcall bq4802_driver_init+0x0/0x18 returned 0 after 267 usecs

[   27.945208] sd 0:0:3:0: [sdd] Mode Sense: eb 00 10 08

[   27.946037] calling  cmos_init+0x0/0x4c @ 1

[   27.948157] sd 0:0:3:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA

[   27.948185] initcall cmos_init+0x0/0x4c returned -19 after 738 usecs

[   27.950288] calling  m48t59_rtc_driver_init+0x0/0x18 @ 1

[   27.951170] initcall m48t59_rtc_driver_init+0x0/0x18 returned 0 after 133 usecs

[   27.952407] calling  starfire_rtc_driver_init+0x0/0x20 @ 1

[   27.953331] initcall starfire_rtc_driver_init+0x0/0x20 returned -19 after 168 usecs

[   27.953883] calling  sun4v_rtc_driver_init+0x0/0x20 @ 1

[   27.954638] rtc-sun4v rtc-sun4v: registered as rtc0

[   27.955048] probe of rtc-sun4v returned 1 after 682 usecs

[   27.955514] initcall sun4v_rtc_driver_init+0x0/0x20 returned 0 after 1211 usecs

[   27.956047] calling  hid_init+0x0/0x84 @ 1

[   27.956470] hidraw: raw HID events driver (C) Jiri Kosina

[   27.956980] initcall hid_init+0x0/0x84 returned 0 after 592 usecs

[   27.957472] calling  sock_diag_init+0x0/0x44 @ 1

[   27.958647] initcall sock_diag_init+0x0/0x44 returned 0 after 799 usecs

[   27.959144] calling  blackhole_init+0x0/0x14 @ 1

[   27.959481] initcall blackhole_init+0x0/0x14 returned 0 after 3 usecs

[   27.959954] calling  gre_offload_init+0x0/0x4c @ 1

[   27.960311] initcall gre_offload_init+0x0/0x4c returned 0 after 1 usecs

[   27.960790] calling  bpfilter_sockopt_init+0x0/0x4c @ 1

[   27.961175] initcall bpfilter_sockopt_init+0x0/0x4c returned 0 after 0 usecs

[   27.961693] calling  sysctl_ipv4_init+0x0/0x58 @ 1

[   27.961951] sd 0:0:3:0: [sdd] Attached SCSI disk

[   27.962266] initcall sysctl_ipv4_init+0x0/0x58 returned 0 after 206 usecs

[   27.962857] calling  inet_diag_init+0x0/0x8c @ 1

[   27.963207] initcall inet_diag_init+0x0/0x8c returned 0 after 4 usecs

[   27.963665] calling  tcp_diag_init+0x0/0x14 @ 1

[   27.964005] initcall tcp_diag_init+0x0/0x14 returned 0 after 1 usecs

[   27.964457] calling  cubictcp_register+0x0/0x8c @ 1

[   27.964822] initcall cubictcp_register+0x0/0x8c returned 0 after 3 usecs

[   27.965306] calling  inet6_init+0x0/0x450 @ 1

[   27.967789] NET: Registered protocol family 10

[   27.978217] Segment Routing with IPv6

[   27.978573] initcall inet6_init+0x0/0x450 returned 0 after 12634 usecs

[   27.979049] calling  packet_init+0x0/0x8c @ 1

[   27.979369] NET: Registered protocol family 17

[   27.979708] initcall packet_init+0x0/0x8c returned 0 after 327 usecs

[   27.980158] calling  xsk_diag_init+0x0/0x14 @ 1

[   27.980493] initcall xsk_diag_init+0x0/0x14 returned 0 after 0 usecs

[   27.981037] calling  sstate_running+0x0/0x2c @ 1

[   27.981444] initcall sstate_running+0x0/0x2c returned 0 after 63 usecs

[   27.981914] calling  init_oops_id+0x0/0x40 @ 1

[   27.982251] initcall init_oops_id+0x0/0x40 returned 0 after 5 usecs

[   27.982714] calling  pm_qos_power_init+0x0/0xb0 @ 1

[   27.983839] initcall pm_qos_power_init+0x0/0xb0 returned 0 after 744 usecs

[   27.984336] calling  printk_late_init+0x0/0x1d4 @ 1

[   27.984702] initcall printk_late_init+0x0/0x1d4 returned 0 after 4 usecs

[   27.985450] calling  tk_debug_sleep_time_init+0x0/0x30 @ 1

[   27.986133] initcall tk_debug_sleep_time_init+0x0/0x30 returned 0 after 11 usecs

[   27.986664] calling  taskstats_init+0x0/0x40 @ 1

[   27.987311] registered taskstats version 1

[   27.987634] initcall taskstats_init+0x0/0x40 returned 0 after 350 usecs

[   27.988382] calling  fault_around_debugfs+0x0/0x30 @ 1

[   27.988771] initcall fault_around_debugfs+0x0/0x30 returned 0 after 13 usecs

[   27.989552] calling  set_hardened_usercopy+0x0/0x28 @ 1

[   27.990204] initcall set_hardened_usercopy+0x0/0x28 returned 1 after 0 usecs

[   27.990966] calling  init_root_keyring+0x0/0xc @ 1

[   27.991366] initcall init_root_keyring+0x0/0xc returned 0 after 47 usecs

[   27.992118] calling  init_profile_hash+0x0/0xa4 @ 1

[   27.992781] AppArmor: AppArmor sha1 policy hashing enabled

[   27.993530] initcall init_profile_hash+0x0/0xa4 returned 0 after 729 usecs

[   27.994365] calling  prandom_reseed+0x0/0x34 @ 1

[   27.995531] initcall prandom_reseed+0x0/0x34 returned 0 after 461 usecs

[   27.996703] calling  pci_resource_alignment_sysfs_init+0x0/0x1c @ 1

[   27.997529] initcall pci_resource_alignment_sysfs_init+0x0/0x1c returned 0 after 9 usecs

[   27.998822] calling  pci_sysfs_init+0x0/0x60 @ 1

[   28.000352] initcall pci_sysfs_init+0x0/0x60 returned 0 after 458 usecs

[   28.002011] calling  deferred_probe_initcall+0x0/0xc0 @ 1

[   28.003412] initcall deferred_probe_initcall+0x0/0xc0 returned 0 after 83 usecs

[   28.004332] calling  init_netconsole+0x0/0x270 @ 1

[   28.005047] printk: console [netcon0] enabled

[   28.005354] netconsole: network logging started

[   28.006043] initcall init_netconsole+0x0/0x270 returned 0 after 985 usecs

[   28.007213] calling  rtc_hctosys+0x0/0xb8 @ 1

[   28.007733] rtc-sun4v rtc-sun4v: setting system clock to 2019-06-19T20:53:35 UTC (1560977615)

[   28.008990] initcall rtc_hctosys+0x0/0xb8 returned 0 after 1383 usecs

[   28.009797] calling  tcp_congestion_default+0x0/0x1c @ 1

[   28.010536] initcall tcp_congestion_default+0x0/0x1c returned 0 after 2 usecs

[   28.011866] Warning: unable to open an initial console.

[   28.030519] random: fast init done

[   28.049869] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)

[   28.050911] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.

[   28.062872] devtmpfs: mounted

[   28.063775] This architecture does not have kernel memory protection.

[   28.064584] Run /sbin/init as init process

[   29.048788] calling  xt_init+0x0/0x120 [x_tables] @ 1

[   29.049954] initcall xt_init+0x0/0x120 [x_tables] returned 0 after 23 usecs

[   29.057501] calling  ip_tables_init+0x0/0xa8 [ip_tables] @ 1

[   29.058685] initcall ip_tables_init+0x0/0xa8 [ip_tables] returned 0 after 22 usecs

[   29.130252] systemd[1]: systemd 240 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)

[   29.134624] systemd[1]: Detected architecture sparc64.

[   29.177623] systemd[1]: Set hostname to <t5140>.

[   29.186212] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid argument

[   29.502836] systemd-rc-loca (1604) used greatest stack depth: 7960 bytes left

[   29.504099] systemd-fstab-g (1600) used greatest stack depth: 6856 bytes left

[   29.691416] systemd-sysv-ge (1607) used greatest stack depth: 6536 bytes left

[   30.402047] random: systemd: uninitialized urandom read (16 bytes read)

[   30.432795] random: systemd: uninitialized urandom read (16 bytes read)

[   30.434317] systemd[1]: Listening on initctl Compatibility Named Pipe.

[   30.435247] random: systemd: uninitialized urandom read (16 bytes read)

[   30.436513] systemd[1]: Listening on Journal Socket (/dev/log).

[   30.458163] systemd[1]: Created slice system-getty.slice.

[   30.459489] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.

[   30.462867] systemd[1]: Listening on Journal Audit Socket.

[   30.464786] systemd[1]: Listening on Journal Socket.

[   30.652756] percpu: allocation failed, size=240 align=8 atomic=0, failed to allocate new chunk

[   30.653765] CPU: 8 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   30.654237] Call Trace:

[   30.654496]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   30.654914]  [00000000009a6f00] mem_cgroup_css_alloc+0x100/0x540

[   30.655388]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   30.655945]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   30.656410]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   30.656846]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   30.657248]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   30.657710]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   30.694033] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   30.695030] CPU: 9 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   30.695499] Call Trace:

[   30.695756]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   30.696173]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   30.696675]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   30.697230]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   30.697657]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   30.698055]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   30.698463]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   30.698914]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   30.705909] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   30.706904] CPU: 9 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   30.707373] Call Trace:

[   30.707618]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   30.708030]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   30.708501]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   30.709057]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   30.709529]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   30.709961]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   30.710361]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   30.710817]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.069056] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   31.070413] CPU: 10 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.071400] Call Trace:

[   31.071768]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.072500]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   31.073286]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   31.074476]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   31.074904]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.075657]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.076382]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.077113]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.444779] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   31.446138] CPU: 10 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.446926] Call Trace:

[   31.447495]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.448229]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   31.449020]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   31.449845]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   31.450596]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.451433]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.452044]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.452774]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.683767] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro

[   31.695813] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   31.697647] CPU: 10 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.700358] Call Trace:

[   31.700989]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.703072]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   31.705124]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   31.708553]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   31.712028]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.714699]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.715064]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.715784]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.746195] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   31.751844] CPU: 10 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.754821] Call Trace:

[   31.755387]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.756117]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   31.758966]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   31.759438]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   31.759875]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.760271]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.760636]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.761058]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.770959] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   31.771649] CPU: 10 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.772152] Call Trace:

[   31.772355]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.772735]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   31.773163]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   31.773696]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   31.774086]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.774483]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.774848]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.775224]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.797961] systemd-journald[1616]: Received request to flush runtime journal from PID 1

[   31.934979] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   31.936697] CPU: 8 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.937852] Call Trace:

[   31.938060]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.939134]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   31.940285]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   31.941429]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   31.942540]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.943657]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.944377]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.945105]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   32.044448] percpu: allocation failed, size=696 align=8 atomic=0, failed to allocate new chunk

[   32.045447] CPU: 8 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   32.045882] Call Trace:

[   32.046102]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   32.046482]  [00000000009a6e58] mem_cgroup_css_alloc+0x58/0x540

[   32.046912]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   32.047685]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   32.048413]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   32.050069]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   32.050435]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   32.050812]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   32.051264] percpu: limit reached, disable warning

[   33.011073] calling  des_generic_mod_init+0x0/0x18 [des_generic] @ 2328

[   33.024305] initcall des_generic_mod_init+0x0/0x18 [des_generic] returned 0 after 11697 usecs

[   33.075774] calling  flash_driver_init+0x0/0x1c [flash] @ 2368

[   33.076949] probe of f0284a88 returned 0 after 31 usecs

[   33.080835] initcall flash_driver_init+0x0/0x1c [flash] returned 0 after 3910 usecs

[   33.188656] calling  n2_init+0x0/0x20 [n2_crypto] @ 2340

[   33.190034] n2_crypto: n2_crypto.c:v0.2 (July 28, 2011)

[   33.191666] n2_crypto: Found N2CP at /virtual-devices@100/n2cp@7

[   33.195176] n2_crypto: Registered NCS HVAPI version 2.0

[   33.197337] n2_crypto: md5 alg registration failed

[   33.198058] n2cp f028674c: /virtual-devices@100/n2cp@7: Unable to register algorithms.

[   33.213097] audit: type=1400 audit(1560977620.690:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/haveged" pid=2330 comm="apparmor_parser"

[   33.229874] Kernel unaligned access at TPC[6ddaf4] aa_dfa_unpack+0x34/0x640

[   33.230740] Kernel unaligned access at TPC[6ddb04] aa_dfa_unpack+0x44/0x640

[   33.231276] Kernel unaligned access at TPC[6ddba4] aa_dfa_unpack+0xe4/0x640

[   33.231899] Kernel unaligned access at TPC[6ddc5c] aa_dfa_unpack+0x19c/0x640

[   33.232439] Kernel unaligned access at TPC[6ddc70] aa_dfa_unpack+0x1b0/0x640

[   33.257249] audit: type=1400 audit(1560977620.730:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=2331 comm="apparmor_parser"

[   33.264409] audit: type=1400 audit(1560977620.730:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=2331 comm="apparmor_parser"

[   33.269393] audit: type=1400 audit(1560977620.730:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=2331 comm="apparmor_parser"

[   33.299704] niu 0001:04:00.0 enP1p4s0f0: renamed from eth0

[   33.323959] calling  init_sg+0x0/0xe4 [sg] @ 2379

[   33.325545] sd 0:0:0:0: Attached scsi generic sg0 type 0

[   33.326959] sd 0:0:1:0: Attached scsi generic sg1 type 0

[   33.328165] sd 0:0:2:0: Attached scsi generic sg2 type 0

[   33.329463] sd 0:0:3:0: Attached scsi generic sg3 type 0

[   33.330061] initcall init_sg+0x0/0xe4 [sg] returned 0 after 5202 usecs

[   33.398879] calling  e1000_init_module+0x0/0x40 [e1000e] @ 2385

[   33.400294] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k

[   33.401248] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.

[   33.403193] e1000e 0000:07:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode

[   33.450519] niu 0001:04:00.1 enP1p4s0f1: renamed from eth1

[   33.484960] calling  usb_init+0x0/0x16c [usbcore] @ 2341

[   33.486000] usbcore: registered new interface driver usbfs

[   33.486917] usbcore: registered new interface driver hub

[   33.490725] usbcore: deregistering interface driver hub

[   33.491897] usbcore: can't allocate workqueue for usb hub

[   33.493032] usbcore: deregistering interface driver usbfs

[   33.494436] initcall usb_init+0x0/0x16c [usbcore] returned -1 after 8357 usecs

[   33.510337] niu 0001:04:00.3 enP1p4s0f3: renamed from eth3

[   33.615965] niu 0001:04:00.2 enP1p4s0f2: renamed from eth2

[   33.633770] e1000e: probe of 0000:07:00.0 failed with error -12

[   33.634948] probe of 0000:07:00.0 returned 0 after 232362 usecs

[   33.636076] initcall e1000_init_module+0x0/0x40 [e1000e] returned 0 after 146590 usecs

[   33.823975] calling  usb_init+0x0/0x16c [usbcore] @ 2368

[   33.825351] usbcore: registered new interface driver usbfs

[   33.826160] usbcore: registered new interface driver hub

[   33.827346] usbcore: deregistering interface driver hub

[   33.830838] usbcore: can't allocate workqueue for usb hub

[   33.833587] usbcore: deregistering interface driver usbfs

[   33.835148] initcall usb_init+0x0/0x16c [usbcore] returned -1 after 9586 usecs

[   33.999666] n2cp: probe of f028674c failed with error -22

[   34.000499] probe of f028674c returned 0 after 810184 usecs

[   34.002740] n2_crypto: Found NCP at /virtual-devices@100/ncp@6

[   34.004230] n2_crypto: Registered NCS HVAPI version 2.0

[   34.005890] probe of f028686c returned 1 after 3170 usecs

[   34.007122] initcall n2_init+0x0/0x20 [n2_crypto] returned 0 after 177625 usecs

[   34.713660] random: crng init done

[   34.714339] random: 7 urandom warning(s) missed due to ratelimiting

[   34.757422] Adding 7863808k swap on /dev/sda2.  Priority:-2 extents:1 across:7863808k

[   36.030375] ip (2622) used greatest stack depth: 5552 bytes left

[   37.594549] Kernel panic - not syncing: Cannot create slab shmem_inode_cache(24:system-getty.slice) size=704 realsize=704 order=2 offset=696 flags=4040000

[   37.596613] CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 5.2.0-rc5 #220

[   37.597151] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func

[   37.597636] Call Trace:

[   37.597887]  [0000000000462a64] panic+0x104/0x344

[   37.598222]  [000000000059e984] kmem_cache_open+0x4c4/0x4e0

[   37.598746]  [000000000059f368] __kmem_cache_create+0x8/0x160

[   37.599195]  [00000000005611bc] create_cache+0x7c/0x1c0

[   37.599610]  [00000000005617c4] memcg_create_kmem_cache+0xc4/0x100

[   37.600140]  [00000000005a6114] memcg_kmem_cache_create_func+0x14/0xa0

[   37.600650]  [000000000047a450] process_one_work+0x190/0x3c0

[   37.601201]  [000000000047a7bc] worker_thread+0x13c/0x500

[   37.601635]  [00000000004810dc] kthread+0xfc/0x120

[   37.602079]  [00000000004060a4] ret_from_fork+0x1c/0x2c

[   37.602493]  [0000000000000000] 0x0

[   37.602910] OOPS: Bogus kernel PC [0000000000001680] in fault handler

[   37.623792] OOPS: Bogus kernel PC [00000000000031c0] in fault handler

[   37.623830] OOPS: RPC [000000000042c7e4]

[   37.644982] OOPS: RPC [000000000042c7e4]

[   37.644988] OOPS: Bogus kernel PC [0000000000000280] in fault handler

[   37.645015] OOPS: RPC [000000000042c7e4]

[   37.645045] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.645056] OOPS: Fault was to vaddr[280]

[   37.645072] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.2.0-rc5 #220

[   37.645077] Call Trace:

[   37.645091]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.645110]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.645119]  [0000000000000280] 0x280

[   37.645130]  [000000000048de38] do_idle+0x118/0x1a0

[   37.645141]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.645159]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.645167]  [0000000000000000] 0x0

[   37.645178] Unable to handle kernel NULL pointer dereference

[   37.645189] tsk->{mm,active_mm}->context = 0000000000000298

[   37.645199] tsk->{mm,active_mm}->pgd = ffff8001ad878000

[   37.645210]               \|/ ____ \|/

[   37.645210]               "@'/ .. \`@"

[   37.645210]               /_| \__/ |_\

[   37.645210]                  \__U_/

[   37.645221] swapper/3(0): Oops [#1]

[   37.645236] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.2.0-rc5 #220

[   37.645251] TSTATE: 0000004480001603 TPC: 0000000000000280 TNPC: 0000000000000284 Y: 00000000    Not tainted

[   37.645261] TPC: <0x280>

[   37.645274] g0: 0000002400000043 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.645288] g4: 0000000000005a20 g5: ffff8001be48e000 g6: ffff8001b8c80000 g7: 0000000000000003

[   37.645299] o0: 0000000000000280 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.645312] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c83531 ret_pc: 000000000042c7e4

[   37.645328] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.645342] l0: ffff8001bf060040 l1: 00000007e8c51080 l2: 000000000007a11f l3: 0000000000b53fe8

[   37.645355] l4: 0000000000000000 l5: ffff8001bf06a380 l6: 00000000009b2400 l7: 00000000ffff97ca

[   37.645367] i0: 0000000000001948 i1: ffff8001bf06aff8 i2: 0000000000000001 i3: 0000000000000280

[   37.645381] i4: 00000000fee94ff8 i5: 00000000fee93800 i6: ffff8001b8c835e1 i7: 000000000048de38

[   37.645393] I7: <do_idle+0x118/0x1a0>

[   37.645402] Call Trace:

[   37.645416]  [000000000048de38] do_idle+0x118/0x1a0

[   37.645430]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.645450]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.645462]  [0000000000000000] 0x0

[   37.645475] Disabling lock debugging due to kernel taint

[   37.645493] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.645512] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.645528] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.645543] Caller[0000000000000000]: 0x0

[   37.645555] Instruction DUMP:

[   37.645570] Unable to handle kernel NULL pointer dereference

[   37.645582] tsk->{mm,active_mm}->context = 0000000000000298

[   37.645595] tsk->{mm,active_mm}->pgd = ffff8001ad878000

[   37.645608]               \|/ ____ \|/

[   37.645608]               "@'/ .. \`@"

[   37.645608]               /_| \__/ |_\

[   37.645608]                  \__U_/

[   37.645623] swapper/3(0): Oops [#2]

[   37.645642] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D           5.2.0-rc5 #220

[   37.645659] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.645679] TPC: <die_if_kernel+0x114/0x24c>

[   37.645698] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.645715] g4: ffff8001b8c47f80 g5: ffff8001be48e000 g6: ffff8001b8c80000 g7: 000000000000000e

[   37.645727] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.645744] o4: 0000000000003f60 o5: ffff8001b8c80000 sp: ffff8001b8c83191 ret_pc: 000000000042b04c

[   37.645760] RPC: <die_if_kernel+0xb4/0x24c>

[   37.645775] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.645788] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.645801] i0: 0000000000ab21e0 i1: ffff8001b8c83c90 i2: ffff8001b8c80000 i3: 0000000000000280

[   37.645814] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c83271 i7: 00000000004501a4

[   37.645828] I7: <unhandled_fault+0x84/0xa0>

[   37.645837] Call Trace:

[   37.645851]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.645866]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.645886]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.645897]  [0000000000000280] 0x280

[   37.645910]  [000000000048de38] do_idle+0x118/0x1a0

[   37.645923]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.645940]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.645951]  [0000000000000000] 0x0

[   37.645967] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.645982] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.646002] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.646021] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.646035] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.646049] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.646065] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.646077] Caller[0000000000000000]: 0x0

[   37.646084] Instruction DUMP:

[   37.646088]  832f7002

[   37.646098]  9210203c

[   37.646107]  96102020

[   37.646117] <d406c001>

[   37.646126]  93666020

[   37.646135]  9010001c

[   37.646144]  ba076001

[   37.646154]  40020421

[   37.646163]  9764603e

[   37.646172]

[   37.665667] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.665671] OOPS: Bogus kernel PC [0000000000000f00] in fault handler

[   37.665678] OOPS: RPC [000000000042c7e4]

[   37.665751] OOPS: Fault was to vaddr[31c0]

[   37.665771] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D           5.2.0-rc5 #220

[   37.665775] Call Trace:

[   37.665789]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.665807]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.665814]  [00000000000031c0] 0x31c0

[   37.665825]  [000000000048de38] do_idle+0x118/0x1a0

[   37.665836]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.665849]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.665857]  [0000000000000000] 0x0

[   37.665869] Unable to handle kernel paging request at virtual address 00000000000031c0

[   37.665880] tsk->{mm,active_mm}->context = 000000000000013d

[   37.665890] tsk->{mm,active_mm}->pgd = ffff8001b5bfc000

[   37.665899]               \|/ ____ \|/

[   37.665899]               "@'/ .. \`@"

[   37.665899]               /_| \__/ |_\

[   37.665899]                  \__U_/

[   37.665910] swapper/2(0): Oops [#3]

[   37.665924] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D           5.2.0-rc5 #220

[   37.665939] TSTATE: 0000004480001603 TPC: 00000000000031c0 TNPC: 00000000000031c4 Y: 00000000    Tainted: G      D

[   37.665950] TPC: <0x31c0>

[   37.665963] g0: ffffffe6ffffffed g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.665976] g4: 0000000000005a20 g5: ffff8001be46e000 g6: ffff8001b8c7c000 g7: 0000000000000002

[   37.665988] o0: 00000000000031c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.666001] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c7f531 ret_pc: 000000000042c7e4

[   37.666018] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.666031] l0: ffff8001bf040040 l1: 00000007ebc00100 l2: 0000000000000000 l3: 0000000000000000

[   37.666044] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 000001000019fa60

[   37.666057] i0: 0000000000001604 i1: ffff8001bf04aff8 i2: 0000000000000001 i3: 00000000000031c0

[   37.666069] i4: 00000000fee8eff8 i5: 00000000fee8d800 i6: ffff8001b8c7f5e1 i7: 000000000048de38

[   37.666082] I7: <do_idle+0x118/0x1a0>

[   37.666090] Call Trace:

[   37.666104]  [000000000048de38] do_idle+0x118/0x1a0

[   37.666118]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.666134]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.666145]  [0000000000000000] 0x0

[   37.666160] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.666174] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.666195] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.666206] Caller[0000000000000000]: 0x0

[   37.666218] Instruction DUMP:

[   37.666229] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.666242] tsk->{mm,active_mm}->context = 000000000000013d

[   37.666257] tsk->{mm,active_mm}->pgd = ffff8001b5bfc000

[   37.666267]               \|/ ____ \|/

[   37.666267]               "@'/ .. \`@"

[   37.666267]               /_| \__/ |_\

[   37.666267]                  \__U_/

[   37.666282] swapper/2(0): Oops [#4]

[   37.666302] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D           5.2.0-rc5 #220

[   37.666320] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 0000185e    Tainted: G      D

[   37.666338] TPC: <die_if_kernel+0x114/0x24c>

[   37.666355] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.666370] g4: ffff8001b8c47700 g5: ffff8001be46e000 g6: ffff8001b8c7c000 g7: 000000000000000e

[   37.666387] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.666403] o4: 0000000000003f60 o5: ffff8001b8c7c000 sp: ffff8001b8c7f191 ret_pc: 000000000042b04c

[   37.666421] RPC: <die_if_kernel+0xb4/0x24c>

[   37.666440] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.666456] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.666469] i0: 0000000000ab21e0 i1: ffff8001b8c7fc90 i2: ffff8001b8c7c000 i3: 00000000000031c0

[   37.666487] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c7f271 i7: 00000000004501a4

[   37.666506] I7: <unhandled_fault+0x84/0xa0>

[   37.666517] Call Trace:

[   37.666534]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.666551]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.666572]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.666585]  [00000000000031c0] 0x31c0

[   37.666600]  [000000000048de38] do_idle+0x118/0x1a0

[   37.666613]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.666629]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.666641]  [0000000000000000] 0x0

[   37.666657] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.666672] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.666692] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.666710] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.666724] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.666738] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.666755] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.666766] Caller[0000000000000000]: 0x0

[   37.666774] Instruction DUMP:

[   37.666777]  832f7002

[   37.666786]  9210203c

[   37.666796]  96102020

[   37.666805] <d406c001>

[   37.666815]  93666020

[   37.666824]  9010001c

[   37.666833]  ba076001

[   37.666843]  40020421

[   37.666852]  9764603e

[   37.666860]

[   37.686338] OOPS: Bogus kernel PC [0000000000000500] in fault handler

[   37.686351] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.686365] OOPS: RPC [000000000042c7e4]

[   37.686368] OOPS: Fault was to vaddr[1680]

[   37.686380] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.2.0-rc5 #220

[   37.686385] Call Trace:

[   37.686398]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.686416]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.686424]  [0000000000001680] 0x1680

[   37.686435]  [000000000048de38] do_idle+0x118/0x1a0

[   37.686445]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.686459]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.686466]  [0000000000000000] 0x0

[   37.686472] Unable to handle kernel NULL pointer dereference

[   37.686479] tsk->{mm,active_mm}->context = 000000000000002a

[   37.686485] tsk->{mm,active_mm}->pgd = ffff8001b7588000

[   37.686492]               \|/ ____ \|/

[   37.686492]               "@'/ .. \`@"

[   37.686492]               /_| \__/ |_\

[   37.686492]                  \__U_/

[   37.686500] swapper/1(0): Oops [#5]

[   37.686511] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.2.0-rc5 #220

[   37.686524] TSTATE: 0000004480001603 TPC: 0000000000001680 TNPC: 0000000000001684 Y: 00000000    Tainted: G      D

[   37.686532] TPC: <0x1680>

[   37.686542] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.686552] g4: 0000000000005a20 g5: ffff8001be44e000 g6: ffff8001b8c78000 g7: 0000000000000001

[   37.686561] o0: 0000000000001680 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.686571] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c7b531 ret_pc: 000000000042c7e4

[   37.686586] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.686596] l0: ffff8001b665aa00 l1: 0000000000000000 l2: 0000000000422db4 l3: 0000000000000000

[   37.686606] l4: 000000000000030c l5: 0000000000000008 l6: ffff8001b46b4000 l7: 00000000006023c0

[   37.686616] i0: 0000000000001a60 i1: ffff8001bf02aff8 i2: 0000000000000001 i3: 0000000000001680

[   37.686626] i4: 00000000fee88ff8 i5: 00000000fee87800 i6: ffff8001b8c7b5e1 i7: 000000000048de38

[   37.686636] I7: <do_idle+0x118/0x1a0>

[   37.686642] Call Trace:

[   37.686653]  [000000000048de38] do_idle+0x118/0x1a0

[   37.686663]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.686675]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.686683]  [0000000000000000] 0x0

[   37.686694] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.686705] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.686716] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.686724] Caller[0000000000000000]: 0x0

[   37.686729] Instruction DUMP:

[   37.686736] Unable to handle kernel NULL pointer dereference

[   37.686743] tsk->{mm,active_mm}->context = 000000000000002a

[   37.686749] tsk->{mm,active_mm}->pgd = ffff8001b7588000

[   37.686756]               \|/ ____ \|/

[   37.686756]               "@'/ .. \`@"

[   37.686756]               /_| \__/ |_\

[   37.686756]                  \__U_/

[   37.686764] swapper/1(0): Oops [#6]

[   37.686775] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.2.0-rc5 #220

[   37.686788] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001931    Tainted: G      D

[   37.686800] TPC: <die_if_kernel+0x114/0x24c>

[   37.686810] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.686821] g4: ffff8001b8c46e80 g5: ffff8001be44e000 g6: ffff8001b8c78000 g7: 000000000000000e

[   37.686830] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.686841] o4: 0000000000003f60 o5: ffff8001b8c78000 sp: ffff8001b8c7b191 ret_pc: 000000000042b04c

[   37.686852] RPC: <die_if_kernel+0xb4/0x24c>

[   37.686862] l0: 0000000000000009 l1: ffff8001b8c7bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   37.686872] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   37.686882] i0: 0000000000ab21e0 i1: ffff8001b8c7bc90 i2: ffff8001b8c78000 i3: 0000000000001680

[   37.686893] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c7b271 i7: 00000000004501a4

[   37.686905] I7: <unhandled_fault+0x84/0xa0>

[   37.686910] Call Trace:

[   37.686922]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.686933]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.686949]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.686957]  [0000000000001680] 0x1680

[   37.686967]  [000000000048de38] do_idle+0x118/0x1a0

[   37.686978]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.686991]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.686999]  [0000000000000000] 0x0

[   37.687011] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.687022] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.687037] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.687051] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.687062] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.687073] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.687086] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.687094] Caller[0000000000000000]: 0x0

[   37.687099] Instruction DUMP:

[   37.687106]  832f7002

[   37.687112]  9210203c

[   37.687117]  96102020

[   37.687123] <d406c001>

[   37.687129]  93666020

[   37.687135]  9010001c

[   37.687140]  ba076001

[   37.687146]  40020421

[   37.687152]  9764603e

[   37.687157]

[   37.707219] OOPS: Bogus kernel PC [0000000000001cc0] in fault handler

[   37.707251] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.707255] OOPS: Fault was to vaddr[f00]

[   37.707266] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D           5.2.0-rc5 #220

[   37.707269] Call Trace:

[   37.707279]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.707294]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.707300]  [0000000000000f00] 0xf00

[   37.707308]  [000000000048de38] do_idle+0x118/0x1a0

[   37.707317]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.707328]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.707334]  [0000000000000000] 0x0

[   37.707338] Unable to handle kernel NULL pointer dereference

[   37.707343] tsk->{mm,active_mm}->context = 00000000000002af

[   37.707347] tsk->{mm,active_mm}->pgd = ffff8001ad610000

[   37.707352]               \|/ ____ \|/

[   37.707352]               "@'/ .. \`@"

[   37.707352]               /_| \__/ |_\

[   37.707352]                  \__U_/

[   37.707357] swapper/4(0): Oops [#7]

[   37.707367] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D           5.2.0-rc5 #220

[   37.707381] TSTATE: 0000004480001603 TPC: 0000000000000f00 TNPC: 0000000000000f04 Y: 00000000    Tainted: G      D

[   37.707386] TPC: <0xf00>

[   37.707394] g0: 000000040000000c g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.707401] g4: 0000000000005a20 g5: ffff8001be4ae000 g6: ffff8001b8c84000 g7: 0000000000000004

[   37.707408] o0: 0000000000000f00 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.707415] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c87531 ret_pc: 000000000042c7e4

[   37.707426] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.707434] l0: ffff8001b6bcbb00 l1: 0000000000ab8e40 l2: 0000000000b95800 l3: 0000000000b95800

[   37.707442] l4: ffff8001bf089c80 l5: ffff8001bf089cf0 l6: 0000000000000000 l7: 003e008100000000

[   37.707449] i0: 000000000000153c i1: ffff8001bf08aff8 i2: 0000000000000001 i3: 0000000000000f00

[   37.707456] i4: 00000000fee9aff8 i5: 00000000fee99800 i6: ffff8001b8c875e1 i7: 000000000048de38

[   37.707464] I7: <do_idle+0x118/0x1a0>

[   37.707467] Call Trace:

[   37.707475]  [000000000048de38] do_idle+0x118/0x1a0

[   37.707483]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.707493]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.707499]  [0000000000000000] 0x0

[   37.707507] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.707516] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.707525] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.707531] Caller[0000000000000000]: 0x0

[   37.707534] Instruction DUMP:

[   37.707540] Unable to handle kernel NULL pointer dereference

[   37.707545] tsk->{mm,active_mm}->context = 00000000000002af

[   37.707549] tsk->{mm,active_mm}->pgd = ffff8001ad610000

[   37.707554]               \|/ ____ \|/

[   37.707554]               "@'/ .. \`@"

[   37.707554]               /_| \__/ |_\

[   37.707554]                  \__U_/

[   37.707559] swapper/4(0): Oops [#8]

[   37.707569] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D           5.2.0-rc5 #220

[   37.707579] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001931    Tainted: G      D

[   37.707588] TPC: <die_if_kernel+0x114/0x24c>

[   37.707596] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.707603] g4: ffff8001b8c48800 g5: ffff8001be4ae000 g6: ffff8001b8c84000 g7: 000000000000000e

[   37.707610] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.707617] o4: 0000000000003f60 o5: ffff8001b8c84000 sp: ffff8001b8c87191 ret_pc: 000000000042b04c

[   37.707625] RPC: <die_if_kernel+0xb4/0x24c>

[   37.707633] l0: 0000000000000009 l1: ffff8001b8c87f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   37.707640] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   37.707654] i0: 0000000000ab21e0 i1: ffff8001b8c87c90 i2: ffff8001b8c84000 i3: 0000000000000f00

[   37.707662] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c87271 i7: 00000000004501a4

[   37.707670] I7: <unhandled_fault+0x84/0xa0>

[   37.707674] Call Trace:

[   37.707691]  [000000000044fc20] do_sparc64_fault+0x320/0x8[   37.707691]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.707705]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.707711]  [0000000000000f00] 0xf00

[   37.707718]  [000000000048de38] do_idle+0x118/0x1a0

[   37.707727]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.707737]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.707743]  [0000000000000000] 0x0

[   37.707753] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.707762] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.707774] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.707786] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.707794] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.707803] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.707813] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.707819] Caller[0000000000000000]: 0x0

[   37.707822] Instruction DUMP:

[   37.707825]  832f7002

[   37.707833]  96102020

[   37.707833]  96102020

[   37.707837] <d406c001>

[   37.707841]  93666020

[   37.707845]  9010001c

[   37.707849]  ba076001

[   37.707853]  40020421

[   37.707857]  9764603e

[   37.707860]

[   37.727903] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.727908] OOPS: Bogus kernel PC [00000000000004c0] in fault handler

[   37.727922] OOPS: Fault was to vaddr[500]

[   37.727925] OOPS: RPC [000000000042c7e4]

[   37.727945] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.727954] OOPS: Fault was to vaddr[4c0]

[   37.727971] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G      D           5.2.0-rc5 #220

[   37.727978] Call Trace:

[   37.727992]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.728010]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.728020]  [00000000000004c0] 0x4c0

[   37.728032]  [000000000048de38] do_idle+0x118/0x1a0

[   37.728043]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.728057]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.728067]  [0000000000000000] 0x0

[   37.728082] Unable to handle kernel NULL pointer dereference

[   37.728095] tsk->{mm,active_mm}->context = 0000000000000259

[   37.728104] tsk->{mm,active_mm}->pgd = ffff8001b1f70000

[   37.728117]               \|/ ____ \|/

[   37.728117]               "@'/ .. \`@"

[   37.728117]               /_| \__/ |_\

[   37.728117]                  \__U_/

[   37.728127] swapper/7(0): Oops [#9]

[   37.728146] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G      D           5.2.0-rc5 #220

[   37.728163] TSTATE: 0000004480001603 TPC: 00000000000004c0 TNPC: 00000000000004c4 Y: 00000000    Tainted: G      D

[   37.728178] TPC: <0x4c0>

[   37.728190] g0: fffffff100000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.728201] g4: 0000000000005a20 g5: ffff8001be50e000 g6: ffff8001b8c90000 g7: 0000000000000007

[   37.728212] o0: 00000000000004c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.728228] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c93531 ret_pc: 000000000042c7e4

[   37.728243] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.728255] l0: ffff8001bf0e0040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   37.728271] l4: ffff8001bf0e9c80 l5: ffff8001bf38a380 l6: 00000000009b2400 l7: 00000000ffff8b06

[   37.728283] i0: 0000000000001cb8 i1: ffff8001bf0eaff8 i2: 0000000000000001 i3: 00000000000004c0

[   37.728295] i4: 00000000feeacff8 i5: 00000000feeab800 i6: ffff8001b8c935e1 i7: 000000000048de38

[   37.728306] I7: <do_idle+0x118/0x1a0>

[   37.728318] Call Trace:

[   37.728335]  [000000000048de38] do_idle+0x118/0x1a0

[   37.728349]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.728369]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.728380]  [0000000000000000] 0x0

[   37.728397] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.728410] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.728424] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.728435] Caller[0000000000000000]: 0x0

[   37.728446] Instruction DUMP:

[   37.728455] Unable to handle kernel NULL pointer dereference

[   37.728468] tsk->{mm,active_mm}->context = 0000000000000259

[   37.728480] tsk->{mm,active_mm}->pgd = ffff8001b1f70000

[   37.728494]               \|/ ____ \|/

[   37.728494]               "@'/ .. \`@"

[   37.728494]               /_| \__/ |_\

[   37.728494]                  \__U_/

[   37.728509] swapper/7(0): Oops [#10]

[   37.728526] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G      D           5.2.0-rc5 #220

[   37.728543] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.728563] TPC: <die_if_kernel+0x114/0x24c>

[   37.728574] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.728586] g4: ffff8001b8c4a180 g5: ffff8001be50e000 g6: ffff8001b8c90000 g7: 000000000000000e

[   37.728598] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.728610] o4: 0000000000003f60 o5: ffff8001b8c90000 sp: ffff8001b8c93191 ret_pc: 000000000042b04c

[   37.728622] RPC: <die_if_kernel+0xb4/0x24c>

[   37.728634] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.728649] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.728665] i0: 0000000000ab21e0 i1: ffff8001b8c93c90 i2: ffff8001b8c90000 i3: 00000000000004c0

[   37.728680] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c93271 i7: 00000000004501a4

[   37.728697] I7: <unhandled_fault+0x84/0xa0>

[   37.728708] Call Trace:

[   37.728723]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.728741]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.728763]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.728777]  [00000000000004c0] 0x4c0

[   37.728789]  [000000000048de38] do_idle+0x118/0x1a0

[   37.728805]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.728825]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.728835]  [0000000000000000] 0x0

[   37.728854] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.728867] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.728884] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.728902] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.728914] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.728927] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.728943] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.728954] Caller[0000000000000000]: 0x0

[   37.728961] Instruction DUMP:

[   37.728970]  832f7002

[   37.728983]  9210203c

[   37.728991]  96102020

[   37.729000] <d406c001>

[   37.729008]  93666020

[   37.729021]  9010001c

[   37.729030]  ba076001

[   37.729038]  40020421

[   37.729046]  9764603e

[   37.729053]

[   37.748615] OOPS: Bogus kernel PC [0000000000003900] in fault handler

[   37.748620] OOPS: RPC [000000000042c7e4]

[   37.748634] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.748638] OOPS: Fault was to vaddr[1cc0]

[   37.748649] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D           5.2.0-rc5 #220

[   37.748652] Call Trace:

[   37.748663]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.748684]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.748691]  [0000000000001cc0] 0x1cc0

[   37.748699]  [000000000048de38] do_idle+0x118/0x1a0

[   37.748708]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.748719]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.748725]  [0000000000000000] 0x0

[   37.748729] Unable to handle kernel NULL pointer dereference

[   37.748734] tsk->{mm,active_mm}->context = 00000000000002ad

[   37.748738] tsk->{mm,active_mm}->pgd = ffff8001ad058000

[   37.748743]               \|/ ____ \|/

[   37.748743]               "@'/ .. \`@"

[   37.748743]               /_| \__/ |_\

[   37.748743]                  \__U_/

[   37.748749] swapper/6(0): Oops [#11]

[   37.748759] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D           5.2.0-rc5 #220

[   37.748768] TSTATE: 0000004480001603 TPC: 0000000000001cc0 TNPC: 0000000000001cc4 Y: 00000000    Tainted: G      D

[   37.748774] TPC: <0x1cc0>

[   37.748781] g0: 0000000900000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.748789] g4: 0000000000005a20 g5: ffff8001be4ee000 g6: ffff8001b8c8c000 g7: 0000000000000006

[   37.748795] o0: 0000000000001cc0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.748803] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c8f531 ret_pc: 000000000042c7e4

[   37.748814] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.748822] l0: ffff8001b1ac0000 l1: 0000000000b54000 l2: 000000000007a11f l3: 0000000000b53fe8

[   37.748829] l4: 0000000000000000 l5: ffff8001bf0ca380 l6: 0000000000000000 l7: 00000000ffff9814

[   37.748836] i0: 000000000000188c i1: ffff8001bf0caff8 i2: 0000000000000001 i3: 0000000000001cc0

[   37.748844] i4: 00000000feea6ff8 i5: 00000000feea5800 i6: ffff8001b8c8f5e1 i7: 000000000048de38

[   37.748851] I7: <do_idle+0x118/0x1a0>

[   37.748855] Call Trace:

[   37.748863]  [000000000048de38] do_idle+0x118/0x1a0

[   37.748871]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.748882]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.748888]  [0000000000000000] 0x0

[   37.748897] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.748905] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.748915] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.748921] Caller[0000000000000000]: 0x0

[   37.748924] Instruction DUMP:

[   37.748931] Unable to handle kernel NULL pointer dereference

[   37.748936] tsk->{mm,active_mm}->context = 00000000000002ad

[   37.748947] tsk->{mm,active_mm}->pgd = ffff8001ad058000

[   37.748952]               \|/ ____ \|/

[   37.748952]               "@'/ .. \`@"

[   37.748952]               /_| \__/ |_\

[   37.748952]                  \__U_/

[   37.748957] swapper/6(0): Oops [#12]

[   37.748968] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D           5.2.0-rc5 #220

[   37.748977] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001932    Tainted: G      D

[   37.748987] TPC: <die_if_kernel+0x114/0x24c>

[   37.748994] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.749002] g4: ffff8001b8c49900 g5: ffff8001be4ee000 g6: ffff8001b8c8c000 g7: 000000000000000e

[   37.749009] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.749017] o4: 0000000000003f60 o5: ffff8001b8c8c000 sp: ffff8001b8c8f191 ret_pc: 000000000042b04c

[   37.749025] RPC: <die_if_kernel+0xb4/0x24c>

[   37.749033] l0: 0000000000000009 l1: ffff8001b8c8ff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   37.749040] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   37.749047] i0: 0000000000ab21e0 i1: ffff8001b8c8fc90 i2: ffff8001b8c8c000 i3: 0000000000001cc0

[   37.749055] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c8f271 i7: 00000000004501a4

[   37.749064] I7: <unhandled_fault+0x84/0xa0>

[   37.749068] Call Trace:

[   37.749076]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.749085]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.749099]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.749105]  [0000000000001cc0] 0x1cc0

[   37.749114]  [000000000048de38] do_idle+0x118/0x1a0

[   37.749122]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.749133]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.749139]  [0000000000000000] 0x0

[   37.749149] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.749158] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.749171] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.749183] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.749191] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.749200] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.749211] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.749217] Caller[0000000000000000]: 0x0

[   37.749224] Instruction DUMP:

[   37.749227]  832f7002

[   37.749231]  9210203c

[   37.749235]  96102020

[   37.749239] <d406c001>

[   37.749244]  93666020

[   37.749247]  9010001c

[   37.749252]  ba076001

[   37.749256]  40020421

[   37.749260]  9764603e

[   37.749263]

[   37.769300] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G      D           5.2.0-rc5 #220

[   37.769305] OOPS: Bogus kernel PC [0000000000001b80] in fault handler

[   37.769319] OOPS: RPC [000000000042c7e4]

[   37.769336] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.769344] OOPS: Fault was to vaddr[1b80]

[   37.790172] OOPS: RPC [000000000042c7e4]

[   37.790178] OOPS: Bogus kernel PC [0000000000002f40] in fault handler

[   37.790194] OOPS: RPC [000000000042c7e4]

[   37.790212] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.790220] OOPS: Fault was to vaddr[2f40]

[   37.810737] Call Trace:

[   37.810754] OOPS: Bogus kernel PC [0000000000003240] in fault handler

[   37.810779] OOPS: RPC [000000000042c7e4]

[   37.810797] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.810806] OOPS: Fault was to vaddr[3240]

[   37.831601] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.831607] OOPS: Bogus kernel PC [00000000000029c0] in fault handler

[   37.831631] OOPS: RPC [000000000042c7e4]

[   37.831649] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.831662] OOPS: Fault was to vaddr[29c0]

[   37.852420]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.852429] OOPS: Bogus kernel PC [0000000000003d40] in fault handler

[   37.852464] OOPS: RPC [000000000042c7e4]

[   37.852482] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.852497] OOPS: Fault was to vaddr[3d40]

[   37.873092] OOPS: Bogus kernel PC [0000000000001000] in fault handler

[   37.873096] OOPS: Fault was to vaddr[3900]

[   37.893821]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.893832] OOPS: Bogus kernel PC [0000000000002a80] in fault handler

[   37.893838]  [0000000000000500] 0x500

[   37.893847]  [000000000048de38] do_idle+0x118/0x1a0

[   37.893855]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.893867]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.893873]  [0000000000000000] 0x0

[   37.893884] CPU: 13 PID: 0 Comm: swapper/13 Tainted: G      D           5.2.0-rc5 #220

[   37.893889] Call Trace:

[   37.893901]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.893904] Unable to handle kernel NULL pointer dereference

[   37.893924]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.893928] tsk->{mm,active_mm}->context = 000000000000027d

[   37.893938]  [0000000000003d40] 0x3d40

[   37.893948] tsk->{mm,active_mm}->pgd = ffff8001ace98000

[   37.893959]  [000000000048de38] do_idle+0x118/0x1a0

[   37.893968]               \|/ ____ \|/

[   37.893968]               "@'/ .. \`@"

[   37.893968]               /_| \__/ |_\

[   37.893968]                  \__U_/

[   37.893975]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.893984] swapper/5(0): Oops [#13]

[   37.893994]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.894007] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G      D           5.2.0-rc5 #220

[   37.894011]  [0000000000000000] 0x0

[   37.894023] TSTATE: 0000004480001603 TPC: 0000000000000500 TNPC: 0000000000000504 Y: 00000000    Tainted: G      D

[   37.894032] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G      D           5.2.0-rc5 #220

[   37.894041] Unable to handle kernel paging request at virtual address 0000000000003d40

[   37.894046] TPC: <0x500>

[   37.894048] Call Trace:

[   37.894055] tsk->{mm,active_mm}->context = 000000000000028e

[   37.894065]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.894071] g0: fffffff800000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.894080] tsk->{mm,active_mm}->pgd = ffff8001ac6bc000

[   37.894093]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.894100] g4: 0000000000005a20 g5: ffff8001be4ce000 g6: ffff8001b8c88000 g7: 0000000000000005

[   37.894109]               \|/ ____ \|/

[   37.894109]               "@'/ .. \`@"

[   37.894109]               /_| \__/ |_\

[   37.894109]                  \__U_/

[   37.894114]  [0000000000003900] 0x3900

[   37.894120] o0: 0000000000000500 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.894130] swapper/13(0): Oops [#14]

[   37.894137]  [000000000048de38] do_idle+0x118/0x1a0

[   37.894143] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c8b531 ret_pc: 000000000042c7e4

[   37.894156] CPU: 13 PID: 0 Comm: swapper/13 Tainted: G      D           5.2.0-rc5 #220

[   37.894164]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.894175] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.894188] TSTATE: 0000004480001603 TPC: 0000000000003d40 TNPC: 0000000000003d44 Y: 00000000    Tainted: G      D

[   37.894198]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.894204] l0: ffff8001bf0a0040 l1: 00000007e8c51080 l2: 0000000000b61000 l3: 0000000000000000

[   37.894213] TPC: <0x3d40>

[   37.894218]  [0000000000000000] 0x0

[   37.894228] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 000001000011dcb8

[   37.894234] g0: 0000000e00000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.894243] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G      D           5.2.0-rc5 #220

[   37.894253] Unable to handle kernel paging request at virtual address 0000000000003900

[   37.894259] i0: 0000000000001414 i1: ffff8001bf0aaff8 i2: 0000000000000001 i3: 0000000000000500

[   37.894265] g4: 0000000000005a20 g5: ffff8001be5ce000 g6: ffff8001b8ca8000 g7: 000000000000000d

[   37.894267] Call Trace:

[   37.894275] tsk->{mm,active_mm}->context = 0000000000000263

[   37.894281] i4: 00000000feea0ff8 i5: 00000000fee9f800 i6: ffff8001b8c8b5e1 i7: 000000000048de38

[   37.894290]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.894296] o0: 0000000000003d40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.894309] tsk->{mm,active_mm}->pgd = ffff8001ad1a0000

[   37.894315] I7: <do_idle+0x118/0x1a0>

[   37.894329]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.894340] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8cab531 ret_pc: 000000000042c7e4

[   37.894344]               \|/ ____ \|/

[   37.894344]               "@'/ .. \`@"

[   37.894344]               /_| \__/ |_\

[   37.894344]                  \__U_/

[   37.894345] Call Trace:

[   37.894350]  [0000000000002f40] 0x2f40

[   37.894367] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.894373]  [000000000048de38] do_idle+0x118/0x1a0

[   37.894378] swapper/8(0): Oops [#15]

[   37.894386]  [000000000048de38] do_idle+0x118/0x1a0

[   37.894398] l0: ffff8001bf1a0040 l1: 00000007e8c51080 l2: 0029005500000000 l3: 0000000000000000

[   37.894405]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.894413] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G      D           5.2.0-rc5 #220

[   37.894421]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.894434] l4: ffff8001ba12a000 l5: 0000000000000000 l6: 0000000000000000 l7: 0028005500000000

[   37.894443]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.894451] TSTATE: 0000004480001603 TPC: 0000000000003900 TNPC: 0000000000003904 Y: 00000000    Tainted: G      D

[   37.894462]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.894475] i0: 000000000000116c i1: ffff8001bf1aaff8 i2: 0000000000000001 i3: 0000000000003d40

[   37.894479]  [0000000000000000] 0x0

[   37.894483] TPC: <0x3900>

[   37.894488]  [0000000000000000] 0x0

[   37.894501] i4: 00000000feed0ff8 i5: 00000000feecf800 i6: ffff8001b8cab5e1 i7: 000000000048de38

[   37.894508] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.894514] g0: 0000000300000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.894523] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G      D           5.2.0-rc5 #220

[   37.894526] Unable to handle kernel paging request at virtual address 0000000000002f40

[   37.894537] I7: <do_idle+0x118/0x1a0>

[   37.894544] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.894551] g4: 0000000000005a20 g5: ffff8001be52e000 g6: ffff8001b8c94000 g7: 0000000000000008

[   37.894552] Call Trace:

[   37.894559] tsk->{mm,active_mm}->context = 000000000000027c

[   37.894561] Call Trace:

[   37.894569] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.894579]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.894589] o0: 0000000000003900 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.894592] tsk->{mm,active_mm}->pgd = ffff8001ad080000

[   37.894600]  [000000000048de38] do_idle+0x118/0x1a0

[   37.894605] Caller[0000000000000000]: 0x0

[   37.894619]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.894630] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c97531 ret_pc: 000000000042c7e4

[   37.894633]               \|/ ____ \|/

[   37.894633]               "@'/ .. \`@"

[   37.894633]               /_| \__/ |_\

[   37.894633]                  \__U_/

[   37.894641]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.894643] Instruction DUMP:

[   37.894653]  [0000000000001b80] 0x1b80

[   37.894669] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.894674] swapper/10(0): Oops [#16]

[   37.894677] Unable to handle kernel NULL pointer dereference

[   37.894687]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.894695]  [000000000048de38] do_idle+0x118/0x1a0

[   37.894707] l0: ffff8001bf100040 l1: 00000007e8c51080 l2: 0000600003d523c0 l3: ffff8001bf10e4c8

[   37.894716] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G      D           5.2.0-rc5 #220

[   37.894719] tsk->{mm,active_mm}->context = 000000000000027d

[   37.894724]  [0000000000000000] 0x0

[   37.894732]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.894745] l4: ffff8001b1e34c00 l5: 0000000000000000 l6: 0000000000000000 l7: 002f010100000000

[   37.894753] TSTATE: 0000004480001603 TPC: 0000000000002f40 TNPC: 0000000000002f44 Y: 00000000    Tainted: G      D

[   37.894756] tsk->{mm,active_mm}->pgd = ffff8001ace98000

[   37.894764] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.894774]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.894786] i0: 00000000000013b4 i1: ffff8001bf10aff8 i2: 0000000000000001 i3: 0000000000003900

[   37.894791] TPC: <0x2f40>

[   37.894794]               \|/ ____ \|/

[   37.894794]               "@'/ .. \`@"

[   37.894794]               /_| \__/ |_\

[   37.894794]                  \__U_/

[   37.894802] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.894807]  [0000000000000000] 0x0

[   37.894821] i4: 00000000feeb2ff8 i5: 00000000feeb1800 i6: ffff8001b8c975e1 i7: 000000000048de38

[   37.894828] g0: 0000001200000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.894832] swapper/5(0): Oops [#17]

[   37.894842] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.894844] Unable to handle kernel NULL pointer dereference

[   37.894853] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G      D           5.2.0-rc5 #220

[   37.894864] I7: <do_idle+0x118/0x1a0>

[   37.894871] g4: 0000000000005a20 g5: ffff8001be56e000 g6: ffff8001b8c9c000 g7: 000000000000000a

[   37.894879] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G      D           5.2.0-rc5 #220

[   37.894882] tsk->{mm,active_mm}->context = 0000000000000146

[   37.894887] Caller[0000000000000000]: 0x0

[   37.894889] Call Trace:

[   37.894896] Call Trace:

[   37.894902] o0: 0000000000002f40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.894906] tsk->{mm,active_mm}->pgd = ffff8001b7464000

[   37.894913] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001933    Tainted: G      D

[   37.894923]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.894924] Instruction DUMP:

[   37.894936]  [000000000048de38] do_idle+0x118/0x1a0

[   37.894940]               \|/ ____ \|/

[   37.894940]               "@'/ .. \`@"

[   37.894940]               /_| \__/ |_\

[   37.894940]                  \__U_/

[   37.894947] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c9f531 ret_pc: 000000000042c7e4

[   37.894956] TPC: <die_if_kernel+0x114/0x24c>

[   37.894970]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.894974] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.894983] swapper/9(0): Oops [#18]

[   37.894991]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.895002] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.895008] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.895019]  [0000000000003240] 0x3240

[   37.895028] tsk->{mm,active_mm}->context = 000000000000028e

[   37.895035] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G      D           5.2.0-rc5 #220

[   37.895046]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.895052] l0: ffff8001bf140040 l1: 00000007e8c51080 l2: 0057010100000000 l3: 0000000000000000

[   37.895059] g4: ffff8001b8c49080 g5: ffff8001be4ce000 g6: ffff8001b8c88000 g7: 000000000000000e

[   37.895067]  [000000000048de38] do_idle+0x118/0x1a0

[   37.895077] tsk->{mm,active_mm}->pgd = ffff8001ac6bc000

[   37.895084] TSTATE: 0000004480001603 TPC: 0000000000001b80 TNPC: 0000000000001b84 Y: 00000000    Tainted: G      D

[   37.895089]  [0000000000000000] 0x0

[   37.895095] l4: ffff8001b940ad00 l5: 0000000000000000 l6: 0000000000000000 l7: 0056010100000000

[   37.895101] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.895109]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.895118]               \|/ ____ \|/

[   37.895118]               "@'/ .. \`@"

[   37.895118]               /_| \__/ |_\

[   37.895118]                  \__U_/

[   37.895122] TPC: <0x1b80>

[   37.895130] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.895137] i0: 0000000000001770 i1: ffff8001bf14aff8 i2: 0000000000000001 i3: 0000000000002f40

[   37.895143] o4: 0000000000003f60 o5: ffff8001b8c88000 sp: ffff8001b8c8b191 ret_pc: 000000000042b04c

[   37.895153]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.895165] g0: ffffffeffffffffd g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.895169] swapper/13(0): Oops [#19]

[   37.895177] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.895184] i4: 00000000feebeff8 i5: 00000000feebd800 i6: ffff8001b8c9f5e1 i7: 000000000048de38

[   37.895191] RPC: <die_if_kernel+0xb4/0x24c>

[   37.895196]  [0000000000000000] 0x0

[   37.895209] g4: 0000000000005a20 g5: ffff8001be54e000 g6: ffff8001b8c98000 g7: 0000000000000009

[   37.895218] CPU: 13 PID: 0 Comm: swapper/13 Tainted: G      D           5.2.0-rc5 #220

[   37.895228] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.895234] I7: <do_idle+0x118/0x1a0>

[   37.895240] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.895249] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G      D           5.2.0-rc5 #220

[   37.895253] Unable to handle kernel paging request at virtual address 0000000000003240

[   37.895263] o0: 0000000000001b80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.895271] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.895276] Caller[0000000000000000]: 0x0

[   37.895277] Call Trace:

[   37.895283] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.895285] Call Trace:

[   37.895293] tsk->{mm,active_mm}->context = 0000000000000296

[   37.895299] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8c9b531 ret_pc: 000000000042c7e4

[   37.895309] TPC: <die_if_kernel+0x114/0x24c>

[   37.895310] Instruction DUMP:

[   37.895318]  [000000000048de38] do_idle+0x118/0x1a0

[   37.895328]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.895334] i0: 0000000000ab21e0 i1: ffff8001b8c8bc90 i2: ffff8001b8c88000 i3: 0000000000000500

[   37.895341] tsk->{mm,active_mm}->pgd = ffff8001b4874000

[   37.895352] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.895356] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.895368] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.895376]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.895390]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.895401] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c8b271 i7: 00000000004501a4

[   37.895405]               \|/ ____ \|/

[   37.895405]               "@'/ .. \`@"

[   37.895405]               /_| \__/ |_\

[   37.895405]                  \__U_/

[   37.895412] l0: ffff8001b55bee00 l1: 0000600003bfd068 l2: 0000600003c11ed0 l3: ffffffffffffffff

[   37.895416] tsk->{mm,active_mm}->context = 0000000000000263

[   37.895422] g4: ffff8001b8c4d480 g5: ffff8001be5ce000 g6: ffff8001b8ca8000 g7: 000000000000000e

[   37.895433]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.895438]  [00000000000029c0] 0x29c0

[   37.895452] I7: <unhandled_fault+0x84/0xa0>

[   37.895457] swapper/11(0): Oops [#20]

[   37.895464] l4: 00000100001215b8 l5: 00000100001215c8 l6: 0000010000136e40 l7: 000001000011dcb8

[   37.895467] tsk->{mm,active_mm}->pgd = ffff8001ad1a0000

[   37.895473] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.895478]  [0000000000000000] 0x0

[   37.895486]  [000000000048de38] do_idle+0x118/0x1a0

[   37.895494] Call Trace:

[   37.895503] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G      D           5.2.0-rc5 #220

[   37.895509] i0: 000000000000174c i1: ffff8001bf12aff8 i2: 0000000000000001 i3: 0000000000001b80

[   37.895513]               \|/ ____ \|/

[   37.895513]               "@'/ .. \`@"

[   37.895513]               /_| \__/ |_\

[   37.895513]                  \__U_/

[   37.895519] o4: 0000000000003f60 o5: ffff8001b8ca8000 sp: ffff8001b8cab191 ret_pc: 000000000042b04c

[   37.895527] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.895534]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.895548]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.895555] i4: 00000000feeb8ff8 i5: 00000000feeb7800 i6: ffff8001b8c9b5e1 i7: 000000000048de38

[   37.895562] TSTATE: 0000004480001603 TPC: 0000000000003240 TNPC: 0000000000003244 Y: 00000000    Tainted: G      D

[   37.895566] swapper/8(0): Oops [#21]

[   37.895576] RPC: <die_if_kernel+0xb4/0x24c>

[   37.895583] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.895594]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.895607]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.895613] I7: <do_idle+0x118/0x1a0>

[   37.895617] TPC: <0x3240>

[   37.895626] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G      D           5.2.0-rc5 #220

[   37.895632] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.895642] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.895647]  [0000000000000000] 0x0

[   37.895666]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.895668] Call Trace:

[   37.895675] g0: fffffff000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.895683] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001933    Tainted: G      D

[   37.895689] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.895693] Caller[0000000000000000]: 0x0

[   37.895697] Unable to handle kernel paging request at virtual address 00000000000029c0

[   37.895710]  [000000000048de38] do_idle+0x118/0x1a0

[   37.895715]  [0000000000000500] 0x500

[   37.895721] g4: 0000000000005a20 g5: ffff8001be58e000 g6: ffff8001b8ca0000 g7: 000000000000000b

[   37.895736] TPC: <die_if_kernel+0x114/0x24c>

[   37.895743] i0: 0000000000ab21e0 i1: ffff8001b8cabc90 i2: ffff8001b8ca8000 i3: 0000000000003d40

[   37.895744] Instruction DUMP:

[   37.895753] tsk->{mm,active_mm}->context = 0000000000000277

[   37.895761]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.895768]  [000000000048de38] do_idle+0x118/0x1a0

[   37.895774] o0: 0000000000003240 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.895780] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.895785] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.895791] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8cab271 i7: 00000000004501a4

[   37.895800] tsk->{mm,active_mm}->pgd = ffff8001b0ebc000

[   37.895811]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.895818]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.895825] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8ca3531 ret_pc: 000000000042c7e4

[   37.895832] g4: ffff8001b8c4aa00 g5: ffff8001be52e000 g6: ffff8001b8c94000 g7: 000000000000000e

[   37.895835] tsk->{mm,active_mm}->context = 000000000000027c

[   37.895843] I7: <unhandled_fault+0x84/0xa0>

[   37.895853]               \|/ ____ \|/

[   37.895853]               "@'/ .. \`@"

[   37.895853]               /_| \__/ |_\

[   37.895853]                  \__U_/

[   37.895858]  [0000000000000000] 0x0

[   37.895868]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.895879] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.895885] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.895889] tsk->{mm,active_mm}->pgd = ffff8001ad080000

[   37.895890] Call Trace:

[   37.895901] swapper/12(0): Oops [#22]

[   37.895909] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.895913]  [0000000000000000] 0x0

[   37.895920] l0: ffff8001bf160040 l1: 00000007e8c51080 l2: 000000000007a11f l3: 0000000000b53fe8

[   37.895927] o4: 0000000000003f60 o5: ffff8001b8c94000 sp: ffff8001b8c97191 ret_pc: 000000000042b04c

[   37.895930]               \|/ ____ \|/

[   37.895930]               "@'/ .. \`@"

[   37.895930]               /_| \__/ |_\

[   37.895930]                  \__U_/

[   37.895939]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.895954] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G      D           5.2.0-rc5 #220

[   37.895962] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.895971] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.895977] l4: 0000000000000000 l5: ffff8001bf16a380 l6: 00000000009b2400 l7: 00000000ffff97ca

[   37.895987] RPC: <die_if_kernel+0xb4/0x24c>

[   37.895991] swapper/10(0): Oops [#23]

[   37.896000]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.896013] TSTATE: 0000004480001603 TPC: 00000000000029c0 TNPC: 00000000000029c4 Y: 00000000    Tainted: G      D

[   37.896023] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.896031] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.896038] i0: 00000000000012c4 i1: ffff8001bf16aff8 i2: 0000000000000001 i3: 0000000000003240

[   37.896044] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.896053] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G      D           5.2.0-rc5 #220

[   37.896071]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.896076] TPC: <0x29c0>

[   37.896081] Caller[0000000000000000]: 0x0

[   37.896093] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.896100] i4: 00000000feec4ff8 i5: 00000000feec3800 i6: ffff8001b8ca35e1 i7: 000000000048de38

[   37.896110] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.896123] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.896128]  [0000000000003d40] 0x3d40

[   37.896134] g0: fffffff800000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.896135] Instruction DUMP:

[   37.896147] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.896154] I7: <do_idle+0x118/0x1a0>

[   37.896168] i0: 0000000000ab21e0 i1: ffff8001b8c97c90 i2: ffff8001b8c94000 i3: 0000000000003900

[   37.896178] TPC: <die_if_kernel+0x114/0x24c>

[   37.896184]  [000000000048de38] do_idle+0x118/0x1a0

[   37.896187] Unable to handle kernel NULL pointer dereference

[   37.896194] g4: 0000000000005a20 g5: ffff8001be5ae000 g6: ffff8001b8ca4000 g7: 000000000000000c

[   37.896201] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.896202] Call Trace:

[   37.896217] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c97271 i7: 00000000004501a4

[   37.896223] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.896227] tsk->{mm,active_mm}->context = 0000000000000146

[   37.896235]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.896240] o0: 00000000000029c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.896248] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.896255]  [000000000048de38] do_idle+0x118/0x1a0

[   37.896268] I7: <unhandled_fault+0x84/0xa0>

[   37.896272] tsk->{mm,active_mm}->pgd = ffff8001b7464000

[   37.896279] g4: ffff8001b8c4bb00 g5: ffff8001be56e000 g6: ffff8001b8c9c000 g7: 000000000000000e

[   37.896289]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.896296] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8ca7531 ret_pc: 000000000042c7e4

[   37.896305] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.896313]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.896323]               \|/ ____ \|/

[   37.896323]               "@'/ .. \`@"

[   37.896323]               /_| \__/ |_\

[   37.896323]                  \__U_/

[   37.896324] Call Trace:

[   37.896330] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.896335]  [0000000000000000] 0x0

[   37.896346] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.896350] Caller[0000000000000000]: 0x0

[   37.896360]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.896370] swapper/9(0): Oops [#24]

[   37.896379]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.896386] o4: 0000000000003f60 o5: ffff8001b8c9c000 sp: ffff8001b8c9f191 ret_pc: 000000000042b04c

[   37.896394] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.896401] l0: ffff8001bf180040 l1: 00000007e8c51080 l2: 000000000007a11f l3: 0000000000b53fe8

[   37.896402] Instruction DUMP:

[   37.896412]  [0000000000000000] 0x0

[   37.896420] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G      D           5.2.0-rc5 #220

[   37.896429]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.896439] RPC: <die_if_kernel+0xb4/0x24c>

[   37.896447] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.896449]  832f7002

[   37.896461] l4: 0000000000000000 l5: ffff8001bf18a380 l6: 00000000009b2400 l7: 00000000ffff97c5

[   37.896469] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.896477] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.896496]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.896503] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.896505]  9210203c

[   37.896517] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.896529] i0: 0000000000001670 i1: ffff8001bf18aff8 i2: 0000000000000001 i3: 00000000000029c0

[   37.896537] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.896546] TPC: <die_if_kernel+0x114/0x24c>

[   37.896552]  [0000000000003900] 0x3900

[   37.896554]  96102020

[   37.896561] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.896571] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.896585] i4: 00000000feecaff8 i5: 00000000feec9800 i6: ffff8001b8ca75e1 i7: 000000000048de38

[   37.896595] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.896602] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.896604] <d406c001>

[   37.896612]  [000000000048de38] do_idle+0x118/0x1a0

[   37.896619] i0: 0000000000ab21e0 i1: ffff8001b8c9fc90 i2: ffff8001b8c9c000 i3: 0000000000002f40

[   37.896625] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.896638] I7: <do_idle+0x118/0x1a0>

[   37.896643] Caller[0000000000000000]: 0x0

[   37.896651] g4: ffff8001b8c4b280 g5: ffff8001be54e000 g6: ffff8001b8c98000 g7: 000000000000000e

[   37.896652]  93666020

[   37.896661]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.896668] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c9f271 i7: 00000000004501a4

[   37.896675] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.896683] Call Trace:

[   37.896684] Instruction DUMP:

[   37.896691] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.896693]  9010001c

[   37.896704]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.896712] I7: <unhandled_fault+0x84/0xa0>

[   37.896721] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.896730] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.896738]  [000000000048de38] do_idle+0x118/0x1a0

[   37.896745] o4: 0000000000003f60 o5: ffff8001b8c98000 sp: ffff8001b8c9b191 ret_pc: 000000000042b04c

[   37.896746]  ba076001

[   37.896752]  [0000000000000000] 0x0

[   37.896754] Call Trace:

[   37.896763] Caller[0000000000000000]: 0x0

[   37.896767] tsk->{mm,active_mm}->context = 0000000000000296

[   37.896775]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.896784] RPC: <die_if_kernel+0xb4/0x24c>

[   37.896786]  40020421

[   37.896796] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.896809]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.896810] Instruction DUMP:

[   37.896814] tsk->{mm,active_mm}->pgd = ffff8001b4874000

[   37.896825]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.896831] l0: 0000000000000009 l1: ffff8001b8c9bf60 l2: 0000000057ac6c00 l3: 0000000000000400

[   37.896833]  9764603e

[   37.896853] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.896855]  832f7002

[   37.896864]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.896868]               \|/ ____ \|/

[   37.896868]               "@'/ .. \`@"

[   37.896868]               /_| \__/ |_\

[   37.896868]                  \__U_/

[   37.896872]  [0000000000000000] 0x0

[   37.896878] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.896879]

[   37.896887]  9210203c

[   37.896902] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.896913]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.896918] swapper/11(0): Oops [#25]

[   37.896925] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.896932] i0: 0000000000ab21e0 i1: ffff8001b8c9bc90 i2: ffff8001b8c98000 i3: 0000000000001b80

[   37.896942]  96102020

[   37.896954] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.896959]  [0000000000002f40] 0x2f40

[   37.896968] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G      D           5.2.0-rc5 #220

[   37.896976] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.896983] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8c9b271 i7: 00000000004501a4

[   37.896991] <d406c001>

[   37.896998] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.897006]  [000000000048de38] do_idle+0x118/0x1a0

[   37.897014] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.897024] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.897032] I7: <unhandled_fault+0x84/0xa0>

[   37.897040]  93666020

[   37.897048] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.897056]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.897065] TPC: <die_if_kernel+0x114/0x24c>

[   37.897070] Caller[0000000000000000]: 0x0

[   37.897072] Call Trace:

[   37.897079]  9010001c

[   37.897089] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.897098]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.897105] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.897114]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.897115] Instruction DUMP:

[   37.897124]  ba076001

[   37.897129] Caller[0000000000000000]: 0x0

[   37.897135]  [0000000000000000] 0x0

[   37.897142] g4: ffff8001b8c4c380 g5: ffff8001be58e000 g6: ffff8001b8ca0000 g7: 000000000000000e

[   37.897151]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.897155] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.897163]  40020421

[   37.897165] Instruction DUMP:

[   37.897179] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.897186] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.897200]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.897210] tsk->{mm,active_mm}->context = 0000000000000277

[   37.897212]  9764603e

[   37.897215]  832f7002

[   37.897225] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.897232] o4: 0000000000003f60 o5: ffff8001b8ca0000 sp: ffff8001b8ca3191 ret_pc: 000000000042b04c

[   37.897237]  [0000000000001b80] 0x1b80

[   37.897245]

[   37.897249] tsk->{mm,active_mm}->pgd = ffff8001b0ebc000

[   37.897251]  9210203c

[   37.897265] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.897274] RPC: <die_if_kernel+0xb4/0x24c>

[   37.897282]  [000000000048de38] do_idle+0x118/0x1a0

[   37.897290]  96102020

[   37.897295]               \|/ ____ \|/

[   37.897295]               "@'/ .. \`@"

[   37.897295]               /_| \__/ |_\

[   37.897295]                  \__U_/

[   37.897305] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.897312] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.897320]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.897327] <d406c001>

[   37.897332] swapper/12(0): Oops [#26]

[   37.897339] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.897345] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.897356]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.897364]  93666020

[   37.897373] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G      D           5.2.0-rc5 #220

[   37.897380] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.897387] i0: 0000000000ab21e0 i1: ffff8001b8ca3c90 i2: ffff8001b8ca0000 i3: 0000000000003240

[   37.897393]  [0000000000000000] 0x0

[   37.897400]  9010001c

[   37.897409] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.897418] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.897425] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8ca3271 i7: 00000000004501a4

[   37.897435] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.897441]  ba076001

[   37.897450] TPC: <die_if_kernel+0x114/0x24c>

[   37.897455] Caller[0000000000000000]: 0x0

[   37.897463] I7: <unhandled_fault+0x84/0xa0>

[   37.897472] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.897479]  40020421

[   37.897486] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.897487] Instruction DUMP:

[   37.897494] Call Trace:

[   37.897508] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.897516]  9764603e

[   37.897519]  832f7002

[   37.897526] g4: ffff8001b8c4cc00 g5: ffff8001be5ae000 g6: ffff8001b8ca4000 g7: 000000000000000e

[   37.897534]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.897546] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.897553]

[   37.897555]  9210203c

[   37.897562] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.897571]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.897578] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.897586]  96102020

[   37.897593] o4: 0000000000003f60 o5: ffff8001b8ca4000 sp: ffff8001b8ca7191 ret_pc: 000000000042b04c

[   37.897606]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.897614] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.897623] <d406c001>

[   37.897632] RPC: <die_if_kernel+0xb4/0x24c>

[   37.897637]  [0000000000003240] 0x3240

[   37.897648] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.897656]  93666020

[   37.897662] l0: 0000000000001000 l1: 0000004480001606 l2: 00000000009806c8 l3: 0000000000000400

[   37.897669]  [000000000048de38] do_idle+0x118/0x1a0

[   37.897674] Caller[0000000000000000]: 0x0

[   37.897681]  9010001c

[   37.897688] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   37.897695]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.897696] Instruction DUMP:

[   37.897703]  ba076001

[   37.897710] i0: 0000000000ab21e0 i1: ffff8001b8ca7c90 i2: ffff8001b8ca4000 i3: 00000000000029c0

[   37.897712]  832f7002

[   37.897722]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.897729]  40020421

[   37.897732]  9210203c

[   37.897739] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8ca7271 i7: 00000000004501a4

[   37.897749]  [0000000000000000] 0x0

[   37.897751]  9764603e

[   37.897754]  96102020

[   37.897762] I7: <unhandled_fault+0x84/0xa0>

[   37.897769]

[   37.897772] <d406c001>

[   37.897781] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.897782] Call Trace:

[   37.897789]  93666020

[   37.897804] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.897816]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.897818]  9010001c

[   37.897836] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.897838]  ba076001

[   37.897847]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.897854]  40020421

[   37.897866] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.897879]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.897886]  9764603e

[   37.897894] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.897899]  [00000000000029c0] 0x29c0

[   37.897905]

[   37.897912] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.897919]  [000000000048de38] do_idle+0x118/0x1a0

[   37.897934] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.897942]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.897952] Caller[0000000000000000]: 0x0

[   37.897960]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.897967] Instruction DUMP:

[   37.897972]  [0000000000000000] 0x0

[   37.897974]  832f7002

[   37.897977]  9210203c

[   37.897988] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.897990]  96102020

[   37.897993] <d406c001>

[   37.898003] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.898005]  93666020

[   37.898008]  9010001c

[   37.898023] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.898024]  ba076001

[   37.898028]  40020421

[   37.898040] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.898042]  9764603e

[   37.898045]

[   37.898053] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.898066] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.898082] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.898092] Caller[0000000000000000]: 0x0

[   37.898098] Instruction DUMP:

[   37.898102]  832f7002

[   37.898110]  9210203c

[   37.898122]  96102020

[   37.898130] <d406c001>

[   37.898138]  93666020

[   37.898146]  9010001c

[   37.898154]  ba076001

[   37.898163]  40020421

[   37.898171]  9764603e

[   37.898178]

[   37.914659] OOPS: RPC [00000000009a9ac4]

[   37.914665] OOPS: Bogus kernel PC [0000000000002400] in fault handler

[   37.914670] OOPS: RPC [0000000300000000]

[   37.914678] OOPS: RPC <0x300000000>

[   37.914683] OOPS: Fault was to vaddr[2400]

[   37.914694] CPU: 16 PID: 1616 Comm: systemd-journal Tainted: G      D           5.2.0-rc5 #220

[   37.914699] Call Trace:

[   37.914711]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.914728]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.914736]  [0000000000002400] 0x2400

[   37.914751]  [00000000005c3290] path_lookupat+0x30/0x220

[   37.914763]  [00000000005c59e8] filename_lookup.part.61+0x48/0x120

[   37.914780]  [00000000005b068c] do_faccessat+0x6c/0x260

[   37.914794]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   37.914800] Unable to handle kernel paging request at virtual address 0000000000002400

[   37.914805] tsk->{mm,active_mm}->context = 000000000000002a

[   37.914809] tsk->{mm,active_mm}->pgd = ffff8001b7588000

[   37.914814]               \|/ ____ \|/

[   37.914814]               "@'/ .. \`@"

[   37.914814]               /_| \__/ |_\

[   37.914814]                  \__U_/

[   37.914821] systemd-journal(1616): Oops [#27]

[   37.914833] CPU: 16 PID: 1616 Comm: systemd-journal Tainted: G      D           5.2.0-rc5 #220

[   37.914844] TSTATE: 0000004411001605 TPC: 0000000000002400 TNPC: 0000000000002404 Y: 00000000    Tainted: G      D

[   37.914850] TPC: <0x2400>

[   37.914859] g0: ffff8001b46b7261 g1: 00000000a21d3002 g2: 00000000f0200000 g3: 00000000fff78000

[   37.914867] g4: 0000000000005a20 g5: ffff8001be62e000 g6: ffff8001b46b4000 g7: 0000000000000000

[   37.914874] o0: 0000000000002400 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.914882] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b46b72c1 ret_pc: 0000000300000000

[   37.914888] RPC: <0x300000000>

[   37.914896] l0: 0000000000000000 l1: 0000000000000000 l2: 0000000000000000 l3: 0000000000000000

[   37.914903] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: ffff800100124380

[   37.914911] i0: ffff8001b95d0021 i1: ffff8001b46b7d08 i2: 0000000000000001 i3: 0000000000002400

[   37.914919] i4: 00000000feee2ff8 i5: 00000000feee1800 i6: ffff8001b46b7381 i7: 00000000005c3290

[   37.914930] I7: <path_lookupat+0x30/0x220>

[   37.914933] Call Trace:

[   37.914944]  [00000000005c3290] path_lookupat+0x30/0x220

[   37.914957]  [00000000005c59e8] filename_lookup.part.61+0x48/0x120

[   37.914971]  [00000000005b068c] do_faccessat+0x6c/0x260

[   37.914985]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   37.914999] Caller[00000000005c3290]: path_lookupat+0x30/0x220

[   37.915012] Caller[00000000005c59e8]: filename_lookup.part.61+0x48/0x120

[   37.915026] Caller[00000000005b068c]: do_faccessat+0x6c/0x260

[   37.915042] Caller[0000000000406254]: linux_sparc_syscall+0x34/0x44

[   37.915051] Caller[ffff800100204fa0]: 0xffff800100204fa0

[   37.915054] Instruction DUMP:

[   37.915066] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.915071] tsk->{mm,active_mm}->context = 000000000000002a

[   37.915075] tsk->{mm,active_mm}->pgd = ffff8001b7588000

[   37.915080]               \|/ ____ \|/

[   37.915080]               "@'/ .. \`@"

[   37.915080]               /_| \__/ |_\

[   37.915080]                  \__U_/

[   37.915087] systemd-journal(1616): Oops [#28]

[   37.915099] CPU: 16 PID: 1616 Comm: systemd-journal Tainted: G      D           5.2.0-rc5 #220

[   37.915108] TSTATE: 0000008880001601 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000010    Tainted: G      D

[   37.915119] TPC: <die_if_kernel+0x114/0x24c>

[   37.915126] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.915133] g4: ffff8001b665aa00 g5: ffff8001be62e000 g6: ffff8001b46b4000 g7: 000000000000000e

[   37.915140] o0: 0000000000000011 o1: 000000000000003c o2: ffff800100204fa0 o3: 0000000000000020

[   37.915147] o4: 0000000000003f60 o5: ffff8001b46b4000 sp: ffff8001b46b6f21 ret_pc: 000000000042b04c

[   37.915154] RPC: <die_if_kernel+0xb4/0x24c>

[   37.915162] l0: 0000000000000009 l1: ffff8001b46b7f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   37.915168] l4: 0000000000000001 l5: 0000000000000000 l6: ffff8001b46b4000 l7: 00000000005b08a0

[   37.915175] i0: 0000000000ab21e0 i1: ffff8001b46b7a20 i2: ffff8001b46b4000 i3: 0000000000002400

[   37.915182] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b46b7001 i7: 00000000004501a4

[   37.915191] I7: <unhandled_fault+0x84/0xa0>

[   37.915194] Call Trace:

[   37.915202]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.915210]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.915223]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.915229]  [0000000000002400] 0x2400

[   37.915238]  [00000000005c3290] path_lookupat+0x30/0x220

[   37.915247]  [00000000005c59e8] filename_lookup.part.61+0x48/0x120

[   37.915258]  [00000000005b068c] do_faccessat+0x6c/0x260

[   37.915268]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   37.915278] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.915286] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.915297] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.915303] Caller[0000000300000000]: 0x300000000

[   37.915312] Caller[00000000005c3290]: path_lookupat+0x30/0x220

[   37.915321] Caller[00000000005c59e8]: filename_lookup.part.61+0x48/0x120

[   37.915331] Caller[00000000005b068c]: do_faccessat+0x6c/0x260

[   37.915342] Caller[0000000000406254]: linux_sparc_syscall+0x34/0x44

[   37.915348] Caller[ffff800100204fa0]: 0xffff800100204fa0

[   37.915351] Instruction DUMP:

[   37.915354]  832f7002

[   37.915357]  9210203c

[   37.915361]  96102020

[   37.915365] <d406c001>

[   37.915369]  93666020

[   37.915373]  9010001c

[   37.915376]  ba076001

[   37.915380]  40020421

[   37.915384]  9764603e

[   37.915387]

[   37.929575] systemd[1]: systemd-journald.service: Service has no hold-off time (RestartSec=0), scheduling restart.

[   37.929972] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.

[   37.931719] systemd[1]: systemd-journal-flush.service: Succeeded.

[   37.932577] systemd[1]: Stopped Flush Journal to Persistent Storage.

[   37.932736] systemd[1]: Stopping Flush Journal to Persistent Storage...

[   37.933529] systemd[1]: Stopped Journal Service.

[   37.934508] systemd[1]: systemd-journald.service: Failed to create cgroup /system.slice/systemd-journald.service: Cannot allocate memory

[   37.935443] OOPS: RPC [000000000042c7e4]

[   37.935450] OOPS: Bogus kernel PC [0000000000002d40] in fault handler

[   37.935463] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.935478] OOPS: RPC [000000000042c7e4]

[   37.935481] OOPS: Fault was to vaddr[2a80]

[   37.935496] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G      D           5.2.0-rc5 #220

[   37.935503] Call Trace:

[   37.935517]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.935538]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.935548]  [0000000000002a80] 0x2a80

[   37.935560]  [000000000048de38] do_idle+0x118/0x1a0

[   37.935572]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.935586]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.935595]  [0000000000000000] 0x0

[   37.935604] Unable to handle kernel paging request at virtual address 0000000000002a80

[   37.935611] tsk->{mm,active_mm}->context = 00000000000002a6

[   37.935620] tsk->{mm,active_mm}->pgd = ffff8001ac008000

[   37.935628]               \|/ ____ \|/

[   37.935628]               "@'/ .. \`@"

[   37.935628]               /_| \__/ |_\

[   37.935628]                  \__U_/

[   37.935637] swapper/15(0): Oops [#29]

[   37.935649] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G      D           5.2.0-rc5 #220

[   37.935662] TSTATE: 0000004480001603 TPC: 0000000000002a80 TNPC: 0000000000002a84 Y: 00000000    Tainted: G      D

[   37.935671] TPC: <0x2a80>

[   37.935681] g0: fffffff900000010 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.935693] g4: 0000000000005a20 g5: ffff8001be60e000 g6: ffff8001b8cc0000 g7: 000000000000000f

[   37.935704] o0: 0000000000002a80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.935715] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8cc3531 ret_pc: 000000000042c7e4

[   37.935732] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.935743] l0: ffff8001bf1e0040 l1: 00000007e95da700 l2: 0000000000000010 l3: 0000000000be00c0

[   37.935754] l4: ffff8001b55bee00 l5: 0000000000bdc300 l6: 0000000000000009 l7: 0000000000000000

[   37.935766] i0: 0000000000001814 i1: ffff8001bf1eaff8 i2: 0000000000000001 i3: 0000000000002a80

[   37.935777] i4: 00000000feedcff8 i5: 00000000feedb800 i6: ffff8001b8cc35e1 i7: 000000000048de38

[   37.935789] I7: <do_idle+0x118/0x1a0>

[   37.935797] Call Trace:

[   37.935809]  [000000000048de38] do_idle+0x118/0x1a0

[   37.935822]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.935835]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.935845]  [0000000000000000] 0x0

[   37.935858] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.935871] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.935884] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.935893] Caller[0000000000000000]: 0x0

[   37.935898] Instruction DUMP:

[   37.935908] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.935916] tsk->{mm,active_mm}->context = 00000000000002a6

[   37.935924] tsk->{mm,active_mm}->pgd = ffff8001ac008000

[   37.935932]               \|/ ____ \|/

[   37.935932]               "@'/ .. \`@"

[   37.935932]               /_| \__/ |_\

[   37.935932]                  \__U_/

[   37.935941] swapper/15(0): Oops [#30]

[   37.935954] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G      D           5.2.0-rc5 #220

[   37.935966] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001933    Tainted: G      D

[   37.935979] TPC: <die_if_kernel+0x114/0x24c>

[   37.935989] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.936000] g4: ffff8001b8c4e580 g5: ffff8001be60e000 g6: ffff8001b8cc0000 g7: 000000000000000e

[   37.936011] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.936022] o4: 0000000000003f60 o5: ffff8001b8cc0000 sp: ffff8001b8cc3191 ret_pc: 000000000042b04c

[   37.936036] RPC: <die_if_kernel+0xb4/0x24c>

[   37.936046] l0: 0000000000000009 l1: ffff8001b8cc3f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   37.936057] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   37.936069] i0: 0000000000ab21e0 i1: ffff8001b8cc3c90 i2: ffff8001b8cc0000 i3: 0000000000002a80

[   37.936080] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8cc3271 i7: 00000000004501a4

[   37.936094] I7: <unhandled_fault+0x84/0xa0>

[   37.936101] Call Trace:

[   37.936114]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.936127]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.936144]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.936154]  [0000000000002a80] 0x2a80

[   37.936167]  [000000000048de38] do_idle+0x118/0x1a0

[   37.936179]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   37.936194]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.936203]  [0000000000000000] 0x0

[   37.936215] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.936228] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.936245] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.936262] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.936274] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.936286] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   37.936301] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.936312] Caller[0000000000000000]: 0x0

[   37.936318] Instruction DUMP:

[   37.936327]  832f7002

[   37.936335]  9210203c

[   37.936343]  96102020

[   37.936351] <d406c001>

[   37.936360]  93666020

[   37.936368]  9010001c

[   37.936376]  ba076001

[   37.936384]  40020421

[   37.936391]  9764603e

[   37.936397]

[   37.939308] systemd[1]: Starting Journal Service...

[   37.939635] systemd[2912]: systemd-journald.service: Failed to attach to cgroup /system.slice/systemd-journald.service: No such file or directory

[   37.940040] systemd[1]: systemd-tmpfiles-setup.service: Failed to create cgroup /system.slice/systemd-tmpfiles-setup.service: Cannot allocate memory

[   37.940081] systemd[1]: Failed to realize cgroups for queued unit systemd-tmpfiles-setup.service, ignoring: Cannot allocate memory

[   37.956125] OOPS: RPC <__mutex_lock.isra.6+0x84/0x440>

[   37.956134] OOPS: Fault was to vaddr[1000]

[   37.956189] OOPS: Bogus kernel PC [0000000000003f40] in fault handler

[   37.956215] OOPS: RPC [000000000042c7e4]

[   37.956234] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.956241] OOPS: Fault was to vaddr[3f40]

[   37.956256] CPU: 18 PID: 0 Comm: swapper/18 Tainted: G      D           5.2.0-rc5 #220

[   37.956262] Call Trace:

[   37.956277]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   37.956299]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.956309]  [0000000000003f40] 0x3f40

[   37.956322]  [000000000048de38] do_idle+0x118/0x1a0

[   37.956335]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.956354]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.956364]  [0000000000000000] 0x0

[   37.956372] Unable to handle kernel paging request at virtual address 0000000000003f40

[   37.956378] tsk->{mm,active_mm}->context = 000000000000013d

[   37.956384] tsk->{mm,active_mm}->pgd = ffff8001b5bfc000

[   37.956390]               \|/ ____ \|/

[   37.956390]               "@'/ .. \`@"

[   37.956390]               /_| \__/ |_\

[   37.956390]                  \__U_/

[   37.956398] swapper/18(0): Oops [#31]

[   37.956413] CPU: 18 PID: 0 Comm: swapper/18 Tainted: G      D           5.2.0-rc5 #220

[   37.956425] TSTATE: 0000004480001603 TPC: 0000000000003f40 TNPC: 0000000000003f44 Y: 00000000    Tainted: G      D

[   37.956433] TPC: <0x3f40>

[   37.956444] g0: fffffffdfffffffa g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   37.956455] g4: 0000000000005a20 g5: ffff8001be66e000 g6: ffff8001b8ccc000 g7: 0000000000000012

[   37.956464] o0: 0000000000003f40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   37.956474] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8ccf531 ret_pc: 000000000042c7e4

[   37.956491] RPC: <arch_cpu_idle+0x64/0xa0>

[   37.956502] l0: ffff8001bf240040 l1: 00000007fed2d100 l2: 0000000000000000 l3: 0000000000000000

[   37.956512] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: ffff800100362000

[   37.956521] i0: 0000000000001188 i1: ffff8001bf24aff8 i2: 0000000000000001 i3: 0000000000003f40

[   37.956531] i4: 00000000feeeeff8 i5: 00000000feeed800 i6: ffff8001b8ccf5e1 i7: 000000000048de38

[   37.956542] I7: <do_idle+0x118/0x1a0>

[   37.956546] Call Trace:

[   37.956558]  [000000000048de38] do_idle+0x118/0x1a0

[   37.956571]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.956586]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.956596]  [0000000000000000] 0x0

[   37.956610] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.956623] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.956638] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.956647] Caller[0000000000000000]: 0x0

[   37.956650] Instruction DUMP:

[   37.956662] Unable to handle kernel paging request at virtual address 0000000000002000

[   37.956668] tsk->{mm,active_mm}->context = 000000000000013d

[   37.956674] tsk->{mm,active_mm}->pgd = ffff8001b5bfc000

[   37.956680]               \|/ ____ \|/

[   37.956680]               "@'/ .. \`@"

[   37.956680]               /_| \__/ |_\

[   37.956680]                  \__U_/

[   37.956688] swapper/18(0): Oops [#32]

[   37.956703] CPU: 18 PID: 0 Comm: swapper/18 Tainted: G      D           5.2.0-rc5 #220

[   37.956716] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   37.956730] TPC: <die_if_kernel+0x114/0x24c>

[   37.956741] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   37.956747] systemd[2913]: systemd-journald.service: Failed to attach to cgroup /system.slice/systemd-journald.service: No such file or directory

[   37.956755] g4: ffff8001b8cd0000 g5: ffff8001be66e000 g6: ffff8001b8ccc000 g7: 000000000000000e

[   37.956764] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   37.956775] o4: 0000000000003f60 o5: ffff8001b8ccc000 sp: ffff8001b8ccf191 ret_pc: 000000000042b04c

[   37.956789] RPC: <die_if_kernel+0xb4/0x24c>

[   37.956800] l0: 0000000000000009 l1: ffff8001b8ccff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   37.956808] l4: 0000000000000001 l5: 0000000000000000 l6: ffff800108016580 l7: 0000000000000000

[   37.956817] i0: 0000000000ab21e0 i1: ffff8001b8ccfc90 i2: ffff8001b8ccc000 i3: 0000000000003f40

[   37.956826] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8ccf271 i7: 00000000004501a4

[   37.956838] I7: <unhandled_fault+0x84/0xa0>

[   37.956841] Call Trace:

[   37.956852]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   37.956863]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   37.956881]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   37.956889]  [0000000000003f40] 0x3f40

[   37.956901]  [000000000048de38] do_idle+0x118/0x1a0

[   37.956913]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   37.956928]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   37.956937]  [0000000000000000] 0x0

[   37.956952] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   37.956965] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   37.956985] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   37.957004] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   37.957016] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   37.957029] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   37.957045] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   37.957055] Caller[0000000000000000]: 0x0

[   37.957058] Instruction DUMP:

[   37.957063]  832f7002

[   37.957068]  9210203c

[   37.957074]  96102020

[   37.957080] <d406c001>

[   37.957085]  93666020

[   37.957090]  9010001c

[   37.957096]  ba076001

[   37.957102]  40020421

[   37.957107]  9764603e

[   37.957111]

[   37.973319] systemd[2914]: systemd-journald.service: Failed to attach to cgroup /system.slice/systemd-journald.service: No such file or directory

[   37.977186] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.977202] systemd[1]: segfault at f02491fc ip 00000000f02491fc (rpc ffff80010057f328) sp 000007fefff338c1 error 1

[   37.977207] OOPS: Fault was to vaddr[2d40]

[   37.977218]  in systemd[10000000000+116000]

[   37.998058] CPU: 14 PID: 920 Comm: kworker/14:1 Tainted: G      D           5.2.0-rc5 #220

[   37.998063] OOPS: Bogus kernel PC [0000000000003280] in fault handler

[   37.998067] OOPS: RPC [000000000042c7e4]

[   37.998080] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   37.998085] OOPS: Fault was to vaddr[3280]

[   38.018843] OOPS: Bogus kernel PC [0000000000001a80] in fault handler

[   38.040313] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func

[   38.040320] OOPS: Bogus kernel PC [0000000000001040] in fault handler

[   38.040326] Call Trace:

[   38.040330] OOPS: RPC [000000000042c7e4]

[   38.040344] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.040349] OOPS: Fault was to vaddr[1040]

[   38.060948] OOPS: RPC [000000000042c7e4]

[   38.060962] OOPS: Bogus kernel PC [0000000000003b80] in fault handler

[   38.060967] OOPS: RPC [0000000000497ba8]

[   38.060984] OOPS: RPC <run_rebalance_domains+0x68/0xc0>

[   38.060990] OOPS: Fault was to vaddr[3b80]

[   38.082150]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.082157] OOPS: Bogus kernel PC [0000000000003fc0] in fault handler

[   38.082161] OOPS: RPC [000000000042c7e4]

[   38.082175] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.082179] OOPS: Fault was to vaddr[3fc0]

[   38.103599] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.103605] OOPS: Bogus kernel PC [00000000000034c0] in fault handler

[   38.103609] OOPS: RPC [000000000042c7e4]

[   38.103622] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.103626] OOPS: Fault was to vaddr[34c0]

[   38.124187]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.124193] OOPS: Bogus kernel PC [0000000000002c40] in fault handler

[   38.124197] OOPS: RPC [000000000042c7e4]

[   38.124210] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.124215] OOPS: Fault was to vaddr[2c40]

[   38.145233] OOPS: Fault was to vaddr[1a80]

[   38.145249] OOPS: Bogus kernel PC [00000000000034c0] in fault handler

[   38.145253] OOPS: RPC [000000000042c7e4]

[   38.145266] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.145271] OOPS: Fault was to vaddr[34c0]

[   38.166585]  [0000000000001000] 0x1000

[   38.166594] OOPS: Bogus kernel PC [00000000000007c0] in fault handler

[   38.166599] OOPS: RPC [000000000042c7e4]

[   38.166612] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.166616] OOPS: Fault was to vaddr[7c0]

[   38.187974] OOPS: Bogus kernel PC [0000000000002c40] in fault handler

[   38.209328]  [0000000000561708] memcg_create_kmem_cache+0x8/0x100

[   38.209337] OOPS: Bogus kernel PC [0000000000003040] in fault handler

[   38.209342] OOPS: RPC [000000000042c7e4]

[   38.209356] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.209360] OOPS: Fault was to vaddr[3040]

[   38.230011] OOPS: RPC [000000000042c7e4]

[   38.230027] OOPS: Bogus kernel PC [0000000000000dc0] in fault handler

[   38.230031] OOPS: RPC [000000000042c7e4]

[   38.230046] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.230051] OOPS: Fault was to vaddr[dc0]

[   38.251014]  [00000000005a6114] memcg_kmem_cache_create_func+0x14/0xa0

[   38.251024] OOPS: Bogus kernel PC [0000000000001940] in fault handler

[   38.251029] OOPS: RPC [000000000042c7e4]

[   38.251052] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.251056] OOPS: Fault was to vaddr[1940]

[   38.272003] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.272008] OOPS: Bogus kernel PC [0000000000001c00] in fault handler

[   38.272012] OOPS: RPC [000000000042c7e4]

[   38.272021] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.272026] OOPS: Fault was to vaddr[1c00]

[   38.293039]  [000000000047a450] process_one_work+0x190/0x3c0

[   38.293044] OOPS: Bogus kernel PC [0000000000001cc0] in fault handler

[   38.293048] OOPS: RPC [000000000042c7e4]

[   38.293057] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.293062] OOPS: Fault was to vaddr[1cc0]

[   38.314077] OOPS: Fault was to vaddr[2c40]

[   38.314092] OOPS: Bogus kernel PC [0000000000000fc0] in fault handler

[   38.314096] OOPS: RPC [000000000042c7e4]

[   38.314105] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.314110] OOPS: Fault was to vaddr[fc0]

[   38.334813]  [000000000047a7bc] worker_thread+0x13c/0x500

[   38.334818] OOPS: Bogus kernel PC [0000000000001ec0] in fault handler

[   38.334822] OOPS: RPC [000000000042c7e4]

[   38.334831] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.334835] OOPS: Fault was to vaddr[1ec0]

[   38.355390] OOPS: Bogus kernel PC [0000000000001040] in fault handler

[   38.376486]  [00000000004810dc] kthread+0xfc/0x120

[   38.376491] OOPS: Bogus kernel PC [0000000000001100] in fault handler

[   38.376495] OOPS: RPC [000000000042c7e4]

[   38.376505] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.376509] OOPS: Fault was to vaddr[1100]

[   38.397291] OOPS: RPC [000000000042c7e4]

[   38.397304] OOPS: Bogus kernel PC [0000000000001480] in fault handler

[   38.397308] OOPS: RPC [000000000042c7e4]

[   38.397321] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.397325] OOPS: Fault was to vaddr[1480]

[   38.418445]  [00000000004060a4] ret_from_fork+0x1c/0x2c

[   38.418453] OOPS: Bogus kernel PC [0000000000000fc0] in fault handler

[   38.418457] OOPS: RPC [000000000042c7e4]

[   38.418470] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.418475] OOPS: Fault was to vaddr[fc0]

[   38.439088] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.439168] OOPS: Bogus kernel PC [0000000000000f80] in fault handler

[   38.439171] OOPS: RPC [000000000042c7e4]

[   38.439181] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.439184] OOPS: Fault was to vaddr[f80]

[   38.460283]  [0000000000000000] 0x0

[   38.460295] OOPS: Bogus kernel PC [0000000000000fc0] in fault handler

[   38.460299] OOPS: RPC [000000000042c7e4]

[   38.460308] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.460313] OOPS: Fault was to vaddr[fc0]

[   38.481044] OOPS: Fault was to vaddr[1040]

[   38.481058] OOPS: Bogus kernel PC [0000000000000e80] in fault handler

[   38.481062] OOPS: RPC [000000000042c7e4]

[   38.481071] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.481075] OOPS: Fault was to vaddr[e80]

[   38.502227] CPU: 68 PID: 0 Comm: swapper/68 Tainted: G      D           5.2.0-rc5 #220

[   38.502235] OOPS: Bogus kernel PC [0000000000001900] in fault handler

[   38.502239] OOPS: RPC [000000000042c7e4]

[   38.502247] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.502252] OOPS: Fault was to vaddr[1900]

[   38.502255] Unable to handle kernel NULL pointer dereference

[   38.502261] tsk->{mm,active_mm}->context = 00000000000002af

[   38.502266] tsk->{mm,active_mm}->pgd = ffff8001ad610000

[   38.502271]               \|/ ____ \|/

[   38.502271]               "@'/ .. \`@"

[   38.502271]               /_| \__/ |_\

[   38.502271]                  \__U_/

[   38.502277] kworker/14:1(920): Oops [#33]

[   38.502288] CPU: 14 PID: 920 Comm: kworker/14:1 Tainted: G      D           5.2.0-rc5 #220

[   38.502305] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func

[   38.502317] TSTATE: 0000004480001607 TPC: 0000000000001000 TNPC: 0000000000001004 Y: 00000000    Tainted: G      D

[   38.502323] TPC: <0x1000>

[   38.502331] g0: 000000010000001e g1: 0000000000000000 g2: 00000000f0200000 g3: 00000000fff78000

[   38.502339] g4: 0000000000005a20 g5: ffff8001be5ee000 g6: ffff8001b9bd8000 g7: 0000000000bdcec0

[   38.502346] o0: 0000000000001000 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.502353] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b9bdb241 ret_pc: 00000000009a9ac4

[   38.502364] RPC: <__mutex_lock.isra.6+0x84/0x440>

[   38.502372] l0: 0000000000000400 l1: 00000000000000ff l2: 0000000000000000 l3: 000000000000000e

[   38.502380] l4: 0000000000000001 l5: ffff8001bf1ca380 l6: ffff8001b91f5440 l7: 00000000ffff9817

[   38.502387] i0: 0000000000b700f8 i1: 0000000000000002 i2: 0000000000000054 i3: 0000000000001000

[   38.502395] i4: 00000000feed6ff8 i5: 00000000feed5800 i6: ffff8001b9bdb311 i7: 0000000000561708

[   38.502403] I7: <memcg_create_kmem_cache+0x8/0x100>

[   38.502407] Call Trace:

[   38.502415]  [0000000000561708] memcg_create_kmem_cache+0x8/0x100

[   38.502429]  [00000000005a6114] memcg_kmem_cache_create_func+0x14/0xa0

[   38.502443]  [000000000047a450] process_one_work+0x190/0x3c0

[   38.502454]  [000000000047a7bc] worker_thread+0x13c/0x500

[   38.502465]  [00000000004810dc] kthread+0xfc/0x120

[   38.502476]  [00000000004060a4] ret_from_fork+0x1c/0x2c

[   38.502482]  [0000000000000000] 0x0

[   38.502493] Caller[0000000000561708]: memcg_create_kmem_cache+0x8/0x100

[   38.502508] Caller[00000000005a6114]: memcg_kmem_cache_create_func+0x14/0xa0

[   38.502523] Caller[000000000047a450]: process_one_work+0x190/0x3c0

[   38.502534] Caller[000000000047a7bc]: worker_thread+0x13c/0x500

[   38.502545] Caller[00000000004810dc]: kthread+0xfc/0x120

[   38.502557] Caller[00000000004060a4]: ret_from_fork+0x1c/0x2c

[   38.502563] Caller[0000000000000000]: 0x0

[   38.502566] Instruction DUMP:

[   38.502574] Unable to handle kernel NULL pointer dereference

[   38.502578] tsk->{mm,active_mm}->context = 00000000000002af

[   38.502583] tsk->{mm,active_mm}->pgd = ffff8001ad610000

[   38.502588]               \|/ ____ \|/

[   38.502588]               "@'/ .. \`@"

[   38.502588]               /_| \__/ |_\

[   38.502588]                  \__U_/

[   38.502594] kworker/14:1(920): Oops [#34]

[   38.502604] CPU: 14 PID: 920 Comm: kworker/14:1 Tainted: G      D           5.2.0-rc5 #220

[   38.502621] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func

[   38.502633] TSTATE: 0000008880001603 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000009    Tainted: G      D

[   38.502643] TPC: <die_if_kernel+0x114/0x24c>

[   38.502651] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.502659] g4: ffff8001b6bccc00 g5: ffff8001be5ee000 g6: ffff8001b9bd8000 g7: 000000000000000e

[   38.502665] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.502673] o4: 0000000000003f60 o5: ffff8001b9bd8000 sp: ffff8001b9bdaea1 ret_pc: 000000000042b04c

[   38.502681] RPC: <die_if_kernel+0xb4/0x24c>

[   38.502689] l0: 0000000000001000 l1: 0000004480001602 l2: 00000000009806c8 l3: 0000000000000400

[   38.502696] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   38.502703] i0: 0000000000ab21e0 i1: ffff8001b9bdb9a0 i2: ffff8001b9bd8000 i3: 0000000000001000

[   38.502711] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b9bdaf81 i7: 00000000004501a4

[   38.502720] I7: <unhandled_fault+0x84/0xa0>

[   38.502723] Call Trace:

[   38.502732]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.502741]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.502755]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.502761]  [0000000000001000] 0x1000

[   38.502770]  [0000000000561708] memcg_create_kmem_cache+0x8/0x100

[   38.502785]  [00000000005a6114] memcg_kmem_cache_create_func+0x14/0xa0

[   38.502800]  [000000000047a450] process_one_work+0x190/0x3c0

[   38.502811]  [000000000047a7bc] worker_thread+0x13c/0x500

[   38.502821]  [00000000004810dc] kthread+0xfc/0x120

[   38.502833]  [00000000004060a4] ret_from_fork+0x1c/0x2c

[   38.502839]  [0000000000000000] 0x0

[   38.502850] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.502859] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.502871] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.502883] Caller[00000000009a9ac4]: __mutex_lock.isra.6+0x84/0x440

[   38.502893] Caller[0000000000561708]: memcg_create_kmem_cache+0x8/0x100

[   38.502908] Caller[00000000005a6114]: memcg_kmem_cache_create_func+0x14/0xa0

[   38.502922] Caller[000000000047a450]: process_one_work+0x190/0x3c0

[   38.502933] Caller[000000000047a7bc]: worker_thread+0x13c/0x500

[   38.502944] Caller[00000000004810dc]: kthread+0xfc/0x120

[   38.502956] Caller[00000000004060a4]: ret_from_fork+0x1c/0x2c

[   38.502962] Caller[0000000000000000]: 0x0

[   38.502965] Instruction DUMP:

[   38.502968]  832f7002

[   38.502972]  9210203c

[   38.502977]  96102020

[   38.502981] <d406c001>

[   38.502985]  93666020

[   38.502990]  9010001c

[   38.502994]  ba076001

[   38.502998]  40020421

[   38.503002]  9764603e

[   38.503006]

[   38.523090] OOPS: Bogus kernel PC [0000000000001040] in fault handler

[   38.543789] Call Trace:

[   38.543808] OOPS: Bogus kernel PC [0000000000000e80] in fault handler

[   38.543812] OOPS: RPC [000000000042c7e4]

[   38.543822] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.543826] OOPS: Fault was to vaddr[e80]

[   38.564408] OOPS: RPC [000000000042c7e4]

[   38.564425] OOPS: Bogus kernel PC [0000000000000e40] in fault handler

[   38.564429] OOPS: RPC [000000000042c7e4]

[   38.564441] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.564445] OOPS: Fault was to vaddr[e40]

[   38.585245]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.585254] OOPS: Bogus kernel PC [0000000000001740] in fault handler

[   38.585258] OOPS: RPC [000000000042c7e4]

[   38.585271] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.585275] OOPS: Fault was to vaddr[1740]

[   38.606101] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.606106] OOPS: Bogus kernel PC [0000000000000f80] in fault handler

[   38.606110] OOPS: RPC [000000000042c7e4]

[   38.606122] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.606127] OOPS: Fault was to vaddr[f80]

[   38.626924]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.626931] OOPS: Bogus kernel PC [0000000000000e80] in fault handler

[   38.626935] OOPS: RPC [000000000042c7e4]

[   38.626949] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.626954] OOPS: Fault was to vaddr[e80]

[   38.648553] OOPS: Fault was to vaddr[1040]

[   38.648568] OOPS: Bogus kernel PC [0000000000000e40] in fault handler

[   38.648575] OOPS: RPC [000000000042c7e4]

[   38.648594] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.648602] OOPS: Fault was to vaddr[e40]

[   38.669289]  [0000000000001ec0] 0x1ec0

[   38.669300] OOPS: Bogus kernel PC [0000000000001040] in fault handler

[   38.669306] OOPS: RPC [000000000042c7e4]

[   38.669323] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.669331] OOPS: Fault was to vaddr[1040]

[   38.690503] OOPS: Bogus kernel PC [0000000000000f00] in fault handler

[   38.712102]  [000000000048de38] do_idle+0x118/0x1a0

[   38.712119] OOPS: Bogus kernel PC [0000000000000f40] in fault handler

[   38.712130] OOPS: RPC [000000000042c7e4]

[   38.712159] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.712169] OOPS: Fault was to vaddr[f40]

[   38.733004] OOPS: RPC [000000000042c7e4]

[   38.733027] OOPS: Bogus kernel PC [0000000000000f00] in fault handler

[   38.733039] OOPS: RPC [000000000042c7e4]

[   38.733087] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.733106] OOPS: Fault was to vaddr[f00]

[   38.754390]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.754433] OOPS: Bogus kernel PC [0000000000001180] in fault handler

[   38.754466]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.754476]  [0000000000000000] 0x0

[   38.754494] CPU: 17 PID: 0 Comm: swapper/17 Tainted: G      D           5.2.0-rc5 #220

[   38.754499] Unable to handle kernel NULL pointer dereference

[   38.754502] Call Trace:

[   38.754508] tsk->{mm,active_mm}->context = 0000000000000069

[   38.754521]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.754526] tsk->{mm,active_mm}->pgd = ffff8001b0104000

[   38.754542]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.754550]               \|/ ____ \|/

[   38.754550]               "@'/ .. \`@"

[   38.754550]               /_| \__/ |_\

[   38.754550]                  \__U_/

[   38.754556]  [0000000000002d40] 0x2d40

[   38.754564] swapper/68(0): Oops [#35]

[   38.754573]  [000000000048de38] do_idle+0x118/0x1a0

[   38.754586] CPU: 68 PID: 0 Comm: swapper/68 Tainted: G      D           5.2.0-rc5 #220

[   38.754598]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.754607] TSTATE: 0000004480001603 TPC: 0000000000001ec0 TNPC: 0000000000001ec4 Y: 00000000    Tainted: G      D

[   38.754620]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.754632] TPC: <0x1ec0>

[   38.754637]  [0000000000000000] 0x0

[   38.754645] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.754651] Unable to handle kernel paging request at virtual address 0000000000002d40

[   38.754678] CPU: 84 PID: 0 Comm: swapper/84 Tainted: G      D           5.2.0-rc5 #220

[   38.754685] g4: 0000000000005a20 g5: ffff8001fe8ae000 g6: ffff8001fa758000 g7: 0000000000000044

[   38.754690] tsk->{mm,active_mm}->context = 000000000000013d

[   38.754696] o0: 0000000000001ec0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.754699] Call Trace:

[   38.754704] tsk->{mm,active_mm}->pgd = ffff8001b5bfc000

[   38.754710] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa75b531 ret_pc: 000000000042c7e4

[   38.754749]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.754755]               \|/ ____ \|/

[   38.754755]               "@'/ .. \`@"

[   38.754755]               /_| \__/ |_\

[   38.754755]                  \__U_/

[   38.754790] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.754831]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.754837] swapper/17(0): Oops [#36]

[   38.754847] l0: ffff8001ff480040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.754864]  [0000000000001900] 0x1900

[   38.754874] CPU: 17 PID: 0 Comm: swapper/17 Tainted: G      D           5.2.0-rc5 #220

[   38.754885] l4: ffff8001ff489c80 l5: ffff8001ff489cf0 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.754906]  [000000000048de38] do_idle+0x118/0x1a0

[   38.754916] TSTATE: 0000004480001603 TPC: 0000000000002d40 TNPC: 0000000000002d44 Y: 00000000    Tainted: G      D

[   38.754925] i0: 00000000000007f4 i1: ffff8001ff48aff8 i2: 0000000000000001 i3: 0000000000001ec0

[   38.754941]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.754946] TPC: <0x2d40>

[   38.754955] i4: 00000000fef5aff8 i5: 00000000fef59800 i6: ffff8001fa75b5e1 i7: 000000000048de38

[   38.754985]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.754993] g0: fffffff6fffffff0 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.755011] I7: <do_idle+0x118/0x1a0>

[   38.755023]  [0000000000000000] 0x0

[   38.755033] g4: 0000000000005a20 g5: ffff8001be64e000 g6: ffff8001b8cc8000 g7: 0000000000000011

[   38.755035] Call Trace:

[   38.755041] Unable to handle kernel NULL pointer dereference

[   38.755051] CPU: 27 PID: 0 Comm: swapper/27 Tainted: G      D           5.2.0-rc5 #220

[   38.755058] o0: 0000000000002d40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.755080]  [000000000048de38] do_idle+0x118/0x1a0

[   38.755086] tsk->{mm,active_mm}->context = 0000000000000079

[   38.755090] Call Trace:

[   38.755097] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8ccb531 ret_pc: 000000000042c7e4

[   38.755114]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.755118] tsk->{mm,active_mm}->pgd = ffff8001b0604000

[   38.755129]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.755141] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.755173]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.755183]               \|/ ____ \|/

[   38.755183]               "@'/ .. \`@"

[   38.755183]               /_| \__/ |_\

[   38.755183]                  \__U_/

[   38.755197]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.755205] l0: ffff8001ac4b1100 l1: 00000100001a8dfc l2: 0000000000000000 l3: 0000000000000000

[   38.755218]  [0000000000000000] 0x0

[   38.755225] swapper/84(0): Oops [#37]

[   38.755230]  [00000000000034c0] 0x34c0

[   38.755237] l4: 0000000000000000 l5: 0000000000000000 l6: 00000100001cd180 l7: 000001000019fa60

[   38.755254] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.755263]  [000000000048de38] do_idle+0x118/0x1a0

[   38.755273] CPU: 84 PID: 0 Comm: swapper/84 Tainted: G      D           5.2.0-rc5 #220

[   38.755280] i0: 0000000000000f70 i1: ffff8001bf22aff8 i2: 0000000000000001 i3: 0000000000002d40

[   38.755296] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.755303]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.755313] TSTATE: 0000004480001603 TPC: 0000000000001900 TNPC: 0000000000001904 Y: 00000000    Tainted: G      D

[   38.755320] i4: 00000000feee8ff8 i5: 00000000feee7800 i6: ffff8001b8ccb5e1 i7: 000000000048de38

[   38.755336] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.755347]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.755362] TPC: <0x1900>

[   38.755369] I7: <do_idle+0x118/0x1a0>

[   38.755379] Caller[0000000000000000]: 0x0

[   38.755385]  [0000000000000000] 0x0

[   38.755394] g0: 0000001d0000000c g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.755398] Call Trace:

[   38.755401] Instruction DUMP:

[   38.755406] Unable to handle kernel paging request at virtual address 00000000000034c0

[   38.755421] CPU: 91 PID: 0 Comm: swapper/91 Tainted: G      D           5.2.0-rc5 #220

[   38.755427] g4: 0000000000005a20 g5: ffff8001fe9ae000 g6: ffff8001fa778000 g7: 0000000000000054

[   38.755436]  [000000000048de38] do_idle+0x118/0x1a0

[   38.755439] tsk->{mm,active_mm}->context = 0000000000000261

[   38.755445] Unable to handle kernel NULL pointer dereference

[   38.755448] Call Trace:

[   38.755454] o0: 0000000000001900 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.755463]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.755466] tsk->{mm,active_mm}->pgd = ffff8001ac020000

[   38.755471] tsk->{mm,active_mm}->context = 0000000000000069

[   38.755495]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.755501] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa77b531 ret_pc: 000000000042c7e4

[   38.755514]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.755518]               \|/ ____ \|/

[   38.755518]               "@'/ .. \`@"

[   38.755518]               /_| \__/ |_\

[   38.755518]                  \__U_/

[   38.755522] tsk->{mm,active_mm}->pgd = ffff8001b0104000

[   38.755553]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.755582] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.755587]  [0000000000000000] 0x0

[   38.755592] swapper/27(0): Oops [#38]

[   38.755598]               \|/ ____ \|/

[   38.755598]               "@'/ .. \`@"

[   38.755598]               /_| \__/ |_\

[   38.755598]                  \__U_/

[   38.755609]  [0000000000000e40] 0xe40

[   38.755618] l0: ffff8001ff580040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.755627] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.755634] CPU: 27 PID: 0 Comm: swapper/27 Tainted: G      D           5.2.0-rc5 #220

[   38.755644] swapper/68(0): Oops [#39]

[   38.755664]  [000000000048de38] do_idle+0x118/0x1a0

[   38.755675] l4: ffff8001ff589c80 l5: 0000000000000000 l6: 0000000000000000 l7: 001f008100000000

[   38.755684] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.755691] TSTATE: 0000004480001603 TPC: 00000000000034c0 TNPC: 00000000000034c4 Y: 00000000    Tainted: G      D

[   38.755702] CPU: 68 PID: 0 Comm: swapper/68 Tainted: G      D           5.2.0-rc5 #220

[   38.755712]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.755721] i0: 0000000000000880 i1: ffff8001ff58aff8 i2: 0000000000000001 i3: 0000000000001900

[   38.755732] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.755737] TPC: <0x34c0>

[   38.755770] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001938    Tainted: G      D

[   38.755794]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.755802] i4: 00000000fef8aff8 i5: 00000000fef89800 i6: ffff8001fa77b5e1 i7: 000000000048de38

[   38.755808] Caller[0000000000000000]: 0x0

[   38.755814] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.755844] TPC: <die_if_kernel+0x114/0x24c>

[   38.755851]  [0000000000000000] 0x0

[   38.755864] I7: <do_idle+0x118/0x1a0>

[   38.755867] Instruction DUMP:

[   38.755873] g4: 0000000000005a20 g5: ffff8001be78e000 g6: ffff8001b8d00000 g7: 000000000000001b

[   38.755908] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.755912] Unable to handle kernel NULL pointer dereference

[   38.755920] CPU: 24 PID: 0 Comm: swapper/24 Tainted: G      D           5.2.0-rc5 #220

[   38.755923] Call Trace:

[   38.755929] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.755934] o0: 00000000000034c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.755971] g4: ffff8001fa742200 g5: ffff8001fe8ae000 g6: ffff8001fa758000 g7: 000000000000000e

[   38.755976] tsk->{mm,active_mm}->context = 0000000000000000

[   38.755979] Call Trace:

[   38.755997]  [000000000048de38] do_idle+0x118/0x1a0

[   38.756007] o4: 0000000000000000 o5: 0000000000000000 sp: ff[   38.756007] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8d03531 ret_pc: 000000000042c7e4

[   38.756038] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.756042] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.756052]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.756069]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.756074] tsk->{mm,active_mm}->pgd = ffff8001b5bfc000

[   38.756084] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.756114] o4: 0000000000003f60 o5: ffff8001fa758000 sp: ffff8001fa75b191 ret_pc: 000000000042b04c

[   38.756120]               \|/ ____ \|/

[   38.756120]               "@'/ .. \`@"

[   38.756120]               /_| \__/ |_\

[   38.756120]                  \__U_/

[   38.756134]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.756160]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.756166]               \|/ ____ \|/

[   38.756166]               "@'/ .. \`@"

[   38.756166]               /_| \__/ |_\

[   38.756166]                  \__U_/

[   38.756172] l0: ffff8001bf360040 l1: 00000007e8c51080 l2: 0000000000c08400 l3: 0000000000b95800

[   38.756191] RPC: <die_if_kernel+0xb4/0x24c>

[   38.756197] swapper/91(0): Oops [#40]

[   38.756203]  [0000000000003fc0] 0x3fc0

[   38.756216]  [0000000000000000] 0x0

[   38.756223] swapper/17(0): Oops [#41]

[   38.756229] l4: ffff8001bf369c80 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.756236] l0: 0000000000000009 l1: ffff8001fa75bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.756243]  [000000000048de38] do_idle+0x118/0x1a0

[   38.756255] CPU: 91 PID: 0 Comm: swapper/91 Tainted: G      D           5.2.0-rc5 #220

[   38.756270] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.756281] CPU: 17 PID: 0 Comm: swapper/17 Tainted: G      D           5.2.0-rc5 #220

[   38.756287] i0: 0000000000000fd0 i1: ffff8001bf36aff8 i2: 0000000000000001 i3: 00000000000034c0

[   38.756294] l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000ba7e l7: 0000000000000001

[   38.756302]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.756310] TSTATE: 0000004480001603 TPC: 0000000000000e40 TNPC: 0000000000000e44 Y: 00000000    Tainted: G      D

[   38.756323] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.756334] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001933    Tainted: G      D

[   38.756340] i4: 00000000fef24ff8 i5: 00000000fef23800 i6: ffff8001b8d035e1 i7: 000000000048de38

[   38.756347] i0: 0000000000ab21e0 i1: ffff8001fa75bc90 i2: ffff8001fa758000 i3: 0000000000001ec0

[   38.756357]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.756367] TPC: <0xe40>

[   38.756383] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.756394] TPC: <die_if_kernel+0x114/0x24c>

[   38.756400] I7: <do_idle+0x118/0x1a0>

[   38.756407] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa75b271 i7: 00000000004501a4

[   38.756412]  [0000000000000000] 0x0

[   38.756419] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.756427] Caller[0000000000000000]: 0x0

[   38.756435] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.756437] Call Trace:

[   38.756451] I7: <unhandled_fault+0x84/0xa0>

[   38.756457] Unable to handle kernel paging request at virtual address 0000000000003fc0

[   38.756467] CPU: 83 PID: 0 Comm: swapper/83 Tainted: G      D           5.2.0-rc5 #220

[   38.756473] g4: 0000000000005a20 g5: ffff8001fea8e000 g6: ffff8001fa794000 g7: 000000000000005b

[   38.756475] Instruction DUMP:

[   38.756484] g4: ffff8001b8c4f680 g5: ffff8001be64e000 g6: ffff8001b8cc8000 g7: 000000000000000e

[   38.756491]  [000000000048de38] do_idle+0x118/0x1a0

[   38.756495] Call Trace:

[   38.756499] tsk->{mm,active_mm}->context = 00000000000002aa

[   38.756503] Call Trace:

[   38.756508] o0: 0000000000000e40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.756513] Unable to handle kernel NULL pointer dereference

[   38.756520] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.756527]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.756552]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.756558] tsk->{mm,active_mm}->pgd = ffff8001b4898000

[   38.756580]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.756586] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa797531 ret_pc: 000000000042c7e4

[   38.756590] tsk->{mm,active_mm}->context = 0000000000000079

[   38.756598] o4: 0000000000003f60 o5: ffff8001b8cc8000 sp: ffff8001b8ccb191 ret_pc: 000000000042b04c

[   38.756606]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.756631]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.756637]               \|/ ____ \|/

[   38.756637]               "@'/ .. \`@"

[   38.756637]               /_| \__/ |_\

[   38.756637]                  \__U_/

[   38.756668]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.756693] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.756697] tsk->{mm,active_mm}->pgd = ffff8001b0604000

[   38.756706] RPC: <die_if_kernel+0xb4/0x24c>

[   38.756710]  [0000000000000000] 0x0

[   38.756753]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.756759] swapper/24(0): Oops [#42]

[   38.756766]  [0000000000000e80] 0xe80

[   38.756775] l0: ffff8001ff660040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.756781]               \|/ ____ \|/

[   38.756781]               "@'/ .. \`@"

[   38.756781]               /_| \__/ |_\

[   38.756781]                  \__U_/

[   38.756789] l0: 0000000000000009 l1: ffff8001b8ccbf60 l2: 0000000057ac6c00 l3: 0000000000000400

[   38.756796] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.756814]  [0000000000001ec0] 0x1ec0

[   38.756823] CPU: 24 PID: 0 Comm: swapper/24 Tainted: G      D           5.2.0-rc5 #220

[   38.756837]  [000000000048de38] do_idle+0x118/0x1a0

[   38.756846] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.756855] swapper/84(0): Oops [#43]

[   38.756862] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   38.756869] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.756895]  [000000000048de38] do_idle+0x118/0x1a0

[   38.756904] TSTATE: 0000004480001603 TPC: 0000000000003fc0 TNPC: 0000000000003fc4 Y: 00000000    Tainted: G      D

[   38.756923]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.756930] i0: 000000000000055c i1: ffff8001ff66aff8 i2: 0000000000000001 i3: 0000000000000e40

[   38.756939] CPU: 84 PID: 0 Comm: swapper/84 Tainted: G      D           5.2.0-rc5 #220

[   38.756947] i0: 0000000000ab21e0 i1: ffff8001b8ccbc90 i2: ffff8001b8cc8000 i3: 0000000000002d40

[   38.756955] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.756977]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.756982] TPC: <0x3fc0>

[   38.757001]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.757008] i4: 00000000fefb4ff8 i5: 00000000fefb3800 i6: ffff8001fa7975e1 i7: 000000000048de38

[   38.757037] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.757045] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8ccb271 i7: 00000000004501a4

[   38.757050] Caller[0000000000000000]: 0x0

[   38.757083]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.757089] g0: 0000000300000009 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.757097]  [0000000000000000] 0x0

[   38.757110] I7: <do_idle+0x118/0x1a0>

[   38.757137] TPC: <die_if_kernel+0x114/0x24c>

[   38.757149] I7: <unhandled_fault+0x84/0xa0>

[   38.757151] Instruction DUMP:

[   38.757170]  [0000000000000000] 0x0

[   38.757177] g4: 0000000000005a20 g5: ffff8001be72e000 g6: ffff8001b8cf4000 g7: 0000000000000018

[   38.757185] CPU: 30 PID: 0 Comm: swapper/30 Tainted: G      D           5.2.0-rc5 #220

[   38.757189] Unable to handle kernel NULL pointer dereference

[   38.757191] Call Trace:

[   38.757217] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.757219] Call Trace:

[   38.757223] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.757241] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.757247] o0: 0000000000003fc0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.757249] Call Trace:

[   38.757253] tsk->{mm,active_mm}->context = 0000000000000000

[   38.757267]  [000000000048de38] do_idle+0x118/0x1a0

[   38.757295] g4: ffff8001fa74d480 g5: ffff8001fe9ae000 g6: ffff8001fa778000 g7: 000000000000000e

[   38.757305]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.757308] tsk->{mm,active_mm}->context = 0000000000000261

[   38.757319] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.757326] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8cf7531 ret_pc: 000000000042c7e4

[   38.757335]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.757340] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.757355]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.757385] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.757396]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.757399] tsk->{mm,active_mm}->pgd = ffff8001ac020000

[   38.757421] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.757431] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.757444]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.757450]               \|/ ____ \|/

[   38.757450]               "@'/ .. \`@"

[   38.757450]               /_| \__/ |_\

[   38.757450]                  \__U_/

[   38.757473]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.757499] o4: 0000000000003f60 o5: ffff8001fa778000 sp: ffff8001fa77b191 ret_pc: 000000000042b04c

[   38.757515]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.757518]               \|/ ____ \|/

[   38.757518]               "@'/ .. \`@"

[   38.757518]               /_| \__/ |_\

[   38.757518]                  \__U_/

[   38.757541] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.757548] l0: ffff8001b0e82a80 l1: 0000000000b4c000 l2: 0000000000b61000 l3: ffff8001b0c427c0

[   38.757553]  [0000000000003040] 0x3040

[   38.757559] swapper/83(0): Oops [#44]

[   38.757568]  [0000000000000000] 0x0

[   38.757587] RPC: <die_if_kernel+0xb4/0x24c>

[   38.757593]  [0000000000002d40] 0x2d40

[   38.757597] swapper/27(0): Oops [#45]

[   38.757611] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.757618] l4: 00000000c0800000 l5: ffff8001ac30fdc0 l6: ffff8001ac30fdc8 l7: 0000000000b58800

[   38.757625]  [000000000048de38] do_idle+0x118/0x1a0

[   38.757636] CPU: 83 PID: 0 Comm: swapper/83 Tainted: G      D           5.2.0-rc5 #220

[   38.757650] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.757658] l0: 0000000000000009 l1: ffff8001fa77bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.757667]  [000000000048de38] do_idle+0x118/0x1a0

[   38.757675] CPU: 27 PID: 0 Comm: swapper/27 Tainted: G      D           5.2.0-rc5 #220

[   38.757685] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.757693] i0: 0000000000001530 i1: ffff8001bf30aff8 i2: 0000000000000001 i3: 0000000000003fc0

[   38.757700]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.757708] TSTATE: 0000004480001603 TPC: 0000000000000e80 TNPC: 0000000000000e84 Y: 00000000    Tainted: G      D

[   38.757721] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.757730] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.757740]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.757747] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.757768] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.757775] i4: 00000000fef12ff8 i5: 00000000fef11800 i6: ffff8001b8cf75e1 i7: 000000000048de38

[   38.757784]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.757794] TPC: <0xe80>

[   38.757808] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.757816] i0: 0000000000ab21e0 i1: ffff8001fa77bc90 i2: ffff8001fa778000 i3: 0000000000001900

[   38.757829]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.757837] TPC: <die_if_kernel+0x114/0x24c>

[   38.757845] Caller[0000000000000000]: 0x0

[   38.757852] I7: <do_idle+0x118/0x1a0>

[   38.757856]  [0000000000000000] 0x0

[   38.757863] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.757872] Caller[0000000000000000]: 0x0

[   38.757881] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa77b271 i7: 00000000004501a4

[   38.757888]  [0000000000000000] 0x0

[   38.757894] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.757896] Instruction DUMP:

[   38.757899] Call Trace:

[   38.757903] Unable to handle kernel paging request at virtual address 0000000000003040

[   38.757914] CPU: 80 PID: 0 Comm: swapper/80 Tainted: G      D           5.2.0-rc5 #220

[   38.757922] g4: 0000000000005a20 g5: ffff8001fe98e000 g6: ffff8001fa774000 g7: 0000000000000053

[   38.757925] Instruction DUMP:

[   38.757940] I7: <unhandled_fault+0x84/0xa0>

[   38.757951] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.757957] g4: ffff8001b8cd4c80 g5: ffff8001be78e000 g6: ffff8001b8d00000 g7: 000000000000000e

[   38.757961]  832f7002

[   38.757969]  [000000000048de38] do_idle+0x118/0x1a0

[   38.757972] tsk->{mm,active_mm}->context = 000000000000029c

[   38.757975] Call Trace:

[   38.757982] o0: 0000000000000e80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.757986] Unable to handle kernel NULL pointer dereference

[   38.757989] Call Trace:

[   38.757999] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.758005] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.758008]  9210203c

[   38.758016]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.758019] tsk->{mm,active_mm}->pgd = ffff8001acdc4000

[   38.758031]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.758037] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa777531 ret_pc: 000000000042c7e4

[   38.758040] tsk->{mm,active_mm}->context = 0000000000000000

[   38.758058]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.758072] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.758079] o4: 0000000000003f60 o5: ffff8001b8d00000 sp: ffff8001b8d03191 ret_pc: 000000000042b04c

[   38.758082]  96102020

[   38.758092]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.758095]               \|/ ____ \|/

[   38.758095]               "@'/ .. \`@"

[   38.758095]               /_| \__/ |_\

[   38.758095]                  \__U_/

[   38.758120]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.758141] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.758144] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.758164]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.758177] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.758185] RPC: <die_if_kernel+0xb4/0x24c>

[   38.758189] <d406c001>

[   38.758195]  [0000000000000000] 0x0

[   38.758199] swapper/30(0): Oops [#46]

[   38.758206]  [0000000000000fc0] 0xfc0

[   38.758214] l0: ffff8001ff560040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.758219]               \|/ ____ \|/

[   38.758219]               "@'/ .. \`@"

[   38.758219]               /_| \__/ |_\

[   38.758219]                  \__U_/

[   38.758247]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.758257] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.758264] l0: 0000000000000009 l1: ffff8001b8d03f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.758267]  93666020

[   38.758275] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.758283] CPU: 30 PID: 0 Comm: swapper/30 Tainted: G      D           5.2.0-rc5 #220

[   38.758294]  [000000000048de38] do_idle+0x118/0x1a0

[   38.758301] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.758309] swapper/91(0): Oops [#47]

[   38.758323]  [0000000000001900] 0x1900

[   38.758332] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.758337] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.758340]  9010001c

[   38.758349] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.758357] TSTATE: 0000004480001603 TPC: 0000000000003040 TNPC: 0000000000003044 Y: 00000000    Tainted: G      D

[   38.758366]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.758373] i0: 00000000000004d8 i1: ffff8001ff56aff8 i2: 0000000000000001 i3: 0000000000000e80

[   38.758382] CPU: 91 PID: 0 Comm: swapper/91 Tainted: G      D           5.2.0-rc5 #220

[   38.758400]  [000000000048de38] do_idle+0x118/0x1a0

[   38.758412] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.758418] i0: 0000000000ab21e0 i1: ffff8001b8d03c90 i2: ffff8001b8d00000 i3: 00000000000034c0

[   38.758422]  ba076001

[   38.758432] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.758436] TPC: <0x3040>

[   38.758455]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.758462] i4: 00000000fef84ff8 i5: 00000000fef83800 i6: ffff8001fa7775e1 i7: 000000000048de38

[   38.758486] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.758503]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.758511] Caller[0000000000000000]: 0x0

[   38.758517] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8d03271 i7: 00000000004501a4

[   38.758521]  40020421

[   38.758527] Caller[0000000000000000]: 0x0

[   38.758533] g0: 0000000700000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.758539]  [0000000000000000] 0x0

[   38.758548] I7: <do_idle+0x118/0x1a0>

[   38.758571] TPC: <die_if_kernel+0x114/0x24c>

[   38.758596]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.758598] Instruction DUMP:

[   38.758607] I7: <unhandled_fault+0x84/0xa0>

[   38.758611]  9764603e

[   38.758614] Instruction DUMP:

[   38.758621] g4: 0000000000005a20 g5: ffff8001be7ee000 g6: ffff8001b8d0c000 g7: 000000000000001e

[   38.758626] Unable to handle kernel NULL pointer dereference

[   38.758634] CPU: 29 PID: 0 Comm: swapper/29 Tainted: G      D           5.2.0-rc5 #220

[   38.758637] Call Trace:

[   38.758662] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.758676]  [0000000000000000] 0x0

[   38.758679]  832f7002

[   38.758682] Call Trace:

[   38.758684]

[   38.758689] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.758695] o0: 0000000000003040 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.758700] tsk->{mm,active_mm}->context = 0000000000000071

[   38.758703] Call Trace:

[   38.758723]  [000000000048de38] do_idle+0x118/0x1a0

[   38.758746] g4: ffff8001fa749900 g5: ffff8001fea8e000 g6: ffff8001fa794000 g7: 000000000000000e

[   38.758749]  9210203c

[   38.758764] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.758772]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.758776] tsk->{mm,active_mm}->context = 00000000000002aa

[   38.758781] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8d0f531 ret_pc: 000000000042c7e4

[   38.758787] tsk->{mm,active_mm}->pgd = ffff8001b0384000

[   38.758797]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.758812]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.758831] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.758834]  96102020

[   38.758847] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.758855]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.758858] tsk->{mm,active_mm}->pgd = ffff8001b4898000

[   38.758868] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.758875]               \|/ ____ \|/

[   38.758875]               "@'/ .. \`@"

[   38.758875]               /_| \__/ |_\

[   38.758875]                  \__U_/

[   38.758889]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.758907]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.758930] o4: 0000000000003f60 o5: ffff8001fa794000 sp: ffff8001fa797191 ret_pc: 000000000042b04c

[   38.758933] <d406c001>

[   38.758958] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.758969]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.758972]               \|/ ____ \|/

[   38.758972]               "@'/ .. \`@"

[   38.758972]               /_| \__/ |_\

[   38.758972]                  \__U_/

[   38.758978] l0: ffff8001bf3c0040 l1: 00000007e8c51080 l2: 0000000000000010 l3: 0000000000be00c0

[   38.758986] swapper/80(0): Oops [#48]

[   38.758991]  [0000000000002c40] 0x2c40

[   38.759001]  [0000000000000000] 0x0

[   38.759016] RPC: <die_if_kernel+0xb4/0x24c>

[   38.759019]  93666020

[   38.759044] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.759050]  [00000000000034c0] 0x34c0

[   38.759054] swapper/24(0): Oops [#49]

[   38.759060] l4: ffff8001ac7d0000 l5: 0000000000bdc300 l6: 000000000000000f l7: 0000000000000000

[   38.759071] CPU: 80 PID: 0 Comm: swapper/80 Tainted: G      D           5.2.0-rc5 #220

[   38.759078]  [000000000048de38] do_idle+0x118/0x1a0

[   38.759094] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.759100] l0: 0000000000000009 l1: ffff8001fa797f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.759104]  9010001c

[   38.759116] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.759123]  [000000000048de38] do_idle+0x118/0x1a0

[   38.759130] CPU: 24 PID: 0 Comm: swapper/24 Tainted: G      D           5.2.0-rc5 #220

[   38.759136] i0: 0000000000000fcc i1: ffff8001bf3caff8 i2: 0000000000000001 i3: 0000000000003040

[   38.759145] TSTATE: 0000004480001603 TPC: 0000000000000fc0 TNPC: 0000000000000fc4 Y: 00000000    Tainted: G      D

[   38.759153]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.759164] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.759170] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.759173]  ba076001

[   38.759184] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.759192]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.759199] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.759205] i4: 00000000fef36ff8 i5: 00000000fef35800 i6: ffff8001b8d0f5e1 i7: 000000000048de38

[   38.759213] TPC: <0xfc0>

[   38.759224]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.759244] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.759250] i0: 0000000000ab21e0 i1: ffff8001fa797c90 i2: ffff8001fa794000 i3: 0000000000000e40

[   38.759253]  40020421

[   38.759266] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.759275]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.759284] TPC: <die_if_kernel+0x114/0x24c>

[   38.759290] I7: <do_idle+0x118/0x1a0>

[   38.759296] g0: 0000000f00000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.759302]  [0000000000000000] 0x0

[   38.759308] Caller[0000000000000000]: 0x0

[   38.759315] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa797271 i7: 00000000004501a4

[   38.759318]  9764603e

[   38.759326] Caller[0000000000000000]: 0x0

[   38.759331]  [0000000000000000] 0x0

[   38.759337] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000b67a60 g3: 0000000000000000

[   38.759338] Call Trace:

[   38.759345] g4: 0000000000005a20 g5: ffff8001fe92e000 g6: ffff8001fa768000 g7: 0000000000000050

[   38.759350] Unable to handle kernel paging request at virtual address 0000000000002c40

[   38.759360] CPU: 70 PID: 0 Comm: swapper/70 Tainted: G      D           5.2.0-rc5 #220

[   38.759362] Instruction DUMP:

[   38.759373] I7: <unhandled_fault+0x84/0xa0>

[   38.759375]

[   38.759377] Instruction DUMP:

[   38.759387] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.759393] g4: ffff8001b8cd3300 g5: ffff8001be72e000 g6: ffff8001b8cf4000 g7: 000000000000000e

[   38.759399]  [000000000048de38] do_idle+0x118/0x1a0

[   38.759406] o0: 0000000000000fc0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.759411] tsk->{mm,active_mm}->context = 00000000000002af

[   38.759414] Call Trace:

[   38.759418] Unable to handle kernel NULL pointer dereference

[   38.759421] Call Trace:

[   38.759423]  832f7002

[   38.759432] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.759438] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.759444]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.759451] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa76b531 ret_pc: 000000000042c7e4

[   38.759456] tsk->{mm,active_mm}->pgd = ffff8001ad610000

[   38.759470]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.759474] tsk->{mm,active_mm}->context = 0000000000000000

[   38.759489]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.759491]  9210203c

[   38.759505] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.759512] o4: 0000000000003f60 o5: ffff8001b8cf4000 sp: ffff8001b8cf7191 ret_pc: 000000000042b04c

[   38.759521]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.759541] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.759545]               \|/ ____ \|/

[   38.759545]               "@'/ .. \`@"

[   38.759545]               /_| \__/ |_\

[   38.759545]                  \__U_/

[   38.759565]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.759569] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.759585]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.759587]  96102020

[   38.759600] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.759607] RPC: <die_if_kernel+0xb4/0x24c>

[   38.759611]  [0000000000000000] 0x0

[   38.759619] l0: ffff8001ff500040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.759624] swapper/29(0): Oops [#50]

[   38.759631]  [0000000000001100] 0x1100

[   38.759636]               \|/ ____ \|/

[   38.759636]               "@'/ .. \`@"

[   38.759636]               /_| \__/ |_\

[   38.759636]                  \__U_/

[   38.759664]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.759666] <d406c001>

[   38.759675] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.759681] l0: 0000000000000009 l1: ffff8001b8cf7f60 l2: 0000000057ac6c00 l3: 0000000000000400

[   38.759687] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.759695] l4: ffff8001ff509c80 l5: ffff8001bf1ea380 l6: 00000000009b2400 l7: 00000000ffff8b16

[   38.759704] CPU: 29 PID: 0 Comm: swapper/29 Tainted: G      D           5.2.0-rc5 #220

[   38.759714]  [000000000048de38] do_idle+0x118/0x1a0

[   38.759722] swapper/83(0): Oops [#51]

[   38.759733]  [0000000000000e40] 0xe40

[   38.759736]  93666020

[   38.759745] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.759750] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   38.759757] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.759765] i0: 0000000000000590 i1: ffff8001ff50aff8 i2: 0000000000000001 i3: 0000000000000fc0

[   38.759773] TSTATE: 0000004480001603 TPC: 0000000000002c40 TNPC: 0000000000002c44 Y: 00000000    Tainted: G      D

[   38.759781]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.759789] CPU: 83 PID: 0 Comm: swapper/83 Tainted: G      D           5.2.0-rc5 #220

[   38.759805]  [000000000048de38] do_idle+0x118/0x1a0

[   38.759809]  9010001c

[   38.759820] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.759826] i0: 0000000000ab21e0 i1: ffff8001b8cf7c90 i2: ffff8001b8cf4000 i3: 0000000000003fc0

[   38.759834] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.759841] i4: 00000000fef72ff8 i5: 00000000fef71800 i6: ffff8001fa76b5e1 i7: 000000000048de38

[   38.759846] TPC: <0x2c40>

[   38.759860]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.759879] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.759894]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.759896]  ba076001

[   38.759902] Caller[0000000000000000]: 0x0

[   38.759909] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8cf7271 i7: 00000000004501a4

[   38.759913] Caller[0000000000000000]: 0x0

[   38.759925] I7: <do_idle+0x118/0x1a0>

[   38.759932] g0: 0000000c00000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.759938]  [0000000000000000] 0x0

[   38.759956] TPC: <die_if_kernel+0x114/0x24c>

[   38.759980]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.759983]  40020421

[   38.759986] Instruction DUMP:

[   38.759994] I7: <unhandled_fault+0x84/0xa0>

[   38.759996] Instruction DUMP:

[   38.759999] Call Trace:

[   38.760006] g4: 0000000000005a20 g5: ffff8001be7ce000 g6: ffff8001b8d08000 g7: 000000000000001d

[   38.760010] Unable to handle kernel NULL pointer dereference

[   38.760019] CPU: 23 PID: 0 Comm: swapper/23 Tainted: G      D           5.2.0-rc5 #220

[   38.760038] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.760049]  [0000000000000000] 0x0

[   38.760051]  9764603e

[   38.760056]  832f7002

[   38.760058] Call Trace:

[   38.760062] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.760074]  [000000000048de38] do_idle+0x118/0x1a0

[   38.760080] o0: 0000000000002c40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.760084] tsk->{mm,active_mm}->context = 00000000000000e7

[   38.760087] Call Trace:

[   38.760106] g4: ffff8001fa74dd00 g5: ffff8001fe98e000 g6: ffff8001fa774000 g7: 000000000000000e

[   38.760107]

[   38.760120] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.760123]  9210203c

[   38.760131]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.760134] tsk->{mm,active_mm}->context = 000000000000029c

[   38.760146]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.760153] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8d0b531 ret_pc: 000000000042c7e4

[   38.760157] tsk->{mm,active_mm}->pgd = ffff8001f7140000

[   38.760167]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.760185] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.760195] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.760198]  96102020

[   38.760206]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.760209] tsk->{mm,active_mm}->pgd = ffff8001acdc4000

[   38.760229]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.760240] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.760246]               \|/ ____ \|/

[   38.760246]               "@'/ .. \`@"

[   38.760246]               /_| \__/ |_\

[   38.760246]                  \__U_/

[   38.760259]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.760278] o4: 0000000000003f60 o5: ffff8001fa774000 sp: ffff8001fa777191 ret_pc: 000000000042b04c

[   38.760296] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.760298] <d406c001>

[   38.760313]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.760316]               \|/ ____ \|/

[   38.760316]               "@'/ .. \`@"

[   38.760316]               /_| \__/ |_\

[   38.760316]                  \__U_/

[   38.760325]  [0000000000000000] 0x0

[   38.760332] l0: ffff8001bf3a0040 l1: 00000007eb276a80 l2: 000000000000ba7e l3: 000000000000b67e

[   38.760338] swapper/70(0): Oops [#52]

[   38.760344]  [0000000000003b80] 0x3b80

[   38.760362] RPC: <die_if_kernel+0xb4/0x24c>

[   38.760379] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.760383]  93666020

[   38.760389]  [0000000000003fc0] 0x3fc0

[   38.760392] swapper/30(0): Oops [#53]

[   38.760406] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.760412] l4: 0000000000000000 l5: 0000000000bf4000 l6: 000000000000ba7e l7: 0000000000b70000

[   38.760422] CPU: 70 PID: 0 Comm: swapper/70 Tainted: G      D           5.2.0-rc5 #220

[   38.760438]  [00000000009acb5c] __do_softirq+0xdc/0x220

[   38.760446] l0: 0000000000000009 l1: ffff8001fa777f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.760456] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.760459]  9010001c

[   38.760466]  [000000000048de38] do_idle+0x118/0x1a0

[   38.760474] CPU: 30 PID: 0 Comm: swapper/30 Tainted: G      D           5.2.0-rc5 #220

[   38.760483] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.760490] i0: 0000000000001038 i1: ffff8001bf3aaff8 i2: 0000000000000001 i3: 0000000000002c40

[   38.760500] TSTATE: 0000004480001603 TPC: 0000000000001100 TNPC: 0000000000001104 Y: 00000000    Tainted: G      D

[   38.760511]  [000000000042c18c] do_softirq_own_stack+0x2c/0x40

[   38.760518] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.760526] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.760529]  ba076001

[   38.760537]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.760544] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.760558] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.760565] i4: 00000000fef30ff8 i5: 00000000fef2f800 i6: ffff8001b8d0b5e1 i7: 000000000048de38

[   38.760573] TPC: <0x1100>

[   38.760581]  [0000000000467098] irq_exit+0x98/0xc0

[   38.760589] i0: 0000000000ab21e0 i1: ffff8001fa777c90 i2: ffff8001fa774000 i3: 0000000000000e80

[   38.760604] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.760607]  40020421

[   38.760618]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.760626] TPC: <die_if_kernel+0x114/0x24c>

[   38.760633] Caller[0000000000000000]: 0x0

[   38.760640] I7: <do_idle+0x118/0x1a0>

[   38.760647] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.760657]  [00000000009ac904] timer_interrupt+0x84/0xc0

[   38.760664] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa777271 i7: 00000000004501a4

[   38.760671] Caller[0000000000000000]: 0x0

[   38.760674]  9764603e

[   38.760679]  [0000000000000000] 0x0

[   38.760685] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.760687] Instruction DUMP:

[   38.760690] Call Trace:

[   38.760697] g4: 0000000000005a20 g5: ffff8001fe8ee000 g6: ffff8001fa760000 g7: 0000000000000046

[   38.760706]  [00000000004209d4] tl0_irq14+0x14/0x20

[   38.760719] I7: <unhandled_fault+0x84/0xa0>

[   38.760722] Instruction DUMP:

[   38.760725]

[   38.760733] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.760739] g4: ffff8001b8cd6600 g5: ffff8001be7ee000 g6: ffff8001b8d0c000 g7: 000000000000000e

[   38.760746]  [000000000048de38] do_idle+0x118/0x1a0

[   38.760751] Unable to handle kernel NULL pointer dereference

[   38.760757] o0: 0000000000001100 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.760766]  [000000000042c7f8] arch_cpu_idle+0x78/0xa0

[   38.760770]  832f7002

[   38.760774] Call Trace:

[   38.760782] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.760788] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.760794]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.760799] tsk->{mm,active_mm}->context = 0000000000000071

[   38.760806] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa763531 ret_pc: 000000000042c7e4

[   38.760813]  [000000000048de38] do_idle+0x118/0x1a0

[   38.760816]  9210203c

[   38.760835]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.760848] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.760855] o4: 0000000000003f60 o5: ffff8001b8d0c000 sp: ffff8001b8d0f191 ret_pc: 000000000042b04c

[   38.760864]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.760868] tsk->{mm,active_mm}->pgd = ffff8001b0384000

[   38.760888] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.760896]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.760899]  96102020

[   38.760917]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.760928] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.760935] RPC: <die_if_kernel+0xb4/0x24c>

[   38.760939]  [0000000000000000] 0x0

[   38.760945]               \|/ ____ \|/

[   38.760945]               "@'/ .. \`@"

[   38.760945]               /_| \__/ |_\

[   38.760945]                  \__U_/

[   38.760952] l0: ffff8001ff4c0040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.760963]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.760966] <d406c001>

[   38.760996]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.761004] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.761009] l0: 0000000000000009 l1: ffff8001b8d0ff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.761016] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.761023] swapper/80(0): Oops [#54]

[   38.761031] l4: ffff8001ff4c9c80 l5: 0000000000000000 l6: 0000000000000000 l7: 0025008100000000

[   38.761036]  [0000000000000000] 0x0

[   38.761039]  93666020

[   38.761050]  [0000000000000e80] 0xe80

[   38.761058] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.761063] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.761070] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.761080] CPU: 80 PID: 0 Comm: swapper/80 Tainted: G      D           5.2.0-rc5 #220

[   38.761087] i0: 0000000000000758 i1: ffff8001ff4caff8 i2: 0000000000000001 i3: 0000000000001100

[   38.761089]  9010001c

[   38.761095] Unable to handle kernel paging request at virtual address 0000000000003b80

[   38.761104] CPU: 64 PID: 0 Comm: swapper/64 Tainted: G      D           5.2.0-rc5 #220

[   38.761119]  [000000000048de38] do_idle+0x118/0x1a0

[   38.761128] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.761134] i0: 0000000000ab21e0 i1: ffff8001b8d0fc90 i2: ffff8001b8d0c000 i3: 0000000000003040

[   38.761142] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.761157] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.761164] i4: 00000000fef66ff8 i5: 00000000fef65800 i6: ffff8001fa7635e1 i7: 000000000048de38

[   38.761166]  ba076001

[   38.761171] tsk->{mm,active_mm}->context = 00000000000002ae

[   38.761173] Call Trace:

[   38.761188]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.761193] Caller[0000000000000000]: 0x0

[   38.761200] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8d0f271 i7: 00000000004501a4

[   38.761205] Caller[0000000000000000]: 0x0

[   38.761221] TPC: <die_if_kernel+0x114/0x24c>

[   38.761230] I7: <do_idle+0x118/0x1a0>

[   38.761233]  40020421

[   38.761239] tsk->{mm,active_mm}->pgd = ffff8001b1fa8000

[   38.761252]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.761270]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.761281] I7: <unhandled_fault+0x84/0xa0>

[   38.761282] Instruction DUMP:

[   38.761297] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.761299]  9764603e

[   38.761301] Call Trace:

[   38.761303] Instruction DUMP:

[   38.761308]               \|/ ____ \|/

[   38.761308]               "@'/ .. \`@"

[   38.761308]               /_| \__/ |_\

[   38.761308]                  \__U_/

[   38.761326]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.761334]  [0000000000000000] 0x0

[   38.761336] Call Trace:

[   38.761341] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.761355] g4: ffff8001fa74f680 g5: ffff8001fe92e000 g6: ffff8001fa768000 g7: 000000000000000e

[   38.761367]  [   38.761367]  [000000000048de38] do_idle+0x118/0x1a0

[   38.761369]  832f7002

[   38.761376] swapper/23(0): Oops [#55]

[   38.761383]  [0000000000001940] 0x1940

[   38.761394] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.761403]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.761406] tsk->{mm,active_mm}->context = 00000000000002af

[   38.761419] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.761428]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.761431]  9210203c

[   38.761440] CPU: 23 PID: 0 Comm: swapper/23 Tainted: G      D           5.2.0-rc5 #220

[   38.761447]  [000000000048de38] do_idle+0x118/0x1a0

[   38.761457] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.761465]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.761468] tsk->{mm,active_mm}->pgd = ffff8001ad610000

[   38.761483] o4: 0000000000003f60 o5: ffff8001fa768000 sp: ffff8001fa76b191 ret_pc: 000000000042b04c

[   38.761499]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.761502]  96102020

[   38.761510] TSTATE: 0000004480001601 TPC: 0000000000003b80 TNPC: 0000000000003b84 Y: 00000000    Tainted: G      D

[   38.761518]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.761537] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.761550]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.761554]               \|/ ____ \|/

[   38.761554]               "@'/ .. \`@"

[   38.761554]               /_| \__/ |_\

[   38.761554]                  \__U_/

[   38.761571] RPC: <die_if_kernel+0xb4/0x24c>

[   38.761577]  [0000000000000000] 0x0

[   38.761580] <d406c001>

[   38.761586] TPC: <0x3b80>

[   38.761597]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.761610] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.761616]  [0000000000003040] 0x3040

[   38.761620] swapper/29(0): Oops [#56]

[   38.761627] l0: 0000000000000009 l1: ffff8001fa76bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.761630]  93666020

[   38.761639] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.761646] g0: 0000000000000000 g1: ffff8001bf2ea300 g2: 00000000f0200000 g3: 00000000fff78000

[   38.761652]  [0000000000000000] 0x0

[   38.761661] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.761668]  [000000000048de38] do_idle+0x118/0x1a0

[   38.761676] CPU: 29 PID: 0 Comm: swapper/29 Tainted: G      D           5.2.0-rc5 #220

[   38.761683] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.761686]  9010001c

[   38.761696] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.761703] g4: 0000000000005a20 g5: ffff8001be70e000 g6: ffff8001b8cf0000 g7: 0000000000000000

[   38.761707] Unable to handle kernel NULL pointer dereference

[   38.761715] CPU: 31 PID: 0 Comm: swapper/31 Tainted: G      D           5.2.0-rc5 #220

[   38.761724] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.761732]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.761739] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001936    Tainted: G      D

[   38.761746] i0: 0000000000ab21e0 i1: ffff8001fa76bc90 i2: ffff8001fa768000 i3: 0000000000000fc0

[   38.761749]  ba076001

[   38.761761] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.761767] o0: 0000000000003b80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.761771] tsk->{mm,active_mm}->context = 0000000000000106

[   38.761774] Call Trace:

[   38.761787] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.761797]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.761806] TPC: <die_if_kernel+0x114/0x24c>

[   38.761813] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa76b271 i7: 00000000004501a4

[   38.761816]  40020421

[   38.761823] Caller[0000000000000000]: 0x0

[   38.761830] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001bff435a1 ret_pc: 0000000000497ba8

[   38.761834] tsk->{mm,active_mm}->pgd = ffff8001f6184000

[   38.761844]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.761850] Caller[0000000000000000]: 0x0

[   38.761856]  [0000000000000000] 0x0

[   38.761862] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.761872] I7: <unhandled_fault+0x84/0xa0>

[   38.761875]  9764603e

[   38.761878] Instruction DUMP:

[   38.761889] RPC: <run_rebalance_domains+0x68/0xc0>

[   38.761895]               \|/ ____ \|/

[   38.761895]               "@'/ .. \`@"

[   38.761895]               /_| \__/ |_\

[   38.761895]                  \__U_/

[   38.761908]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.761910] Instruction DUMP:

[   38.761920] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.761926] g4: ffff8001b8cd5d80 g5: ffff8001be7ce000 g6: ffff8001b8d08000 g7: 000000000000000e

[   38.761927]

[   38.761930] Call Trace:

[   38.761933] Unable to handle kernel NULL pointer dereference

[   38.761940] l0: 0000000000bf4400 l1: ffffffffffffffff l2: 0000000000bf4700 l3: 0000000000000000

[   38.761946] swapper/64(0): Oops [#57]

[   38.761952]  [0000000000000dc0] 0xdc0

[   38.761955]  832f7002

[   38.761964] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.761970] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.761983]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.761987] tsk->{mm,active_mm}->context = 00000000000000e7

[   38.761993] l4: 0000000000000000 l5: 0000000000000001 l6: 000000000000e9de l7: 0000000000000001

[   38.762002] CPU: 64 PID: 0 Comm: swapper/64 Tainted: G      D           5.2.0-rc5 #220

[   38.762010]  [000000000048de38] do_idle+0x118/0x1a0

[   38.762013]  9210203c

[   38.762026] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.762032] o4: 0000000000003f60 o5: ffff8001b8d08000 sp: ffff8001b8d0b191 ret_pc: 000000000042b04c

[   38.762045]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.762049] tsk->{mm,active_mm}->pgd = ffff8001f7140000

[   38.762055] i0: ffff8001bf2ea300 i1: 0000000000000000 i2: 0000000000000017 i3: 0000000000003b80

[   38.762063] TSTATE: 0000004480001603 TPC: 0000000000001940 TNPC: 0000000000001944 Y: 00000000    Tainted: G      D

[   38.762071]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.762074]  96102020

[   38.762086] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.762093] RPC: <die_if_kernel+0xb4/0x24c>

[   38.762115]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.762119]               \|/ ____ \|/

[   38.762119]               "@'/ .. \`@"

[   38.762119]               /_| \__/ |_\

[   38.762119]                  \__U_/

[   38.762126] i4: 00000000fef0cff8 i5: 00000000fef0b800 i6: ffff8001bff43671 i7: 00000000009acb5c

[   38.762132] TPC: <0x1940>

[   38.762143]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.762146] <d406c001>

[   38.762155] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.762161] l0: 0000000000000009 l1: ffff8001b8d0bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.762170]  [0000000000000fc0] 0xfc0

[   38.762176] swapper/70(0): Oops [#58]

[   38.762189] I7: <__do_softirq+0xdc/0x220>

[   38.762195] g0: fffffff300000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.762200]  [0000000000000000] 0x0

[   38.762203]  93666020

[   38.762212] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.762217] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.762228]  [000000000048de38] do_idle+0x118/0x1a0

[   38.762236] CPU: 70 PID: 0 Comm: swapper/70 Tainted: G      D           5.2.0-rc5 #220

[   38.762238] Call Trace:

[   38.762245] g4: 0000000000005a20 g5: ffff8001fe82e000 g6: ffff8001fa718000 g7: 0000000000000040

[   38.762248] Unable to handle kernel NULL pointer dereference

[   38.762251]  9010001c

[   38.762261] CPU: 95 PID: 0 Comm: swapper/95 Tainted: G      D           5.2.0-rc5 #220

[   38.762270] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.762276] i0: 0000000000ab21e0 i1: ffff8001b8d0bc90 i2: ffff8001b8d08000 i3: 0000000000002c40

[   38.762286]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.762296] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.762306]  [00000000009acb5c] __do_softirq+0xdc/0x220

[   38.762312] o0: 0000000000001940 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.762316] tsk->{mm,active_mm}->context = 0000000000000289

[   38.762319]  ba076001

[   38.762322] Call Trace:

[   38.762327] Caller[0000000000000000]: 0x0

[   38.762334] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8d0b271 i7: 00000000004501a4

[   38.762347]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.762359] TPC: <die_if_kernel+0x114/0x24c>

[   38.762371]  [000000000042c18c] do_softirq_own_stack+0x2c/0x40

[   38.762377] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa71b531 ret_pc: 000000000042c7e4

[   38.762381] tsk->{mm,active_mm}->pgd = ffff8001b741c000

[   38.762384]  40020421

[   38.762395]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.762397] Instruction DUMP:

[   38.762406] I7: <unhandled_fault+0x84/0xa0>

[   38.762412]  [0000000000000000] 0x0

[   38.762421] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000b67a60 g3: 0000000000000000

[   38.762428]  [0000000000467098] irq_exit+0x98/0xc0

[   38.762439] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.762443]               \|/ ____ \|/

[   38.762443]               "@'/ .. \`@"

[   38.762443]               /_| \__/ |_\

[   38.762443]                  \__U_/

[   38.762446]  9764603e

[   38.762461]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.762464]  832f7002

[   38.762467] Call Trace:

[   38.762477] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.762486] g4: ffff8001fa743300 g5: ffff8001fe8ee000 g6: ffff8001fa760000 g7: 000000000000000e

[   38.762497]  [00000000009ac904] timer_interrupt+0x84/0xc0

[   38.762504] l0: ffff8001ff400040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.762508] swapper/31(0): Oops [#59]

[   38.762510]

[   38.762515]  [0000000000000f00] 0xf00

[   38.762518]  9210203c

[   38.762527]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.762535] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.762544] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.762552]  [00000000004209d4] tl0_irq14+0x14/0x20

[   38.762558] l4: ffff8001ff409c80 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.762567] CPU: 31 PID: 0 Comm: swapper/31 Tainted: G      D           5.2.0-rc5 #220

[   38.762575]  [000000000048de38] do_idle+0x118/0x1a0

[   38.762578]  96102020

[   38.762586]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.762600] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.762609] o4: 0000000000003f60 o5: ffff8001fa760000 sp: ffff8001fa763191 ret_pc: 000000000042b04c

[   38.762619]  [000000000042c7f8] arch_cpu_idle+0x78/0xa0

[   38.762625] i0: 000000000000069c i1: ffff8001ff40aff8 i2: 0000000000000001 i3: 0000000000001940

[   38.762633] TSTATE: 0000004480001603 TPC: 0000000000000dc0 TNPC: 0000000000000dc4 Y: 00000000    Tainted: G      D

[   38.762641]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.762644] <d406c001>

[   38.762657]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.762670] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.762679] RPC: <die_if_kernel+0xb4/0x24c>

[   38.762687]  [000000000048de38] do_idle+0x118/0x1a0

[   38.762694] i4: 00000000fef42ff8 i5: 00000000fef41800 i6: ffff8001fa71b5e1 i7: 000000000048de38

[   38.762698] TPC: <0xdc0>

[   38.762709]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.762712]  93666020

[   38.762717]  [0000000000002c40] 0x2c40

[   38.762726] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.762732] l0: 0000000000000009 l1: ffff8001fa763f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.762740]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.762747] I7: <do_idle+0x118/0x1a0>

[   38.762754] g0: ffffffdd00000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.762759]  [0000000000000000] 0x0

[   38.762762]  9010001c

[   38.762769]  [000000000048de38] do_idle+0x118/0x1a0

[   38.762777] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.762783] l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000ba7e l7: 0000000000000001

[   38.762793]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.762796] Call Trace:

[   38.762803] g4: 0000000000005a20 g5: ffff8001be80e000 g6: ffff8001b8d10000 g7: 000000000000001f

[   38.762805]  ba076001

[   38.762810] Unable to handle kernel NULL pointer dereference

[   38.762818] CPU: 28 PID: 0 Comm: swapper/28 Tainted: G      D           5.2.0-rc5 #220

[   38.762826]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.762836] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.762843] i0: 0000000000ab21e0 i1: ffff8001fa763c90 i2: ffff8001fa760000 i3: 0000000000001100

[   38.762848]  [0000000000000000] 0x0

[   38.762856]  [000000000048de38] do_idle+0x118/0x1a0

[   38.762862] o0: 0000000000000dc0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.762864]  40020421

[   38.762870] tsk->{mm,active_mm}->context = 00000000000000c3

[   38.762872] Call Trace:

[   38.762882]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.762887] Caller[0000000000000000]: 0x0

[   38.762893] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa763271 i7: 00000000004501a4

[   38.762905] Caller[00000000009acb5c]: __do_softirq+0xdc/0x220

[   38.762914]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.762920] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8d13531 ret_pc: 000000000042c7e4

[   38.762923]  9764603e

[   38.762928] tsk->{mm,active_mm}->pgd = ffff8001f6e20000

[   38.762938]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.762943]  [0000000000000000] 0x0

[   38.762944] Instruction DUMP:

[   38.762953] I7: <unhandled_fault+0x84/0xa0>

[   38.762964] Caller[000000000042c18c]: do_softirq_own_stack+0x2c/0x40

[   38.762977]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.762988] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.762990]

[   38.762994]               \|/ ____ \|/

[   38.762994]               "@'/ .. \`@"

[   38.762994]               /_| \__/ |_\

[   38.762994]                  \__U_/

[   38.763009]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.763017] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.763020]  832f7002

[   38.763023] Call Trace:

[   38.763030] Caller[0000000000467098]: irq_exit+0x98/0xc0

[   38.763037]  [0000000000000000] 0x0

[   38.763044] l0: ffff8001bf3e0040 l1: 00000007e8c51080 l2: 0000600003cf3c50 l3: ffff8001bf3ee4c8

[   38.763049] swapper/95(0): Oops [#60]

[   38.763055]  [00000000000007c0] 0x7c0

[   38.763063] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.763065]  9210203c

[   38.763077]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.763088] Caller[00000000009ac904]: timer_interrupt+0x84/0xc0

[   38.763096] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.763103] l4: 0000000000000000 l5: 0000000000100000 l6: 0000600003ecc058 l7: 00000000000009d8

[   38.763112] CPU: 95 PID: 0 Comm: swapper/95 Tainted: G      D           5.2.0-rc5 #220

[   38.763119]  [000000000048de38] do_idle+0x118/0x1a0

[   38.763131] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.763134]  96102020

[   38.763144]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.763152] Caller[00000000004209d4]: tl0_irq14+0x14/0x20

[   38.763160] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.763167] i0: 0000000000001378 i1: ffff8001bf3eaff8 i2: 0000000000000001 i3: 0000000000000dc0

[   38.763175] TSTATE: 0000004480001603 TPC: 0000000000000f00 TNPC: 0000000000000f04 Y: 00000000    Tainted: G      D

[   38.763183]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.763193] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.763196] <d406c001>

[   38.763214]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.763224] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.763235] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.763243] i4: 00000000fef3cff8 i5: 00000000fef3b800 i6: ffff8001b8d135e1 i7: 000000000048de38

[   38.763248] TPC: <0xf00>

[   38.763258]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.763265] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.763268]  93666020

[   38.763276]  [0000000000001100] 0x1100

[   38.763283] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.763288] Caller[0000000000000000]: 0x0

[   38.763296] I7: <do_idle+0x118/0x1a0>

[   38.763302] g0: ffffffdcfffffffd g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.763308]  [0000000000000000] 0x0

[   38.763315] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.763317]  9010001c

[   38.763325]  [000000000048de38] do_idle+0x118/0x1a0

[   38.763332] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.763334] Instruction DUMP:

[   38.763337] Call Trace:

[   38.763344] g4: 0000000000005a20 g5: ffff8001feb0e000 g6: ffff8001fa7a4000 g7: 000000000000005f

[   38.763347] Unable to handle kernel NULL pointer dereference

[   38.763356] CPU: 87 PID: 0 Comm: swapper/87 Tainted: G      D           5.2.0-rc5 #220

[   38.763365] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.763368]  ba076001

[   38.763376]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.763386] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.763389] Unable to handle kernel NULL pointer dereference

[   38.763397]  [000000000048de38] do_idle+0x118/0x1a0

[   38.763403] o0: 0000000000000f00 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.763407] tsk->{mm,active_mm}->context = 000000000000013c

[   38.763409] Call Trace:

[   38.763414] Caller[0000000000000000]: 0x0

[   38.763417]  40020421

[   38.763425]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.763431] Caller[0000000000000000]: 0x0

[   38.763435] tsk->{mm,active_mm}->context = 0000000000000106

[   38.763443]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.763449] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa7a7531 ret_pc: 000000000042c7e4

[   38.763453] tsk->{mm,active_mm}->pgd = ffff8001b7528000

[   38.763463]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.763464] Instruction DUMP:

[   38.763468]  9764603e

[   38.763473]  [0000000000000000] 0x0

[   38.763475] Instruction DUMP:

[   38.763480] tsk->{mm,active_mm}->pgd = ffff8001f6184000

[   38.763489]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.763499] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.763503]               \|/ ____ \|/

[   38.763503]               "@'/ .. \`@"

[   38.763503]               /_| \__/ |_\

[   38.763503]                  \__U_/

[   38.763516]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.763519]  832f7002

[   38.763522]

[   38.763530] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.763535] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.763540]               \|/ ____ \|/

[   38.763540]               "@'/ .. \`@"

[   38.763540]               /_| \__/ |_\

[   38.763540]                  \__U_/

[   38.763545]  [0000000000000000] 0x0

[   38.763551] l0: ffff8001ff6e0040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.763556] swapper/28(0): Oops [#61]

[   38.763561]  [0000000000000e40] 0xe40

[   38.763564]  9210203c

[   38.763573] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.763577] tsk->{mm,active_mm}->context = 00000000000002ae

[   38.763582] swapper/64(0): Oops [#62]

[   38.763590] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.763596] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.763605] CPU: 28 PID: 0 Comm: swapper/28 Tainted: G      D           5.2.0-rc5 #220

[   38.763613]  [000000000048de38] do_idle+0x118/0x1a0

[   38.763615]  96102020

[   38.763629] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.763633] tsk->{mm,active_mm}->pgd = ffff8001b1fa8000

[   38.763642] CPU: 64 PID: 0 Comm: swapper/64 Tainted: G      D           5.2.0-rc5 #220

[   38.763650] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.763656] i0: 000000000000068c i1: ffff8001ff6eaff8 i2: 0000000000000001 i3: 0000000000000f00

[   38.763665] TSTATE: 0000004480001603 TPC: 00000000000007c0 TNPC: 00000000000007c4 Y: 00000000    Tainted: G      D

[   38.763672]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.763675] <d406c001>

[   38.763687] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.763692]               \|/ ____ \|/

[   38.763692]               "@'/ .. \`@"

[   38.763692]               /_| \__/ |_\

[   38.763692]                  \__U_/

[   38.763699] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.763708] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.763715] i4: 00000000fefccff8 i5: 00000000fefcb800 i6: ffff8001fa7a75e1 i7: 000000000048de38

[   38.763720] TPC: <0x7c0>

[   38.763729]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.763732]  93666020

[   38.763740] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.763745] swapper/23(0): Oops [#63]

[   38.763753] TPC: <die_if_kernel+0x114/0x24c>

[   38.763759] Caller[0000000000000000]: 0x0

[   38.763765] I7: <do_idle+0x118/0x1a0>

[   38.763772] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.763777]  [0000000000000000] 0x0

[   38.763780]  9010001c

[   38.763788] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.763797] CPU: 23 PID: 0 Comm: swapper/23 Tainted: G      D           5.2.0-rc5 #220

[   38.763803] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.763805] Instruction DUMP:

[   38.763808] Call Trace:

[   38.763815] g4: 0000000000005a20 g5: ffff8001be7ae000 g6: ffff8001b8d04000 g7: 000000000000001c

[   38.763818]  ba076001

[   38.763822] Unable to handle kernel NULL pointer dereference

[   38.763831] CPU: 26 PID: 0 Comm: swapper/26 Tainted: G      D           5.2.0-rc5 #220

[   38.763841] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.763849] TSTATE: 0000008880001605 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.763856] g4: ffff8001fa740000 g5: ffff8001fe82e000 g6: ffff8001fa718000 g7: 000000000000000e

[   38.763860] Unable to handle kernel NULL pointer dereference

[   38.763866]  [000000000048de38] do_idle+0x118/0x1a0

[   38.763873] o0: 00000000000007c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.763875]  40020421

[   38.763880] tsk->{mm,active_mm}->context = 0000000000000000

[   38.763883] Call Trace:

[   38.763888] Caller[0000000000000000]: 0x0

[   38.763898] TPC: <die_if_kernel+0x114/0x24c>

[   38.763903] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.763908] tsk->{mm,active_mm}->context = 0000000000000289

[   38.763915]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.763922] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8d07531 ret_pc: 000000000042c7e4

[   38.763924]  9764603e

[   38.763929] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.763939]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.763941] Instruction DUMP:

[   38.763949] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000100

[   38.763956] o4: 0000000000003f60 o5: ffff8001fa718000 sp: ffff8001fa71b191 ret_pc: 000000000042b04c

[   38.763960] tsk->{mm,active_mm}->pgd = ffff8001b741c000

[   38.763969]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.763980] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.763981]

[   38.763985]               \|/ ____ \|/

[   38.763985]               "@'/ .. \`@"

[   38.763985]               /_| \__/ |_\

[   38.763985]                  \__U_/

[   38.763999]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.764002]  832f7002

[   38.764010] g4: ffff8001b8cd2a80 g5: ffff8001be70e000 g6: ffff8001b8cf0000 g7: 000000000000000e

[   38.764018] RPC: <die_if_kernel+0xb4/0x24c>

[   38.764022]               \|/ ____ \|/

[   38.764022]               "@'/ .. \`@"

[   38.764022]               /_| \__/ |_\

[   38.764022]                  \__U_/

[   38.764027]  [0000000000000000] 0x0

[   38.764035] l0: ffff8001bf380040 l1: 00000008009c9480 l2: 0000000000000001 l3: 000007feffecaf60

[   38.764039] swapper/87(0): Oops [#64]

[   38.764045]  [0000000000002c40] 0x2c40

[   38.764048]  9210203c

[   38.764055] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.764062] l0: 0000000000000009 l1: ffff8001fa71bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.764066] swapper/31(0): Oops [#65]

[   38.764074] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.764081] l4: 000007feffecaf64 l5: 000007feffecaf68 l6: 000007feffecaf6c l7: 000007feffecaf70

[   38.764090] CPU: 87 PID: 0 Comm: swapper/87 Tainted: G      D           5.2.0-rc5 #220

[   38.764097]  [000000000048de38] do_idle+0x118/0x1a0

[   38.764100]  96102020

[   38.764108] o4: 0000000000003f60 o5: ffff8001b8cf0000 sp: ffff8001bff43201 ret_pc: 000000000042b04c

[   38.764114] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.764123] CPU: 31 PID: 0 Comm: swapper/31 Tainted: G      D           5.2.0-rc5 #220

[   38.764131] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.764137] i0: 00000000000013d8 i1: ffff8001bf38aff8 i2: 0000000000000001 i3: 00000000000007c0

[   38.764145] TSTATE: 0000004480001603 TPC: 0000000000000e40 TNPC: 0000000000000e44 Y: 00000000    Tainted: G      D

[   38.764152]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.764155] <d406c001>

[   38.764164] RPC: <die_if_kernel+0xb4/0x24c>

[   38.764171] i0: 0000000000ab21e0 i1: ffff8001fa71bc90 i2: ffff8001fa718000 i3: 0000000000001940

[   38.764179] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.764187] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.764194] i4: 00000000fef2aff8 i5: 00000000fef29800 i6: ffff8001b8d075e1 i7: 000000000048de38

[   38.764199] TPC: <0xe40>

[   38.764209]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.764212]  93666020

[   38.764220] l0: 0000000000000003 l1: ffff8001b8cf3f60 l2: 0000000057ac6c00 l3: 0000000000000400

[   38.764226] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa71b271 i7: 00000000004501a4

[   38.764236] TPC: <die_if_kernel+0x114/0x24c>

[   38.764241] Caller[0000000000000000]: 0x0

[   38.764248] I7: <do_idle+0x118/0x1a0>

[   38.764254] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.764260]  [0000000000000000] 0x0

[   38.764263]  9010001c

[   38.764270] l4: 0000000000000000 l5: 0000000000000004 l6: 0000000000000000 l7: 0000000000000008

[   38.764278] I7: <unhandled_fault+0x84/0xa0>

[   38.764285] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.764287] Instruction DUMP:

[   38.764290] Call Trace:

[   38.764296] g4: 0000000000005a20 g5: ffff8001fea0e000 g6: ffff8001fa784000 g7: 0000000000000057

[   38.764301] Unable to handle kernel paging request at virtual address 0000000000002c40

[   38.764304]  ba076001

[   38.764313] CPU: 67 PID: 0 Comm: swapper/67 Tainted: G      D           5.2.0-rc5 #220

[   38.764320] i0: 0000000000ab21e0 i1: ffff8001bff43d00 i2: ffff8001b8cf0000 i3: 0000000000003b80

[   38.764322] Call Trace:

[   38.764329] g4: ffff8001b8cd6e80 g5: ffff8001be80e000 g6: ffff8001b8d10000 g7: 000000000000000e

[   38.764333] Unable to handle kernel NULL pointer dereference

[   38.764340]  [000000000048de38] do_idle+0x118/0x1a0

[   38.764346] o0: 0000000000000e40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.764351] tsk->{mm,active_mm}->context = 0000000000000282

[   38.764353]  40020421

[   38.764356] Call Trace:

[   38.764363] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001bff432e1 i7: 00000000004501a4

[   38.764370]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.764377] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.764381] tsk->{mm,active_mm}->context = 00000000000000c3

[   38.764389]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.764395] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa787531 ret_pc: 000000000042c7e4

[   38.764399] tsk->{mm,active_mm}->pgd = ffff8001ad8a4000

[   38.764402]  9764603e

[   38.764410]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.764419] I7: <unhandled_fault+0x84/0xa0>

[   38.764427]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.764434] o4: 0000000000003f60 o5: ffff8001b8d10000 sp: ffff8001b8d13191 ret_pc: 000000000042b04c

[   38.764438] tsk->{mm,active_mm}->pgd = ffff8001f6e20000

[   38.764447]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.764457] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.764462]               \|/ ____ \|/

[   38.764462]               "@'/ .. \`@"

[   38.764462]               /_| \__/ |_\

[   38.764462]                  \__U_/

[   38.764464]

[   38.764476]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.764478] Call Trace:

[   38.764489]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.764498] RPC: <die_if_kernel+0xb4/0x24c>

[   38.764502]               \|/ ____ \|/

[   38.764502]               "@'/ .. \`@"

[   38.764502]               /_| \__/ |_\

[   38.764502]                  \__U_/

[   38.764507]  [0000000000000000] 0x0

[   38.764514] l0: ffff8001ff5e0040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.764519] swapper/26(0): Oops [#66]

[   38.764524]  [0000000000000fc0] 0xfc0

[   38.764532]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.764537]  [0000000000001940] 0x1940

[   38.764544] l0: 0000000000000009 l1: ffff8001b8d13f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.764549] swapper/95(0): Oops [#67]

[   38.764557] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.764563] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.764572] CPU: 26 PID: 0 Comm: swapper/26 Tainted: G      D           5.2.0-rc5 #220

[   38.764579]  [000000000048de38] do_idle+0x118/0x1a0

[   38.764587]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.764593]  [000000000048de38] do_idle+0x118/0x1a0

[   38.764600] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.764608] CPU: 95 PID: 0 Comm: swapper/95 Tainted: G      D           5.2.0-rc5 #220

[   38.764617] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.764623] i0: 0000000000000570 i1: ffff8001ff5eaff8 i2: 0000000000000001 i3: 0000000000000e40

[   38.764631] TSTATE: 0000004480001603 TPC: 0000000000002c40 TNPC: 0000000000002c44 Y: 00000000    Tainted: G      D

[   38.764638]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.764652]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.764659]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.764666] i0: 0000000000ab21e0 i1: ffff8001b8d13c90 i2: ffff8001b8d10000 i3: 0000000000000dc0

[   38.764674] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.764684] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.764690] i4: 00000000fef9cff8 i5: 00000000fef9b800 i6: ffff8001fa7875e1 i7: 000000000048de38

[   38.764695] TPC: <0x2c40>

[   38.764705]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.764711]  [0000000000003b80] 0x3b80

[   38.764719]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.764726] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8d13271 i7: 00000000004501a4

[   38.764735] TPC: <die_if_kernel+0x114/0x24c>

[   38.764740] Caller[0000000000000000]: 0x0

[   38.764748] I7: <do_idle+0x118/0x1a0>

[   38.764754] g0: ffffffd800000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.764759]  [0000000000000000] 0x0

[   38.764772]  [00000000009acb5c] __do_softirq+0xdc/0x220

[   38.764777]  [0000000000000000] 0x0

[   38.764786] I7: <unhandled_fault+0x84/0xa0>

[   38.764792] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.764794] Instruction DUMP:

[   38.764797] Call Trace:

[   38.764804] g4: 0000000000005a20 g5: ffff8001be76e000 g6: ffff8001b8cfc000 g7: 000000000000001a

[   38.764807] Unable to handle kernel NULL pointer dereference

[   38.764816] CPU: 25 PID: 0 Comm: swapper/25 Tainted: G      D           5.2.0-rc5 #220

[   38.764827]  [000000000042c18c] do_softirq_own_stack+0x2c/0x40

[   38.764836] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.764838] Call Trace:

[   38.764845] g4: ffff8001fa747700 g5: ffff8001feb0e000 g6: ffff8001fa7a4000 g7: 000000000000000e

[   38.764849] Unable to handle kernel NULL pointer dereference

[   38.764855]  [000000000048de38] do_idle+0x118/0x1a0

[   38.764862] o0: 0000000000002c40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.764865] tsk->{mm,active_mm}->context = 00000000000000f1

[   38.764868] Call Trace:

[   38.764875]  [0000000000467098] irq_exit+0x98/0xc0

[   38.764883] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.764892]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.764898] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.764902] tsk->{mm,active_mm}->context = 000000000000013c

[   38.764909]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.764916] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8cff531 ret_pc: 000000000042c7e4

[   38.764920] tsk->{mm,active_mm}->pgd = ffff8001f7240000

[   38.764930]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.764939]  [00000000009ac904] timer_interrupt+0x84/0xc0

[   38.764952] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.764960]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.764966] o4: 0000000000003f60 o5: ffff8001fa7a4000 sp: ffff8001fa7a7191 ret_pc: 000000000042b04c

[   38.764971] tsk->{mm,active_mm}->pgd = ffff8001b7528000

[   38.764980]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.764991] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.764995]               \|/ ____ \|/

[   38.764995]               "@'/ .. \`@"

[   38.764995]               /_| \__/ |_\

[   38.764995]                  \__U_/

[   38.765009]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.765016]  [00000000004209d4] tl0_irq14+0x14/0x20

[   38.765027] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.765038]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.765045] RPC: <die_if_kernel+0xb4/0x24c>

[   38.765050]               \|/ ____ \|/

[   38.765050]               "@'/ .. \`@"

[   38.765050]               /_| \__/ |_\

[   38.765050]                  \__U_/

[   38.765054]  [0000000000000000] 0x0

[   38.765062] l0: ffff8001bf340040 l1: 00000007fd090d80 l2: ffff8001b1ed0790 l3: 0000000000000001

[   38.765066] swapper/67(0): Oops [#68]

[   38.765072]  [00000000000034c0] 0x34c0

[   38.765082]  [000000000042c7f8] arch_cpu_idle+0x78/0xa0

[   38.765089] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.765094]  [0000000000000dc0] 0xdc0

[   38.765101] l0: 0000000000000009 l1: ffff8001fa7a7f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.765106] swapper/28(0): Oops [#69]

[   38.765113] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.765120] l4: 0000010000121620 l5: 0000000000000003 l6: 0000000000000000 l7: 000001000011dcb8

[   38.765129] CPU: 67 PID: 0 Comm: swapper/67 Tainted: G      D           5.2.0-rc5 #220

[   38.765136]  [000000000048de38] do_idle+0x118/0x1a0

[   38.765143]  [000000000048de38] do_idle+0x118/0x1a0

[   38.765150] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.765157]  [000000000048de38] do_idle+0x118/0x1a0

[   38.765164] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.765173] CPU: 28 PID: 0 Comm: swapper/28 Tainted: G      D           5.2.0-rc5 #220

[   38.765180] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.765187] i0: 0000000000001674 i1: ffff8001bf34aff8 i2: 0000000000000001 i3: 0000000000002c40

[   38.765195] TSTATE: 0000004480001603 TPC: 0000000000000fc0 TNPC: 0000000000000fc4 Y: 00000000    Tainted: G      D

[   38.765203]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.765210]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.765220] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.765228]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.765234] i0: 0000000000ab21e0 i1: ffff8001fa7a7c90 i2: ffff8001fa7a4000 i3: 0000000000000f00

[   38.765243] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.765251] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.765258] i4: 00000000fef1eff8 i5: 00000000fef1d800 i6: ffff8001b8cff5e1 i7: 000000000048de38

[   38.765262] TPC: <0xfc0>

[   38.765273]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.765282]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.765287] Caller[0000000000000000]: 0x0

[   38.765296]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.765303] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa7a7271 i7: 00000000004501a4

[   38.765312] TPC: <die_if_kernel+0x114/0x24c>

[   38.765318] Caller[0000000000000000]: 0x0

[   38.765325] I7: <do_idle+0x118/0x1a0>

[   38.765331] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.765336]  [0000000000000000] 0x0

[   38.765341]  [0000000000000000] 0x0

[   38.765342] Instruction DUMP:

[   38.765349]  [0000000000000000] 0x0

[   38.765357] I7: <unhandled_fault+0x84/0xa0>

[   38.765364] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.765366] Instruction DUMP:

[   38.765369] Call Trace:

[   38.765375] g4: 0000000000005a20 g5: ffff8001fe88e000 g6: ffff8001fa754000 g7: 0000000000000043

[   38.765380] Unable to handle kernel paging request at virtual address 00000000000034c0

[   38.765389] CPU: 66 PID: 0 Comm: swapper/66 Tainted: G      D           5.2.0-rc5 #220

[   38.765391]  832f7002

[   38.765401] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.765411] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.765413] Call Trace:

[   38.765420] g4: ffff8001b8cd5500 g5: ffff8001be7ae000 g6: ffff8001b8d04000 g7: 000000000000000e

[   38.765424] Unable to handle kernel NULL pointer dereference

[   38.765431]  [000000000048de38] do_idle+0x118/0x1a0

[   38.765437] o0: 0000000000000fc0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.765441] tsk->{mm,active_mm}->context = 00000000000002b3

[   38.765444] Call Trace:

[   38.765446]  9210203c

[   38.765456] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.765463] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.765471]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.765478] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.765482] tsk->{mm,active_mm}->context = 0000000000000000

[   38.765490]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.765496] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa757531 ret_pc: 000000000042c7e4

[   38.765500] tsk->{mm,active_mm}->pgd = ffff8001acdcc000

[   38.765510]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.765512]  96102020

[   38.765527] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.765540] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.765548]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.765555] o4: 0000000000003f60 o5: ffff8001b8d04000 sp: ffff8001b8d07191 ret_pc: 000000000042b04c

[   38.765559] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.765570]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.765579] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.765584]               \|/ ____ \|/

[   38.765584]               "@'/ .. \`@"

[   38.765584]               /_| \__/ |_\

[   38.765584]                  \__U_/

[   38.765598]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.765600] <d406c001>

[   38.765611] Caller[0000000000497ba8]: run_rebalance_domains+0x68/0xc0

[   38.765623] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.765636]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.765644] RPC: <die_if_kernel+0xb4/0x24c>

[   38.765648]               \|/ ____ \|/

[   38.765648]               "@'/ .. \`@"

[   38.765648]               /_| \__/ |_\

[   38.765648]                  \__U_/

[   38.765653]  [0000000000000000] 0x0

[   38.765660] l0: ffff8001ff460040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.765666] swapper/25(0): Oops [#70]

[   38.765671]  [0000000000001cc0] 0x1cc0

[   38.765673]  93666020

[   38.765687] Caller[00000000009acb5c]: __do_softirq+0xdc/0x220

[   38.765694] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.765699]  [0000000000000f00] 0xf00

[   38.765706] l0: 0000000000000009 l1: ffff8001b8d07f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.765711] swapper/87(0): Oops [#71]

[   38.765719] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.765725] l4: ffff8001ff469c80 l5: ffff8001bf1ea380 l6: 00000000009b2400 l7: 00000000ffff8b16

[   38.765735] CPU: 25 PID: 0 Comm: swapper/25 Tainted: G      D           5.2.0-rc5 #220

[   38.765742]  [000000000048de38] do_idle+0x118/0x1a0

[   38.765744]  9010001c

[   38.765757] Caller[000000000042c18c]: do_softirq_own_stack+0x2c/0x40

[   38.765765] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.765772]  [000000000048de38] do_idle+0x118/0x1a0

[   38.765778] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000000000 l7: ffff800100d78000

[   38.765787] CPU: 87 PID: 0 Comm: swapper/87 Tainted: G      D           5.2.0-rc5 #220

[   38.765795] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.765801] i0: 0000000000000584 i1: ffff8001ff46aff8 i2: 0000000000000001 i3: 0000000000000fc0

[   38.765810] TSTATE: 0000004480001603 TPC: 00000000000034c0 TNPC: 00000000000034c4 Y: 00000000    Tainted: G      D

[   38.765817]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.765819]  ba076001

[   38.765828] Caller[0000000000467098]: irq_exit+0x98/0xc0

[   38.765838] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.765845]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.765852] i0: 0000000000ab21e0 i1: ffff8001b8d07c90 i2: ffff8001b8d04000 i3: 00000000000007c0

[   38.765860] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.765869] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.765875] i4: 00000000fef54ff8 i5: 00000000fef53800 i6: ffff8001fa7575e1 i7: 000000000048de38

[   38.765880] TPC: <0x34c0>

[   38.765890]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.765893]  40020421

[   38.765905] Caller[00000000009ac904]: timer_interrupt+0x84/0xc0

[   38.765909] Caller[0000000000000000]: 0x0

[   38.765919]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.765926] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8d07271 i7: 00000000004501a4

[   38.765935] TPC: <die_if_kernel+0x114/0x24c>

[   38.765941] Caller[0000000000000000]: 0x0

[   38.765947] I7: <do_idle+0x118/0x1a0>

[   38.765954] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.765959]  [0000000000000000] 0x0

[   38.765961]  9764603e

[   38.765971] Caller[00000000004209d4]: tl0_irq14+0x14/0x20

[   38.765972] Instruction DUMP:

[   38.765978]  [0000000000000000] 0x0

[   38.765987] I7: <unhandled_fault+0x84/0xa0>

[   38.765993] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.765995] Instruction DUMP:

[   38.765998] Call Trace:

[   38.766006] g4: 0000000000005a20 g5: ffff8001be74e000 g6: ffff8001b8cf8000 g7: 0000000000000019

[   38.766007]

[   38.766010] Unable to handle kernel NULL pointer dereference

[   38.766019] CPU: 20 PID: 0 Comm: swapper/20 Tainted: G      D           5.2.0-rc5 #220

[   38.766021]  832f7002

[   38.766032] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.766041] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.766044] Call Trace:

[   38.766050] g4: ffff8001fa74bb00 g5: ffff8001fea0e000 g6: ffff8001fa784000 g7: 000000000000000e

[   38.766055] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.766063]  [000000000048de38] do_idle+0x118/0x1a0

[   38.766069] o0: 00000000000034c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.766073] tsk->{mm,active_mm}->context = 00000000000000bd

[   38.766076] Call Trace:

[   38.766078]  9210203c

[   38.766086] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.766093] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.766102]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.766108] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.766112] tsk->{mm,active_mm}->context = 0000000000000282

[   38.766120]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.766126] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8cfb531 ret_pc: 000000000042c7e4

[   38.766130] tsk->{mm,active_mm}->pgd = ffff8001f6d30000

[   38.766140]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.766142]  96102020

[   38.766150] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.766161] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.766170]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.766177] o4: 0000000000003f60 o5: ffff8001fa784000 sp: ffff8001fa787191 ret_pc: 000000000042b04c

[   38.766181] tsk->{mm,active_mm}->pgd = ffff8001ad8a4000

[   38.766190]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.766200] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.766205]               \|/ ____ \|/

[   38.766205]               "@'/ .. \`@"

[   38.766205]               /_| \__/ |_\

[   38.766205]                  \__U_/

[   38.766219]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.766221] <d406c001>

[   38.766232] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.766243] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.766257]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.766264] RPC: <die_if_kernel+0xb4/0x24c>

[   38.766269]               \|/ ____ \|/

[   38.766269]               "@'/ .. \`@"

[   38.766269]               /_| \__/ |_\

[   38.766269]                  \__U_/

[   38.766274]  [0000000000000000] 0x0

[   38.766281] l0: ffff8001bf320040 l1: 00000008009c9480 l2: 0000000000b54400 l3: 0000000000b95800

[   38.766286] swapper/66(0): Oops [#72]

[   38.766291]  [0000000000003280] 0x3280

[   38.766294]  93666020

[   38.766299] Caller[0000000000000000]: 0x0

[   38.766306] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.766311]  [00000000000007c0] 0x7c0

[   38.766318] l0: 0000000000000009 l1: ffff8001fa787f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.766323] swapper/26(0): Oops [#73]

[   38.766330] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.766337] l4: 0000000000000001 l5: 0000000000000001 l6: 0000000000000000 l7: 0000000000000008

[   38.766346] CPU: 66 PID: 0 Comm: swapper/66 Tainted: G      D           5.2.0-rc5 #220

[   38.766353]  [000000000048de38] do_idle+0x118/0x1a0

[   38.766355]  9010001c

[   38.766358] Instruction DUMP:

[   38.766366] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.766374]  [000000000048de38] do_idle+0x118/0x1a0

[   38.766380] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.766389] CPU: 26 PID: 0 Comm: swapper/26 Tainted: G      D           5.2.0-rc5 #220

[   38.766397] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.766404] i0: 000000000000120c i1: ffff8001bf32aff8 i2: 0000000000000001 i3: 00000000000034c0

[   38.766411] TSTATE: 0000004480001603 TPC: 0000000000001cc0 TNPC: 0000000000001cc4 Y: 00000000    Tainted: G      D

[   38.766419]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.766422]  ba076001

[   38.766425]  832f7002

[   38.766436] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.766444]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.766451] i0: 0000000000ab21e0 i1: ffff8001fa787c90 i2: ffff8001fa784000 i3: 0000000000000e40

[   38.766459] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.766467] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.766475] i4: 00000000fef18ff8 i5: 00000000fef17800 i6: ffff8001b8cfb5e1 i7: 000000000048de38

[   38.766479] TPC: <0x1cc0>

[   38.766489]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.766491]  40020421

[   38.766494]  9210203c

[   38.766500] Caller[0000000000000000]: 0x0

[   38.766511]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.766517] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa787271 i7: 00000000004501a4

[   38.766527] TPC: <die_if_kernel+0x114/0x24c>

[   38.766532] Caller[0000000000000000]: 0x0

[   38.766539] I7: <do_idle+0x118/0x1a0>

[   38.766546] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.766551]  [0000000000000000] 0x0

[   38.766553]  9764603e

[   38.766556]  96102020

[   38.766559] Instruction DUMP:

[   38.766566]  [0000000000000000] 0x0

[   38.766574] I7: <unhandled_fault+0x84/0xa0>

[   38.766581] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.766583] Instruction DUMP:

[   38.766586] Call Trace:

[   38.766593] g4: 0000000000005a20 g5: ffff8001fe86e000 g6: ffff8001fa750000 g7: 0000000000000042

[   38.766598] Unable to handle kernel paging request at virtual address 0000000000003280

[   38.766599]

[   38.766607] CPU: 89 PID: 0 Comm: swapper/89 Tainted: G      D           5.2.0-rc5 #220

[   38.766610] <d406c001>

[   38.766614]  832f7002

[   38.766625] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.766628] Call Trace:

[   38.766635] g4: ffff8001b8cd4400 g5: ffff8001be76e000 g6: ffff8001b8cfc000 g7: 000000000000000e

[   38.766638] Unable to handle kernel NULL pointer dereference

[   38.766646]  [000000000048de38] do_idle+0x118/0x1a0

[   38.766652] o0: 0000000000001cc0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.766656] tsk->{mm,active_mm}->context = 00000000000002b0

[   38.766658] Call Trace:

[   38.766661]  93666020

[   38.766665]  9210203c

[   38.766675] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.766682]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.766689] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.766693] tsk->{mm,active_mm}->context = 00000000000000f1

[   38.766701]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.766707] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa753531 ret_pc: 000000000042c7e4

[   38.766712] tsk->{mm,active_mm}->pgd = ffff8001acd8c000

[   38.766722]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.766724]  9010001c

[   38.766728]  96102020

[   38.766743] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.766751]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.766758] o4: 0000000000003f60 o5: ffff8001b8cfc000 sp: ffff8001b8cff191 ret_pc: 000000000042b04c

[   38.766762] tsk->{mm,active_mm}->pgd = ffff8001f7240000

[   38.766772]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.766782] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.766787]               \|/ ____ \|/

[   38.766787]               "@'/ .. \`@"

[   38.766787]               /_| \__/ |_\

[   38.766787]                  \__U_/

[   38.766800]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.766802]  ba076001

[   38.766807] <d406c001>

[   38.766820] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.766832]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.766840] RPC: <die_if_kernel+0xb4/0x24c>

[   38.766845]               \|/ ____ \|/

[   38.766845]               "@'/ .. \`@"

[   38.766845]               /_| \__/ |_\

[   38.766845]                  \__U_/

[   38.766850]  [0000000000000000] 0x0

[   38.766857] l0: ffff8001ff440040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.766862] swapper/20(0): Oops [#74]

[   38.766867]  [0000000000000f80] 0xf80

[   38.766870]  40020421

[   38.766874]  93666020

[   38.766883] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.766889]  [0000000000000e40] 0xe40

[   38.766895] l0: 0000000000000009 l1: ffff8001b8cfff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.766900] swapper/67(0): Oops [#75]

[   38.766908] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.766915] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.766924] CPU: 20 PID: 0 Comm: swapper/20 Tainted: G      D           5.2.0-rc5 #220

[   38.766931]  [000000000048de38] do_idle+0x118/0x1a0

[   38.766934]  9764603e

[   38.766937]  9010001c

[   38.766947] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.766954]  [000000000048de38] do_idle+0x118/0x1a0

[   38.766960] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.766969] CPU: 67 PID: 0 Comm: swapper/67 Tainted: G      D           5.2.0-rc5 #220

[   38.766977] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.766983] i0: 000000000000067c i1: ffff8001ff44aff8 i2: 0000000000000001 i3: 0000000000001cc0

[   38.766992] TSTATE: 0000004480001603 TPC: 0000000000003280 TNPC: 0000000000003284 Y: 00000000    Tainted: G      D

[   38.766999]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.767001]

[   38.767003]  ba076001

[   38.767015] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.767022]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.767029] i0: 0000000000ab21e0 i1: ffff8001b8cffc90 i2: ffff8001b8cfc000 i3: 0000000000002c40

[   38.767037] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.767045] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.767052] i4: 00000000fef4eff8 i5: 00000000fef4d800 i6: ffff8001fa7535e1 i7: 000000000048de38

[   38.767057] TPC: <0x3280>

[   38.767067]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.767069]  40020421

[   38.767075] Caller[0000000000000000]: 0x0

[   38.767085]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.767092] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8cff271 i7: 00000000004501a4

[   38.767101] TPC: <die_if_kernel+0x114/0x24c>

[   38.767106] Caller[0000000000000000]: 0x0

[   38.767113] I7: <do_idle+0x118/0x1a0>

[   38.767119] g0: 000000000000000d g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.767124]  [0000000000000000] 0x0

[   38.767127]  9764603e

[   38.767130] Instruction DUMP:

[   38.767136]  [0000000000000000] 0x0

[   38.767145] I7: <unhandled_fault+0x84/0xa0>

[   38.767151] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.767153] Instruction DUMP:

[   38.767156] Call Trace:

[   38.767163] g4: 0000000000005a20 g5: ffff8001be6ae000 g6: ffff8001b8ce4000 g7: 0000000000000014

[   38.767165]

[   38.767167] Unable to handle kernel NULL pointer dereference

[   38.767176] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G      D           5.2.0-rc5 #220

[   38.767178]  832f7002

[   38.767188] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.767191] Call Trace:

[   38.767198] g4: ffff8001fa741980 g5: ffff8001fe88e000 g6: ffff8001fa754000 g7: 000000000000000e

[   38.767203] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.767211]  [000000000048de38] do_idle+0x118/0x1a0

[   38.767217] o0: 0000000000003280 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.767221] tsk->{mm,active_mm}->context = 00000000000000d7

[   38.767223] Call Trace:

[   38.767226]  9210203c

[   38.767235] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.767243]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.767249] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.767253] tsk->{mm,active_mm}->context = 00000000000002b3

[   38.767261]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.767268] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8ce7531 ret_pc: 000000000042c7e4

[   38.767272] tsk->{mm,active_mm}->pgd = ffff8001f6fa8000

[   38.767282]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.767284]  96102020

[   38.767297] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.767306]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.767312] o4: 0000000000003f60 o5: ffff8001fa754000 sp: ffff8001fa757191 ret_pc: 000000000042b04c

[   38.767317] tsk->{mm,active_mm}->pgd = ffff8001acdcc000

[   38.767327]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.767337] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.767342]               \|/ ____ \|/

[   38.767342]               "@'/ .. \`@"

[   38.767342]               /_| \__/ |_\

[   38.767342]                  \__U_/

[   38.767356]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.767358] <d406c001>

[   38.767371] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.767385]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.767393] RPC: <die_if_kernel+0xb4/0x24c>

[   38.767397]               \|/ ____ \|/

[   38.767397]               "@'/ .. \`@"

[   38.767397]               /_| \__/ |_\

[   38.767397]                  \__U_/

[   38.767402]  [0000000000000000] 0x0

[   38.767410] l0: ffff8001b55bee00 l1: ffff8001ac6915e0 l2: 0001010100000000 l3: 0000000000000000

[   38.767415] swapper/89(0): Oops [#76]

[   38.767421]  [0000000000001040] 0x1040

[   38.767423]  93666020

[   38.767431] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.767437]  [0000000000002c40] 0x2c40

[   38.767444] l0: 0000000000000009 l1: ffff8001fa757f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.767449] swapper/25(0): Oops [#77]

[   38.767457] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.767464] l4: ffff8001b0d5c000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000010100000000

[   38.767473] CPU: 89 PID: 0 Comm: swapper/89 Tainted: G      D           5.2.0-rc5 #220

[   38.767481]  [000000000048de38] do_idle+0x118/0x1a0

[   38.767483]  9010001c

[   38.767492] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.767499]  [000000000048de38] do_idle+0x118/0x1a0

[   38.767506] l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000ba7e l7: 0000000000000001

[   38.767515] CPU: 25 PID: 0 Comm: swapper/25 Tainted: G      D           5.2.0-rc5 #220

[   38.767522] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.767529] i0: 00000000000019d8 i1: ffff8001bf28aff8 i2: 0000000000000001 i3: 0000000000003280

[   38.767537] TSTATE: 0000004480001603 TPC: 0000000000000f80 TNPC: 0000000000000f84 Y: 00000000    Tainted: G      D

[   38.767545]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.767548]  ba076001

[   38.767559] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.767567]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.767574] i0: 0000000000ab21e0 i1: ffff8001fa757c90 i2: ffff8001fa754000 i3: 0000000000000fc0

[   38.767582] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.767591] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.767598] i4: 00000000feefaff8 i5: 00000000feef9800 i6: ffff8001b8ce75e1 i7: 000000000048de38

[   38.767603] TPC: <0xf80>

[   38.767613]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.767616]  40020421

[   38.767623] Caller[0000000000000000]: 0x0

[   38.767633]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.767640] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa757271 i7: 00000000004501a4

[   38.767650] TPC: <die_if_kernel+0x114/0x24c>

[   38.767655] Caller[0000000000000000]: 0x0

[   38.767662] I7: <do_idle+0x118/0x1a0>

[   38.767668] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.767674]  [0000000000000000] 0x0

[   38.767676]  9764603e

[   38.767680] Instruction DUMP:

[   38.767686]  [0000000000000000] 0x0

[   38.767695] I7: <unhandled_fault+0x84/0xa0>

[   38.767702] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.767703] Instruction DUMP:

[   38.767707] Call Trace:

[   38.767714] g4: 0000000000005a20 g5: ffff8001fea4e000 g6: ffff8001fa78c000 g7: 0000000000000059

[   38.767717] Unable to handle kernel NULL pointer dereference

[   38.767719]

[   38.767727] CPU: 94 PID: 0 Comm: swapper/94 Tainted: G      D           5.2.0-rc5 #220

[   38.767729]  832f7002

[   38.767740] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.767742] Call Trace:

[   38.767750] g4: ffff8001b8cd3b80 g5: ffff8001be74e000 g6: ffff8001b8cf8000 g7: 000000000000000e

[   38.767753] Unable to handle kernel NULL pointer dereference

[   38.767761]  [000000000048de38] do_idle+0x118/0x1a0

[   38.767767] o0: 0000000000000f80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.767771] tsk->{mm,active_mm}->context = 00000000000002b2

[   38.767774] Call Trace:

[   38.767776]  9210203c

[   38.767786] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.767794]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.767800] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.767804] tsk->{mm,active_mm}->context = 00000000000000bd

[   38.767812]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.767818] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa78f531 ret_pc: 000000000042c7e4

[   38.767822] tsk->{mm,active_mm}->pgd = ffff8001ad8a0000

[   38.767833]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.767835]  96102020

[   38.767850] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.767858]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.767865] o4: 0000000000003f60 o5: ffff8001b8cf8000 sp: ffff8001b8cfb191 ret_pc: 000000000042b04c

[   38.767869] tsk->{mm,active_mm}->pgd = ffff8001f6d30000

[   38.767878]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.767888] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.767893]               \|/ ____ \|/

[   38.767893]               "@'/ .. \`@"

[   38.767893]               /_| \__/ |_\

[   38.767893]                  \__U_/

[   38.767907]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.767909] <d406c001>

[   38.767922] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.767936]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.767944] RPC: <die_if_kernel+0xb4/0x24c>

[   38.767948]               \|/ ____ \|/

[   38.767948]               "@'/ .. \`@"

[   38.767948]               /_| \__/ |_\

[   38.767948]                  \__U_/

[   38.767953]  [0000000000000000] 0x0

[   38.767960] l0: ffff8001ff620040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.767965] swapper/22(0): Oops [#78]

[   38.767971]  [0000000000000f40] 0xf40

[   38.767973]  93666020

[   38.767982] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.767987]  [0000000000000fc0] 0xfc0

[   38.767994] l0: 0000000000000009 l1: ffff8001b8cfbf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.767999] swapper/66(0): Oops [#79]

[   38.768007] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.768013] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.768023] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G      D           5.2.0-rc5 #220

[   38.768030]  [000000000048de38] do_idle+0x118/0x1a0

[   38.768032]  9010001c

[   38.768042] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.768049]  [000000000048de38] do_idle+0x118/0x1a0

[   38.768055] l4: 0000000000000001 l5: 0000000000000000 l6: 00000000009b2400 l7: 00000000ffff981c

[   38.768064] CPU: 66 PID: 0 Comm: swapper/66 Tainted: G      D           5.2.0-rc5 #220

[   38.768073] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.768079] i0: 00000000000005d0 i1: ffff8001ff62aff8 i2: 0000000000000001 i3: 0000000000000f80

[   38.768088] TSTATE: 0000004480001603 TPC: 0000000000001040 TNPC: 0000000000001044 Y: 00000000    Tainted: G      D

[   38.768095]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.768097]  ba076001

[   38.768109] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.768117]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.768124] i0: 0000000000ab21e0 i1: ffff8001b8cfbc90 i2: ffff8001b8cf8000 i3: 00000000000034c0

[   38.768132] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.768142] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.768149] i4: 00000000fefa8ff8 i5: 00000000fefa7800 i6: ffff8001fa78f5e1 i7: 000000000048de38

[   38.768154] TPC: <0x1040>

[   38.768164]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.768166]  40020421

[   38.768173] Caller[0000000000000000]: 0x0

[   38.768183]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.768190] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8cfb271 i7: 00000000004501a4

[   38.768200] TPC: <die_if_kernel+0x114/0x24c>

[   38.768205] Caller[0000000000000000]: 0x0

[   38.768212] I7: <do_idle+0x118/0x1a0>

[   38.768219] g0: ffffffcbffffffd8 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.768224]  [0000000000000000] 0x0

[   38.768226]  9764603e

[   38.768229] Instruction DUMP:

[   38.768236]  [0000000000000000] 0x0

[   38.768245] I7: <unhandled_fault+0x84/0xa0>

[   38.768251] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.768253] Instruction DUMP:

[   38.768256] Call Trace:

[   38.768264] g4: 0000000000005a20 g5: ffff8001be6ee000 g6: ffff8001b8cec000 g7: 0000000000000016

[   38.768267] Unable to handle kernel NULL pointer dereference

[   38.768268]

[   38.768276] CPU: 65 PID: 0 Comm: swapper/65 Tainted: G      D           5.2.0-rc5 #220

[   38.768279]  832f7002

[   38.768289] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.768291] Call Trace:

[   38.768298] g4: ffff8001fa741100 g5: ffff8001fe86e000 g6: ffff8001fa750000 g7: 000000000000000e

[   38.768304] Unable to handle kernel paging request at virtual address 0000000000002000

[   38.768311]  [000000000048de38] do_idle+0x118/0x1a0

[   38.768318] o0: 0000000000001040 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.768322] tsk->{mm,active_mm}->context = 0000000000000000

[   38.768324] Call Trace:

[   38.768326]  9210203c

[   38.768336] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.768344]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.768350] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.768354] tsk->{mm,active_mm}->context = 00000000000002b0

[   38.768362]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.768369] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8cef531 ret_pc: 000000000042c7e4

[   38.768373] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.768381]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.768384]  96102020

[   38.768399] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.768407]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.768414] o4: 0000000000003f60 o5: ffff8001fa750000 sp: ffff8001fa753191 ret_pc: 000000000042b04c

[   38.768418] tsk->{mm,active_mm}->pgd = ffff8001acd8c000

[   38.768427]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.768438] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.768443]               \|/ ____ \|/

[   38.768443]               "@'/ .. \`@"

[   38.768443]               /_| \__/ |_\

[   38.768443]                  \__U_/

[   38.768453]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.768455] <d406c001>

[   38.768468] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.768481]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.768489] RPC: <die_if_kernel+0xb4/0x24c>

[   38.768494]               \|/ ____ \|/

[   38.768494]               "@'/ .. \`@"

[   38.768494]               /_| \__/ |_\

[   38.768494]                  \__U_/

[   38.768499]  [0000000000000000] 0x0

[   38.768506] l0: ffff8001b68ecc00 l1: 0000000000ab8e40 l2: 0000000000b95800 l3: 0000000000b95800

[   38.768511] swapper/94(0): Oops [#80]

[   38.768516]  [0000000000001c00] 0x1c00

[   38.768519]  93666020

[   38.768527] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.768533]  [00000000000034c0] 0x34c0

[   38.768539] l0: 0000000000000009 l1: ffff8001fa753f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.768545] swapper/20(0): Oops [#81]

[   38.768552] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.768559] l4: ffff8001bf2c9c80 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.768568] CPU: 94 PID: 0 Comm: swapper/94 Tainted: G      D           5.2.0-rc5 #220

[   38.768575]  [000000000048de38] do_idle+0x118/0x1a0

[   38.768577]  9010001c

[   38.768586] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.768594]  [000000000048de38] do_idle+0x118/0x1a0

[   38.768600] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.768609] CPU: 20 PID: 0 Comm: swapper/20 Tainted: G      D           5.2.0-rc5 #220

[   38.768617] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.768624] i0: 0000000000001310 i1: ffff8001bf2caff8 i2: 0000000000000001 i3: 0000000000001040

[   38.768632] TSTATE: 0000004480001603 TPC: 0000000000000f40 TNPC: 0000000000000f44 Y: 00000000    Tainted: G      D

[   38.768639]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.768641]  ba076001

[   38.768653] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.768660]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.768667] i0: 0000000000ab21e0 i1: ffff8001fa753c90 i2: ffff8001fa750000 i3: 0000000000001cc0

[   38.768676] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.768685] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.768692] i4: 00000000fef06ff8 i5: 00000000fef05800 i6: ffff8001b8cef5e1 i7: 000000000048de38

[   38.768696] TPC: <0xf40>

[   38.768704]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.768707]  40020421

[   38.768713] Caller[0000000000000000]: 0x0

[   38.768723]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.768730] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa753271 i7: 00000000004501a4

[   38.768739] TPC: <die_if_kernel+0x114/0x24c>

[   38.768745] Caller[0000000000000000]: 0x0

[   38.768752] I7: <do_idle+0x118/0x1a0>

[   38.768759] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.768763]  [0000000000000000] 0x0

[   38.768766]  9764603e

[   38.768769] Instruction DUMP:

[   38.768775]  [0000000000000000] 0x0

[   38.768784] I7: <unhandled_fault+0x84/0xa0>

[   38.768791] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.768792] Instruction DUMP:

[   38.768796] Call Trace:

[   38.768803] g4: 0000000000005a20 g5: ffff8001feaee000 g6: ffff8001fa7a0000 g7: 000000000000005e

[   38.768805] Unable to handle kernel NULL pointer dereference

[   38.768813] CPU: 82 PID: 0 Comm: swapper/82 Tainted: G      D           5.2.0-rc5 #220

[   38.768815]

[   38.768818]  832f7002

[   38.768828] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.768830] Call Trace:

[   38.768838] g4: ffff8001b8cd1100 g5: ffff8001be6ae000 g6: ffff8001b8ce4000 g7: 000000000000000e

[   38.768841] Unable to handle kernel NULL pointer dereference

[   38.768848]  [000000000048de38] do_idle+0x118/0x1a0

[   38.768854] o0: 0000000000000f40 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.768858] tsk->{mm,active_mm}->context = 0000000000000000

[   38.768859] Call Trace:

[   38.768861]  9210203c

[   38.768871] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.768879]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.768886] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.768889] tsk->{mm,active_mm}->context = 00000000000000d7

[   38.768898]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.768904] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa7a3531 ret_pc: 000000000042c7e4

[   38.768907] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.768916]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.768918]  96102020

[   38.768932] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.768940]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.768948] o4: 0000000000003f60 o5: ffff8001b8ce4000 sp: ffff8001b8ce7191 ret_pc: 000000000042b04c

[   38.768952] tsk->{mm,active_mm}->pgd = ffff8001f6fa8000

[   38.768962]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.768973] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.768977]               \|/ ____ \|/

[   38.768977]               "@'/ .. \`@"

[   38.768977]               /_| \__/ |_\

[   38.768977]                  \__U_/

[   38.768989]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.768991] <d406c001>

[   38.769003] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.769017]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.769026] RPC: <die_if_kernel+0xb4/0x24c>

[   38.769030]               \|/ ____ \|/

[   38.769030]               "@'/ .. \`@"

[   38.769030]               /_| \__/ |_\

[   38.769030]                  \__U_/

[   38.769035]  [0000000000000000] 0x0

[   38.769042] l0: ffff8001ff6c0040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.769047] swapper/65(0): Oops [#82]

[   38.769051]  [0000000000000fc0] 0xfc0

[   38.769053]  93666020

[   38.769062] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.769067]  [0000000000001cc0] 0x1cc0

[   38.769074] l0: 0000000000000009 l1: ffff8001b8ce7f60 l2: 0000000057ac6c00 l3: 0000000000000400

[   38.769079] swapper/89(0): Oops [#83]

[   38.769087] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.769094] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.769102] CPU: 65 PID: 0 Comm: swapper/65 Tainted: G      D           5.2.0-rc5 #220

[   38.769108]  [000000000048de38] do_idle+0x118/0x1a0

[   38.769110]  9010001c

[   38.769119] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.769127]  [000000000048de38] do_idle+0x118/0x1a0

[   38.769133] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   38.769142] CPU: 89 PID: 0 Comm: swapper/89 Tainted: G      D           5.2.0-rc5 #220

[   38.769150] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.769156] i0: 0000000000000610 i1: ffff8001ff6caff8 i2: 0000000000000001 i3: 0000000000000f40

[   38.769164] TSTATE: 0000004480001603 TPC: 0000000000001c00 TNPC: 0000000000001c04 Y: 0000001a    Tainted: G      D

[   38.769170]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.769172]  ba076001

[   38.769184] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.769191]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.769199] i0: 0000000000ab21e0 i1: ffff8001b8ce7c90 i2: ffff8001b8ce4000 i3: 0000000000003280

[   38.769207] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.769216] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.769223] i4: 00000000fefc6ff8 i5: 00000000fefc5800 i6: ffff8001fa7a35e1 i7: 000000000048de38

[   38.769227] TPC: <0x1c00>

[   38.769236]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.769238]  40020421

[   38.769245] Caller[0000000000000000]: 0x0

[   38.769255]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.769262] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8ce7271 i7: 00000000004501a4

[   38.769271] TPC: <die_if_kernel+0x114/0x24c>

[   38.769276] Caller[0000000000000000]: 0x0

[   38.769283] I7: <do_idle+0x118/0x1a0>

[   38.769289] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.769293]  [0000000000000000] 0x0

[   38.769295]  9764603e

[   38.769298] Instruction DUMP:

[   38.769305]  [0000000000000000] 0x0

[   38.769313] I7: <unhandled_fault+0x84/0xa0>

[   38.769320] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.769322] Instruction DUMP:

[   38.769325] Call Trace:

[   38.769331] g4: 0000000000005a20 g5: ffff8001fe84e000 g6: ffff8001fa71c000 g7: 0000000000000041

[   38.769333] Unable to handle kernel NULL pointer dereference

[   38.769341] CPU: 71 PID: 0 Comm: swapper/71 Tainted: G      D           5.2.0-rc5 #220

[   38.769342]

[   38.769345]  832f7002

[   38.769355] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.769357] Call Trace:

[   38.769364] g4: ffff8001fa74aa00 g5: ffff8001fea4e000 g6: ffff8001fa78c000 g7: 000000000000000e

[   38.769368] Unable to handle kernel NULL pointer dereference

[   38.769375]  [000000000048de38] do_idle+0x118/0x1a0

[   38.769381] o0: 0000000000001c00 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.769384] tsk->{mm,active_mm}->context = 00000000000000cf

[   38.769386] Call Trace:

[   38.769388]  9210203c

[   38.769397] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.769406]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.769412] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.769417] tsk->{mm,active_mm}->context = 00000000000002b2

[   38.769424]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.769430] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa71f531 ret_pc: 000000000042c7e4

[   38.769433] tsk->{mm,active_mm}->pgd = ffff8001f6e9c000

[   38.769441]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.769444]  96102020

[   38.769459] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.769467]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.769474] o4: 0000000000003f60 o5: ffff8001fa78c000 sp: ffff8001fa78f191 ret_pc: 000000000042b04c

[   38.769478] tsk->{mm,active_mm}->pgd = ffff8001ad8a0000

[   38.769488]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.769498] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.769502]               \|/ ____ \|/

[   38.769502]               "@'/ .. \`@"

[   38.769502]               /_| \__/ |_\

[   38.769502]                  \__U_/

[   38.769513]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.769516] <d406c001>

[   38.769527] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.769541]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.769549] RPC: <die_if_kernel+0xb4/0x24c>

[   38.769554]               \|/ ____ \|/

[   38.769554]               "@'/ .. \`@"

[   38.769554]               /_| \__/ |_\

[   38.769554]                  \__U_/

[   38.769559]  [0000000000000000] 0x0

[   38.769565] l0: ffff8001ff420040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.769569] swapper/82(0): Oops [#84]

[   38.769574]  [0000000000001480] 0x1480

[   38.769576]  93666020

[   38.769585] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.769590]  [0000000000003280] 0x3280

[   38.769597] l0: 0000000000000009 l1: ffff8001fa78ff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.769602] swapper/22(0): Oops [#85]

[   38.769610] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.769616] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.769623] CPU: 82 PID: 0 Comm: swapper/82 Tainted: G      D           5.2.0-rc5 #220

[   38.769630]  [000000000048de38] do_idle+0x118/0x1a0

[   38.769632]  9010001c

[   38.769641] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.769649]  [000000000048de38] do_idle+0x118/0x1a0

[   38.769655] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.769664] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G      D           5.2.0-rc5 #220

[   38.769672] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.769678] i0: 0000000000000524 i1: ffff8001ff42aff8 i2: 0000000000000001 i3: 0000000000001c00

[   38.769685] TSTATE: 0000004480001603 TPC: 0000000000000fc0 TNPC: 0000000000000fc4 Y: 00000000    Tainted: G      D

[   38.769692]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.769695]  ba076001

[   38.769706] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.769715]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.769721] i0: 0000000000ab21e0 i1: ffff8001fa78fc90 i2: ffff8001fa78c000 i3: 0000000000000f80

[   38.769730] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.769739] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.769745] i4: 00000000fef48ff8 i5: 00000000fef47800 i6: ffff8001fa71f5e1 i7: 000000000048de38

[   38.769749] TPC: <0xfc0>

[   38.769757]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.769759]  40020421

[   38.769766] Caller[0000000000000000]: 0x0

[   38.769776]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.769783] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa78f271 i7: 00000000004501a4

[   38.769793] TPC: <die_if_kernel+0x114/0x24c>

[   38.769798] Caller[0000000000000000]: 0x0

[   38.769805] I7: <do_idle+0x118/0x1a0>

[   38.769811] g0: 0000000f00000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.769815]  [0000000000000000] 0x0

[   38.769818]  9764603e

[   38.769821] Instruction DUMP:

[   38.769828]  [0000000000000000] 0x0

[   38.769836] I7: <unhandled_fault+0x84/0xa0>

[   38.769843] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.769845] Instruction DUMP:

[   38.769847] Call Trace:

[   38.769853] g4: 0000000000005a20 g5: ffff8001fe96e000 g6: ffff8001fa770000 g7: 0000000000000052

[   38.769856] Unable to handle kernel NULL pointer dereference

[   38.769863] CPU: 81 PID: 0 Comm: swapper/81 Tainted: G      D           5.2.0-rc5 #220

[   38.769865]

[   38.769868]  832f7002

[   38.769878] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.769881] Call Trace:

[   38.769888] g4: ffff8001b8cd2200 g5: ffff8001be6ee000 g6: ffff8001b8cec000 g7: 000000000000000e

[   38.769892] Unable to handle kernel NULL pointer dereference

[   38.769898]  [000000000048de38] do_idle+0x118/0x1a0

[   38.769904] o0: 0000000000000fc0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.769907] tsk->{mm,active_mm}->context = 00000000000000f6

[   38.769908] Call Trace:

[   38.769910]  9210203c

[   38.769920] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.769929]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.769935] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.769939] tsk->{mm,active_mm}->context = 0000000000000000

[   38.769946]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.769952] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa773531 ret_pc: 000000000042c7e4

[   38.769955] tsk->{mm,active_mm}->pgd = ffff8001f7264000

[   38.769964]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.769966]  96102020

[   38.769981] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.769989]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.769996] o4: 0000000000003f60 o5: ffff8001b8cec000 sp: ffff8001b8cef191 ret_pc: 000000000042b04c

[   38.770000] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.770009]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.770018] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.770022]               \|/ ____ \|/

[   38.770022]               "@'/ .. \`@"

[   38.770022]               /_| \__/ |_\

[   38.770022]                  \__U_/

[   38.770035]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.770037] <d406c001>

[   38.770050] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.770063]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.770072] RPC: <die_if_kernel+0xb4/0x24c>

[   38.770076]               \|/ ____ \|/

[   38.770076]               "@'/ .. \`@"

[   38.770076]               /_| \__/ |_\

[   38.770076]                  \__U_/

[   38.770080]  [0000000000000000] 0x0

[   38.770087] l0: ffff8001ff540040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.770091] swapper/71(0): Oops [#86]

[   38.770095]  [0000000000000f80] 0xf80

[   38.770097]  93666020

[   38.770106] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.770112]  [0000000000000f80] 0xf80

[   38.770119] l0: 0000000000000009 l1: ffff8001b8ceff60 l2: 0000000057ac6c00 l3: 0000000000000400

[   38.770123] swapper/94(0): Oops [#87]

[   38.770130] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.770136] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.770144] CPU: 71 PID: 0 Comm: swapper/71 Tainted: G      D           5.2.0-rc5 #220

[   38.770150]  [000000000048de38] do_idle+0x118/0x1a0

[   38.770152]  9010001c

[   38.770162] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.770169]  [000000000048de38] do_idle+0x118/0x1a0

[   38.770176] l4: 0000000000000000 l5: 0000000000000002 l6: 0000000000000000 l7: 0000000000000008

[   38.770184] CPU: 94 PID: 0 Comm: swapper/94 Tainted: G      D           5.2.0-rc5 #220

[   38.770192] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.770198] i0: 00000000000006c0 i1: ffff8001ff54aff8 i2: 0000000000000001 i3: 0000000000000fc0

[   38.770205] TSTATE: 0000004480001603 TPC: 0000000000001480 TNPC: 0000000000001484 Y: 00000000    Tainted: G      D

[   38.770211]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.770213]  ba076001

[   38.770225] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.770233]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.770240] i0: 0000000000ab21e0 i1: ffff8001b8cefc90 i2: ffff8001b8cec000 i3: 0000000000001040

[   38.770248] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.770256] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.770262] i4: 00000000fef7eff8 i5: 00000000fef7d800 i6: ffff8001fa7735e1 i7: 000000000048de38

[   38.770267] TPC: <0x1480>

[   38.770276]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.770278]  40020421

[   38.770284] Caller[0000000000000000]: 0x0

[   38.770295]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.770302] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8cef271 i7: 00000000004501a4

[   38.770311] TPC: <die_if_kernel+0x114/0x24c>

[   38.770316] Caller[0000000000000000]: 0x0

[   38.770322] I7: <do_idle+0x118/0x1a0>

[   38.770328] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.770332]  [0000000000000000] 0x0

[   38.770334]  9764603e

[   38.770337] Instruction DUMP:

[   38.770344]  [0000000000000000] 0x0

[   38.770352] I7: <unhandled_fault+0x84/0xa0>

[   38.770359] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.770360] Instruction DUMP:

[   38.770363] Call Trace:

[   38.770369] g4: 0000000000005a20 g5: ffff8001fe90e000 g6: ffff8001fa764000 g7: 0000000000000047

[   38.770371] Unable to handle kernel NULL pointer dereference

[   38.770372]

[   38.770380] CPU: 85 PID: 0 Comm: swapper/85 Tainted: G      D           5.2.0-rc5 #220

[   38.770383]  832f7002

[   38.770393] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.770395] Call Trace:

[   38.770402] g4: ffff8001fa747f80 g5: ffff8001feaee000 g6: ffff8001fa7a0000 g7: 000000000000000e

[   38.770405] Unable to handle kernel NULL pointer dereference

[   38.770412]  [000000000048de38] do_idle+0x118/0x1a0

[   38.770417] o0: 0000000000001480 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.770420] tsk->{mm,active_mm}->context = 0000000000000000

[   38.770421] Call Trace:

[   38.770424]  9210203c

[   38.770433] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.770442]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.770448] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.770451] tsk->{mm,active_mm}->context = 0000000000000000

[   38.770458]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.770464] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa767531 ret_pc: 000000000042c7e4

[   38.770467] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.770475]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.770478]  96102020

[   38.770492] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.770500]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.770507] o4: 0000000000003f60 o5: ffff8001fa7a0000 sp: ffff8001fa7a3191 ret_pc: 000000000042b04c

[   38.770511] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.770519]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.770529] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.770532]               \|/ ____ \|/

[   38.770532]               "@'/ .. \`@"

[   38.770532]               /_| \__/ |_\

[   38.770532]                  \__U_/

[   38.770545]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.770548] <d406c001>

[   38.770560] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.770573]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.770581] RPC: <die_if_kernel+0xb4/0x24c>

[   38.770585]               \|/ ____ \|/

[   38.770585]               "@'/ .. \`@"

[   38.770585]               /_| \__/ |_\

[   38.770585]                  \__U_/

[   38.770589]  [0000000000000000] 0x0

[   38.770595] l0: ffff8001ff4e0040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.770599] swapper/81(0): Oops [#88]

[   38.770604]  [0000000000001040] 0x1040

[   38.770606]  93666020

[   38.770615] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.770621]  [0000000000001040] 0x1040

[   38.770627] l0: 0000000000000009 l1: ffff8001fa7a3f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.770632] swapper/65(0): Oops [#89]

[   38.770639] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.770644] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.770652] CPU: 81 PID: 0 Comm: swapper/81 Tainted: G      D           5.2.0-rc5 #220

[   38.770658]  [000000000048de38] do_idle+0x118/0x1a0

[   38.770661]  9010001c

[   38.770670] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.770678]  [000000000048de38] do_idle+0x118/0x1a0

[   38.770684] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.770692] CPU: 65 PID: 0 Comm: swapper/65 Tainted: G      D           5.2.0-rc5 #220

[   38.770699] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.770704] i0: 00000000000006ec i1: ffff8001ff4eaff8 i2: 0000000000000001 i3: 0000000000001480

[   38.770712] TSTATE: 0000004480001603 TPC: 0000000000000f80 TNPC: 0000000000000f84 Y: 00000000    Tainted: G      D

[   38.770718]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.770721]  ba076001

[   38.770732] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.770740]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.770747] i0: 0000000000ab21e0 i1: ffff8001fa7a3c90 i2: ffff8001fa7a0000 i3: 0000000000000f40

[   38.770754] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 0000001a    Tainted: G      D

[   38.770764] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.770770] i4: 00000000fef6cff8 i5: 00000000fef6b800 i6: ffff8001fa7675e1 i7: 000000000048de38

[   38.770773] TPC: <0xf80>

[   38.770781]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.770784]  40020421

[   38.770790] Caller[0000000000000000]: 0x0

[   38.770800]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.770807] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa7a3271 i7: 00000000004501a4

[   38.770815] TPC: <die_if_kernel+0x114/0x24c>

[   38.770820] Caller[0000000000000000]: 0x0

[   38.770826] I7: <do_idle+0x118/0x1a0>

[   38.770832] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.770836]  [0000000000000000] 0x0

[   38.770839]  9764603e

[   38.770842] Instruction DUMP:

[   38.770848]  [0000000000000000] 0x0

[   38.770857] I7: <unhandled_fault+0x84/0xa0>

[   38.770863] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.770864] Instruction DUMP:

[   38.770866] Call Trace:

[   38.770872] g4: 0000000000005a20 g5: ffff8001fe94e000 g6: ffff8001fa76c000 g7: 0000000000000051

[   38.770875] Unable to handle kernel NULL pointer dereference

[   38.770884] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G      D           5.2.0-rc5 #220

[   38.770885]

[   38.770888]  832f7002

[   38.770898] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.770901] Call Trace:

[   38.770907] g4: ffff8001fa740880 g5: ffff8001fe84e000 g6: ffff8001fa71c000 g7: 000000000000000e

[   38.770913]  [000000000048de38] do_idle+0x118/0x1a0

[   38.770916] Unable to handle kernel NULL pointer dereference

[   38.770921] o0: 0000000000000f80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.770924] tsk->{mm,active_mm}->context = 00000000000000f5

[   38.770927] Call Trace:

[   38.770929]  9210203c

[   38.770939] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.770947]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.770953] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.770960]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.770963] tsk->{mm,active_mm}->context = 00000000000000cf

[   38.770968] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa76f531 ret_pc: 000000000042c7e4

[   38.770971] tsk->{mm,active_mm}->pgd = ffff8001f7170000

[   38.770980]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.770983]  96102020

[   38.770997] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.771005]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.771012] o4: 0000000000003f60 o5: ffff8001fa71c000 sp: ffff8001fa71f191 ret_pc: 000000000042b04c

[   38.771021]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.771024] tsk->{mm,active_mm}->pgd = ffff8001f6e9c000

[   38.771034] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.771037]               \|/ ____ \|/

[   38.771037]               "@'/ .. \`@"

[   38.771037]               /_| \__/ |_\

[   38.771037]                  \__U_/

[   38.771048]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.771051] <d406c001>

[   38.771064] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.771077]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.771085] RPC: <die_if_kernel+0xb4/0x24c>

[   38.771089]  [0000000000000000] 0x0

[   38.771093]               \|/ ____ \|/

[   38.771093]               "@'/ .. \`@"

[   38.771093]               /_| \__/ |_\

[   38.771093]                  \__U_/

[   38.771099] l0: ffff8001ff520040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.771103] swapper/85(0): Oops [#90]

[   38.771108]  [0000000000001a80] 0x1a80

[   38.771111]  93666020

[   38.771120] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.771125]  [0000000000000f40] 0xf40

[   38.771132] l0: 0000000000000009 l1: ffff8001fa71ff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.771138] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.771142] swapper/82(0): Oops [#91]

[   38.771149] l4: ffff8001ff529c80 l5: ffff8001bf1ea380 l6: 00000000009b2400 l7: 00000000ffff8b16

[   38.771156] CPU: 85 PID: 0 Comm: swapper/85 Tainted: G      D           5.2.0-rc5 #220

[   38.771164]  [000000000048de38] do_idle+0x118/0x1a0

[   38.771167]  9010001c

[   38.771176] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.771183]  [000000000048de38] do_idle+0x118/0x1a0

[   38.771189] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.771196] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.771203] CPU: 82 PID: 0 Comm: swapper/82 Tainted: G      D           5.2.0-rc5 #220

[   38.771209] i0: 0000000000000628 i1: ffff8001ff52aff8 i2: 0000000000000001 i3: 0000000000000f80

[   38.771216] TSTATE: 0000004480001603 TPC: 0000000000001040 TNPC: 0000000000001044 Y: 00000000    Tainted: G      D

[   38.771227]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.771229]  ba076001

[   38.771243] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.771250]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.771256] i0: 0000000000ab21e0 i1: ffff8001fa71fc90 i2: ffff8001fa71c000 i3: 0000000000001c00

[   38.771265] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.771272] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.771278] i4: 00000000fef78ff8 i5: 00000000fef77800 i6: ffff8001fa76f5e1 i7: 000000000048de38

[   38.771282] TPC: <0x1040>

[   38.771294]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.771297]  40020421

[   38.771307]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.771313] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa71f271 i7: 00000000004501a4

[   38.771317] Caller[0000000000000000]: 0x0

[   38.771323] Caller[0000000000000000]: 0x0

[   38.771332] TPC: <die_if_kernel+0x114/0x24c>

[   38.771338] I7: <do_idle+0x118/0x1a0>

[   38.771345] g0: ffffffff00000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.771350]  [0000000000000000] 0x0

[   38.771353]  9764603e

[   38.771358]  [0000000000000000] 0x0

[   38.771366] I7: <unhandled_fault+0x84/0xa0>

[   38.771367] Instruction DUMP:

[   38.771370] Instruction DUMP:

[   38.771377] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.771379] Call Trace:

[   38.771385] g4: 0000000000005a20 g5: ffff8001fe9ce000 g6: ffff8001fa77c000 g7: 0000000000000055

[   38.771388] Unable to handle kernel NULL pointer dereference

[   38.771390]

[   38.771398] CPU: 90 PID: 0 Comm: swapper/90 Tainted: G      D           5.2.0-rc5 #220

[   38.771406] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.771408] Call Trace:

[   38.771410] Unable to handle kernel NULL pointer dereference

[   38.771413]  832f7002

[   38.771421] g4: ffff8001fa74e580 g5: ffff8001fe96e000 g6: ffff8001fa770000 g7: 000000000000000e

[   38.771427]  [000000000048de38] do_idle+0x118/0x1a0

[   38.771433] o0: 0000000000001040 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.771437] tsk->{mm,active_mm}->context = 00000000000002a4

[   38.771439] Call Trace:

[   38.771447] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.771454]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.771457] tsk->{mm,active_mm}->context = 00000000000000f6

[   38.771460]  9210203c

[   38.771467] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.771474]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.771480] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa77f531 ret_pc: 000000000042c7e4

[   38.771484] tsk->{mm,active_mm}->pgd = ffff8001aceec000

[   38.771493]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.771505] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.771513]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.771516] tsk->{mm,active_mm}->pgd = ffff8001f7264000

[   38.771518]  96102020

[   38.771526] o4: 0000000000003f60 o5: ffff8001fa770000 sp: ffff8001fa773191 ret_pc: 000000000042b04c

[   38.771536]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.771545] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.771549]               \|/ ____ \|/

[   38.771549]               "@'/ .. \`@"

[   38.771549]               /_| \__/ |_\

[   38.771549]                  \__U_/

[   38.771560]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.771571] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.771584]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.771587]               \|/ ____ \|/

[   38.771587]               "@'/ .. \`@"

[   38.771587]               /_| \__/ |_\

[   38.771587]                  \__U_/

[   38.771590] <d406c001>

[   38.771599] RPC: <die_if_kernel+0xb4/0x24c>

[   38.771603]  [0000000000000000] 0x0

[   38.771609] l0: ffff8001ff5a0040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.771615] swapper/21(0): Oops [#92]

[   38.771620]  [0000000000000e80] 0xe80

[   38.771627] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.771631]  [0000000000001c00] 0x1c00

[   38.771635] swapper/71(0): Oops [#93]

[   38.771638]  93666020

[   38.771646] l0: 0000000000000009 l1: ffff8001fa773f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.771653] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.771659] l4: ffff8001ff5a9c80 l5: 0000000000000000 l6: 0000000000000000 l7: 002b008100000000

[   38.771668] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G      D           5.2.0-rc5 #220

[   38.771675]  [000000000048de38] do_idle+0x118/0x1a0

[   38.771682] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.771689]  [000000000048de38] do_idle+0x118/0x1a0

[   38.771697] CPU: 71 PID: 0 Comm: swapper/71 Tainted: G      D           5.2.0-rc5 #220

[   38.771700]  9010001c

[   38.771707] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.771714] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.771720] i0: 00000000000006ac i1: ffff8001ff5aaff8 i2: 0000000000000001 i3: 0000000000001040

[   38.771728] TSTATE: 0000004480001603 TPC: 0000000000001a80 TNPC: 0000000000001a84 Y: 00000000    Tainted: G      D

[   38.771736]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.771746] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.771752]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.771760] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.771762]  ba076001

[   38.771770] i0: 0000000000ab21e0 i1: ffff8001fa773c90 i2: ffff8001fa770000 i3: 0000000000000fc0

[   38.771779] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.771785] i4: 00000000fef90ff8 i5: 00000000fef8f800 i6: ffff8001fa77f5e1 i7: 000000000048de38

[   38.771790] TPC: <0x1a80>

[   38.771799]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.771803] Caller[0000000000000000]: 0x0

[   38.771812]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.771821] TPC: <die_if_kernel+0x114/0x24c>

[   38.771824]  40020421

[   38.771832] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa773271 i7: 00000000004501a4

[   38.771836] Caller[0000000000000000]: 0x0

[   38.771842] I7: <do_idle+0x118/0x1a0>

[   38.771850] g0: fffffffbffffffdb g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.771854]  [0000000000000000] 0x0

[   38.771856] Instruction DUMP:

[   38.771861]  [0000000000000000] 0x0

[   38.771867] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.771870]  9764603e

[   38.771879] I7: <unhandled_fault+0x84/0xa0>

[   38.771880] Instruction DUMP:

[   38.771882] Call Trace:

[   38.771889] g4: 0000000000005a20 g5: ffff8001be6ce000 g6: ffff8001b8ce8000 g7: 0000000000000015

[   38.771892]  832f7002

[   38.771896] Unable to handle kernel NULL pointer dereference

[   38.771903] CPU: 92 PID: 0 Comm: swapper/92 Tainted: G      D           5.2.0-rc5 #220

[   38.771912] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.771918] g4: ffff8001fa743b80 g5: ffff8001fe90e000 g6: ffff8001fa764000 g7: 000000000000000e

[   38.771920]

[   38.771922] Call Trace:

[   38.771925] Unable to handle kernel NULL pointer dereference

[   38.771931]  [000000000048de38] do_idle+0x118/0x1a0

[   38.771938] o0: 0000000000001a80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.771940]  9210203c

[   38.771945] tsk->{mm,active_mm}->context = 0000000000000000

[   38.771946] Call Trace:

[   38.771953] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.771959] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.771966]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.771969] tsk->{mm,active_mm}->context = 0000000000000000

[   38.771976]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.771983] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001b8ceb531 ret_pc: 000000000042c7e4

[   38.771986]  96102020

[   38.771990] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.771999]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.772011] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.772018] o4: 0000000000003f60 o5: ffff8001fa764000 sp: ffff8001fa767191 ret_pc: 000000000042b04c

[   38.772025]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.772028] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.772037]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.772048] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.772051] <d406c001>

[   38.772055]               \|/ ____ \|/

[   38.772055]               "@'/ .. \`@"

[   38.772055]               /_| \__/ |_\

[   38.772055]                  \__U_/

[   38.772068]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.772078] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.772085] RPC: <die_if_kernel+0xb4/0x24c>

[   38.772098]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.772102]               \|/ ____ \|/

[   38.772102]               "@'/ .. \`@"

[   38.772102]               /_| \__/ |_\

[   38.772102]                  \__U_/

[   38.772106]  [0000000000000000] 0x0

[   38.772113] l0: ffff8001bf2a0040 l1: 0000000802665800 l2: ffff8001b8c6fde0 l3: 0000000000000002

[   38.772116]  93666020

[   38.772121] swapper/90(0): Oops [#94]

[   38.772126]  [0000000000001040] 0x1040

[   38.772132] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.772138] l0: 0000000000000009 l1: ffff8001fa767f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.772143]  [0000000000000fc0] 0xfc0

[   38.772147] swapper/81(0): Oops [#95]

[   38.772154] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.772160] l4: 0000000000000000 l5: 0000000000000001 l6: 0000000000b680a0 l7: 0000000000001043

[   38.772163]  9010001c

[   38.772172] CPU: 90 PID: 0 Comm: swapper/90 Tainted: G      D           5.2.0-rc5 #220

[   38.772178]  [000000000048de38] do_idle+0x118/0x1a0

[   38.772185] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.772191] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.772197]  [000000000048de38] do_idle+0x118/0x1a0

[   38.772205] CPU: 81 PID: 0 Comm: swapper/81 Tainted: G      D           5.2.0-rc5 #220

[   38.772212] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.772219] i0: 00000000000011a0 i1: ffff8001bf2aaff8 i2: 0000000000000001 i3: 0000000000001a80

[   38.772222]  ba076001

[   38.772230] TSTATE: 0000004480001603 TPC: 0000000000000e80 TNPC: 0000000000000e84 Y: 00000000    Tainted: G      D

[   38.772236]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.772246] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.772252] i0: 0000000000ab21e0 i1: ffff8001fa767c90 i2: ffff8001fa764000 i3: 0000000000001480

[   38.772258]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.772266] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.772275] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.772282] i4: 00000000fef00ff8 i5: 00000000feeff800 i6: ffff8001b8ceb5e1 i7: 000000000048de38

[   38.772285]  40020421

[   38.772289] TPC: <0xe80>

[   38.772299]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.772303] Caller[0000000000000000]: 0x0

[   38.772309] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa767271 i7: 00000000004501a4

[   38.772317]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.772326] TPC: <die_if_kernel+0x114/0x24c>

[   38.772330] Caller[0000000000000000]: 0x0

[   38.772337] I7: <do_idle+0x118/0x1a0>

[   38.772340]  9764603e

[   38.772347] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.772351]  [0000000000000000] 0x0

[   38.772352] Instruction DUMP:

[   38.772360] I7: <unhandled_fault+0x84/0xa0>

[   38.772365]  [0000000000000000] 0x0

[   38.772371] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.772372] Instruction DUMP:

[   38.772375] Call Trace:

[   38.772376]

[   38.772382] g4: 0000000000005a20 g5: ffff8001fea6e000 g6: ffff8001fa790000 g7: 000000000000005a

[   38.772385]  832f7002

[   38.772388] Unable to handle kernel NULL pointer dereference

[   38.772395] CPU: 88 PID: 0 Comm: swapper/88 Tainted: G      D           5.2.0-rc5 #220

[   38.772397] Call Trace:

[   38.772405] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.772412] g4: ffff8001fa74ee00 g5: ffff8001fe94e000 g6: ffff8001fa76c000 g7: 000000000000000e

[   38.772415] Unable to handle kernel NULL pointer dereference

[   38.772422]  [000000000048de38] do_idle+0x118/0x1a0

[   38.772428] o0: 0000000000000e80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.772430]  9210203c

[   38.772434] tsk->{mm,active_mm}->context = 00000000000000f8

[   38.772436] Call Trace:

[   38.772443]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.772450] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.772456] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.772459] tsk->{mm,active_mm}->context = 00000000000000f5

[   38.772467]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.772473] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa793531 ret_pc: 000000000042c7e4

[   38.772475]  96102020

[   38.772479] tsk->{mm,active_mm}->pgd = ffff8001f7320000

[   38.772488]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.772495]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.772508] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.772514] o4: 0000000000003f60 o5: ffff8001fa76c000 sp: ffff8001fa76f191 ret_pc: 000000000042b04c

[   38.772517] tsk->{mm,active_mm}->pgd = ffff8001f7170000

[   38.772527]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.772538] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.772540] <d406c001>

[   38.772544]               \|/ ____ \|/

[   38.772544]               "@'/ .. \`@"

[   38.772544]               /_| \__/ |_\

[   38.772544]                  \__U_/

[   38.772557]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.772569]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.772580] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.772587] RPC: <die_if_kernel+0xb4/0x24c>

[   38.772590]               \|/ ____ \|/

[   38.772590]               "@'/ .. \`@"

[   38.772590]               /_| \__/ |_\

[   38.772590]                  \__U_/

[   38.772595]  [0000000000000000] 0x0

[   38.772602] l0: ffff8001ff640040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.772604]  93666020

[   38.772609] swapper/92(0): Oops [#96]

[   38.772614]  [0000000000001740] 0x1740

[   38.772618]  [0000000000001480] 0x1480

[   38.772625] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.772631] l0: 0000000000000009 l1: ffff8001fa76ff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.772635] swapper/85(0): Oops [#97]

[   38.772643] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.772649] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.772651]  9010001c

[   38.772660] CPU: 92 PID: 0 Comm: swapper/92 Tainted: G      D           5.2.0-rc5 #220

[   38.772666]  [000000000048de38] do_idle+0x118/0x1a0

[   38.772672]  [000000000048de38] do_idle+0x118/0x1a0

[   38.772680] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.772685] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.772693] CPU: 85 PID: 0 Comm: swapper/85 Tainted: G      D           5.2.0-rc5 #220

[   38.772701] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.772707] i0: 000000000000056c i1: ffff8001ff64aff8 i2: 0000000000000001 i3: 0000000000000e80

[   38.772709]  ba076001

[   38.772717] TSTATE: 0000004480001603 TPC: 0000000000001040 TNPC: 0000000000001044 Y: 00000000    Tainted: G      D

[   38.772724]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.772731]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.772740] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.772746] i0: 0000000000ab21e0 i1: ffff8001fa76fc90 i2: ffff8001fa76c000 i3: 0000000000000f80

[   38.772753] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001938    Tainted: G      D

[   38.772763] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.772769] i4: 00000000fefaeff8 i5: 00000000fefad800 i6: ffff8001fa7935e1 i7: 000000000048de38

[   38.772771]  40020421

[   38.772776] TPC: <0x1040>

[   38.772786]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.772795]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.772799] Caller[0000000000000000]: 0x0

[   38.772805] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa76f271 i7: 00000000004501a4

[   38.772813] TPC: <die_if_kernel+0x114/0x24c>

[   38.772819] Caller[0000000000000000]: 0x0

[   38.772826] I7: <do_idle+0x118/0x1a0>

[   38.772828]  9764603e

[   38.772835] g0: fffffff6ffffffff g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.772839]  [0000000000000000] 0x0

[   38.772843]  [0000000000000000] 0x0

[   38.772844] Instruction DUMP:

[   38.772852] I7: <unhandled_fault+0x84/0xa0>

[   38.772858] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.772860] Instruction DUMP:

[   38.772862]

[   38.772864] Call Trace:

[   38.772870] g4: 0000000000005a20 g5: ffff8001feaae000 g6: ffff8001fa798000 g7: 000000000000005c

[   38.772872] Unable to handle kernel NULL pointer dereference

[   38.772880] CPU: 69 PID: 0 Comm: swapper/69 Tainted: G      D           5.2.0-rc5 #220

[   38.772882]  832f7002

[   38.772890] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.772892] Call Trace:

[   38.772898] g4: ffff8001fa74cc00 g5: ffff8001fe9ce000 g6: ffff8001fa77c000 g7: 000000000000000e

[   38.772902] Unable to handle kernel NULL pointer dereference

[   38.772909]  [000000000048de38] do_idle+0x118/0x1a0

[   38.772914] o0: 0000000000001040 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.772917] tsk->{mm,active_mm}->context = 000000000000007b

[   38.772919] Call Trace:

[   38.772921]  9210203c

[   38.772929] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.772936]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.772942] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.772946] tsk->{mm,active_mm}->context = 00000000000002a4

[   38.772953]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.772959] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa79b531 ret_pc: 000000000042c7e4

[   38.772962] tsk->{mm,active_mm}->pgd = ffff8001b06a4000

[   38.772970]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.772972]  96102020

[   38.772984] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.772991]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.772997] o4: 0000000000003f60 o5: ffff8001fa77c000 sp: ffff8001fa77f191 ret_pc: 000000000042b04c

[   38.773002] tsk->{mm,active_mm}->pgd = ffff8001aceec000

[   38.773011]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.773020] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.773024]               \|/ ____ \|/

[   38.773024]               "@'/ .. \`@"

[   38.773024]               /_| \__/ |_\

[   38.773024]                  \__U_/

[   38.773033]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.773035] <d406c001>

[   38.773047] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.773059]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.773067] RPC: <die_if_kernel+0xb4/0x24c>

[   38.773072]               \|/ ____ \|/

[   38.773072]               "@'/ .. \`@"

[   38.773072]               /_| \__/ |_\

[   38.773072]                  \__U_/

[   38.773077]  [0000000000000000] 0x0

[   38.773084] l0: ffff8001ff680040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.773088] swapper/88(0): Oops [#98]

[   38.773092]  [0000000000001040] 0x1040

[   38.773094]  93666020

[   38.773102] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.773106]  [0000000000000f80] 0xf80

[   38.773112] l0: 0000000000000009 l1: ffff8001fa77ff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.773117] swapper/21(0): Oops [#99]

[   38.773125] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.773131] l4: ffff8001ff689c80 l5: 0000000000000000 l6: 0000000000000000 l7: 001d008100000000

[   38.773139] CPU: 88 PID: 0 Comm: swapper/88 Tainted: G      D           5.2.0-rc5 #220

[   38.773145]  [000000000048de38] do_idle+0x118/0x1a0

[   38.773147]  9010001c

[   38.773154] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.773161]  [000000000048de38] do_idle+0x118/0x1a0

[   38.773166] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.773175] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G      D           5.2.0-rc5 #220

[   38.773183] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.773189] i0: 0000000000000648 i1: ffff8001ff68aff8 i2: 0000000000000001 i3: 0000000000001040

[   38.773196] TSTATE: 0000004480001603 TPC: 0000000000001740 TNPC: 0000000000001744 Y: 00000000    Tainted: G      D

[   38.773203]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.773205]  ba076001

[   38.773214] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.773221]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.773227] i0: 0000000000ab21e0 i1: ffff8001fa77fc90 i2: ffff8001fa77c000 i3: 0000000000001040

[   38.773236] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00001934    Tainted: G      D

[   38.773246] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.773252] i4: 00000000fefbaff8 i5: 00000000fefb9800 i6: ffff8001fa79b5e1 i7: 000000000048de38

[   38.773256] TPC: <0x1740>

[   38.773263]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.773265]  40020421

[   38.773270] Caller[0000000000000000]: 0x0

[   38.773280]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.773286] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa77f271 i7: 00000000004501a4

[   38.773296] TPC: <die_if_kernel+0x114/0x24c>

[   38.773301] Caller[0000000000000000]: 0x0

[   38.773307] I7: <do_idle+0x118/0x1a0>

[   38.773313] g0: 000000020000000d g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.773317]  [0000000000000000] 0x0

[   38.773319]  9764603e

[   38.773321] Instruction DUMP:

[   38.773326]  [0000000000000000] 0x0

[   38.773333] I7: <unhandled_fault+0x84/0xa0>

[   38.773340] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.773342] Instruction DUMP:

[   38.773345] Call Trace:

[   38.773351] g4: 0000000000005a20 g5: ffff8001fea2e000 g6: ffff8001fa788000 g7: 0000000000000058

[   38.773353] Unable to handle kernel NULL pointer dereference

[   38.773354]

[   38.773362] CPU: 86 PID: 0 Comm: swapper/86 Tainted: G      D           5.2.0-rc5 #220

[   38.773364]  832f7002

[   38.773372] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.773373] Call Trace:

[   38.773380] g4: ffff8001b8cd1980 g5: ffff8001be6ce000 g6: ffff8001b8ce8000 g7: 000000000000000e

[   38.773384] Unable to handle kernel NULL pointer dereference

[   38.773391]  [000000000048de38] do_idle+0x118/0x1a0

[   38.773396] o0: 0000000000001740 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.773399] tsk->{mm,active_mm}->context = 00000000000000cb

[   38.773400] Call Trace:

[   38.773402]  9210203c

[   38.773410] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.773417]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.773424] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.773428] tsk->{mm,active_mm}->context = 0000000000000000

[   38.773435]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.773440] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa78b531 ret_pc: 000000000042c7e4

[   38.773444] tsk->{mm,active_mm}->pgd = ffff8001f6eb0000

[   38.773452]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.773454]  96102020

[   38.773467] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.773474]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.773481] o4: 0000000000003f60 o5: ffff8001b8ce8000 sp: ffff8001b8ceb191 ret_pc: 000000000042b04c

[   38.773485] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.773494]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.773503] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.773507]               \|/ ____ \|/

[   38.773507]               "@'/ .. \`@"

[   38.773507]               /_| \__/ |_\

[   38.773507]                  \__U_/

[   38.773517]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.773519] <d406c001>

[   38.773530] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.773541]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.773549] RPC: <die_if_kernel+0xb4/0x24c>

[   38.773553]               \|/ ____ \|/

[   38.773553]               "@'/ .. \`@"

[   38.773553]               /_| \__/ |_\

[   38.773553]                  \__U_/

[   38.773558]  [0000000000000000] 0x0

[   38.773564] l0: ffff8001ff600040 l1: 00000007e8c51080 l2: 0000000000b95800 l3: 0000000000b95800

[   38.773568] swapper/69(0): Oops [#100]

[   38.773573]  [0000000000000e80] 0xe80

[   38.773575]  93666020

[   38.773582] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.773587]  [0000000000001040] 0x1040

[   38.773594] l0: 0000000000000009 l1: ffff8001b8cebf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.773599] swapper/90(0): Oops [#101]

[   38.773606] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.773612] l4: ffff8001ff609c80 l5: 0000000000000000 l6: 0000000000000000 l7: 001d008100000000

[   38.773619] CPU: 69 PID: 0 Comm: swapper/69 Tainted: G      D           5.2.0-rc5 #220

[   38.773626]  [000000000048de38] do_idle+0x118/0x1a0

[   38.773628]  9010001c

[   38.773635] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.773641]  [000000000048de38] do_idle+0x118/0x1a0

[   38.773648] l4: 0000000000000001 l5: 0000000000000000 l6: 00000000009b2400 l7: 00000000ffff9842

[   38.773656] CPU: 90 PID: 0 Comm: swapper/90 Tainted: G      D           5.2.0-rc5 #220

[   38.773664] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.773669] i0: 00000000000006d4 i1: ffff8001ff60aff8 i2: 0000000000000001 i3: 0000000000001740

[   38.773676] TSTATE: 0000004480001603 TPC: 0000000000001040 TNPC: 0000000000001044 Y: 00000000    Tainted: G      D

[   38.773683]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.773685]  ba076001

[   38.773695] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.773702]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.773709] i0: 0000000000ab21e0 i1: ffff8001b8cebc90 i2: ffff8001b8ce8000 i3: 0000000000001a80

[   38.773717] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.773726] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.773731] i4: 00000000fefa2ff8 i5: 00000000fefa1800 i6: ffff8001fa78b5e1 i7: 000000000048de38

[   38.773735] TPC: <0x1040>

[   38.773743]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.773745]  40020421

[   38.773750] Caller[0000000000000000]: 0x0

[   38.773758]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.773765] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001b8ceb271 i7: 00000000004501a4

[   38.773774] TPC: <die_if_kernel+0x114/0x24c>

[   38.773779] Caller[0000000000000000]: 0x0

[   38.773785] I7: <do_idle+0x118/0x1a0>

[   38.773790] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.773795]  [0000000000000000] 0x0

[   38.773796]  9764603e

[   38.773798] Instruction DUMP:

[   38.773803]  [0000000000000000] 0x0

[   38.773812] I7: <unhandled_fault+0x84/0xa0>

[   38.773818] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.773819] Instruction DUMP:

[   38.773821] Call Trace:

[   38.773827] g4: 0000000000005a20 g5: ffff8001fe8ce000 g6: ffff8001fa75c000 g7: 0000000000000045

[   38.773830] Unable to handle kernel NULL pointer dereference

[   38.773831]

[   38.773833]  832f7002

[   38.773842] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.773844] Call Trace:

[   38.773851] g4: ffff8001fa74a180 g5: ffff8001fea6e000 g6: ffff8001fa790000 g7: 000000000000000e

[   38.773854] Unable to handle kernel NULL pointer dereference

[   38.773860]  [000000000048de38] do_idle+0x118/0x1a0

[   38.773866] o0: 0000000000001040 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.773869] tsk->{mm,active_mm}->context = 0000000000000000

[   38.773871]  9210203c

[   38.773879] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.773887]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.773893] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.773896] tsk->{mm,active_mm}->context = 00000000000000f8

[   38.773903]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.773908] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa75f531 ret_pc: 000000000042c7e4

[   38.773912] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.773913]  96102020

[   38.773926] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.773935]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.773942] o4: 0000000000003f60 o5: ffff8001fa790000 sp: ffff8001fa793191 ret_pc: 000000000042b04c

[   38.773945] tsk->{mm,active_mm}->pgd = ffff8001f7320000

[   38.773954]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.773963] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.773966]               \|/ ____ \|/

[   38.773966]               "@'/ .. \`@"

[   38.773966]               /_| \__/ |_\

[   38.773966]                  \__U_/

[   38.773968] <d406c001>

[   38.773979] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.773993]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.774002] RPC: <die_if_kernel+0xb4/0x24c>

[   38.774005]               \|/ ____ \|/

[   38.774005]               "@'/ .. \`@"

[   38.774005]               /_| \__/ |_\

[   38.774005]                  \__U_/

[   38.774010]  [0000000000000000] 0x0

[   38.774016] l0: ffff8001ff4a0040 l1: 00000007e8c51080 l2: 000000000000ba7e l3: 000000000000b67e

[   38.774020] swapper/86(0): Oops [#102]

[   38.774022]  93666020

[   38.774030] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.774035]  [0000000000001a80] 0x1a80

[   38.774042] l0: 0000000000000009 l1: ffff8001fa793f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.774046] swapper/92(0): Oops [#103]

[   38.774053] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.774059] l4: 0000000000000000 l5: 0000000000bf4000 l6: 000000000000ba7e l7: 00000000ffff8b16

[   38.774061]  9010001c

[   38.774070] CPU: 86 PID: 0 Comm: swapper/86 Tainted: G      D           5.2.0-rc5 #220

[   38.774077] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.774084]  [000000000048de38] do_idle+0x118/0x1a0

[   38.774091] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.774098] CPU: 92 PID: 0 Comm: swapper/92 Tainted: G      D           5.2.0-rc5 #220

[   38.774105] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.774111] i0: 00000000000005e8 i1: ffff8001ff4aaff8 i2: 0000000000000001 i3: 0000000000001040

[   38.774113]  ba076001

[   38.774121] TSTATE: 0000004480001603 TPC: 0000000000000e80 TNPC: 0000000000000e84 Y: 00000000    Tainted: G      D

[   38.774130] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.774138]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.774145] i0: 0000000000ab21e0 i1: ffff8001fa793c90 i2: ffff8001fa790000 i3: 0000000000000e80

[   38.774152] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.774161] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.774167] i4: 00000000fef60ff8 i5: 00000000fef5f800 i6: ffff8001fa75f5e1 i7: 000000000048de38

[   38.774169]  40020421

[   38.774173] TPC: <0xe80>

[   38.774178] Caller[0000000000000000]: 0x0

[   38.774188]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.774195] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa793271 i7: 00000000004501a4

[   38.774204] TPC: <die_if_kernel+0x114/0x24c>

[   38.774208] Caller[0000000000000000]: 0x0

[   38.774214] I7: <do_idle+0x118/0x1a0>

[   38.774216]  9764603e

[   38.774222] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.774224] Instruction DUMP:

[   38.774230]  [0000000000000000] 0x0

[   38.774238] I7: <unhandled_fault+0x84/0xa0>

[   38.774244] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.774245] Instruction DUMP:

[   38.774247] Call Trace:

[   38.774249]

[   38.774254] g4: 0000000000005a20 g5: ffff8001fe9ee000 g6: ffff8001fa780000 g7: 0000000000000056

[   38.774256]  832f7002

[   38.774266] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.774269] Call Trace:

[   38.774275] g4: ffff8001fa749080 g5: ffff8001feaae000 g6: ffff8001fa798000 g7: 000000000000000e

[   38.774278] Unable to handle kernel NULL pointer dereference

[   38.774284]  [000000000048de38] do_idle+0x118/0x1a0

[   38.774289] o0: 0000000000000e80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.774291]  9210203c

[   38.774301] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.774310]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.774315] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.774318] tsk->{mm,active_mm}->context = 000000000000007b

[   38.774325]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.774330] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa783531 ret_pc: 000000000042c7e4

[   38.774332]  96102020

[   38.774346] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.774355]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.774361] o4: 0000000000003f60 o5: ffff8001fa798000 sp: ffff8001fa79b191 ret_pc: 000000000042b04c

[   38.774363] tsk->{mm,active_mm}->pgd = ffff8001b06a4000

[   38.774372]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.774381] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.774383] <d406c001>

[   38.774396] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.774410]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.774418] RPC: <die_if_kernel+0xb4/0x24c>

[   38.774422]               \|/ ____ \|/

[   38.774422]               "@'/ .. \`@"

[   38.774422]               /_| \__/ |_\

[   38.774422]                  \__U_/

[   38.774426]  [0000000000000000] 0x0

[   38.774432] l0: ffff8001ff5c0040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.774434]  93666020

[   38.774443] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.774449]  [0000000000000e80] 0xe80

[   38.774456] l0: 0000000000000009 l1: ffff8001fa79bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.774460] swapper/88(0): Oops [#104]

[   38.774467] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.774473] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.774475]  9010001c

[   38.774484] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.774493]  [000000000048de38] do_idle+0x118/0x1a0

[   38.774498] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.774506] CPU: 88 PID: 0 Comm: swapper/88 Tainted: G      D           5.2.0-rc5 #220

[   38.774512] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.774518] i0: 00000000000004d0 i1: ffff8001ff5caff8 i2: 0000000000000001 i3: 0000000000000e80

[   38.774520]  ba076001

[   38.774532] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.774540]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.774546] i0: 0000000000ab21e0 i1: ffff8001fa79bc90 i2: ffff8001fa798000 i3: 0000000000001040

[   38.774554] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000000    Tainted: G      D

[   38.774561] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.774567] i4: 00000000fef96ff8 i5: 00000000fef95800 i6: ffff8001fa7835e1 i7: 000000000048de38

[   38.774569]  40020421

[   38.774576] Caller[0000000000000000]: 0x0

[   38.774587]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.774593] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa79b271 i7: 00000000004501a4

[   38.774601] TPC: <die_if_kernel+0x114/0x24c>

[   38.774606] Caller[0000000000000000]: 0x0

[   38.774612] I7: <do_idle+0x118/0x1a0>

[   38.774614]  9764603e

[   38.774617] Instruction DUMP:

[   38.774624]  [0000000000000000] 0x0

[   38.774632] I7: <unhandled_fault+0x84/0xa0>

[   38.774637] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.774639] Instruction DUMP:

[   38.774641] Call Trace:

[   38.774642]

[   38.774645]  832f7002

[   38.774654] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.774655] Call Trace:

[   38.774662] g4: ffff8001fa74b280 g5: ffff8001fea2e000 g6: ffff8001fa788000 g7: 000000000000000e

[   38.774664] Unable to handle kernel NULL pointer dereference

[   38.774670]  [000000000048de38] do_idle+0x118/0x1a0

[   38.774674]  9210203c

[   38.774683] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.774690]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.774696] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.774699] tsk->{mm,active_mm}->context = 00000000000000cb

[   38.774705]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.774708]  96102020

[   38.774723] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.774731]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.774737] o4: 0000000000003f60 o5: ffff8001fa788000 sp: ffff8001fa78b191 ret_pc: 000000000042b04c

[   38.774740] tsk->{mm,active_mm}->pgd = ffff8001f6eb0000

[   38.774749]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.774752] <d406c001>

[   38.774764] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.774776]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.774784] RPC: <die_if_kernel+0xb4/0x24c>

[   38.774787]               \|/ ____ \|/

[   38.774787]               "@'/ .. \`@"

[   38.774787]               /_| \__/ |_\

[   38.774787]                  \__U_/

[   38.774792]  [0000000000000000] 0x0

[   38.774794]  93666020

[   38.774803] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.774808]  [0000000000001040] 0x1040

[   38.774814] l0: 0000000000000009 l1: ffff8001fa78bf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.774818] swapper/69(0): Oops [#105]

[   38.774825] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.774828]  9010001c

[   38.774836] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.774843]  [000000000048de38] do_idle+0x118/0x1a0

[   38.774848] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.774856] CPU: 69 PID: 0 Comm: swapper/69 Tainted: G      D           5.2.0-rc5 #220

[   38.774863] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.774866]  ba076001

[   38.774878] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.774886]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.774893] i0: 0000000000ab21e0 i1: ffff8001fa78bc90 i2: ffff8001fa788000 i3: 0000000000001740

[   38.774900] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000001    Tainted: G      D

[   38.774907] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.774910]  40020421

[   38.774917] Caller[0000000000000000]: 0x0

[   38.774926]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.774932] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa78b271 i7: 00000000004501a4

[   38.774941] TPC: <die_if_kernel+0x114/0x24c>

[   38.774945] Caller[0000000000000000]: 0x0

[   38.774948]  9764603e

[   38.774951] Instruction DUMP:

[   38.774957]  [0000000000000000] 0x0

[   38.774965] I7: <unhandled_fault+0x84/0xa0>

[   38.774971] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.774972] Instruction DUMP:

[   38.774974]

[   38.774977]  832f7002

[   38.774987] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.774988] Call Trace:

[   38.774995] g4: ffff8001fa742a80 g5: ffff8001fe8ce000 g6: ffff8001fa75c000 g7: 000000000000000e

[   38.774997] Unable to handle kernel NULL pointer dereference

[   38.774999]  9210203c

[   38.775009] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.775016]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.775022] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.775025] tsk->{mm,active_mm}->context = 0000000000000000

[   38.775027]  96102020

[   38.775042] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.775050]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.775056] o4: 0000000000003f60 o5: ffff8001fa75c000 sp: ffff8001fa75f191 ret_pc: 000000000042b04c

[   38.775059] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.775062] <d406c001>

[   38.775074] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.775087]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.775094] RPC: <die_if_kernel+0xb4/0x24c>

[   38.775097]               \|/ ____ \|/

[   38.775097]               "@'/ .. \`@"

[   38.775097]               /_| \__/ |_\

[   38.775097]                  \__U_/

[   38.775099]  93666020

[   38.775107] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.775112]  [0000000000001740] 0x1740

[   38.775118] l0: 0000000000000009 l1: ffff8001fa75ff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.775122] swapper/86(0): Oops [#106]

[   38.775124]  9010001c

[   38.775132] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.775139]  [000000000048de38] do_idle+0x118/0x1a0

[   38.775145] l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000ba7e l7: 0000000000000001

[   38.775152] CPU: 86 PID: 0 Comm: swapper/86 Tainted: G      D           5.2.0-rc5 #220

[   38.775154]  ba076001

[   38.775166] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.775173]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.775179] i0: 0000000000ab21e0 i1: ffff8001fa75fc90 i2: ffff8001fa75c000 i3: 0000000000001040

[   38.775186] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000001    Tainted: G      D

[   38.775188]  40020421

[   38.775193] Caller[0000000000000000]: 0x0

[   38.775202]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.775208] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa75f271 i7: 00000000004501a4

[   38.775216] TPC: <die_if_kernel+0x114/0x24c>

[   38.775219]  9764603e

[   38.775221] Instruction DUMP:

[   38.775226]  [0000000000000000] 0x0

[   38.775233] I7: <unhandled_fault+0x84/0xa0>

[   38.775239] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.775240]

[   38.775242]  832f7002

[   38.775251] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.775253] Call Trace:

[   38.775259] g4: ffff8001fa74c380 g5: ffff8001fe9ee000 g6: ffff8001fa780000 g7: 000000000000000e

[   38.775261]  9210203c

[   38.775270] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.775277]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.775282] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.775284]  96102020

[   38.775297] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.775305]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.775311] o4: 0000000000003f60 o5: ffff8001fa780000 sp: ffff8001fa783191 ret_pc: 000000000042b04c

[   38.775313] <d406c001>

[   38.775324] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.775337]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.775344] RPC: <die_if_kernel+0xb4/0x24c>

[   38.775346]  93666020

[   38.775354] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.775358]  [0000000000001040] 0x1040

[   38.775364] l0: 0000000000000009 l1: ffff8001fa783f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.775366]  9010001c

[   38.775374] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.775381]  [000000000048de38] do_idle+0x118/0x1a0

[   38.775386] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.775388]  ba076001

[   38.775399] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.775406]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.775412] i0: 0000000000ab21e0 i1: ffff8001fa783c90 i2: ffff8001fa780000 i3: 0000000000000e80

[   38.775414]  40020421

[   38.775420] Caller[0000000000000000]: 0x0

[   38.775429]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.775435] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa783271 i7: 00000000004501a4

[   38.775451] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.775453]  9764603e

[   38.775455] Instruction DUMP:

[   38.775459]  [0000000000000000] 0x0

[   38.775464] OOPS: Bogus kernel PC [0000000000000e80] in fault handler

[   38.775472] I7: <unhandled_fault+0x84/0xa0>

[   38.775473]

[   38.775475]  832f7002

[   38.775483] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.775486] OOPS: RPC [000000000042c7e4]

[   38.775487] Call Trace:

[   38.775489]  9210203c

[   38.775497] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.775509] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.775516]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.775518]  96102020

[   38.775530] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.775532] OOPS: Fault was to vaddr[e80]

[   38.775539]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.775541] <d406c001>

[   38.775552] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.775560] CPU: 97 PID: 0 Comm: swapper/97 Tainted: G      D           5.2.0-rc5 #220

[   38.775573]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.775574]  93666020

[   38.775582] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.775583] Call Trace:

[   38.775587]  [0000000000000e80] 0xe80

[   38.775589]  9010001c

[   38.775597] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.775606]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.775612]  [000000000048de38] do_idle+0x118/0x1a0

[   38.775614]  ba076001

[   38.775624] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.775636]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.775643]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.775645]  40020421

[   38.775650] Caller[0000000000000000]: 0x0

[   38.775654]  [0000000000000e80] 0xe80

[   38.775663]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.775665]  9764603e

[   38.775667] Instruction DUMP:

[   38.775674]  [000000000048de38] do_idle+0x118/0x1a0

[   38.775678]  [0000000000000000] 0x0

[   38.775679]

[   38.775681]  832f7002

[   38.775688]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.775695] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.775697]  9210203c

[   38.775707]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.775714] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.775716]  96102020

[   38.775721]  [0000000000000000] 0x0

[   38.775732] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.775734] <d406c001>

[   38.775737] Unable to handle kernel NULL pointer dereference

[   38.775747] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.775749]  93666020

[   38.775752] tsk->{mm,active_mm}->context = 0000000000000000

[   38.775759] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.775761]  9010001c

[   38.775764] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.775771] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.775773]  ba076001

[   38.775777]               \|/ ____ \|/

[   38.775777]               "@'/ .. \`@"

[   38.775777]               /_| \__/ |_\

[   38.775777]                  \__U_/

[   38.775786] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.775788]  40020421

[   38.775792] swapper/97(0): Oops [#107]

[   38.775797] Caller[0000000000000000]: 0x0

[   38.775799]  9764603e

[   38.775807] CPU: 97 PID: 0 Comm: swapper/97 Tainted: G      D           5.2.0-rc5 #220

[   38.775808] Instruction DUMP:

[   38.775810]

[   38.775811]  832f7002

[   38.775819] TSTATE: 0000004480001603 TPC: 0000000000000e80 TNPC: 0000000000000e84 Y: 00000000    Tainted: G      D

[   38.775821]  9210203c

[   38.775825] TPC: <0xe80>

[   38.775827]  96102020

[   38.775832] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.775834] <d406c001>

[   38.775840] g4: 0000000000005a20 g5: ffff8001feb4e000 g6: ffff8001fa7ac000 g7: 0000000000000061

[   38.775842]  93666020

[   38.775848] o0: 0000000000000e80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.775850]  9010001c

[   38.775855] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa7af531 ret_pc: 000000000042c7e4

[   38.775857]  ba076001

[   38.775867] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.775869]  40020421

[   38.775875] l0: ffff8001ff720040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.775877]  9764603e

[   38.775883] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.775884]

[   38.775890] i0: 0000000000000420 i1: ffff8001ff72aff8 i2: 0000000000000001 i3: 0000000000000e80

[   38.775896] i4: 00000000fefd8ff8 i5: 00000000fefd7800 i6: ffff8001fa7af5e1 i7: 000000000048de38

[   38.775903] I7: <do_idle+0x118/0x1a0>

[   38.775906] Call Trace:

[   38.775913]  [000000000048de38] do_idle+0x118/0x1a0

[   38.775921]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.775930]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.775935]  [0000000000000000] 0x0

[   38.775943] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.775951] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.775959] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.775965] Caller[0000000000000000]: 0x0

[   38.775967] Instruction DUMP:

[   38.775974] Unable to handle kernel NULL pointer dereference

[   38.775978] tsk->{mm,active_mm}->context = 0000000000000000

[   38.775982] tsk->{mm,active_mm}->pgd = ffff80000e802000

[   38.775986]               \|/ ____ \|/

[   38.775986]               "@'/ .. \`@"

[   38.775986]               /_| \__/ |_\

[   38.775986]                  \__U_/

[   38.775991] swapper/97(0): Oops [#108]

[   38.776001] CPU: 97 PID: 0 Comm: swapper/97 Tainted: G      D           5.2.0-rc5 #220

[   38.776009] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000001    Tainted: G      D

[   38.776019] TPC: <die_if_kernel+0x114/0x24c>

[   38.776025] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.776032] g4: ffff8001fa746600 g5: ffff8001feb4e000 g6: ffff8001fa7ac000 g7: 000000000000000e

[   38.776038] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.776045] o4: 0000000000003f60 o5: ffff8001fa7ac000 sp: ffff8001fa7af191 ret_pc: 000000000042b04c

[   38.776053] RPC: <die_if_kernel+0xb4/0x24c>

[   38.776059] l0: 0000000000000009 l1: ffff8001fa7aff60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.776066] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.776073] i0: 0000000000ab21e0 i1: ffff8001fa7afc90 i2: ffff8001fa7ac000 i3: 0000000000000e80

[   38.776079] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa7af271 i7: 00000000004501a4

[   38.776088] I7: <unhandled_fault+0x84/0xa0>

[   38.776091] Call Trace:

[   38.776098]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.776106]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.776119]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.776125]  [0000000000000e80] 0xe80

[   38.776132]  [000000000048de38] do_idle+0x118/0x1a0

[   38.776139]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.776149]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.776155]  [0000000000000000] 0x0

[   38.776164] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.776172] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.776184] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.776195] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.776202] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.776210] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.776220] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.776225] Caller[0000000000000000]: 0x0

[   38.776227] Instruction DUMP:

[   38.776230]  832f7002

[   38.776234]  9210203c

[   38.776237]  96102020

[   38.776241] <d406c001>

[   38.776245]  93666020

[   38.776248]  9010001c

[   38.776252]  ba076001

[   38.776255]  40020421

[   38.776259]  9764603e

[   38.776262]

[   38.796446] OOPS: RPC [000000000042c7e4]

[   38.796461] OOPS: Bogus kernel PC [0000000000001600] in fault handler

[   38.796465] OOPS: RPC [000000000042c7e4]

[   38.796478] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.796483] OOPS: Fault was to vaddr[1600]

[   38.796493] CPU: 98 PID: 0 Comm: swapper/98 Tainted: G      D           5.2.0-rc5 #220

[   38.796496] Call Trace:

[   38.796507]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.796520]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.796526]  [0000000000001600] 0x1600

[   38.796534]  [000000000048de38] do_idle+0x118/0x1a0

[   38.796542]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.796552]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.796558]  [0000000000000000] 0x0

[   38.796561] Unable to handle kernel NULL pointer dereference

[   38.796566] tsk->{mm,active_mm}->context = 000000000000008b

[   38.796570] tsk->{mm,active_mm}->pgd = ffff8001b09f4000

[   38.796574]               \|/ ____ \|/

[   38.796574]               "@'/ .. \`@"

[   38.796574]               /_| \__/ |_\

[   38.796574]                  \__U_/

[   38.796579] swapper/98(0): Oops [#109]

[   38.796589] CPU: 98 PID: 0 Comm: swapper/98 Tainted: G      D           5.2.0-rc5 #220

[   38.796597] TSTATE: 0000004480001603 TPC: 0000000000001600 TNPC: 0000000000001604 Y: 00000000    Tainted: G      D

[   38.796602] TPC: <0x1600>

[   38.796609] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.796616] g4: 0000000000005a20 g5: ffff8001feb6e000 g6: ffff8001fa7b0000 g7: 0000000000000062

[   38.796622] o0: 0000000000001600 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.796629] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa7b3531 ret_pc: 000000000042c7e4

[   38.796639] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.796646] l0: ffff8001ff740040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.796653] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.796659] i0: 0000000000000678 i1: ffff8001ff74aff8 i2: 0000000000000001 i3: 0000000000001600

[   38.796666] i4: 00000000fefdeff8 i5: 00000000fefdd800 i6: ffff8001fa7b35e1 i7: 000000000048de38

[   38.796673] I7: <do_idle+0x118/0x1a0>

[   38.796676] Call Trace:

[   38.796683]  [000000000048de38] do_idle+0x118/0x1a0

[   38.796691]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.796701]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.796706]  [0000000000000000] 0x0

[   38.796714] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.796722] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.796731] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.796736] Caller[0000000000000000]: 0x0

[   38.796739] Instruction DUMP:

[   38.796745] Unable to handle kernel NULL pointer dereference

[   38.796749] tsk->{mm,active_mm}->context = 000000000000008b

[   38.796753] tsk->{mm,active_mm}->pgd = ffff8001b09f4000

[   38.796758]               \|/ ____ \|/

[   38.796758]               "@'/ .. \`@"

[   38.796758]               /_| \__/ |_\

[   38.796758]                  \__U_/

[   38.796763] swapper/98(0): Oops [#110]

[   38.796772] CPU: 98 PID: 0 Comm: swapper/98 Tainted: G      D           5.2.0-rc5 #220

[   38.796781] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000001    Tainted: G      D

[   38.796790] TPC: <die_if_kernel+0x114/0x24c>

[   38.796797] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.796804] g4: ffff8001fa745d80 g5: ffff8001feb6e000 g6: ffff8001fa7b0000 g7: 000000000000000e

[   38.796810] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.796817] o4: 0000000000003f60 o5: ffff8001fa7b0000 sp: ffff8001fa7b3191 ret_pc: 000000000042b04c

[   38.796825] RPC: <die_if_kernel+0xb4/0x24c>

[   38.796832] l0: 0000000000000009 l1: ffff8001fa7b3f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.796838] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.796845] i0: 0000000000ab21e0 i1: ffff8001fa7b3c90 i2: ffff8001fa7b0000 i3: 0000000000001600

[   38.796852] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa7b3271 i7: 00000000004501a4

[   38.796860] I7: <unhandled_fault+0x84/0xa0>

[   38.796863] Call Trace:

[   38.796871]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.796879]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.796893]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.796898]  [0000000000001600] 0x1600

[   38.796906]  [000000000048de38] do_idle+0x118/0x1a0

[   38.796913]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.796923]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.796929]  [0000000000000000] 0x0

[   38.796938] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.796946] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.796958] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.796969] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.796977] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.796985] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.796995] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.797000] Caller[0000000000000000]: 0x0

[   38.797003] Instruction DUMP:

[   38.797006]  832f7002

[   38.797009]  9210203c

[   38.797013]  96102020

[   38.797017] <d406c001>

[   38.797020]  93666020

[   38.797024]  9010001c

[   38.797028]  ba076001

[   38.797031]  40020421

[   38.797035]  9764603e

[   38.797038]

[   38.817500] OOPS: Fault was to vaddr[f00]

[   38.817516] OOPS: Bogus kernel PC [0000000000000e80] in fault handler

[   38.817520] OOPS: RPC [000000000042c7e4]

[   38.817533] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.817537] OOPS: Fault was to vaddr[e80]

[   38.817548] CPU: 99 PID: 0 Comm: swapper/99 Tainted: G      D           5.2.0-rc5 #220

[   38.817551] Call Trace:

[   38.817562]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.817576]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.817582]  [0000000000000e80] 0xe80

[   38.817590]  [000000000048de38] do_idle+0x118/0x1a0

[   38.817598]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.817609]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.817614]  [0000000000000000] 0x0

[   38.817618] Unable to handle kernel NULL pointer dereference

[   38.817622] tsk->{mm,active_mm}->context = 000000000000008b

[   38.817626] tsk->{mm,active_mm}->pgd = ffff8001b09f4000

[   38.817631]               \|/ ____ \|/

[   38.817631]               "@'/ .. \`@"

[   38.817631]               /_| \__/ |_\

[   38.817631]                  \__U_/

[   38.817636] swapper/99(0): Oops [#111]

[   38.817646] CPU: 99 PID: 0 Comm: swapper/99 Tainted: G      D           5.2.0-rc5 #220

[   38.817655] TSTATE: 0000004480001603 TPC: 0000000000000e80 TNPC: 0000000000000e84 Y: 00000000    Tainted: G      D

[   38.817659] TPC: <0xe80>

[   38.817666] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.817673] g4: 0000000000005a20 g5: ffff8001feb8e000 g6: ffff8001fa7b4000 g7: 0000000000000063

[   38.817680] o0: 0000000000000e80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.817687] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa7b7531 ret_pc: 000000000042c7e4

[   38.817697] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.817705] l0: ffff8001ff760040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.817711] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.817718] i0: 00000000000003f4 i1: ffff8001ff76aff8 i2: 0000000000000001 i3: 0000000000000e80

[   38.817725] i4: 00000000fefe4ff8 i5: 00000000fefe3800 i6: ffff8001fa7b75e1 i7: 000000000048de38

[   38.817732] I7: <do_idle+0x118/0x1a0>

[   38.817735] Call Trace:

[   38.817743]  [000000000048de38] do_idle+0x118/0x1a0

[   38.817751]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.817761]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.817766]  [0000000000000000] 0x0

[   38.817774] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.817782] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.817791] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.817797] Caller[0000000000000000]: 0x0

[   38.817800] Instruction DUMP:

[   38.817806] Unable to handle kernel NULL pointer dereference

[   38.817811] tsk->{mm,active_mm}->context = 000000000000008b

[   38.817815] tsk->{mm,active_mm}->pgd = ffff8001b09f4000

[   38.817819]               \|/ ____ \|/

[   38.817819]               "@'/ .. \`@"

[   38.817819]               /_| \__/ |_\

[   38.817819]                  \__U_/

[   38.817824] swapper/99(0): Oops [#112]

[   38.817834] CPU: 99 PID: 0 Comm: swapper/99 Tainted: G      D           5.2.0-rc5 #220

[   38.817843] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000001    Tainted: G      D

[   38.817853] TPC: <die_if_kernel+0x114/0x24c>

[   38.817859] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.817866] g4: ffff8001fa745500 g5: ffff8001feb8e000 g6: ffff8001fa7b4000 g7: 000000000000000e

[   38.817873] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.817880] o4: 0000000000003f60 o5: ffff8001fa7b4000 sp: ffff8001fa7b7191 ret_pc: 000000000042b04c

[   38.817888] RPC: <die_if_kernel+0xb4/0x24c>

[   38.817895] l0: 0000000000000009 l1: ffff8001fa7b7f60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.817902] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.817909] i0: 0000000000ab21e0 i1: ffff8001fa7b7c90 i2: ffff8001fa7b4000 i3: 0000000000000e80

[   38.817916] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa7b7271 i7: 00000000004501a4

[   38.817924] I7: <unhandled_fault+0x84/0xa0>

[   38.817928] Call Trace:

[   38.817936]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.817944]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.817958]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.817963]  [0000000000000e80] 0xe80

[   38.817971]  [000000000048de38] do_idle+0x118/0x1a0

[   38.817979]  [000000000048e0dc] cpu_startup_entry+0x1c/0x40

[   38.817989]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.817995]  [0000000000000000] 0x0

[   38.818004] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.818013] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.818025] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.818036] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.818044] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.818052] Caller[000000000048e0dc]: cpu_startup_entry+0x1c/0x40

[   38.818063] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.818068] Caller[0000000000000000]: 0x0

[   38.818071] Instruction DUMP:

[   38.818073]  832f7002

[   38.818077]  9210203c

[   38.818081]  96102020

[   38.818085] <d406c001>

[   38.818088]  93666020

[   38.818092]  9010001c

[   38.818096]  ba076001

[   38.818100]  40020421

[   38.818103]  9764603e

[   38.818106]

[   38.838200] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.838207] OOPS: Bogus kernel PC [0000000000001f80] in fault handler

[   38.838210] OOPS: RPC [000000000042c7e4]

[   38.838219] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.838224] OOPS: Fault was to vaddr[1f80]

[   38.838234] CPU: 100 PID: 0 Comm: swapper/100 Tainted: G      D           5.2.0-rc5 #220

[   38.838237] Call Trace:

[   38.838247]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   38.838261]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.838267]  [0000000000001f80] 0x1f80

[   38.838274]  [000000000048de38] do_idle+0x118/0x1a0

[   38.838281]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.838291]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.838297]  [0000000000000000] 0x0

[   38.838301] Unable to handle kernel NULL pointer dereference

[   38.838305] tsk->{mm,active_mm}->context = 00000000000000db

[   38.838309] tsk->{mm,active_mm}->pgd = ffff8001f7060000

[   38.838313]               \|/ ____ \|/

[   38.838313]               "@'/ .. \`@"

[   38.838313]               /_| \__/ |_\

[   38.838313]                  \__U_/

[   38.838318] swapper/100(0): Oops [#113]

[   38.838327] CPU: 100 PID: 0 Comm: swapper/100 Tainted: G      D           5.2.0-rc5 #220

[   38.838336] TSTATE: 0000004480001603 TPC: 0000000000001f80 TNPC: 0000000000001f84 Y: 00000000    Tainted: G      D

[   38.838340] TPC: <0x1f80>

[   38.838347] g0: 0000000000000000 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000

[   38.838353] g4: 0000000000005a20 g5: ffff8001febae000 g6: ffff8001fa7b8000 g7: 0000000000000064

[   38.838360] o0: 0000000000001f80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000

[   38.838366] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001fa7bb531 ret_pc: 000000000042c7e4

[   38.838376] RPC: <arch_cpu_idle+0x64/0xa0>

[   38.838383] l0: ffff8001ff780040 l1: 00000007e8c51080 l2: 00000000004e76e0 l3: 0000000000000000

[   38.838389] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000b50c00 l7: 0000000000b70000

[   38.838396] i0: 000000000000068c i1: ffff8001ff78aff8 i2: 0000000000000001 i3: 0000000000001f80

[   38.838403] i4: 00000000fefeaff8 i5: 00000000fefe9800 i6: ffff8001fa7bb5e1 i7: 000000000048de38

[   38.838409] I7: <do_idle+0x118/0x1a0>

[   38.838413] Call Trace:

[   38.838420]  [000000000048de38] do_idle+0x118/0x1a0

[   38.838427]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.838437]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.838442]  [0000000000000000] 0x0

[   38.838449] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.838457] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.838466] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.838471] Caller[0000000000000000]: 0x0

[   38.838473] Instruction DUMP:

[   38.838480] Unable to handle kernel NULL pointer dereference

[   38.838484] tsk->{mm,active_mm}->context = 00000000000000db

[   38.838488] tsk->{mm,active_mm}->pgd = ffff8001f7060000

[   38.838492]               \|/ ____ \|/

[   38.838492]               "@'/ .. \`@"

[   38.838492]               /_| \__/ |_\

[   38.838492]                  \__U_/

[   38.838497] swapper/100(0): Oops [#114]

[   38.838506] CPU: 100 PID: 0 Comm: swapper/100 Tainted: G      D           5.2.0-rc5 #220

[   38.838515] TSTATE: 0000008880001607 TPC: 000000000042b0ac TNPC: 000000000042b0b0 Y: 00000001    Tainted: G      D

[   38.838524] TPC: <die_if_kernel+0x114/0x24c>

[   38.838530] g0: 0000000000000001 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000

[   38.838537] g4: ffff8001fa744c80 g5: ffff8001febae000 g6: ffff8001fa7b8000 g7: 000000000000000e

[   38.838543] o0: 0000000000000011 o1: 000000000000003c o2: 0000000000000000 o3: 0000000000000020

[   38.838550] o4: 0000000000003f60 o5: ffff8001fa7b8000 sp: ffff8001fa7bb191 ret_pc: 000000000042b04c

[   38.838557] RPC: <die_if_kernel+0xb4/0x24c>

[   38.838564] l0: 0000000000000009 l1: ffff8001fa7bbf60 l2: 0000000057ac6c00 l3: 0000000000c07c00

[   38.838570] l4: 0000000000000001 l5: 0000000000000000 l6: 0000000000b95800 l7: 0000000000000001

[   38.838577] i0: 0000000000ab21e0 i1: ffff8001fa7bbc90 i2: ffff8001fa7b8000 i3: 0000000000001f80

[   38.838584] i4: 0000000000aaf888 i5: fffffffffffffffd i6: ffff8001fa7bb271 i7: 00000000004501a4

[   38.838592] I7: <unhandled_fault+0x84/0xa0>

[   38.838595] Call Trace:

[   38.838603]  [00000000004501a4] unhandled_fault+0x84/0xa0

[   38.838611]  [000000000044fc20] do_sparc64_fault+0x320/0x820

[   38.838624]  [00000000004076f4] sparc64_realfault_common+0x10/0x20

[   38.838629]  [0000000000001f80] 0x1f80

[   38.838637]  [000000000048de38] do_idle+0x118/0x1a0

[   38.838644]  [000000000048e0d4] cpu_startup_entry+0x14/0x40

[   38.838654]  [0000000000b5f6a4] after_lock_tlb+0x1a8/0x1bc

[   38.838659]  [0000000000000000] 0x0

[   38.838668] Caller[00000000004501a4]: unhandled_fault+0x84/0xa0

[   38.838676] Caller[000000000044fc20]: do_sparc64_fault+0x320/0x820

[   38.838688] Caller[00000000004076f4]: sparc64_realfault_common+0x10/0x20

[   38.838699] Caller[000000000042c7e4]: arch_cpu_idle+0x64/0xa0

[   38.838706] Caller[000000000048de38]: do_idle+0x118/0x1a0

[   38.838714] Caller[000000000048e0d4]: cpu_startup_entry+0x14/0x40

[   38.838724] Caller[0000000000b5f6a4]: after_lock_tlb+0x1a8/0x1bc

[   38.838729] Caller[0000000000000000]: 0x0

[   38.838732] Instruction DUMP:

[   38.838734]  832f7002

[   38.838738]  9210203c

[   38.838742]  96102020

[   38.838745] <d406c001>

[   38.838749]  93666020

[   38.838752]  9010001c

[   38.838756]  ba076001

[   38.838759]  40020421

[   38.838763]  9764603e

[   38.838766]

[   38.859227] CPU: 93 PID: 0 Comm: swapper/93 Tainted: G      D           5.2.0-rc5 #220

[   38.859237] OOPS: Bogus kernel PC [0000000000001ac0] in fault handler

[   38.859241] OOPS: RPC [000000000042c7e4]

[   38.859253] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.859258] OOPS: Fault was to vaddr[1ac0]

[   38.880252] OOPS: Fault was to vaddr[1180]

[   38.880268] OOPS: Bogus kernel PC [0000000000003140] in fault handler

[   38.880272] OOPS: RPC [000000000042c7e4]

[   38.880285] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.880289] OOPS: Fault was to vaddr[3140]

[   38.901245] Call Trace:

[   38.901262] OOPS: Bogus kernel PC [0000000000001980] in fault handler

[   38.901267] OOPS: RPC [000000000042c7e4]

[   38.901281] OOPS: RPC <arch_cpu_idle+0x64/0xa0>

[   38.901286] OOPS: Fault was to vaddr[1980]

[   51.194013] Press Stop-A (L1-A) from sun keyboard or send break

[   51.194013] twice on console to return to the boot prom

[   51.195323]  [000000000044fc10] do_sparc64_fault+0x310/0x820

[   51.199109] ---[ end Kernel panic - not syncing: Cannot create slab shmem_inode_cache(24:system-getty.slice) size=704 realsize=704 order=2 offset=696 flags=4040000 ]---

[   51.200523]  [00000000004076f4] sparc64_realfault_common+0x10/0x20



Full dmesg:

[    0.000021] PROMLIB: Sun IEEE Boot Prom 'OBP 4.33.6.h 2017/05/04 14:23'

[    0.000029] PROMLIB: Root node compatible: sun4v

[    0.000065] Linux version 5.2.0-rc5 (mroos@t5140) (gcc version 8.3.0 (Debian 8.3.0-7)) #220 SMP Mon Jun 17 16:53:23 EEST 2019

[    0.000148] printk: debug: ignoring loglevel setting.

[    0.003861] printk: bootconsole [earlyprom0] enabled

[    0.004572] ARCH: SUN4V

[    0.005190] Ethernet address: 00:21:28:05:3a:a4

[    0.005894] MM: PAGE_OFFSET is 0xffff800000000000 (max_phys_bits == 39)

[    0.006723] MM: VMALLOC [0x0000000100000000 --> 0x0000600000000000]

[    0.007529] MM: VMEMMAP [0x0000600000000000 --> 0x0000c00000000000]

[    0.099820] Kernel: Using 3 locked TLB entries for main kernel image.

[    0.100673] Remapping the kernel...

[    0.100696] done.

[    1.962712] OF stdout device is: /virtual-devices@100/console@1

[    1.963486] PROM: Built device tree with 188124 bytes of memory.

[    1.963944] MDESC: Size is 74544 bytes.

[    1.966422] PLATFORM: banner-name [T5140]

[    1.967063] PLATFORM: name [SUNW,T5140]

[    1.967348] PLATFORM: hostid [85053aa4]

[    1.967779] PLATFORM: serial# [00ab4130]

[    1.968363] PLATFORM: stick-frequency [457656f0]

[    1.969063] PLATFORM: mac-address [2128053aa4]

[    1.969752] PLATFORM: watchdog-resolution [1000 ms]

[    1.970470] PLATFORM: watchdog-max-timeout [31536000000 ms]

[    1.971229] PLATFORM: max-cpus [128]

[    2.044727] Allocated 16384 bytes for kernel page tables.

[    2.045517] Zone ranges:

[    2.046095]   Normal   [mem 0x000000000e400000-0x00000001ffb8dfff]

[    2.048435] Movable zone start for each node

[    2.051320] Early memory node ranges

[    2.051711]   node   0: [mem 0x000000000e400000-0x000000003fffffff]

[    2.052772]   node   1: [mem 0x0000000040000000-0x000000007fffffff]

[    2.055912]   node   0: [mem 0x0000000080000000-0x00000000bfffffff]

[    2.057911]   node   1: [mem 0x00000000c0000000-0x00000000ffffffff]

[    2.061928]   node   0: [mem 0x0000000100000000-0x000000013fffffff]

[    2.062844]   node   1: [mem 0x0000000140000000-0x000000017fffffff]

[    2.063649]   node   0: [mem 0x0000000180000000-0x00000001bfffffff]

[    2.064443]   node   1: [mem 0x00000001c0000000-0x00000001ffa81fff]

[    2.065663]   node   1: [mem 0x00000001ffa92000-0x00000001ffaa5fff]

[    2.069752]   node   1: [mem 0x00000001ffb80000-0x00000001ffb8dfff]

[    2.079484] Zeroed struct page in unavailable ranges: 29301 pages

[    2.079493] Initmem setup node 0 [mem 0x000000000e400000-0x00000001bfffffff]

[    2.082595] On node 0 totalpages: 495104

[    2.083412]   Normal zone: 4352 pages used for memmap

[    2.086090]   Normal zone: 0 pages reserved

[    2.086399]   Normal zone: 495104 pages, LIFO batch:31

[    2.285940] Initmem setup node 1 [mem 0x0000000040000000-0x00000001ffb8dfff]

[    2.286950] On node 1 totalpages: 523602

[    2.288569]   Normal zone: 4602 pages used for memmap

[    2.289678]   Normal zone: 0 pages reserved

[    2.290733]   Normal zone: 523602 pages, LIFO batch:31

[    2.508291] Booting Linux...

[    2.508948] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]

[    2.510292] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit]

[    3.120147] percpu: Embedded 11 pages/cpu s46168 r8192 d35752 u131072

[    3.127979] pcpu-alloc: s46168 r8192 d35752 u131072 alloc=1*4194304

[    3.129218] pcpu-alloc: [0] 000 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031

[    3.133990] pcpu-alloc: [0] 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058 059 060 061 062 063

[    3.141201] pcpu-alloc: [0] 072 073 074 075 076 077 078 079 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127

[    3.144190] pcpu-alloc: [1] 064 065 066 067 068 069 070 071 080 081 082 083 084 085 086 087 088 089 090 091 092 093 094 095 096 097 098 099 100 101 102 103

[    3.168560] SUN4V: Mondo queue sizes [cpu(16384) dev(16384) r(8192) nr(256)]

[    3.177939] Built 2 zonelists, mobility grouping on.  Total pages: 1009752

[    3.179125] Policy zone: Normal

[    3.179735] Kernel command line: root=/dev/sda1 ro console=ttyS1 ignore_loglevel initcall_debug

[    3.183855] printk: log_buf_len individual max cpu contribution: 4096 bytes

[    3.185060] printk: log_buf_len total cpu_extra contributions: 520192 bytes

[    3.185626] printk: log_buf_len min size: 65536 bytes

[    3.188910] printk: log_buf_len: 1048576 bytes

[    3.189312] printk: early log buf free: 60880(92%)

[    3.189682] Sorting __ex_table...

[    3.401064] Memory: 8050376K/8149648K available (5795K kernel code, 319K rwdata, 1632K rodata, 264K init, 275K bss, 99272K reserved, 0K cma-reserved)

[    3.406836] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=128, Nodes=16

[    3.414164] rcu: Hierarchical RCU implementation.

[    3.415236] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.

[    3.417403] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1

[    3.418251] SUN4V: Using IRQ API major 1, cookie only virqs disabled

[    3.429685] clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x10cc5eb20f1, max_idle_ns: 440795243037 ns

[    3.432890] clocksource: mult[dbab92] shift[24]

[    3.433992] clockevent: mult[952b4894] shift[31]

[    3.436297] Console: colour dummy device 80x25

[    3.585519] Calibrating delay using timer specific routine.. 2333.55 BogoMIPS (lpj=11667763)

[    3.586499] pid_max: default: 131072 minimum: 1024

[    3.588391] LSM: Security Framework initializing

[    3.589615] AppArmor: AppArmor initialized

[    3.600318] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)

[    3.606544] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)

[    3.608031] Mount-cache hash table entries: 16384 (order: 4, 131072 bytes)

[    3.608801] Mountpoint-cache hash table entries: 16384 (order: 4, 131072 bytes)

[    3.617855] calling  cpu_type_probe+0x0/0x3a4 @ 1

[    3.618556] initcall cpu_type_probe+0x0/0x3a4 returned 0 after 0 usecs

[    3.619157] calling  spawn_ksoftirqd+0x0/0x54 @ 1

[    3.619671] initcall spawn_ksoftirqd+0x0/0x54 returned 0 after 0 usecs

[    3.620224] calling  migration_init+0x0/0x44 @ 1

[    3.620605] initcall migration_init+0x0/0x44 returned 0 after 0 usecs

[    3.621150] calling  srcu_bootup_announce+0x0/0x3c @ 1

[    3.621553] rcu: Hierarchical SRCU implementation.

[    3.621993] initcall srcu_bootup_announce+0x0/0x3c returned 0 after 0 usecs

[    3.622570] calling  rcu_sysrq_init+0x0/0x30 @ 1

[    3.623000] initcall rcu_sysrq_init+0x0/0x30 returned 0 after 0 usecs

[    3.623825] calling  check_cpu_stall_init+0x0/0x20 @ 1

[    3.624571] initcall check_cpu_stall_init+0x0/0x20 returned 0 after 0 usecs

[    3.625328] calling  rcu_spawn_gp_kthread+0x0/0x12c @ 1

[    3.625833] initcall rcu_spawn_gp_kthread+0x0/0x12c returned 0 after 0 usecs

[    3.626344] calling  cpu_stop_init+0x0/0xcc @ 1

[    3.626835] initcall cpu_stop_init+0x0/0xcc returned 0 after 0 usecs

[    3.627288] calling  jump_label_init_module+0x0/0x14 @ 1

[    3.627674] initcall jump_label_init_module+0x0/0x14 returned 0 after 0 usecs

[    3.628189] calling  initialize_ptr_random+0x0/0x64 @ 1

[    3.628570] initcall initialize_ptr_random+0x0/0x64 returned 0 after 0 usecs

[    3.636816] smp: Bringing up secondary CPUs ...

[    3.707001] smp: Brought up 2 nodes, 64 CPUs

[    3.717741] devtmpfs: initialized

[    3.726126] calling  init_hw_perf_events+0x0/0x1d4 @ 1

[    3.727218] Performance events:

[    3.727417] Testing NMI watchdog ...

[    3.928170] OK.

[    3.928939] Supported PMU type is 'niagara2'

[    3.930309] initcall init_hw_perf_events+0x0/0x1d4 returned 0 after 195312 usecs

[    3.933547] calling  bpf_jit_charge_init+0x0/0x40 @ 1

[    3.934025] initcall bpf_jit_charge_init+0x0/0x40 returned 0 after 0 usecs

[    3.935143] calling  ipc_ns_init+0x0/0x40 @ 1

[    3.935838] random: get_random_u32 called from bucket_table_alloc.isra.27+0x58/0x160 with crng_init=0

[    3.936853] initcall ipc_ns_init+0x0/0x40 returned 0 after 9765 usecs

[    3.938018] calling  init_mmap_min_addr+0x0/0x18 @ 1

[    3.938762] initcall init_mmap_min_addr+0x0/0x18 returned 0 after 0 usecs

[    3.939610] calling  pci_realloc_setup_params+0x0/0x24 @ 1

[    3.940371] initcall pci_realloc_setup_params+0x0/0x24 returned 0 after 0 usecs

[    3.941619] calling  net_ns_init+0x0/0x138 @ 1

[    3.942609] initcall net_ns_init+0x0/0x138 returned 0 after 0 usecs

[    3.943429] calling  sparc_sysrq_init+0x0/0x38 @ 1

[    3.943867] initcall sparc_sysrq_init+0x0/0x38 returned 0 after 0 usecs

[    3.944403] calling  sstate_init+0x0/0x88 @ 1

[    3.944825] initcall sstate_init+0x0/0x88 returned 0 after 0 usecs

[    3.945267] calling  wq_sysfs_init+0x0/0x38 @ 1

[    3.945798] initcall wq_sysfs_init+0x0/0x38 returned 0 after 0 usecs

[    3.946269] calling  ksysfs_init+0x0/0x94 @ 1

[    3.946351] kworker/u257:0 (334) used greatest stack depth: 9000 bytes left

[    3.946629] initcall ksysfs_init+0x0/0x94 returned 0 after 0 usecs

[    3.947609] calling  pm_init+0x0/0x58 @ 1

[    3.948898] initcall pm_init+0x0/0x58 returned 0 after 0 usecs

[    3.949332] calling  rcu_set_runtime_mode+0x0/0x14 @ 1

[    3.949710] initcall rcu_set_runtime_mode+0x0/0x14 returned 0 after 0 usecs

[    3.950202] calling  init_jiffies_clocksource+0x0/0x1c @ 1

[    3.950680] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns

[    3.951370] initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 0 usecs

[    3.951956] calling  futex_init+0x0/0xdc @ 1

[    3.952669] futex hash table entries: 32768 (order: 8, 2097152 bytes)

[    3.961406] initcall futex_init+0x0/0xdc returned 0 after 9765 usecs

[    3.961881] calling  cgroup_wq_init+0x0/0x44 @ 1

[    3.962867] initcall cgroup_wq_init+0x0/0x44 returned 0 after 0 usecs

[    3.963330] calling  cgroup1_wq_init+0x0/0x40 @ 1

[    3.964299] initcall cgroup1_wq_init+0x0/0x40 returned 0 after 0 usecs

[    3.964766] calling  init_zero_pfn+0x0/0x44 @ 1

[    3.965101] initcall init_zero_pfn+0x0/0x44 returned 0 after 0 usecs

[    3.965554] calling  init_per_zone_wmark_min+0x0/0x98 @ 1

[    3.966076] initcall init_per_zone_wmark_min+0x0/0x98 returned 0 after 0 usecs

[    3.966584] calling  fsnotify_init+0x0/0x50 @ 1

[    3.967342] initcall fsnotify_init+0x0/0x50 returned 0 after 9765 usecs

[    3.967813] calling  filelock_init+0x0/0xb4 @ 1

[    3.968286] initcall filelock_init+0x0/0xb4 returned 0 after 0 usecs

[    3.968824] calling  init_misc_binfmt+0x0/0x34 @ 1

[    3.969185] initcall init_misc_binfmt+0x0/0x34 returned 0 after 0 usecs

[    3.969654] calling  init_script_binfmt+0x0/0x20 @ 1

[    3.970019] initcall init_script_binfmt+0x0/0x20 returned 0 after 0 usecs

[    3.970572] calling  init_elf_binfmt+0x0/0x20 @ 1

[    3.970921] initcall init_elf_binfmt+0x0/0x20 returned 0 after 0 usecs

[    3.971397] calling  init_compat_elf_binfmt+0x0/0x20 @ 1

[    3.971855] initcall init_compat_elf_binfmt+0x0/0x20 returned 0 after 0 usecs

[    3.972357] calling  debugfs_init+0x0/0x64 @ 1

[    3.972703] initcall debugfs_init+0x0/0x64 returned 0 after 0 usecs

[    3.973222] calling  securityfs_init+0x0/0x7c @ 1

[    3.973856] initcall securityfs_init+0x0/0x7c returned 0 after 0 usecs

[    3.974333] calling  prandom_init+0x0/0xe8 @ 1

[    3.974776] initcall prandom_init+0x0/0xe8 returned 0 after 0 usecs

[    3.975260] calling  component_debug_init+0x0/0x28 @ 1

[    3.975901] initcall component_debug_init+0x0/0x28 returned 0 after 0 usecs

[    3.976396] calling  sock_init+0x0/0xb4 @ 1

[    3.977547] initcall sock_init+0x0/0xb4 returned 0 after 9765 usecs

[    3.977996] calling  net_inuse_init+0x0/0x2c @ 1

[    3.978489] initcall net_inuse_init+0x0/0x2c returned 0 after 0 usecs

[    3.979030] calling  net_defaults_init+0x0/0x2c @ 1

[    3.979390] initcall net_defaults_init+0x0/0x2c returned 0 after 0 usecs

[    3.979865] calling  init_default_flow_dissectors+0x0/0x58 @ 1

[    3.980288] initcall init_default_flow_dissectors+0x0/0x58 returned 0 after 0 usecs

[    3.980908] calling  netpoll_init+0x0/0x1c @ 1

[    3.981240] initcall netpoll_init+0x0/0x1c returned 0 after 0 usecs

[    3.981687] calling  netlink_proto_init+0x0/0x15c @ 1

[    3.982169] NET: Registered protocol family 16

[    3.982627] initcall netlink_proto_init+0x0/0x15c returned 0 after 0 usecs

[    3.983186] calling  scan_of_devices+0x0/0x3c @ 1

[    4.012702] initcall scan_of_devices+0x0/0x3c returned 0 after 29296 usecs

[    4.013247] calling  irq_sysfs_init+0x0/0xb8 @ 1

[    4.015115] initcall irq_sysfs_init+0x0/0xb8 returned 0 after 0 usecs

[    4.015642] calling  audit_init+0x0/0x168 @ 1

[    4.015996] audit: initializing netlink subsys (disabled)

[    4.016753] initcall audit_init+0x0/0x168 returned 0 after 0 usecs

[    4.016759] audit: type=2000 audit(0.570:1): state=initialized audit_enabled=0 res=1

[    4.017777] calling  bdi_class_init+0x0/0x5c @ 1

[    4.018254] initcall bdi_class_init+0x0/0x5c returned 0 after 0 usecs

[    4.018728] calling  mm_sysfs_init+0x0/0x30 @ 1

[    4.019074] initcall mm_sysfs_init+0x0/0x30 returned 0 after 0 usecs

[    4.019599] calling  pcibus_class_init+0x0/0x1c @ 1

[    4.019993] initcall pcibus_class_init+0x0/0x1c returned 0 after 0 usecs

[    4.020489] calling  pci_driver_init+0x0/0x30 @ 1

[    4.021060] initcall pci_driver_init+0x0/0x30 returned 0 after 0 usecs

[    4.021527] calling  tty_class_init+0x0/0x4c @ 1

[    4.021907] initcall tty_class_init+0x0/0x4c returned 0 after 0 usecs

[    4.022438] calling  vtconsole_class_init+0x0/0xe8 @ 1

[    4.022939] initcall vtconsole_class_init+0x0/0xe8 returned 0 after 0 usecs

[    4.023446] calling  software_node_init+0x0/0x34 @ 1

[    4.023820] initcall software_node_init+0x0/0x34 returned 0 after 0 usecs

[    4.024300] calling  register_node_type+0x0/0x1c @ 1

[    4.024845] initcall register_node_type+0x0/0x1c returned 0 after 0 usecs

[    4.025339] calling  kobject_uevent_init+0x0/0x14 @ 1

[    4.025727] initcall kobject_uevent_init+0x0/0x14 returned 0 after 0 usecs

[    4.026375] calling  report_memory+0x0/0x174 @ 1

[    4.026725] initcall report_memory+0x0/0x174 returned 0 after 0 usecs

[    4.027182] calling  hugetlbpage_init+0x0/0x30 @ 1

[    4.027549] initcall hugetlbpage_init+0x0/0x30 returned 0 after 0 usecs

[    4.028114] calling  cryptomgr_init+0x0/0x14 @ 1

[    4.028465] initcall cryptomgr_init+0x0/0x14 returned 0 after 0 usecs

[    4.029062] calling  topology_init+0x0/0x110 @ 1

[    4.045311] kworker/u257:2 (607) used greatest stack depth: 8672 bytes left

[    4.054650] initcall topology_init+0x0/0x110 returned 0 after 19531 usecs

[    4.055147] calling  sbus_init+0x0/0x43c @ 1

[    4.055629] initcall sbus_init+0x0/0x43c returned 0 after 0 usecs

[    4.056065] calling  pcibios_init+0x0/0x14 @ 1

[    4.056396] initcall pcibios_init+0x0/0x14 returned 0 after 0 usecs

[    4.056914] calling  psycho_init+0x0/0x18 @ 1

[    4.058080] initcall psycho_init+0x0/0x18 returned 0 after 0 usecs

[    4.058616] calling  sabre_init+0x0/0x18 @ 1

[    4.059467] initcall sabre_init+0x0/0x18 returned 0 after 0 usecs

[    4.059977] calling  schizo_init+0x0/0x18 @ 1

[    4.060996] initcall schizo_init+0x0/0x18 returned 0 after 0 usecs

[    4.061519] calling  pci_sun4v_init+0x0/0x18 @ 1

[    4.062134] pci_sun4v: Registered hvapi major[2] minor[0]

[    4.063884] pci@400: SUN4V PCI Bus Module

[    4.064172] pci@400: On NUMA node 0

[    4.064514] pci@400: PCI IO [io  0xc0f0000000-0xc0ffffffff] offset c0f0000000

[    4.065023] pci@400: PCI MEM [mem 0xc100000000-0xc17ffeffff] offset c100000000

[    4.065524] pci@400: PCI MEM64 [mem 0xc200000000-0xc5fffeffff] offset c200000000

[    4.066126] pci@400: Unable to request IOMMU resource.

[    4.118734] pci@400: Imported 3 TSB entries from OBP

[    4.124718] pci@400: MSI Queue first[0] num[36] count[128] devino[0x18]

[    4.125186] pci@400: MSI first[0] num[256] mask[0xff] width[32]

[    4.125605] pci@400: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]

[    4.126191] pci@400: MSI queues at RA [00000001fb500000]

[    4.126579] PCI: Scanning PBM /pci@400

[    4.127133] pci_sun4v f028cf80: PCI host bridge to bus 0000:02

[    4.127563] pci_bus 0000:02: root bus resource [io  0xc0f0000000-0xc0ffffffff] (bus address [0x0000-0xfffffff])

[    4.128268] pci_bus 0000:02: root bus resource [mem 0xc100000000-0xc17ffeffff] (bus address [0x00000000-0x7ffeffff])

[    4.129079] pci_bus 0000:02: root bus resource [mem 0xc200000000-0xc5fffeffff] (bus address [0x00000000-0x3fffeffff])

[    4.129833] pci_bus 0000:02: root bus resource [bus 02-09]

[    4.130492] pci 0000:02:00.0: [10b5:8548] type 01 class 0x060400

[    4.130939] pci 0000:02:00.0: reg 0x10: [mem 0xc100100000-0xc10011ffff]

[    4.131647] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold

[    4.132838] pci 0000:03:01.0: [10b5:8548] type 01 class 0x060400

[    4.133567] pci 0000:03:01.0: PME# supported from D0 D3hot D3cold

[    4.134679] pci 0000:04:00.0: [10b5:8112] type 01 class 0x060400

[    4.135130] pci 0000:04:00.0: enabling Extended Tags

[    4.135764] pci 0000:04:00.0: supports D1

[    4.136069] pci 0000:04:00.0: PME# supported from D0 D1 D3hot

[    4.136970] pci_bus 0000:05: extended config space not accessible

[    4.137629] pci 0000:05:00.0: [1033:0035] type 00 class 0x0c0310

[    4.138064] pci 0000:05:00.0: reg 0x10: [mem 0xc100200000-0xc100201fff]

[    4.138724] pci 0000:05:00.0: supports D1 D2

[    4.139045] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot

[    4.139907] pci 0000:05:00.1: [1033:0035] type 00 class 0x0c0310

[    4.140342] pci 0000:05:00.1: reg 0x10: [mem 0xc100202000-0xc100203fff]

[    4.140913] pci 0000:05:00.1: supports D1 D2

[    4.141234] pci 0000:05:00.1: PME# supported from D0 D1 D2 D3hot

[    4.142102] pci 0000:05:00.2: [1033:00e0] type 00 class 0x0c0320

[    4.142537] pci 0000:05:00.2: reg 0x10: [mem 0xc100204000-0xc100205fff]

[    4.143108] pci 0000:05:00.2: supports D1 D2

[    4.143466] pci 0000:05:00.2: PME# supported from D0 D1 D2 D3hot

[    4.144301] pci 0000:03:08.0: [10b5:8548] type 01 class 0x060400

[    4.144955] pci 0000:03:08.0: PME# supported from D0 D3hot D3cold

[    4.146129] pci 0000:06:00.0: [1000:0058] type 00 class 0x010000

[    4.146567] pci 0000:06:00.0: reg 0x10: [io  0xc0f0000000-0xc0f00000ff]

[    4.147034] pci 0000:06:00.0: reg 0x14: [mem 0xc100300000-0xc10030ffff]

[    4.147587] pci 0000:06:00.0: reg 0x1c: [mem 0xc100310000-0xc10031ffff]

[    4.148055] pci 0000:06:00.0: reg 0x30: [mem 0xc100400000-0xc1007fffff]

[    4.148545] pci 0000:06:00.0: enabling Extended Tags

[    4.149156] pci 0000:06:00.0: supports D1 D2

[    4.149933] pci 0000:03:09.0: [10b5:8548] type 01 class 0x060400

[    4.150673] pci 0000:03:09.0: PME# supported from D0 D3hot D3cold

[    4.151791] pci 0000:07:00.0: [8086:10b9] type 00 class 0x020000

[    4.152295] pci 0000:07:00.0: reg 0x10: [mem 0xc100800000-0xc10081ffff]

[    4.152764] pci 0000:07:00.0: reg 0x14: [mem 0xc100820000-0xc10083ffff]

[    4.153245] pci 0000:07:00.0: reg 0x18: [io  0xc0f0001000-0xc0f000101f]

[    4.153786] pci 0000:07:00.0: reg 0x30: [mem 0xc100840000-0xc10085ffff]

[    4.154466] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold

[    4.155477] pci 0000:03:0c.0: [10b5:8548] type 01 class 0x060400

[    4.156131] pci 0000:03:0c.0: PME# supported from D0 D3hot D3cold

[    4.157292] pci 0000:03:0d.0: [10b5:8548] type 01 class 0x060400

[    4.157947] pci 0000:03:0d.0: PME# supported from D0 D3hot D3cold

[    4.159162] probe of f028cf80 returned 1 after 90000 usecs

[    4.159701] pci@500: SUN4V PCI Bus Module

[    4.160088] pci@500: On NUMA node 1

[    4.160346] pci@500: PCI IO [io  0xc4f0000000-0xc4ffffffff] offset c4f0000000

[    4.160855] pci@500: PCI MEM [mem 0xc500000000-0xc57ffeffff] offset c500000000

[    4.161356] pci@500: PCI MEM64 [mem 0xc600000000-0xc9fffeffff] offset c600000000

[    4.161953] pci@500: Unable to request IOMMU resource.

[    4.218076] pci@500: MSI Queue first[0] num[36] count[128] devino[0x18]

[    4.218567] pci@500: MSI first[0] num[256] mask[0xff] width[32]

[    4.218989] pci@500: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]

[    4.219507] pci@500: MSI queues at RA [00000001b6600000]

[    4.219891] PCI: Scanning PBM /pci@500

[    4.220370] pci_sun4v f0296b40: PCI host bridge to bus 0001:02

[    4.220798] pci_bus 0001:02: root bus resource [io  0xc4f0000000-0xc4ffffffff] (bus address [0x0000-0xfffffff])

[    4.221503] pci_bus 0001:02: root bus resource [mem 0xc500000000-0xc57ffeffff] (bus address [0x00000000-0x7ffeffff])

[    4.222234] pci_bus 0001:02: root bus resource [mem 0xc600000000-0xc9fffeffff] (bus address [0x00000000-0x3fffeffff])

[    4.222967] pci_bus 0001:02: root bus resource [bus 02-07]

[    4.223548] pci 0001:02:00.0: [10b5:8548] type 01 class 0x060400

[    4.223993] pci 0001:02:00.0: reg 0x10: [mem 0xc500100000-0xc50011ffff]

[    4.224748] pci 0001:02:00.0: PME# supported from D0 D3hot D3cold

[    4.225939] pci 0001:03:08.0: [10b5:8548] type 01 class 0x060400

[    4.226670] pci 0001:03:08.0: PME# supported from D0 D3hot D3cold

[    4.227851] pci 0001:04:00.0: [108e:abcd] type 00 class 0x020000

[    4.228286] pci 0001:04:00.0: reg 0x10: [mem 0xc501000000-0xc501ffffff]

[    4.228763] pci 0001:04:00.0: reg 0x18: [mem 0xc500200000-0xc500207fff]

[    4.229245] pci 0001:04:00.0: reg 0x20: [mem 0xc500208000-0xc50020ffff]

[    4.229713] pci 0001:04:00.0: reg 0x30: [mem 0xc500300000-0xc5003fffff]

[    4.230962] pci 0001:04:00.1: [108e:abcd] type 00 class 0x020000

[    4.231409] pci 0001:04:00.1: reg 0x10: [mem 0xc502000000-0xc502ffffff]

[    4.231878] pci 0001:04:00.1: reg 0x18: [mem 0xc500210000-0xc500217fff]

[    4.232345] pci 0001:04:00.1: reg 0x20: [mem 0xc500218000-0xc50021ffff]

[    4.232828] pci 0001:04:00.1: reg 0x30: [mem 0xc500400000-0xc5004fffff]

[    4.234020] pci 0001:04:00.2: [108e:abcd] type 00 class 0x020000

[    4.234454] pci 0001:04:00.2: reg 0x10: [mem 0xc503000000-0xc503ffffff]

[    4.234934] pci 0001:04:00.2: reg 0x18: [mem 0xc500220000-0xc500227fff]

[    4.235402] pci 0001:04:00.2: reg 0x20: [mem 0xc500228000-0xc50022ffff]

[    4.235870] pci 0001:04:00.2: reg 0x30: [mem 0xc500500000-0xc5005fffff]

[    4.237091] pci 0001:04:00.3: [108e:abcd] type 00 class 0x020000

[    4.237526] pci 0001:04:00.3: reg 0x10: [mem 0xc504000000-0xc504ffffff]

[    4.237994] pci 0001:04:00.3: reg 0x18: [mem 0xc500230000-0xc500237fff]

[    4.238474] pci 0001:04:00.3: reg 0x20: [mem 0xc500238000-0xc50023ffff]

[    4.238951] pci 0001:04:00.3: reg 0x30: [mem 0xc500600000-0xc5006fffff]

[    4.240149] pci 0001:03:09.0: [10b5:8548] type 01 class 0x060400

[    4.240894] pci 0001:03:09.0: PME# supported from D0 D3hot D3cold

[    4.242058] pci 0001:03:0c.0: [10b5:8548] type 01 class 0x060400

[    4.242776] pci 0001:03:0c.0: PME# supported from D0 D3hot D3cold

[    4.243938] pci 0001:03:0d.0: [10b5:8548] type 01 class 0x060400

[    4.244670] pci 0001:03:0d.0: PME# supported from D0 D3hot D3cold

[    4.245832] probe of f0296b40 returned 1 after 90000 usecs

[    4.246347] initcall pci_sun4v_init+0x0/0x18 returned 0 after 175781 usecs

[    4.280069] calling  fire_init+0x0/0x18 @ 1

[    4.282078] initcall fire_init+0x0/0x18 returned 0 after 0 usecs

[    4.284535] calling  init_vdso+0x0/0x48 @ 1

[    4.284896] initcall init_vdso+0x0/0x48 returned 0 after 0 usecs

[    4.287353] calling  uid_cache_init+0x0/0x8c @ 1

[    4.288902] initcall uid_cache_init+0x0/0x8c returned 0 after 0 usecs

[    4.290387] calling  param_sysfs_init+0x0/0x1f4 @ 1

[    4.299129] initcall param_sysfs_init+0x0/0x1f4 returned 0 after 0 usecs

[    4.299698] calling  user_namespace_sysctl_init+0x0/0x50 @ 1

[    4.300154] initcall user_namespace_sysctl_init+0x0/0x50 returned 0 after 0 usecs

[    4.300795] calling  pm_sysrq_init+0x0/0x20 @ 1

[    4.301517] initcall pm_sysrq_init+0x0/0x20 returned 0 after 0 usecs

[    4.301977] calling  crash_save_vmcoreinfo_init+0x0/0x514 @ 1

[    4.303595] initcall crash_save_vmcoreinfo_init+0x0/0x514 returned 0 after 0 usecs

[    4.306155] calling  cgroup_sysfs_init+0x0/0x1c @ 1

[    4.307539] initcall cgroup_sysfs_init+0x0/0x1c returned 0 after 0 usecs

[    4.309047] calling  cgroup_namespaces_init+0x0/0x8 @ 1

[    4.310440] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs

[    4.313970] calling  user_namespaces_init+0x0/0x30 @ 1

[    4.315532] initcall user_namespaces_init+0x0/0x30 returned 0 after 0 usecs

[    4.317029] calling  hung_task_init+0x0/0x58 @ 1

[    4.318532] initcall hung_task_init+0x0/0x58 returned 0 after 0 usecs

[    4.321039] calling  dev_map_init+0x0/0x1c @ 1

[    4.321361] initcall dev_map_init+0x0/0x1c returned 0 after 0 usecs

[    4.324837] calling  stack_map_init+0x0/0x74 @ 1

[    4.326206] initcall stack_map_init+0x0/0x74 returned 0 after 0 usecs

[    4.327668] calling  oom_init+0x0/0x3c @ 1

[    4.329130] initcall oom_init+0x0/0x3c returned 0 after 0 usecs

[    4.330562] calling  cgwb_init+0x0/0x30 @ 1

[    4.332547] initcall cgwb_init+0x0/0x30 returned 0 after 0 usecs

[    4.333985] calling  default_bdi_init+0x0/0x84 @ 1

[    4.336050] initcall default_bdi_init+0x0/0x84 returned 0 after 0 usecs

[    4.337528] calling  percpu_enable_async+0x0/0x14 @ 1

[    4.339929] initcall percpu_enable_async+0x0/0x14 returned 0 after 0 usecs

[    4.341425] calling  init_reserve_notifier+0x0/0x8 @ 1

[    4.342823] initcall init_reserve_notifier+0x0/0x8 returned 0 after 0 usecs

[    4.344328] calling  init_admin_reserve+0x0/0x40 @ 1

[    4.346708] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs

[    4.349218] calling  init_user_reserve+0x0/0x40 @ 1

[    4.350587] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs

[    4.353091] calling  swap_init_sysfs+0x0/0x6c @ 1

[    4.353506] initcall swap_init_sysfs+0x0/0x6c returned 0 after 0 usecs

[    4.357001] calling  swapfile_init+0x0/0xb0 @ 1

[    4.357328] initcall swapfile_init+0x0/0xb0 returned 0 after 0 usecs

[    4.359814] calling  hugetlb_init+0x0/0x570 @ 1

[    4.362169] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages

[    4.363658] HugeTLB registered 8.00 MiB page size, pre-allocated 0 pages

[    4.366141] HugeTLB registered 256 MiB page size, pre-allocated 0 pages

[    4.368629] HugeTLB registered 2.00 GiB page size, pre-allocated 0 pages

[    4.370547] initcall hugetlb_init+0x0/0x570 returned 0 after 0 usecs

[    4.372011] calling  mem_cgroup_swap_init+0x0/0x90 @ 1

[    4.375433] initcall mem_cgroup_swap_init+0x0/0x90 returned 0 after 0 usecs

[    4.376931] calling  mem_cgroup_init+0x0/0x1b4 @ 1

[    4.378956] initcall mem_cgroup_init+0x0/0x1b4 returned 0 after 0 usecs

[    4.380433] calling  crypto_wq_init+0x0/0x30 @ 1

[    4.382487] initcall crypto_wq_init+0x0/0x30 returned 0 after 0 usecs

[    4.385013] calling  seqiv_module_init+0x0/0x14 @ 1

[    4.386417] initcall seqiv_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.388906] calling  hmac_module_init+0x0/0x14 @ 1

[    4.390267] initcall hmac_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.391742] calling  crypto_null_mod_init+0x0/0x7c @ 1

[    4.394934] initcall crypto_null_mod_init+0x0/0x7c returned 0 after 0 usecs

[    4.396451] calling  md5_mod_init+0x0/0x14 @ 1

[    4.399165] initcall md5_mod_init+0x0/0x14 returned 0 after 0 usecs

[    4.399665] calling  sha1_generic_mod_init+0x0/0x14 @ 1

[    4.402416] initcall sha1_generic_mod_init+0x0/0x14 returned 0 after 0 usecs

[    4.403920] calling  sha256_generic_mod_init+0x0/0x18 @ 1

[    4.407018] initcall sha256_generic_mod_init+0x0/0x18 returned 0 after 0 usecs

[    4.408532] calling  crypto_ecb_module_init+0x0/0x14 @ 1

[    4.409944] initcall crypto_ecb_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.412473] calling  crypto_cbc_module_init+0x0/0x14 @ 1

[    4.414874] initcall crypto_cbc_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.416380] calling  crypto_cts_module_init+0x0/0x14 @ 1

[    4.418786] initcall crypto_cts_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.421333] calling  crypto_module_init+0x0/0x14 @ 1

[    4.422705] initcall crypto_module_init+0x0/0x14 returned 0 after 0 usecs

[    4.425196] calling  crypto_ctr_module_init+0x0/0x18 @ 1

[    4.426594] initcall crypto_ctr_module_init+0x0/0x18 returned 0 after 0 usecs

[    4.430132] calling  aes_init+0x0/0x14 @ 1

[    4.431820] initcall aes_init+0x0/0x14 returned 0 after 0 usecs

[    4.433252] calling  crc32c_mod_init+0x0/0x14 @ 1

[    4.434948] initcall crc32c_mod_init+0x0/0x14 returned 0 after 0 usecs

[    4.436418] calling  drbg_init+0x0/0xc4 @ 1

[    4.441743] initcall drbg_init+0x0/0xc4 returned 0 after 9765 usecs

[    4.442241] calling  init_bio+0x0/0xbc @ 1

[    4.443090] initcall init_bio+0x0/0xbc returned 0 after 0 usecs

[    4.443515] calling  blk_settings_init+0x0/0x30 @ 1

[    4.444879] initcall blk_settings_init+0x0/0x30 returned 0 after 0 usecs

[    4.448385] calling  blk_ioc_init+0x0/0x30 @ 1

[    4.449839] initcall blk_ioc_init+0x0/0x30 returned 0 after 0 usecs

[    4.451295] calling  blk_softirq_init+0x0/0xa4 @ 1

[    4.452696] initcall blk_softirq_init+0x0/0xa4 returned 0 after 0 usecs

[    4.455177] calling  blk_mq_init+0x0/0x30 @ 1

[    4.456512] initcall blk_mq_init+0x0/0x30 returned 0 after 0 usecs

[    4.458970] calling  genhd_device_init+0x0/0x80 @ 1

[    4.461414] initcall genhd_device_init+0x0/0x80 returned 0 after 9765 usecs

[    4.462949] calling  pci_slot_init+0x0/0x60 @ 1

[    4.465314] initcall pci_slot_init+0x0/0x60 returned 0 after 0 usecs

[    4.466776] calling  misc_init+0x0/0xd0 @ 1

[    4.468167] initcall misc_init+0x0/0xd0 returned 0 after 0 usecs

[    4.469612] calling  vga_arb_device_init+0x0/0x1a0 @ 1

[    4.471280] vgaarb: loaded

[    4.472516] initcall vga_arb_device_init+0x0/0x1a0 returned 0 after 9765 usecs

[    4.475053] calling  init_scsi+0x0/0xc8 @ 1

[    4.476842] SCSI subsystem initialized

[    4.478144] initcall init_scsi+0x0/0xc8 returned 0 after 0 usecs

[    4.479585] calling  input_init+0x0/0x108 @ 1

[    4.480972] initcall input_init+0x0/0x108 returned 0 after 0 usecs

[    4.482429] calling  rtc_init+0x0/0x54 @ 1

[    4.484792] initcall rtc_init+0x0/0x54 returned 0 after 0 usecs

[    4.486243] calling  power_supply_class_init+0x0/0x54 @ 1

[    4.488693] initcall power_supply_class_init+0x0/0x54 returned 0 after 0 usecs

[    4.491238] calling  ras_init+0x0/0x14 @ 1

[    4.492606] initcall ras_init+0x0/0x14 returned 0 after 0 usecs

[    4.495045] calling  nvmem_init+0x0/0x14 @ 1

[    4.496447] initcall nvmem_init+0x0/0x14 returned 0 after 0 usecs

[    4.497898] calling  proto_init+0x0/0x14 @ 1

[    4.499241] initcall proto_init+0x0/0x14 returned 0 after 0 usecs

[    4.501695] calling  net_dev_init+0x0/0x25c @ 1

[    4.503993] initcall net_dev_init+0x0/0x25c returned 0 after 0 usecs

[    4.517552] calling  neigh_init+0x0/0xa0 @ 1

[    4.518894] initcall neigh_init+0x0/0xa0 returned 0 after 0 usecs

[    4.520338] calling  fib_notifier_init+0x0/0x14 @ 1

[    4.521710] initcall fib_notifier_init+0x0/0x14 returned 0 after 0 usecs

[    4.525217] calling  fib_rules_init+0x0/0xc4 @ 1

[    4.526578] initcall fib_rules_init+0x0/0xc4 returned 0 after 0 usecs

[    4.528056] calling  bpf_lwt_init+0x0/0x18 @ 1

[    4.529401] initcall bpf_lwt_init+0x0/0x18 returned 0 after 0 usecs

[    4.530856] calling  pktsched_init+0x0/0x124 @ 1

[    4.532228] initcall pktsched_init+0x0/0x124 returned 0 after 0 usecs

[    4.535719] calling  tc_filter_init+0x0/0x138 @ 1

[    4.537133] initcall tc_filter_init+0x0/0x138 returned 0 after 0 usecs

[    4.538617] calling  tc_action_init+0x0/0x60 @ 1

[    4.539976] initcall tc_action_init+0x0/0x60 returned 0 after 0 usecs

[    4.541447] calling  genl_init+0x0/0x48 @ 1

[    4.542796] initcall genl_init+0x0/0x48 returned 0 after 0 usecs

[    4.544235] calling  watchdog_init+0x0/0xa4 @ 1

[    4.546790] initcall watchdog_init+0x0/0xa4 returned 0 after 0 usecs

[    4.548344] calling  clock_init+0x0/0x78 @ 1

[    4.549794] initcall clock_init+0x0/0x78 returned 0 after 0 usecs

[    4.552264] calling  sunfire_init+0x0/0x30 @ 1

[    4.553267] initcall sunfire_init+0x0/0x30 returned 0 after 0 usecs

[    4.554761] calling  auxio_init+0x0/0x18 @ 1

[    4.557314] initcall auxio_init+0x0/0x18 returned 0 after 0 usecs

[    4.557819] calling  clocksource_done_booting+0x0/0x48 @ 1

[    4.561171] clocksource: Switched to clocksource stick

[    4.561560] initcall clocksource_done_booting+0x0/0x48 returned 0 after 830 usecs

[    4.564109] calling  bpf_init+0x0/0x50 @ 1

[    4.564420] initcall bpf_init+0x0/0x50 returned 0 after 15 usecs

[    4.567890] calling  init_pipe_fs+0x0/0x4c @ 1

[    4.569479] initcall init_pipe_fs+0x0/0x4c returned 0 after 238 usecs

[    4.570975] calling  cgroup_writeback_init+0x0/0x30 @ 1

[    4.572936] initcall cgroup_writeback_init+0x0/0x30 returned 0 after 545 usecs

[    4.573446] calling  inotify_user_setup+0x0/0x50 @ 1

[    4.575843] initcall inotify_user_setup+0x0/0x50 returned 0 after 16 usecs

[    4.578357] calling  eventpoll_init+0x0/0x94 @ 1

[    4.579850] initcall eventpoll_init+0x0/0x94 returned 0 after 138 usecs

[    4.581359] calling  anon_inode_init+0x0/0x60 @ 1

[    4.582924] initcall anon_inode_init+0x0/0x60 returned 0 after 192 usecs

[    4.586434] calling  proc_locks_init+0x0/0x30 @ 1

[    4.587797] initcall proc_locks_init+0x0/0x30 returned 0 after 5 usecs

[    4.589269] calling  proc_cmdline_init+0x0/0x30 @ 1

[    4.591672] initcall proc_cmdline_init+0x0/0x30 returned 0 after 5 usecs

[    4.593172] calling  proc_consoles_init+0x0/0x30 @ 1

[    4.594552] initcall proc_consoles_init+0x0/0x30 returned 0 after 5 usecs

[    4.598066] calling  proc_cpuinfo_init+0x0/0x28 @ 1

[    4.599440] initcall proc_cpuinfo_init+0x0/0x28 returned 0 after 5 usecs

[    4.600945] calling  proc_devices_init+0x0/0x30 @ 1

[    4.602334] initcall proc_devices_init+0x0/0x30 returned 0 after 5 usecs

[    4.603817] calling  proc_interrupts_init+0x0/0x30 @ 1

[    4.606215] initcall proc_interrupts_init+0x0/0x30 returned 0 after 5 usecs

[    4.608733] calling  proc_loadavg_init+0x0/0x30 @ 1

[    4.610107] initcall proc_loadavg_init+0x0/0x30 returned 0 after 5 usecs

[    4.611610] calling  proc_meminfo_init+0x0/0x30 @ 1

[    4.614002] initcall proc_meminfo_init+0x0/0x30 returned 0 after 5 usecs

[    4.616505] calling  proc_stat_init+0x0/0x28 @ 1

[    4.617861] initcall proc_stat_init+0x0/0x28 returned 0 after 5 usecs

[    4.619346] calling  proc_uptime_init+0x0/0x30 @ 1

[    4.621742] initcall proc_uptime_init+0x0/0x30 returned 0 after 5 usecs

[    4.623238] calling  proc_version_init+0x0/0x30 @ 1

[    4.624613] initcall proc_version_init+0x0/0x30 returned 0 after 5 usecs

[    4.628121] calling  proc_softirqs_init+0x0/0x30 @ 1

[    4.629500] initcall proc_softirqs_init+0x0/0x30 returned 0 after 4 usecs

[    4.631009] calling  proc_kcore_init+0x0/0xc8 @ 1

[    4.632436] initcall proc_kcore_init+0x0/0xc8 returned 0 after 18 usecs

[    4.633964] calling  proc_kmsg_init+0x0/0x28 @ 1

[    4.636328] initcall proc_kmsg_init+0x0/0x28 returned 0 after 5 usecs

[    4.639820] calling  proc_page_init+0x0/0x64 @ 1

[    4.641206] initcall proc_page_init+0x0/0x64 returned 0 after 11 usecs

[    4.642702] calling  init_ramfs_fs+0x0/0x34 @ 1

[    4.644106] initcall init_ramfs_fs+0x0/0x34 returned 0 after 0 usecs

[    4.646574] calling  init_hugetlbfs_fs+0x0/0x130 @ 1

[    4.648933] initcall init_hugetlbfs_fs+0x0/0x130 returned 0 after 958 usecs

[    4.651520] calling  aa_create_aafs+0x0/0x370 @ 1

[    4.653782] AppArmor: AppArmor Filesystem Enabled

[    4.654120] initcall aa_create_aafs+0x0/0x370 returned 0 after 1196 usecs

[    4.656669] calling  blk_scsi_ioctl_init+0x0/0xd4 @ 1

[    4.658046] initcall blk_scsi_ioctl_init+0x0/0xd4 returned 0 after 1 usecs

[    4.660543] calling  chr_dev_init+0x0/0xd4 @ 1

[    4.675423] initcall chr_dev_init+0x0/0xd4 returned 0 after 13190 usecs

[    4.675946] calling  firmware_class_init+0x0/0x48 @ 1

[    4.676396] initcall firmware_class_init+0x0/0x48 returned 0 after 75 usecs

[    4.676947] calling  sysctl_core_init+0x0/0x2c @ 1

[    4.677381] initcall sysctl_core_init+0x0/0x2c returned 0 after 75 usecs

[    4.677858] calling  eth_offload_init+0x0/0x1c @ 1

[    4.678235] initcall eth_offload_init+0x0/0x1c returned 0 after 1 usecs

[    4.678717] calling  inet_init+0x0/0x308 @ 1

[    4.679786] NET: Registered protocol family 2

[    4.683025] tcp_listen_portaddr_hash hash table entries: 4096 (order: 3, 65536 bytes)

[    4.684115] TCP established hash table entries: 65536 (order: 6, 524288 bytes)

[    4.688034] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)

[    4.692887] TCP: Hash tables configured (established 65536 bind 65536)

[    4.694751] UDP hash table entries: 4096 (order: 4, 131072 bytes)

[    4.695860] UDP-Lite hash table entries: 4096 (order: 4, 131072 bytes)

[    4.737372] initcall inet_init+0x0/0x308 returned 0 after 56936 usecs

[    4.737835] calling  ipv4_offload_init+0x0/0x90 @ 1

[    4.738248] initcall ipv4_offload_init+0x0/0x90 returned 0 after 2 usecs

[    4.739737] calling  af_unix_init+0x0/0x5c @ 1

[    4.741202] NET: Registered protocol family 1

[    4.741537] initcall af_unix_init+0x0/0x5c returned 0 after 433 usecs

[    4.745027] calling  ipv6_offload_init+0x0/0x98 @ 1

[    4.746394] initcall ipv6_offload_init+0x0/0x98 returned 0 after 2 usecs

[    4.747872] calling  vlan_offload_init+0x0/0x28 @ 1

[    4.749236] initcall vlan_offload_init+0x0/0x28 returned 0 after 1 usecs

[    4.750713] calling  xsk_init+0x0/0x6c @ 1

[    4.752041] NET: Registered protocol family 44

[    4.753382] initcall xsk_init+0x0/0x6c returned 0 after 1304 usecs

[    4.755900] calling  pci_apply_final_quirks+0x0/0x160 @ 1

[    4.758397] pci 0000:05:00.0: calling  quirk_usb_early_handoff+0x0/0x7c0 @ 1

[    4.760029] pci 0000:05:00.0: quirk_usb_early_handoff+0x0/0x7c0 took 120 usecs

[    4.762609] pci 0000:05:00.1: calling  quirk_usb_early_handoff+0x0/0x7c0 @ 1

[    4.764168] pci 0000:05:00.1: quirk_usb_early_handoff+0x0/0x7c0 took 47 usecs

[    4.764749] pci 0000:05:00.2: calling  quirk_usb_early_handoff+0x0/0x7c0 @ 1

[    4.767285] pci 0000:05:00.2: enabling device (0000 -> 0002)

[    4.769012] pci 0000:05:00.2: quirk_usb_early_handoff+0x0/0x7c0 took 1694 usecs

[    4.770584] pci 0000:06:00.0: CLS mismatch (64 != 512), using 64 bytes

[    4.771166] pci 0000:07:00.0: calling  quirk_e100_interrupt+0x0/0x200 @ 1

[    4.772664] pci 0000:07:00.0: quirk_e100_interrupt+0x0/0x200 took 0 usecs

[    4.776340] initcall pci_apply_final_quirks+0x0/0x160 returned 0 after 17607 usecs

[    4.777876] calling  default_rootfs+0x0/0x88 @ 1

[    4.779378] initcall default_rootfs+0x0/0x88 returned 0 after 150 usecs

[    4.781989] calling  power_driver_init+0x0/0x18 @ 1

[    4.783858] initcall power_driver_init+0x0/0x18 returned 0 after 488 usecs

[    4.785350] calling  mdesc_misc_init+0x0/0x14 @ 1

[    4.786876] initcall mdesc_misc_init+0x0/0x14 returned 0 after 167 usecs

[    4.788359] calling  of_pci_slot_init+0x0/0x150 @ 1

[    4.790032] initcall of_pci_slot_init+0x0/0x150 returned 0 after 300 usecs

[    4.792695] calling  audit_classes_init+0x0/0xb0 @ 1

[    4.794083] initcall audit_classes_init+0x0/0xb0 returned 0 after 14 usecs

[    4.795575] calling  proc_execdomains_init+0x0/0x30 @ 1

[    4.796972] initcall proc_execdomains_init+0x0/0x30 returned 0 after 8 usecs

[    4.799534] calling  register_warn_debugfs+0x0/0x30 @ 1

[    4.800959] initcall register_warn_debugfs+0x0/0x30 returned 0 after 17 usecs

[    4.803476] calling  ioresources_init+0x0/0x5c @ 1

[    4.804845] initcall ioresources_init+0x0/0x5c returned 0 after 9 usecs

[    4.807343] calling  timekeeping_init_ops+0x0/0x1c @ 1

[    4.807771] initcall timekeeping_init_ops+0x0/0x1c returned 0 after 1 usecs

[    4.809269] calling  init_clocksource_sysfs+0x0/0x34 @ 1

[    4.810897] initcall init_clocksource_sysfs+0x0/0x34 returned 0 after 226 usecs

[    4.812433] calling  init_timer_list_procfs+0x0/0x38 @ 1

[    4.813835] initcall init_timer_list_procfs+0x0/0x38 returned 0 after 6 usecs

[    4.816351] calling  alarmtimer_init+0x0/0xf4 @ 1

[    4.817995] probe of alarmtimer returned 1 after 43 usecs

[    4.820412] initcall alarmtimer_init+0x0/0xf4 returned 0 after 2639 usecs

[    4.822939] calling  init_posix_timers+0x0/0x30 @ 1

[    4.824475] initcall init_posix_timers+0x0/0x30 returned 0 after 136 usecs

[    4.826977] calling  clockevents_init_sysfs+0x0/0xd8 @ 1

[    4.839188] initcall clockevents_init_sysfs+0x0/0xd8 returned 0 after 10548 usecs

[    4.839788] calling  proc_modules_init+0x0/0x28 @ 1

[    4.840174] initcall proc_modules_init+0x0/0x28 returned 0 after 10 usecs

[    4.840656] calling  modules_wq_init+0x0/0x40 @ 1

[    4.841035] initcall modules_wq_init+0x0/0x40 returned 0 after 0 usecs

[    4.841557] calling  kallsyms_init+0x0/0x28 @ 1

[    4.841901] initcall kallsyms_init+0x0/0x28 returned 0 after 5 usecs

[    4.843371] calling  pid_namespaces_init+0x0/0x30 @ 1

[    4.845798] initcall pid_namespaces_init+0x0/0x30 returned 0 after 46 usecs

[    4.847293] calling  audit_watch_init+0x0/0x3c @ 1

[    4.848653] initcall audit_watch_init+0x0/0x3c returned 0 after 1 usecs

[    4.850124] calling  audit_fsnotify_init+0x0/0x3c @ 1

[    4.851519] initcall audit_fsnotify_init+0x0/0x3c returned 0 after 1 usecs

[    4.855069] calling  audit_tree_init+0x0/0x7c @ 1

[    4.856442] initcall audit_tree_init+0x0/0x7c returned 0 after 19 usecs

[    4.857915] calling  seccomp_sysctl_init+0x0/0x30 @ 1

[    4.859312] initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 22 usecs

[    4.862852] calling  utsname_sysctl_init+0x0/0x1c @ 1

[    4.863292] initcall utsname_sysctl_init+0x0/0x1c returned 0 after 19 usecs

[    4.865795] calling  perf_event_sysfs_init+0x0/0xc4 @ 1

[    4.867392] initcall perf_event_sysfs_init+0x0/0xc4 returned 0 after 205 usecs

[    4.869925] calling  kswapd_init+0x0/0xac @ 1

[    4.872569] initcall kswapd_init+0x0/0xac returned 0 after 281 usecs

[    4.873053] calling  mm_compute_batch_init+0x0/0x5c @ 1

[    4.875447] initcall mm_compute_batch_init+0x0/0x5c returned 0 after 0 usecs

[    4.876948] calling  slab_proc_init+0x0/0x28 @ 1

[    4.878301] initcall slab_proc_init+0x0/0x28 returned 0 after 6 usecs

[    4.880784] calling  workingset_init+0x0/0xb8 @ 1

[    4.882174] workingset: timestamp_bits=42 max_order=20 bucket_order=0

[    4.884668] initcall workingset_init+0x0/0xb8 returned 0 after 2429 usecs

[    4.886154] calling  proc_vmalloc_init+0x0/0x3c @ 1

[    4.887525] initcall proc_vmalloc_init+0x0/0x3c returned 0 after 6 usecs

[    4.891056] calling  procswaps_init+0x0/0x28 @ 1

[    4.891455] initcall procswaps_init+0x0/0x28 returned 0 after 5 usecs

[    4.893926] calling  slab_sysfs_init+0x0/0x120 @ 1

[    4.909033] initcall slab_sysfs_init+0x0/0x120 returned 0 after 13410 usecs

[    4.909545] calling  fcntl_init+0x0/0x30 @ 1

[    4.909884] initcall fcntl_init+0x0/0x30 returned 0 after 17 usecs

[    4.910375] calling  proc_filesystems_init+0x0/0x30 @ 1

[    4.910779] initcall proc_filesystems_init+0x0/0x30 returned 0 after 9 usecs

[    4.911306] calling  start_dirtytime_writeback+0x0/0x48 @ 1

[    4.911716] initcall start_dirtytime_writeback+0x0/0x48 returned 0 after 3 usecs

[    4.912296] calling  blkdev_init+0x0/0x20 @ 1

[    4.912671] initcall blkdev_init+0x0/0x20 returned 0 after 46 usecs

[    4.913120] calling  dio_init+0x0/0x30 @ 1

[    4.913804] initcall dio_init+0x0/0x30 returned 0 after 328 usecs

[    4.915250] calling  dnotify_init+0x0/0x7c @ 1

[    4.916893] initcall dnotify_init+0x0/0x7c returned 0 after 295 usecs

[    4.918362] calling  fanotify_user_setup+0x0/0x58 @ 1

[    4.920006] initcall fanotify_user_setup+0x0/0x58 returned 0 after 258 usecs

[    4.922593] calling  userfaultfd_init+0x0/0x38 @ 1

[    4.925221] initcall userfaultfd_init+0x0/0x38 returned 0 after 250 usecs

[    4.926710] calling  aio_setup+0x0/0x80 @ 1

[    4.928363] initcall aio_setup+0x0/0x80 returned 0 after 321 usecs

[    4.929814] calling  io_uring_init+0x0/0x30 @ 1

[    4.931201] initcall io_uring_init+0x0/0x30 returned 0 after 21 usecs

[    4.932668] calling  fscrypt_init+0x0/0xac @ 1

[    4.935157] initcall fscrypt_init+0x0/0xac returned 0 after 1119 usecs

[    4.937649] calling  init_sys32_ioctl+0x0/0x30 @ 1

[    4.939250] initcall init_sys32_ioctl+0x0/0x30 returned 0 after 233 usecs

[    4.940737] calling  mbcache_init+0x0/0x38 @ 1

[    4.942422] initcall mbcache_init+0x0/0x38 returned 0 after 249 usecs

[    4.943890] calling  init_devpts_fs+0x0/0x30 @ 1

[    4.945272] initcall init_devpts_fs+0x0/0x30 returned 0 after 29 usecs

[    4.947764] calling  ext4_init_fs+0x0/0x210 @ 1

[    4.949464] initcall ext4_init_fs+0x0/0x210 returned 0 after 1339 usecs

[    4.950981] calling  journal_init+0x0/0x164 @ 1

[    4.954138] initcall journal_init+0x0/0x164 returned 0 after 782 usecs

[    4.954605] calling  init_autofs_fs+0x0/0x34 @ 1

[    4.957163] initcall init_autofs_fs+0x0/0x34 returned 0 after 193 usecs

[    4.958643] calling  fuse_init+0x0/0x1e0 @ 1

[    4.959964] fuse: init (API version 7.31)

[    4.961941] initcall fuse_init+0x0/0x1e0 returned 0 after 1919 usecs

[    4.963404] calling  cuse_init+0x0/0xb8 @ 1

[    4.964924] initcall cuse_init+0x0/0xb8 returned 0 after 189 usecs

[    4.967394] calling  ipc_init+0x0/0x38 @ 1

[    4.967722] initcall ipc_init+0x0/0x38 returned 0 after 27 usecs

[    4.971212] calling  ipc_sysctl_init+0x0/0x1c @ 1

[    4.972599] initcall ipc_sysctl_init+0x0/0x1c returned 0 after 25 usecs

[    4.974077] calling  init_mqueue_fs+0x0/0xdc @ 1

[    4.976015] initcall init_mqueue_fs+0x0/0xdc returned 0 after 569 usecs

[    4.977489] calling  key_proc_init+0x0/0x74 @ 1

[    4.978839] initcall key_proc_init+0x0/0x74 returned 0 after 9 usecs

[    4.980296] calling  crypto_algapi_init+0x0/0x14 @ 1

[    4.981691] initcall crypto_algapi_init+0x0/0x14 returned 0 after 5 usecs

[    4.985204] calling  jent_mod_init+0x0/0x3c @ 1

[    4.989513] initcall jent_mod_init+0x0/0x3c returned 0 after 2895 usecs

[    4.989982] calling  proc_genhd_init+0x0/0x58 @ 1

[    4.990337] initcall proc_genhd_init+0x0/0x58 returned 0 after 8 usecs

[    4.991829] calling  bsg_init+0x0/0x114 @ 1

[    4.993188] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)

[    5.046079] initcall bsg_init+0x0/0x114 returned 0 after 51667 usecs

[    5.048544] calling  iolatency_init+0x0/0x14 @ 1

[    5.049906] initcall iolatency_init+0x0/0x14 returned 0 after 14 usecs

[    5.051394] calling  btree_module_init+0x0/0x30 @ 1

[    5.052784] initcall btree_module_init+0x0/0x30 returned 0 after 22 usecs

[    5.056296] calling  percpu_counter_startup+0x0/0x88 @ 1

[    5.060195] initcall percpu_counter_startup+0x0/0x88 returned 0 after 2445 usecs

[    5.060763] calling  sg_pool_init+0x0/0xe0 @ 1

[    5.061524] initcall sg_pool_init+0x0/0xe0 returned 0 after 396 usecs

[    5.064009] calling  pci_proc_init+0x0/0x88 @ 1

[    5.065546] initcall pci_proc_init+0x0/0x88 returned 0 after 190 usecs

[    5.068022] calling  pcie_portdrv_init+0x0/0x4c @ 1

[    5.070046] probe of 0000:02:00.0 returned 0 after 449 usecs

[    5.071903] probe of 0000:03:01.0 returned 0 after 416 usecs

[    5.072375] probe of 0000:04:00.0 returned 0 after 60 usecs

[    5.075141] probe of 0000:03:08.0 returned 0 after 343 usecs

[    5.078923] probe of 0000:03:09.0 returned 0 after 337 usecs

[    5.079699] probe of 0000:03:0c.0 returned 0 after 336 usecs

[    5.082565] probe of 0000:03:0d.0 returned 0 after 420 usecs

[    5.083561] probe of 0001:02:00.0 returned 0 after 582 usecs

[    5.085364] probe of 0001:03:08.0 returned 0 after 384 usecs

[    5.087148] probe of 0001:03:09.0 returned 0 after 362 usecs

[    5.089949] probe of 0001:03:0c.0 returned 0 after 363 usecs

[    5.091752] probe of 0001:03:0d.0 returned 0 after 361 usecs

[    5.093230] initcall pcie_portdrv_init+0x0/0x4c returned 0 after 23274 usecs

[    5.094733] calling  n_null_init+0x0/0x38 @ 1

[    5.096065] initcall n_null_init+0x0/0x38 returned 0 after 1 usecs

[    5.098516] calling  pty_init+0x0/0x210 @ 1

[    5.100009] initcall pty_init+0x0/0x210 returned 0 after 168 usecs

[    5.102501] calling  sysrq_init+0x0/0x68 @ 1

[    5.102826] initcall sysrq_init+0x0/0x68 returned 0 after 15 usecs

[    5.106298] calling  suncore_init+0x0/0x8 @ 1

[    5.108635] initcall suncore_init+0x0/0x8 returned 0 after 0 usecs

[    5.110080] calling  sunhv_init+0x0/0x30 @ 1

[    5.111711] f0286ce8: ttyS0 at I/O 0x0 (irq = 33, base_baud = 115200) is a SUN4V HCONS

[    5.113579] probe of f0286ce8 returned 1 after 1928 usecs

[    5.115811] initcall sunhv_init+0x0/0x30 returned 0 after 4282 usecs

[    5.118309] calling  sunsu_init+0x0/0x1d4 @ 1

[    5.121149] f02a1874: ttyS1 at MMIO 0xfff0ca0000 (irq = 46, base_baud = 115387) is a 16550A

[    5.121776] Console: ttyS2 (SU)

[    5.123336] probe of f02a1874 returned 1 after 2595 usecs

[    5.125809] initcall sunsu_init+0x0/0x1d4 returned 0 after 6020 usecs

[    5.127274] calling  sunsab_init+0x0/0x114 @ 1

[    5.129132] initcall sunsab_init+0x0/0x114 returned 0 after 506 usecs

[    5.131647] calling  topology_sysfs_init+0x0/0x40 @ 1

[    5.134665] initcall topology_sysfs_init+0x0/0x40 returned 0 after 1595 usecs

[    5.136176] calling  cacheinfo_sysfs_init+0x0/0x30 @ 1

[    5.137592] initcall cacheinfo_sysfs_init+0x0/0x30 returned -2 after 31 usecs

[    5.140120] calling  loop_init+0x0/0x144 @ 1

[    5.166536] loop: module loaded

[    5.166800] initcall loop_init+0x0/0x144 returned 0 after 23726 usecs

[    5.167307] calling  sas_transport_init+0x0/0xd0 @ 1

[    5.167887] initcall sas_transport_init+0x0/0xd0 returned 0 after 196 usecs

[    5.168386] calling  init_sd+0x0/0x1d4 @ 1

[    5.168886] initcall init_sd+0x0/0x1d4 returned 0 after 183 usecs

[    5.169371] calling  net_olddevs_init+0x0/0x80 @ 1

[    5.169741] initcall net_olddevs_init+0x0/0x80 returned 0 after 16 usecs

[    5.170213] calling  niu_init+0x0/0x88 @ 1

[    5.171208] niu: niu.c:v1.1 (Apr 22, 2010)

[    5.178855] niu: niu0: Found PHY 002063b0 type MII at phy_port 26

[    5.179638] niu: niu0: Found PHY 002063b0 type MII at phy_port 27

[    5.180426] niu: niu0: Found PHY 002063b0 type MII at phy_port 28

[    5.181245] niu: niu0: Found PHY 002063b0 type MII at phy_port 29

[    5.182395] niu: niu0: Port 0 [4 RX chans] [6 TX chans]

[    5.182816] niu: niu0: Port 1 [4 RX chans] [6 TX chans]

[    5.183190] niu: niu0: Port 2 [4 RX chans] [6 TX chans]

[    5.183563] niu: niu0: Port 3 [4 RX chans] [6 TX chans]

[    5.183937] niu: niu0: Port 0 RDC tbl(0) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]

[    5.184509] niu: niu0: Port 0 RDC tbl(1) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]

[    5.185021] niu: niu0: Port 1 RDC tbl(2) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]

[    5.185545] niu: niu0: Port 1 RDC tbl(3) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]

[    5.186105] niu: niu0: Port 2 RDC tbl(4) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]

[    5.188687] niu: niu0: Port 2 RDC tbl(5) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]

[    5.190251] niu: niu0: Port 3 RDC tbl(6) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]

[    5.193904] niu: niu0: Port 3 RDC tbl(7) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]

[    5.436535] niu: eth0: NIU Ethernet 00:21:28:05:3a:a4

[    5.436920] niu: eth0: Port type[XMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    5.437502] probe of 0001:04:00.0 returned 1 after 266248 usecs

[    5.656963] niu: eth1: NIU Ethernet 00:21:28:05:3a:a5

[    5.658046] niu: eth1: Port type[XMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    5.659373] probe of 0001:04:00.1 returned 1 after 221356 usecs

[    5.886315] niu: eth2: NIU Ethernet 00:21:28:05:3a:a6

[    5.887032] niu: eth2: Port type[BMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    5.888292] probe of 0001:04:00.2 returned 1 after 227730 usecs

[    6.116455] niu: eth3: NIU Ethernet 00:21:28:05:3a:a7

[    6.117969] niu: eth3: Port type[BMAC] mode[1G:COPPER] XCVR[MII] phy[mif]

[    6.119242] probe of 0001:04:00.3 returned 1 after 229777 usecs

[    6.120535] initcall niu_init+0x0/0x88 returned 0 after 927409 usecs

[    6.124189] calling  fusion_init+0x0/0x114 @ 1

[    6.125777] Fusion MPT base driver 3.04.20

[    6.128458] Copyright (c) 1999-2008 LSI Corporation

[    6.129288] initcall fusion_init+0x0/0x114 returned 0 after 3418 usecs

[    6.129763] calling  mptsas_init+0x0/0x130 @ 1

[    6.130086] Fusion MPT SAS Host driver 3.04.20

[    6.132487] mptbase: ioc0: Initiating bringup

[    8.382125] ioc0: LSISAS1068E B2: Capabilities={Initiator}

[   27.952851] scsi host0: ioc0: LSISAS1068E B2, FwRev=01170400h, Ports=1, MaxQ=286, IRQ=36

[   27.998502] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 0, phy 0, sas_addr 0x5000cca00076eb05

[   28.007327] scsi 0:0:0:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   28.012687] probe of 0:0:0:0 returned 1 after 408 usecs

[   28.015544] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 1, phy 1, sas_addr 0x5000cca00076ebf9

[   28.016263] sd 0:0:0:0: [sda] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   28.018277] sd 0:0:0:0: [sda] Write Protect is off

[   28.018636] sd 0:0:0:0: [sda] Mode Sense: eb 00 10 08

[   28.020426] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA

[   28.024872] scsi 0:0:1:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   28.029116]  sda: sda1 sda2 sda3

[   28.030166] probe of 0:0:1:0 returned 1 after 540 usecs

[   28.033360] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 2, phy 2, sas_addr 0x5000cca0009006c5

[   28.034453] sd 0:0:1:0: [sdb] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   28.036513] sd 0:0:1:0: [sdb] Write Protect is off

[   28.036879] sd 0:0:1:0: [sdb] Mode Sense: eb 00 10 08

[   28.038303] sd 0:0:0:0: [sda] Attached SCSI disk

[   28.038670] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA

[   28.042532] scsi 0:0:2:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   28.047157] probe of 0:0:2:0 returned 1 after 412 usecs

[   28.049682] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 3, phy 3, sas_addr 0x5000cca000936c6d

[   28.050404] sd 0:0:2:0: [sdc] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   28.052409] sd 0:0:2:0: [sdc] Write Protect is off

[   28.052766] sd 0:0:2:0: [sdc] Mode Sense: eb 00 10 08

[   28.054573] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA

[   28.058454] scsi 0:0:3:0: Direct-Access     HITACHI  H101414SCSUN146G SA25 PQ: 0 ANSI: 5

[   28.063213] probe of 0:0:3:0 returned 1 after 393 usecs

[   28.066598] probe of 0000:06:00.0 returned 1 after 21928143 usecs

[   28.066888] sd 0:0:3:0: [sdd] 286739329 512-byte logical blocks: (147 GB/137 GiB)

[   28.067895] initcall mptsas_init+0x0/0x130 returned 0 after 21415842 usecs

[   28.069992] calling  bq4802_driver_init+0x0/0x18 @ 1

[   28.070411] sd 0:0:3:0: [sdd] Write Protect is off

[   28.071007] initcall bq4802_driver_init+0x0/0x18 returned 0 after 294 usecs

[   28.071513] sd 0:0:3:0: [sdd] Mode Sense: eb 00 10 08

[   28.072076] calling  cmos_init+0x0/0x4c @ 1

[   28.073847] initcall cmos_init+0x0/0x4c returned -19 after 735 usecs

[   28.074171] sd 0:0:3:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA

[   28.074312] calling  m48t59_rtc_driver_init+0x0/0x18 @ 1

[   28.075423] initcall m48t59_rtc_driver_init+0x0/0x18 returned 0 after 130 usecs

[   28.075939] calling  starfire_rtc_driver_init+0x0/0x20 @ 1

[   28.076520] initcall starfire_rtc_driver_init+0x0/0x20 returned -19 after 164 usecs

[   28.077067] calling  sun4v_rtc_driver_init+0x0/0x20 @ 1

[   28.077778] sd 0:0:2:0: [sdc] Attached SCSI disk

[   28.077879] rtc-sun4v rtc-sun4v: registered as rtc0

[   28.078509] probe of rtc-sun4v returned 1 after 957 usecs

[   28.078952] initcall sun4v_rtc_driver_init+0x0/0x20 returned 0 after 1456 usecs

[   28.079528] calling  hid_init+0x0/0x84 @ 1

[   28.079985] hidraw: raw HID events driver (C) Jiri Kosina

[   28.080487] initcall hid_init+0x0/0x84 returned 0 after 629 usecs

[   28.080685] sd 0:0:1:0: [sdb] Attached SCSI disk

[   28.080928] calling  sock_diag_init+0x0/0x44 @ 1

[   28.082476] initcall sock_diag_init+0x0/0x44 returned 0 after 863 usecs

[   28.083060] calling  blackhole_init+0x0/0x14 @ 1

[   28.083480] initcall blackhole_init+0x0/0x14 returned 0 after 3 usecs

[   28.083976] calling  gre_offload_init+0x0/0x4c @ 1

[   28.084370] initcall gre_offload_init+0x0/0x4c returned 0 after 1 usecs

[   28.084926] calling  bpfilter_sockopt_init+0x0/0x4c @ 1

[   28.085346] initcall bpfilter_sockopt_init+0x0/0x4c returned 0 after 0 usecs

[   28.085916] calling  sysctl_ipv4_init+0x0/0x58 @ 1

[   28.086515] initcall sysctl_ipv4_init+0x0/0x58 returned 0 after 200 usecs

[   28.087083] calling  inet_diag_init+0x0/0x8c @ 1

[   28.087513] initcall inet_diag_init+0x0/0x8c returned 0 after 4 usecs

[   28.088010] calling  tcp_diag_init+0x0/0x14 @ 1

[   28.088386] initcall tcp_diag_init+0x0/0x14 returned 0 after 1 usecs

[   28.088876] calling  cubictcp_register+0x0/0x8c @ 1

[   28.089300] initcall cubictcp_register+0x0/0x8c returned 0 after 3 usecs

[   28.089899] calling  inet6_init+0x0/0x450 @ 1

[   28.092435] NET: Registered protocol family 10

[   28.093150] sd 0:0:3:0: [sdd] Attached SCSI disk

[   28.102855] Segment Routing with IPv6

[   28.103564] initcall inet6_init+0x0/0x450 returned 0 after 13033 usecs

[   28.106812] calling  packet_init+0x0/0x8c @ 1

[   28.108000] NET: Registered protocol family 17

[   28.108413] initcall packet_init+0x0/0x8c returned 0 after 398 usecs

[   28.109606] calling  xsk_diag_init+0x0/0x14 @ 1

[   28.109932] initcall xsk_diag_init+0x0/0x14 returned 0 after 0 usecs

[   28.111191] calling  sstate_running+0x0/0x2c @ 1

[   28.111952] initcall sstate_running+0x0/0x2c returned 0 after 63 usecs

[   28.112434] calling  init_oops_id+0x0/0x40 @ 1

[   28.113098] initcall init_oops_id+0x0/0x40 returned 0 after 5 usecs

[   28.113894] calling  pm_qos_power_init+0x0/0xb0 @ 1

[   28.115631] initcall pm_qos_power_init+0x0/0xb0 returned 0 after 663 usecs

[   28.116475] calling  printk_late_init+0x0/0x1d4 @ 1

[   28.117181] initcall printk_late_init+0x0/0x1d4 returned 0 after 4 usecs

[   28.118361] calling  tk_debug_sleep_time_init+0x0/0x30 @ 1

[   28.119125] initcall tk_debug_sleep_time_init+0x0/0x30 returned 0 after 11 usecs

[   28.120761] calling  taskstats_init+0x0/0x40 @ 1

[   28.121832] registered taskstats version 1

[   28.122129] initcall taskstats_init+0x0/0x40 returned 0 after 300 usecs

[   28.122943] calling  fault_around_debugfs+0x0/0x30 @ 1

[   28.123823] initcall fault_around_debugfs+0x0/0x30 returned 0 after 12 usecs

[   28.124669] calling  set_hardened_usercopy+0x0/0x28 @ 1

[   28.125397] initcall set_hardened_usercopy+0x0/0x28 returned 1 after 0 usecs

[   28.126236] calling  init_root_keyring+0x0/0xc @ 1

[   28.126996] initcall init_root_keyring+0x0/0xc returned 0 after 56 usecs

[   28.128120] calling  init_profile_hash+0x0/0xa4 @ 1

[   28.128823] AppArmor: AppArmor sha1 policy hashing enabled

[   28.129591] initcall init_profile_hash+0x0/0xa4 returned 0 after 748 usecs

[   28.130431] calling  prandom_reseed+0x0/0x34 @ 1

[   28.131589] initcall prandom_reseed+0x0/0x34 returned 0 after 460 usecs

[   28.133085] calling  pci_resource_alignment_sysfs_init+0x0/0x1c @ 1

[   28.134150] initcall pci_resource_alignment_sysfs_init+0x0/0x1c returned 0 after 8 usecs

[   28.135418] calling  pci_sysfs_init+0x0/0x60 @ 1

[   28.136253] initcall pci_sysfs_init+0x0/0x60 returned 0 after 445 usecs

[   28.137440] calling  deferred_probe_initcall+0x0/0xc0 @ 1

[   28.137925] initcall deferred_probe_initcall+0x0/0xc0 returned 0 after 84 usecs

[   28.139146] calling  init_netconsole+0x0/0x270 @ 1

[   28.139998] printk: console [netcon0] enabled

[   28.141333] netconsole: network logging started

[   28.141660] initcall init_netconsole+0x0/0x270 returned 0 after 1634 usecs

[   28.142656] calling  rtc_hctosys+0x0/0xb8 @ 1

[   28.143112] rtc-sun4v rtc-sun4v: setting system clock to 2019-06-19T20:04:52 UTC (1560974692)

[   28.143720] initcall rtc_hctosys+0x0/0xb8 returned 0 after 717 usecs

[   28.144174] calling  tcp_congestion_default+0x0/0x1c @ 1

[   28.144564] initcall tcp_congestion_default+0x0/0x1c returned 0 after 2 usecs

[   28.145115] Warning: unable to open an initial console.

[   28.150162] EXT4-fs (sda1): INFO: recovery required on readonly filesystem

[   28.150647] EXT4-fs (sda1): write access will be enabled during recovery

[   28.171600] random: fast init done

[   28.293936] EXT4-fs (sda1): recovery complete

[   28.312674] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)

[   28.313751] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.

[   28.333349] devtmpfs: mounted

[   28.334254] This architecture does not have kernel memory protection.

[   28.335362] Run /sbin/init as init process

[   29.349169] calling  xt_init+0x0/0x120 [x_tables] @ 1

[   29.350358] initcall xt_init+0x0/0x120 [x_tables] returned 0 after 24 usecs

[   29.357875] calling  ip_tables_init+0x0/0xa8 [ip_tables] @ 1

[   29.358672] initcall ip_tables_init+0x0/0xa8 [ip_tables] returned 0 after 22 usecs

[   29.430636] systemd[1]: systemd 240 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)

[   29.435732] systemd[1]: Detected architecture sparc64.

[   29.478030] systemd[1]: Set hostname to <t5140>.

[   29.486607] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid argument

[   29.767539] systemd-hiberna (1603) used greatest stack depth: 8664 bytes left

[   29.769114] systemd-veritys (1608) used greatest stack depth: 7944 bytes left

[   29.888488] systemd-fstab-g (1600) used greatest stack depth: 6856 bytes left

[   30.009599] systemd-sysv-ge (1607) used greatest stack depth: 6536 bytes left

[   30.726409] random: systemd: uninitialized urandom read (16 bytes read)

[   30.751584] random: systemd: uninitialized urandom read (16 bytes read)

[   30.754073] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.

[   30.758649] random: systemd: uninitialized urandom read (16 bytes read)

[   30.759800] systemd[1]: Listening on initctl Compatibility Named Pipe.

[   30.761447] systemd[1]: Listening on fsck to fsckd communication Socket.

[   30.784293] systemd[1]: Created slice system-getty.slice.

[   30.787188] systemd[1]: Listening on udev Control Socket.

[   30.788479] systemd[1]: Listening on udev Kernel Socket.

[   30.973159] percpu: allocation failed, size=240 align=8 atomic=0, failed to allocate new chunk

[   30.975625] CPU: 17 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   30.979751] Call Trace:

[   30.981375]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   30.982924]  [00000000009a6f14] mem_cgroup_css_alloc+0x114/0x540

[   30.983721]  [00000000004e0090] cgroup_apply_control_enable+0x190/0x3c0

[   30.984544]  [00000000004e2574] cgroup_mkdir+0x234/0x420

[   30.988011]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   30.989592]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   30.990311]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   30.993626]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.052942] mount (1609) used greatest stack depth: 6416 bytes left

[   31.070224] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.071625] CPU: 64 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.072518] Call Trace:

[   31.072957]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.073359]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.073779]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.074218]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.074664]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.075077]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.075543]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.079335] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.080372] CPU: 64 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.080908] Call Trace:

[   31.081162]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.081587]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.082087]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.082521]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.082965]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.083374]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.083798]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.084524] systemd[1620]: sys-fs-fuse-connections.mount: Failed to attach to cgroup /system.slice/sys-fs-fuse-connections.mount: No such file or directory

[   31.088145] systemd[1621]: systemd-sysctl.service: Failed to attach to cgroup /system.slice/systemd-sysctl.service: No such file or directory

[   31.284827] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.286182] CPU: 65 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.286954] Call Trace:

[   31.287749]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.289084]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.289820]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.290549]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.291283]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.292312]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.292790]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.297993] systemd[1699]: systemd-remount-fs.service: Failed to attach to cgroup /system.slice/systemd-remount-fs.service: No such file or directory

[   31.305297] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.306251] CPU: 65 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.307058] Call Trace:

[   31.307256]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.307671]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.308111]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.308536]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.309020]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.309420]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.309828]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.332739] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.334041] CPU: 65 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.334564] Call Trace:

[   31.334763]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.335177]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.335617]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.336044]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.336526]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.336975]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.337383]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.340956] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.341943] CPU: 65 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.342418] Call Trace:

[   31.342712]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.343090]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.343492]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.343879]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.344274]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.344675]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.345082]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.356411] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.357367] CPU: 65 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.357842] Call Trace:

[   31.358089]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.358541]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.358980]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.359452]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.359885]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.360286]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.360751]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.366854] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.367876] CPU: 27 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.368351] Call Trace:

[   31.368656]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.369076]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.369564]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.369991]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.370423]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.370878]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.371291]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.375896] percpu: allocation failed, size=64 align=8 atomic=0, failed to allocate new chunk

[   31.376907] CPU: 27 PID: 1 Comm: systemd Not tainted 5.2.0-rc5 #220

[   31.377433] Call Trace:

[   31.377679]  [000000000055f804] pcpu_alloc+0x684/0x6c0

[   31.378094]  [00000000004e3f74] cgroup_rstat_init+0x74/0xa0

[   31.378582]  [00000000004e25a0] cgroup_mkdir+0x260/0x420

[   31.379005]  [0000000000639228] kernfs_iop_mkdir+0x68/0xc0

[   31.379438]  [00000000005c22b4] vfs_mkdir+0xf4/0x180

[   31.379886]  [00000000005c62f0] do_mkdirat+0xb0/0x120

[   31.380294]  [0000000000406254] linux_sparc_syscall+0x34/0x44

[   31.380816] percpu: limit reached, disable warning



Config:

#
# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 5.2.0-rc5 Kernel Configuration
#

#
# Compiler: gcc (Debian 8.3.0-7) 8.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=80300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_HOSTNAME="t5140"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_IRQ_PREFLOW_FASTEOI=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=16
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
# CONFIG_MEMCG_SWAP_ENABLED is not set
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_PROFILING is not set
# end of General setup

CONFIG_64BIT=y
CONFIG_SPARC=y
CONFIG_SPARC64=y
CONFIG_ARCH_DEFCONFIG="arch/sparc/configs/sparc64_defconfig"
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_ARCH_ATU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_MMU=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_ARCH_SUPPORTS_UPROBES=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_NR_CPUS=128
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_SPARC64_SMP=y
CONFIG_EARLYFB=y
CONFIG_SECCOMP=y
# CONFIG_HOTPLUG_CPU is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

# CONFIG_US3_MC is not set
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=4
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_FORCE_MAX_ZONEORDER=13
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_CMDLINE_BOOL is not set
# end of Processor type and features

#
# Bus options (PCI etc.)
#
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
# CONFIG_SUN_LDOMS is not set
CONFIG_SUN_OPENPROMFS=m
CONFIG_SPARC64_PCI=y
CONFIG_SPARC64_PCI_MSI=y
# end of Bus options (PCI etc.)

CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=m
CONFIG_OBP_FLASH=m
# CONFIG_TADPOLE_TS102_UCTRL is not set
# CONFIG_BBC_I2C is not set
# CONFIG_ENVCTRL is not set
# CONFIG_DISPLAY7SEG is not set
# CONFIG_ORACLE_DAX is not set
# end of Misc Linux/SPARC drivers

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_NMI_WATCHDOG=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_NO_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ODD_RT_SIGACTION=y
CONFIG_OLD_SIGSUSPEND=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_CPU_NO_EFFICIENT_FFS=y
# CONFIG_REFCOUNT_FULL is not set
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC=""
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=m
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=m
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_INTERFACE=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_IP_MROUTE is not set
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_ZONES is not set
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_SET=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
# CONFIG_NFT_FLOW_OFFLOAD is not set
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_SECURITY is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=y
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=m
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_BW=y
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# end of Cadence PCIe controllers support

# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_OF=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

#
# Altera FPGA firmware download module (requires I2C)
#

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGICPTI is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SUNESP is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_GRETH is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=m
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
# CONFIG_LDISC_AUTOLOAD is not set
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_SUNCORE=y
# CONFIG_SERIAL_SUNZILOG is not set
CONFIG_SERIAL_SUNSU=y
CONFIG_SERIAL_SUNSU_CONSOLE=y
CONFIG_SERIAL_SUNSAB=y
CONFIG_SERIAL_SUNSAB_CONSOLE=y
CONFIG_SERIAL_SUNHV=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# end of Serial drivers

# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_ADI is not set
# end of Character devices

#
# I2C support
#
# CONFIG_I2C is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_WATCHDOG_CP1XXX is not set
# CONFIG_WATCHDOG_RIO is not set
CONFIG_WATCHDOG_SUN4V=m

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_DRM is not set
# CONFIG_DRM_DP_CEC is not set

#
# ARM devices
#
# end of ARM devices

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#

#
# SPI RTC drivers
#

#
# SPI and I2C RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_SUN4V=y
CONFIG_RTC_DRV_STARFIRE=y
# CONFIG_RTC_DRV_CADENCE is not set
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_STAGING is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_DP is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=775
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
# CONFIG_CONFIGFS_FS is not set
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="UTF-8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_SPARC64 is not set
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=m
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MD5_SPARC64 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SPARC64 is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA256_SPARC64 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA512_SPARC64 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_SPARC64 is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_SPARC64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES_SPARC64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_NIAGARA2=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_GENERIC_PCI_IOMAP=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
# CONFIG_CRC8 is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
# CONFIG_XZ_DEC is not set
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_SG_POOL=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0xffff
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_STACKTRACE is not set
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_HAVE_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_NO_ALIGNMENT is not set
CONFIG_UBSAN_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_DEBUG_DCFLUSH is not set
# end of Kernel hacking

-- 
Meelis Roos <mroos@linux.ee>
