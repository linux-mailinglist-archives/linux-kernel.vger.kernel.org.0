Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D332737AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfGXTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 15:18:33 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:53050 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfGXTSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:18:08 -0400
Received: by mail-io1-f70.google.com with SMTP id p12so52058987iog.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+Xth2lHyiuRzcaAju3mJNcm0GH89euUPbCyns5kD0e0=;
        b=De7OdDaiAOaJdfvCMPdjTtfTiz2EBPzmHM77GX6m6SKY6jXkjNk1YTFOzINPE3Yi5X
         bf/vaH6alpvtXZAqZSJ16XvROdrEwZ9ZcKvU1pGGa6W59unRgAFqtt3pTDJED+22zaxm
         YEb3v/R0fuW3vjdFJa0OVmQybSDYnLVL+qizkzYP71X52/WKPl5uQ6oUUA6/Vw4lc0cu
         UKcWD7Mr1ZTSzodr/Pt7RB5tUwL2ipP1teE42Ns/wQMsi9N6HQvdMWDku3raO5cxOXw7
         Jm7CnoYmnwwLtFTuE7XMWTu75LVR4J1oXAYXT+mrbPWQWZYVOAYfTo1oqZzu3AvCfI/T
         5Cwg==
X-Gm-Message-State: APjAAAVQKhVQushUMBYnZyfX4Bpe5TqUntL7ASmakKdNrb4Q9b1FIGX0
        lAPn3D7bvRr3uU+w2rAtYPwGC5W9HKs8gyUT3IMCk2f5zpwK
X-Google-Smtp-Source: APXvYqyr5nWHyL3ESeWO4iMGSFO7coGdQMklNN+gKZo+2AakNG9NqgNIpPqh8euffOOiBfVBadblnX0BhPx1ZITB2xWlVw+mfGfL
MIME-Version: 1.0
X-Received: by 2002:a6b:fb02:: with SMTP id h2mr53124412iog.289.1563995887565;
 Wed, 24 Jul 2019 12:18:07 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:18:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f0309058e722b24@google.com>
Subject: general protection fault in rose_transmit_clear_request
From:   syzbot <syzbot+a1c743815982d9496393@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10656fa4600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7937b718ddac333b
dashboard link: https://syzkaller.appspot.com/bug?extid=a1c743815982d9496393
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f6d348600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cad91fa00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1164f2f4600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1564f2f4600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a1c743815982d9496393@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.2.0+ #37
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rose_send_frame /net/rose/rose_link.c:101 [inline]
RIP: 0010:rose_transmit_clear_request+0x1ee/0x460 /net/rose/rose_link.c:255
Code: fc ff df 80 3c 08 00 74 12 4c 89 f7 e8 8b 57 dd fa 48 b9 00 00 00 00  
00 fc ff df bb 50 03 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <80> 3c 08 00 74  
12 48 89 df e8 64 57 dd fa 48 b9 00 00 00 00 00 fc
RSP: 0018:ffff8880aeb09a28 EFLAGS: 00010206
RAX: 000000000000006a RBX: 0000000000000350 RCX: dffffc0000000000
RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880aeb09a70 R08: ffffffff86d3c4c5 R09: ffffed101255690d
R10: ffffed101255690d R11: 0000000000000000 R12: ffff8882167bec80
R13: ffff888092ab47dc R14: ffff8882167beca0 R15: ffff888092ab47de
FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000190 CR3: 000000009c1e1000 CR4: 00000000001406e0
Call Trace:
  <IRQ>
  rose_rx_call_request+0xadb/0x1b00 /net/rose/af_rose.c:998
  rose_loopback_timer+0x2f8/0x480 /net/rose/rose_loopback.c:100
  call_timer_fn+0xec/0x200 /kernel/time/timer.c:1322
  expire_timers /kernel/time/timer.c:1366 [inline]
  __run_timers+0x7cd/0x9c0 /kernel/time/timer.c:1685
  run_timer_softirq+0x1d/0x40 /kernel/time/timer.c:1698
  __do_softirq+0x307/0x774 /./arch/x86/include/asm/paravirt.h:778
  invoke_softirq /kernel/softirq.c:373 [inline]
  irq_exit+0x1e9/0x1f0 /kernel/softirq.c:413
  exiting_irq /./arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0xcc/0x220 /arch/x86/kernel/apic/apic.c:1095
  apic_timer_interrupt+0xf/0x20 /arch/x86/entry/entry_64.S:828
  </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 /./arch/x86/include/asm/irqflags.h:61
Code: 38 46 0a fa eb ae 89 d9 80 e1 07 80 c1 03 38 c1 7c ba 48 89 df e8 22  
46 0a fa eb b0 e9 07 00 00 00 0f 00 2d e6 b0 5b 00 fb f4 <c3> 90 e9 07 00  
00 00 0f 00 2d d6 b0 5b 00 f4 c3 90 90 55 48 89 e5
RSP: 0018:ffff8880a98c7d38 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff11950f3 RBX: ffff8880a98bc340 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff812cd3ea RDI: ffff8880a98bcb38
RBP: ffff8880a98c7d40 R08: ffff8880a98bcb50 R09: ffffed1015317869
R10: ffffed1015317869 R11: 0000000000000000 R12: 1ffff11015317868
R13: 0000000000000001 R14: dffffc0000000000 R15: 1ffffffff11950f1
  arch_cpu_idle+0xa/0x10 /arch/x86/kernel/process.c:571
  default_idle_call+0x59/0xa0 /kernel/sched/idle.c:94
  cpuidle_idle_call /kernel/sched/idle.c:154 [inline]
  do_idle+0x174/0x770 /kernel/sched/idle.c:263
  cpu_startup_entry+0x25/0x30 /kernel/sched/idle.c:354
  start_secondary+0x3f4/0x490 /arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 /arch/x86/kernel/head_64.S:241
Modules linked in:
---[ end trace fd2ad3b72484e5c3 ]---
RIP: 0010:rose_send_frame /net/rose/rose_link.c:101 [inline]
RIP: 0010:rose_transmit_clear_request+0x1ee/0x460 /net/rose/rose_link.c:255
Code: fc ff df 80 3c 08 00 74 12 4c 89 f7 e8 8b 57 dd fa 48 b9 00 00 00 00  
00 fc ff df bb 50 03 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <80> 3c 08 00 74  
12 48 89 df e8 64 57 dd fa 48 b9 00 00 00 00 00 fc
RSP: 0018:ffff8880aeb09a28 EFLAGS: 00010206
RAX: 000000000000006a RBX: 0000000000000350 RCX: dffffc0000000000
RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880aeb09a70 R08: ffffffff86d3c4c5 R09: ffffed101255690d
R10: ffffed101255690d R11: 0000000000000000 R12: ffff8882167bec80
R13: ffff888092ab47dc R14: ffff8882167beca0 R15: ffff888092ab47de
FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000190 CR3: 000000009c1e1000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
