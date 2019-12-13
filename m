Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA9F11EDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 23:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLMWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 17:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMWqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:46:48 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0241422527;
        Fri, 13 Dec 2019 22:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576277207;
        bh=KlkbVMB/CR5n8QfXhBY9LAbQTnsXDKmS5ifFaHM+5j4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EAhCxKrirXGbBOlKKgsmjWXpzkpciN9TmRA2ex9FoSwd6ODjq/DxFeFDxg2oA7EFA
         TPyUUrM5ecY0yokoB+vtHU5naL8C+VAqaTyajayele4lKOZE3+ExqNdclm4fiOUXnA
         xvBCBxalEFMTRdBY2U+2PBdiULpyf5mxR4GEhSiU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7A61B3522824; Fri, 13 Dec 2019 14:46:46 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:46:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
Message-ID: <20191213224646.GH2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <3DAA2B11-682B-43B4-94F3-A4706D3179F6@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DAA2B11-682B-43B4-94F3-A4706D3179F6@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:13:27AM -0500, Qian Cai wrote:
> The linux-next commit 82150cb53dcb ("rcu: React to callback overload by aggressively seeking quiescent states”)
> causes hangs on boot on almost all arches. Reverted it fixed the issue.

I am running this on a number of x86 systems, but will try it on a
wider variety.  If I cannot reproduce it, would you be willing to
run diagnostics?

Just to double-check...  Are you running rcutorture built into the kernel?
(My guess is "no", but figured that I should ask.)

							Thanx, Paul

> === x86_64 (Intel) ===
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> [   29.130611][    T0] mce: CPU0: Thermal monitoring enabled (TM1)
> [   29.136598][    T0] process: using mwait in idle threads
> [   29.140582][    T0] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [   29.146704][    T0] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [   29.150570][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [   29.160584][    T0] Spectre V2 : Mitigation: Full generic retpoline
> [   29.166881][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [   29.170567][    T0] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [   29.180569][    T0] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [   29.190567][    T0] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> [   29.200569][    T0] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [   29.210570][    T0] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
> [   28.995181][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> [   29.005929][    T0] debug: unmapping init [mem 0xffffffffb50ec000-0xffffffffb50f0fff]
> [   29.035681][    T1] smpboot: CPU0: Intel(R) Xeon(R) 
> <hang ….>
> 
> === arm64 ===
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> 
> [    0.000000][    T0] ITS [mem 0x440100000-0x44011ffff]
> [    0.000000][    T0] ITS@0x0000000440100000: allocated 65536 Devices @8bfd080000 (flat, esz 8, psz 64K, shr 0)
> [    0.000000][    T0] ITS@0x0000000440100000: allocated 32768 Interrupt Collections @8bfd020000 (flat, esz 2, psz 16K, shr 0)
> [    0.000000][    T0] ITS: using cache flushing for cmd queue
> [    0.000000][    T0] GICv3: using LPI property table @0x0000000880db0000
> [    0.000000][    T0] GIC: using cache flushing for LPI property table
> [    0.000000][    T0] GICv3: CPU0: using allocated LPI pending table @0x0000000880dd0000
> [    0.000000][    T0] arch_timer: cp15 timer(s) running at 200.00MHz (phys).
> [    0.000000][    T0] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2e2049d3e8, max_idle_ns: 440795210634 ns
> [    0.000005][    T0] sched_clock: 56 bits at 200MHz, resolution 5ns, wraps every 4398046511102ns
> [    0.061872][    T0] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.070420][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.075298][    T0] ... MAX_LOCK_DEPTH:          48
> [    0.080240][    T0] ... MAX_LOCKDEP_KEYS:        8192
> [    0.085379][    T0] ... CLASSHASH_SIZE:          4096
> [    0.090496][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.095722][    T0] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.100926][    T0] ... CHAINHASH_SIZE:          32768
> [    0.106153][    T0]  memory used by lock dependency info: 6237 kB
> [    0.112324][    T0]  memory used for stack traces: 4224 kB
> [    0.117902][    T0]  per task-struct memory footprint: 1920 bytes
> [    0.158652][    T0] ACPI: Core revision 20191018
> [    0.194716][    T0] Calibrating delay loop (skipped), value calculated using timer frequency.. 400.00 BogoMIPS (lpj=2000000)
> [    0.206116][    T0] pid_max: default: 262144 minimum: 2048
> [    0.355206][    T0] Dentry cache hash table entries: 8388608 (order: 10, 67108864 bytes, vmalloc)
> [    0.396920][    T0] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes, vmalloc)
> [    0.422261][    T0] Mount-cache hash table entries: 131072 (order: 4, 1048576 bytes, vmalloc)
> [    0.431925][    T0] Mountpoint-cache hash table entries: 131072 (order: 4, 1048576 bytes, vmalloc)
> [    0.736297][    T1] ASID allocator initialised with 32768 entries
> [    0.743932][    T1] rcu: Hierarchical SRCU implementation.
> [    0.759898][    T1] Platform MSI: ITS@0x400100000 domain created
> [    0.766249][    T1] Platform MSI: ITS@0x440100000 domain created
> [    0.772602][    T1] PCI/MSI: ITS@0x400100000 domain created
> [    0.778561][    T1] PCI/MSI: ITS@0x440100000 domain created
> [    0.784292][    T1] Remapping and enabling EFI services.
> <hang …>
> 
> === powerpc ===
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> 
> [    0.000000][    T0] SLUB: HWalign=128, Order=0-0, MinObjects=0, CPUs=128, Nodes=256
> [    0.000000][    T0] ODEBUG: selftest passed
> [    0.000000][    T0] ftrace: allocating 19886 entries in 8 pages
> [    0.000000][    T0] ftrace: allocated 8 pages with 1 groups
> [    0.000000][    T0] Running RCU self tests
> [    0.000000][    T0] rcu: Hierarchical RCU implementation.
> [    0.000000][    T0] rcu: 	RCU lockdep checking is enabled.
> [    0.000000][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=128.
> [    0.000000][    T0] rcu: 	RCU callback double-/use-after-free debug enabled.
> [    0.000000][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> [    0.000000][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128
> [    0.000000][    T0] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
> [    0.000000][    T0] xive: Interrupt handling initialized with native backend
> [    0.000000][    T0] xive: Using priority 7 for all interrupts
> [    0.000000][    T0] xive: Using 64kB queues
> [    0.000007][    T0] time_init: 56 bit decrementer (max: 7fffffffffffff)
> [    0.003188][    T0] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
> [    0.011496][    T0] clocksource: timebase mult[1f40000] shift[24] registered
> [    0.029470][    T0] printk: console [hvc0] enabled
> [    0.029470][    T0] printk: console [hvc0] enabled
> [    0.035652][    T0] printk: bootconsole [udbg0] disabled
> [    0.035652][    T0] printk: bootconsole [udbg0] disabled
> [    0.040864][    T0] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.040892][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.040918][    T0] ... MAX_LOCK_DEPTH:          48
> [    0.040944][    T0] ... MAX_LOCKDEP_KEYS:        8192
> [    0.040969][    T0] ... CLASSHASH_SIZE:     
> <hang ...>
