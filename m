Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80430AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEaIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 04:54:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38812 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:54:06 -0400
Received: by mail-io1-f71.google.com with SMTP id w3so7086762iot.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 01:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6qnjHWDOwzLpNhNm6KCXLI8xjNxb9MDyO3pY4iTDiss=;
        b=LP6TWBtpEIzWttE8s6PnGcEkRJ+spBIYf1eTC4dl/IOWFasK6Z5uWHKbl+DzFLYk44
         LTCUQeoi9DT8ZrfVTeb6h5iZIS/CO1z/N14uDnQQrB8aLqbfMamumNLeDivEc2yAfi/6
         oKGTCj7UCCn7owTg6g2+yOpBhKfcXpTcO9Y8Zh3kv3cyyj1robPmJYU90ehnH7MX4W6v
         g6Gqe7HRpjqa9nAYFwJsl+wHmNIhRO0T60MXIjkczCm3ISeRDo/8Hx2U6GwpYli/p3Ys
         Or9ax7YQN6ZmCEqTd0Z2BsilxMZ9aIjpUCQ8Z8nUkThR/OkeuxtanF8X6oSMfeVUXq+v
         1W5g==
X-Gm-Message-State: APjAAAVnP8B06xVLViqwhvGD6zkylS9SyyS4AhZTUoII7+8rYzQzgARB
        6v3b2DzsFdO1tyYm1f9XkVFt6bpjF6Nj2Ryp4/c3s0W1ZHrj
X-Google-Smtp-Source: APXvYqyk2gmntUlN5yf5AaqdRl0vyt17XjJy+0/mbjCtvRwKupNX9Lyg3KKv9vJpfjl/QJEMeYRKfzctQKl4MHTWRoxYVf2lbUD4
MIME-Version: 1.0
X-Received: by 2002:a6b:f910:: with SMTP id j16mr5830393iog.256.1559292845922;
 Fri, 31 May 2019 01:54:05 -0700 (PDT)
Date:   Fri, 31 May 2019 01:54:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ea227058a2b28a4@google.com>
Subject: WARNING in bpf_base_func_proto
From:   syzbot <syzbot+5b595d1c2cd4d7d0f521@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5fac1718 selftests: bpf: fix compiler warning in flow_diss..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=10fbeea2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=5b595d1c2cd4d7d0f521
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5b595d1c2cd4d7d0f521@syzkaller.appspotmail.com

------------[ cut here ]------------
Could not allocate percpu trace_printk buffer
WARNING: CPU: 0 PID: 26679 at kernel/trace/trace.c:3004  
alloc_percpu_trace_buffer kernel/trace/trace.c:3004 [inline]
WARNING: CPU: 0 PID: 26679 at kernel/trace/trace.c:3004  
trace_printk_init_buffers+0x5b/0x60 kernel/trace/trace.c:3018
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 26679 Comm: syz-executor.1 Not tainted 5.2.0-rc1+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:218
  __warn.cold+0x20/0x4d kernel/panic.c:575
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:alloc_percpu_trace_buffer kernel/trace/trace.c:3004 [inline]
RIP: 0010:trace_printk_init_buffers+0x5b/0x60 kernel/trace/trace.c:3018
Code: ff be 04 00 00 00 bf 04 10 00 00 e8 7f 2a 21 00 48 85 c0 0f 85 8c 35  
00 00 e8 91 71 fb ff 48 c7 c7 40 9a 6f 87 e8 03 b7 cd ff <0f> 0b eb c2 90  
55 48 89 e5 41 57 49 c7 c7 e0 80 6f 87 41 56 49 89
RSP: 0018:ffff888063fbf6a8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000008c4e RSI: ffffffff815ac7e6 RDI: ffffed100c7f7ec7
RBP: ffff888063fbf6b8 R08: ffff88809eaea280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8771a560
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000006
  bpf_get_trace_printk_proto+0xe/0x20 kernel/trace/bpf_trace.c:335
  bpf_base_func_proto net/core/filter.c:5850 [inline]
  bpf_base_func_proto+0x199/0x1b0 net/core/filter.c:5812
  sk_filter_func_proto+0x69/0x90 net/core/filter.c:5921
  cg_skb_func_proto+0x43/0xe0 net/core/filter.c:5949
  check_helper_call kernel/bpf/verifier.c:3240 [inline]
  do_check+0x513f/0xa950 kernel/bpf/verifier.c:6765
  bpf_check+0x67c8/0x8fb0 kernel/bpf/verifier.c:8261
  bpf_prog_load+0xdbe/0x1500 kernel/bpf/syscall.c:1683
  __do_sys_bpf+0xe03/0x43d0 kernel/bpf/syscall.c:2813
  __se_sys_bpf kernel/bpf/syscall.c:2772 [inline]
  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:2772
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f21ef383c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459279
RDX: 0000000000000070 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 000000000075bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f21ef3846d4
R13: 00000000004bf658 R14: 00000000004d09d8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
