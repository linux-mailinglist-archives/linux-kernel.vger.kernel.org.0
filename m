Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E082716A02B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 09:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgBXIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 03:38:16 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:50974 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgBXIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:38:14 -0500
Received: by mail-il1-f198.google.com with SMTP id z12so16954689ilh.17
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 00:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GsrXjmJeGikYtB/cB8yddymFCfJV2BF6AAZhIaBbNF4=;
        b=SiEeQij95jog0hSIOJP0gR6fYrsIpNH5I27nZQo8D14zKiRcY7ZRkuYRtRGR7I7UoP
         zxhGlxfHBu26ivTZBPNtB/283BBlTfY0ySD8W8Nhp66mksEG2eY3+0w3HpMZf8AdgjtG
         a2dorv/oWlLNG4U+95ChFNCCGN8YQi5TU+BXlsGbnyhMu1O2Ij8P+JufsADhfSNvTb68
         5Sb/w99Bv1b29qrmpy/mkDzbdxe4Jx/c4FLzGKB9LAI6T52XcjAWZd+DlC3yiCwDAVnK
         aYPOJT45x6fx89B8/xbw+V2yTu9mMQoIrNmsUgaF0P3tm79T+cFTrxru2wMEPhwIZVMJ
         i4rg==
X-Gm-Message-State: APjAAAVl0aWWcr646IEx9mVuuuX1DBwo1XqRQhPWY5ezHnI7ffVukRgd
        aML6T1Cfb205njRZaBxTcgaGVEV7GbuqlsjPNMqG9cn5GAoF
X-Google-Smtp-Source: APXvYqzy47V2csfPLyZ4K4CJj8Vfu2iPewOTbfW2itGqslEdeiHMx1tm2n/SeT/W4cM9uLNHwYYp1/q6sw/knHXinEv5R43hdh2o
MIME-Version: 1.0
X-Received: by 2002:a02:708f:: with SMTP id f137mr49636155jac.4.1582533493717;
 Mon, 24 Feb 2020 00:38:13 -0800 (PST)
Date:   Mon, 24 Feb 2020 00:38:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd0208059f4e4a87@google.com>
Subject: KMSAN: uninit-value in batadv_get_vid
From:   syzbot <syzbot+0adb190024de0a0e265b@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, glider@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15471109e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=0adb190024de0a0e265b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247c109e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1349a779e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0adb190024de0a0e265b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in batadv_get_vid+0x1fd/0x340 net/batman-adv/main.c:650
CPU: 0 PID: 12317 Comm: syz-executor026 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 batadv_get_vid+0x1fd/0x340 net/batman-adv/main.c:650
 batadv_interface_tx+0x30a/0x2450 net/batman-adv/soft-interface.c:212
 __netdev_start_xmit include/linux/netdevice.h:4524 [inline]
 netdev_start_xmit include/linux/netdevice.h:4538 [inline]
 xmit_one net/core/dev.c:3470 [inline]
 dev_hard_start_xmit+0x531/0xab0 net/core/dev.c:3486
 __dev_queue_xmit+0x37de/0x4220 net/core/dev.c:4063
 dev_queue_xmit+0x4b/0x60 net/core/dev.c:4096
 __bpf_tx_skb net/core/filter.c:2061 [inline]
 __bpf_redirect_common net/core/filter.c:2100 [inline]
 __bpf_redirect+0x11d5/0x1440 net/core/filter.c:2107
 ____bpf_clone_redirect net/core/filter.c:2140 [inline]
 bpf_clone_redirect+0x466/0x620 net/core/filter.c:2112
 bpf_prog_bb15b996d00816f9+0x7a4/0x1000
 bpf_dispatcher_nopfunc include/linux/bpf.h:521 [inline]
 bpf_test_run+0x60c/0xe50 net/bpf/test_run.c:48
 bpf_prog_test_run_skb+0xcab/0x24a0 net/bpf/test_run.c:388
 bpf_prog_test_run kernel/bpf/syscall.c:2572 [inline]
 __do_sys_bpf+0xa684/0x13510 kernel/bpf/syscall.c:3414
 __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
 __ia32_sys_bpf+0xdb/0x120 kernel/bpf/syscall.c:3355
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fc8d99
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ff9adc0c EFLAGS: 00000246 ORIG_RAX: 0000000000000165
RAX: ffffffffffffffda RBX: 000000000000000a RCX: 0000000020000280
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 000000000000005b
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2793 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4401
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 pskb_expand_head+0x20b/0x1b00 net/core/skbuff.c:1629
 skb_ensure_writable+0x3ea/0x490 net/core/skbuff.c:5453
 __bpf_try_make_writable net/core/filter.c:1635 [inline]
 bpf_try_make_writable net/core/filter.c:1641 [inline]
 bpf_try_make_head_writable net/core/filter.c:1649 [inline]
 ____bpf_clone_redirect net/core/filter.c:2134 [inline]
 bpf_clone_redirect+0x251/0x620 net/core/filter.c:2112
 bpf_prog_bb15b996d00816f9+0x7a4/0x1000
 bpf_dispatcher_nopfunc include/linux/bpf.h:521 [inline]
 bpf_test_run+0x60c/0xe50 net/bpf/test_run.c:48
 bpf_prog_test_run_skb+0xcab/0x24a0 net/bpf/test_run.c:388
 bpf_prog_test_run kernel/bpf/syscall.c:2572 [inline]
 __do_sys_bpf+0xa684/0x13510 kernel/bpf/syscall.c:3414
 __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
 __ia32_sys_bpf+0xdb/0x120 kernel/bpf/syscall.c:3355
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
