Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D217875B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 02:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgCDBD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 20:03:28 -0500
Received: from hua.moonlit-rail.com ([45.79.167.250]:39914 "EHLO
        hua.moonlit-rail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgCDBD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:03:27 -0500
Received: from 209-6-248-230.s2276.c3-0.wrx-ubr1.sbo-wrx.ma.cable.rcncustomer.com ([209.6.248.230] helo=boston.moonlit-rail.com)
        by hua.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux-1993@moonlit-rail.com>)
        id 1j9IRZ-0005Dy-Rb
        for linux-kernel@vger.kernel.org; Tue, 03 Mar 2020 20:03:25 -0500
Received: from springdale.moonlit-rail.com ([192.168.71.35])
        by boston.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <linux-1993@moonlit-rail.com>)
        id 1j9IRZ-0008St-EJ
        for linux-kernel@vger.kernel.org; Tue, 03 Mar 2020 20:03:25 -0500
Subject: Re: Linux 5.5.7
To:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <20200301093749.GA1013956@kroah.com>
From:   Kris Karas <linux-1993@moonlit-rail.com>
Message-ID: <6d4f9ac8-a478-2ae4-0fe3-5d074d267148@moonlit-rail.com>
Date:   Tue, 3 Mar 2020 20:03:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200301093749.GA1013956@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I'm announcing the release of the 5.5.7 kernel.
> All users of the 5.5 kernel series must upgrade.

This one gave me an OOPS on boot, necessitating an Alt-SysRq-E to get in 
and save at least a portion of it to disk.� There are actually several 
OOPSen in the dmesg output I'll append, only common theme I can see 
being buggery within an IRQ handler.

Not seeing any similar reports as a reply to the 5.5.7 announcement, I 
was all set to bisect.� But reproducing this is elusive; I've only got 
one hit thus far, on the second of 8 or so boots.� (Hardware is a very 
stable Ryzen 2700 machine with ECC memory.)� Thus, this could have been 
introduced in 5.5.6 or even earlier.

In any case, I have seen a few patches recently mentioning NMI/IRQ work; 
perhaps one of those patch authors will recognize the stack traces and 
offer a clue.

Best,
Kris Karas

BUG: kernel NULL pointer dereference, address: 00000000000000e8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 7f6a50067 P4D 7f6a50067 PUD 7f6a51067 PMD 0
Oops: 0000 [#1] SMP
CPU: 3 PID: 516 Comm: pidof Not tainted 5.5.7 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X470 Taichi, BIOS P3.50 07/18/2019
RIP: 0010:cap_capable+0x13/0x70
Code: bf f4 ff ff ff 66 90 e9 01 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 4c 8b 87 88 00 00 00 4c 39 c6 74 39 45 8b 88 e8 00 00 00 <44> 39 8e e8 00 00 00 7e 18 48 8b 86 e0 00 00 00 4c 39 c0 74 12 48
RSP: 0018:ffffc90000777cb0 EFLAGS: 00010207
RAX: ffff8887f96ea000 RBX: 0000000000000002 RCX: 0000000000000002
RDX: 0000000000000013 RSI: 0000000000000000 RDI: ffff8887f9646480
RBP: 0000000000000013 R08: ffffffff82423da0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8887f9646480 R14: ffffffff822a7620 R15: ffff8887fae600c0
FS:  00007f8ee26cd740(0000) GS:ffff8887fecc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000e8 CR3: 00000007f8691000 CR4: 00000000003406e0
Call Trace:
  security_capable+0x36/0x50
  ptrace_has_cap+0x14/0x30
  __ptrace_may_access+0x76/0x110
  ptrace_may_access+0x28/0x50
  do_task_stat+0x7b/0xd90
  ? do_filp_open+0xab/0x100
  proc_single_show+0x54/0xc0
  ? __kmalloc+0x183/0x210
  seq_read+0xbb/0x3c0
  vfs_read+0xc6/0x150
  ksys_read+0x6b/0x100
  do_syscall_64+0x3d/0x120
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f8ee27d682e
Code: c0 e9 f6 fe ff ff 50 48 8d 3d b6 5d 0a 00 e8 e9 fd 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffdc7fdcf58 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f8ee28ce958 RCX: 00007f8ee27d682e
RDX: 0000000000000400 RSI: 00000000017e2590 RDI: 0000000000000004
RBP: 00007f8ee28ce950 R08: 00007f8ee28ac120 R09: 00007ffdc7fdce00
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdc7fddf02
Modules linked in:
CR2: 00000000000000e8
---[ end trace 9da0e81512fbb929 ]---
RIP: 0010:cap_capable+0x13/0x70
Code: bf f4 ff ff ff 66 90 e9 01 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 4c 8b 87 88 00 00 00 4c 39 c6 74 39 45 8b 88 e8 00 00 00 <44> 39 8e e8 00 00 00 7e 18 48 8b 86 e0 00 00 00 4c 39 c0 74 12 48
RSP: 0018:ffffc90000777cb0 EFLAGS: 00010207
RAX: ffff8887f96ea000 RBX: 0000000000000002 RCX: 0000000000000002
RDX: 0000000000000013 RSI: 0000000000000000 RDI: ffff8887f9646480
RBP: 0000000000000013 R08: ffffffff82423da0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8887f9646480 R14: ffffffff822a7620 R15: ffff8887fae600c0
FS:  00007f8ee26cd740(0000) GS:ffff8887fecc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000e8 CR3: 00000007f8691000 CR4: 00000000003406e0
udevd[518]: starting eudev-3.2.9
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    14-....: (20999 ticks this GP) idle=216/1/0x4000000000000002 softirq=454/454 fqs=5250
         (t=21004 jiffies g=-755 q=1327)
NMI backtrace for cpu 14
CPU: 14 PID: 520 Comm: pidof Tainted: G      D           5.5.7 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X470 Taichi, BIOS P3.50 07/18/2019
Call Trace:
  <IRQ>
  dump_stack+0x50/0x70
  nmi_cpu_backtrace.cold+0x14/0x53
  ? lapic_can_unplug_cpu.cold+0x44/0x44
  nmi_trigger_cpumask_backtrace+0x7b/0x88
  rcu_dump_cpu_stacks+0x7b/0xa9
  rcu_sched_clock_irq.cold+0x152/0x39b
  update_process_times+0x1f/0x50
  tick_sched_timer+0x40/0x90
  ? tick_sched_do_timer+0x50/0x50
  __hrtimer_run_queues+0xdd/0x180
  hrtimer_interrupt+0x108/0x230
  smp_apic_timer_interrupt+0x53/0xa0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
RIP: 0010:queued_spin_lock_slowpath+0x41/0x1a0
Code: 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 18 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 8b 07 84 c0 <75> f8 66 c7 07 01 00 c3 f6 c4 01 75 04 c6 47 01 00 48 c7 c0 40 29
RSP: 0018:ffffc90001e87d08 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000101 RBX: ffff8887f96f0000 RCX: ffff8887f96f0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8887f96f0658
RBP: 000000000000000d R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8887f50b7080
R13: ffffffff82424480 R14: ffffffff82424480 R15: ffff8887f50b70c0
  ptrace_may_access+0x1e/0x50
  do_task_stat+0x7b/0xd90
  ? do_filp_open+0xab/0x100
  proc_single_show+0x54/0xc0
  ? __kmalloc+0x183/0x210
  seq_read+0xbb/0x3c0
  vfs_read+0xc6/0x150
  ksys_read+0x6b/0x100
  do_syscall_64+0x3d/0x120
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f666796082e
Code: c0 e9 f6 fe ff ff 50 48 8d 3d b6 5d 0a 00 e8 e9 fd 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffe26688b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f6667a58958 RCX: 00007f666796082e
RDX: 0000000000000400 RSI: 000000000153e590 RDI: 0000000000000004
RBP: 00007f6667a58950 R08: 00007f6667a36120 R09: 00007ffe266889e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffe2668aee9
...
sysrq: Terminate All Tasks
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    14-....: (83876 ticks this GP) idle=216/1/0x4000000000000002 softirq=454/454 fqs=20970
         (t=84003 jiffies g=-755 q=2695)
NMI backtrace for cpu 14
CPU: 14 PID: 520 Comm: pidof Tainted: G      D           5.5.7 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X470 Taichi, BIOS P3.50 07/18/2019
Call Trace:
  <IRQ>
  dump_stack+0x50/0x70
  nmi_cpu_backtrace.cold+0x14/0x53
  ? lapic_can_unplug_cpu.cold+0x44/0x44
  nmi_trigger_cpumask_backtrace+0x7b/0x88
  rcu_dump_cpu_stacks+0x7b/0xa9
  rcu_sched_clock_irq.cold+0x152/0x39b
  update_process_times+0x1f/0x50
  tick_sched_timer+0x40/0x90
  ? tick_sched_do_timer+0x50/0x50
  __hrtimer_run_queues+0xdd/0x180
  hrtimer_interrupt+0x108/0x230
  smp_apic_timer_interrupt+0x53/0xa0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
RIP: 0010:queued_spin_lock_slowpath+0x3d/0x1a0
Code: 3e f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 18 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 66 c7 07 01 00 c3 f6 c4 01 75 04 c6 47 01 00 48
RSP: 0018:ffffc90001e87d08 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000101 RBX: ffff8887f96f0000 RCX: ffff8887f96f0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8887f96f0658
RBP: 000000000000000d R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8887f50b7080
R13: ffffffff82424480 R14: ffffffff82424480 R15: ffff8887f50b70c0
  ptrace_may_access+0x1e/0x50
  do_task_stat+0x7b/0xd90
  ? do_filp_open+0xab/0x100
  proc_single_show+0x54/0xc0
  ? __kmalloc+0x183/0x210
  seq_read+0xbb/0x3c0
  vfs_read+0xc6/0x150
  ksys_read+0x6b/0x100
  do_syscall_64+0x3d/0x120
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f666796082e
Code: c0 e9 f6 fe ff ff 50 48 8d 3d b6 5d 0a 00 e8 e9 fd 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffe26688b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f6667a58958 RCX: 00007f666796082e
RDX: 0000000000000400 RSI: 000000000153e590 RDI: 0000000000000004
RBP: 00007f6667a58950 R08: 00007f6667a36120 R09: 00007ffe266889e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffe2668aee9
rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 14-... } 21041 jiffies s: 45 root: 0x4000/.
rcu: blocking rcu_node structures:
Task dump for CPU 14:
pidof           R  running task        0   520      1 0x8000000c
Call Trace:
  ? do_syscall_64+0x3d/0x120
  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    14-....: (146878 ticks this GP) idle=216/1/0x4000000000000002 softirq=454/454 fqs=36715
         (t=147006 jiffies g=-755 q=3376)
NMI backtrace for cpu 14
CPU: 14 PID: 520 Comm: pidof Tainted: G      D           5.5.7 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X470 Taichi, BIOS P3.50 07/18/2019
Call Trace:
  <IRQ>
  dump_stack+0x50/0x70
  nmi_cpu_backtrace.cold+0x14/0x53
  ? lapic_can_unplug_cpu.cold+0x44/0x44
  nmi_trigger_cpumask_backtrace+0x7b/0x88
  rcu_dump_cpu_stacks+0x7b/0xa9
  rcu_sched_clock_irq.cold+0x152/0x39b
  update_process_times+0x1f/0x50
  tick_sched_timer+0x40/0x90
  ? tick_sched_do_timer+0x50/0x50
  __hrtimer_run_queues+0xdd/0x180
  hrtimer_interrupt+0x108/0x230
  smp_apic_timer_interrupt+0x53/0xa0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
RIP: 0010:queued_spin_lock_slowpath+0x3d/0x1a0
Code: 3e f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 18 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 66 c7 07 01 00 c3 f6 c4 01 75 04 c6 47 01 00 48
RSP: 0018:ffffc90001e87d08 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000101 RBX: ffff8887f96f0000 RCX: ffff8887f96f0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8887f96f0658
RBP: 000000000000000d R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8887f50b7080
R13: ffffffff82424480 R14: ffffffff82424480 R15: ffff8887f50b70c0
  ptrace_may_access+0x1e/0x50
  do_task_stat+0x7b/0xd90
  ? do_filp_open+0xab/0x100
  proc_single_show+0x54/0xc0
  ? __kmalloc+0x183/0x210
  seq_read+0xbb/0x3c0
  vfs_read+0xc6/0x150
  ksys_read+0x6b/0x100
  do_syscall_64+0x3d/0x120
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f666796082e
Code: c0 e9 f6 fe ff ff 50 48 8d 3d b6 5d 0a 00 e8 e9 fd 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffe26688b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f6667a58958 RCX: 00007f666796082e
RDX: 0000000000000400 RSI: 000000000153e590 RDI: 0000000000000004
RBP: 00007f6667a58950 R08: 00007f6667a36120 R09: 00007ffe266889e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffe2668aee9
rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 14-... } 85041 jiffies s: 45 root: 0x4000/.
rcu: blocking rcu_node structures:
Task dump for CPU 14:
pidof           R  running task        0   520      1 0x8000000c
Call Trace:
  ? do_syscall_64+0x3d/0x120
  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    14-....: (209792 ticks this GP) idle=216/1/0x4000000000000002 softirq=454/454 fqs=52439
         (t=210009 jiffies g=-755 q=3747)
NMI backtrace for cpu 14
CPU: 14 PID: 520 Comm: pidof Tainted: G      D           5.5.7 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X470 Taichi, BIOS P3.50 07/18/2019
Call Trace:
  <IRQ>
  dump_stack+0x50/0x70
  nmi_cpu_backtrace.cold+0x14/0x53
  ? lapic_can_unplug_cpu.cold+0x44/0x44
  nmi_trigger_cpumask_backtrace+0x7b/0x88
  rcu_dump_cpu_stacks+0x7b/0xa9
  rcu_sched_clock_irq.cold+0x152/0x39b
  update_process_times+0x1f/0x50
  tick_sched_timer+0x40/0x90
  ? tick_sched_do_timer+0x50/0x50
  __hrtimer_run_queues+0xdd/0x180
  hrtimer_interrupt+0x108/0x230
  smp_apic_timer_interrupt+0x53/0xa0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
RIP: 0010:queued_spin_lock_slowpath+0x3d/0x1a0
Code: 3e f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 18 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 66 c7 07 01 00 c3 f6 c4 01 75 04 c6 47 01 00 48
RSP: 0018:ffffc90001e87d08 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000101 RBX: ffff8887f96f0000 RCX: ffff8887f96f0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8887f96f0658
RBP: 000000000000000d R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8887f50b7080
R13: ffffffff82424480 R14: ffffffff82424480 R15: ffff8887f50b70c0
  ptrace_may_access+0x1e/0x50
  do_task_stat+0x7b/0xd90
  ? do_filp_open+0xab/0x100
  proc_single_show+0x54/0xc0
  ? __kmalloc+0x183/0x210
  seq_read+0xbb/0x3c0
  vfs_read+0xc6/0x150
  ksys_read+0x6b/0x100
  do_syscall_64+0x3d/0x120
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f666796082e
Code: c0 e9 f6 fe ff ff 50 48 8d 3d b6 5d 0a 00 e8 e9 fd 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffe26688b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f6667a58958 RCX: 00007f666796082e
RDX: 0000000000000400 RSI: 000000000153e590 RDI: 0000000000000004
RBP: 00007f6667a58950 R08: 00007f6667a36120 R09: 00007ffe266889e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffe2668aee9
rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 14-... } 150577 jiffies s: 45 root: 0x4000/.
rcu: blocking rcu_node structures:
Task dump for CPU 14:
pidof           R  running task        0   520      1 0x8000000c
Call Trace:
  ? do_syscall_64+0x3d/0x120
  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

                                                                                                 

