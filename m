Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9CC19477A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 20:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgCZTdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 15:33:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49542 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:33:14 -0400
Received: by mail-io1-f72.google.com with SMTP id p14so6229045ios.16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QCc6eEBTd80+TVR9cU/emXIJTFrZ99HWv6eRPwLw5SY=;
        b=Alq2VfUBNPMf26yzn3oeAiUM9N2GU3+TzNc5jwobpJ92DemH8HQcwghCdRYD0l5nLY
         PLESe/ldGUy0AjrZVosoNPNaxFtMAVjMYSE/hSCALt+xH/wjWOXyNhjClJ7rlNLt7XYv
         mTCzf0zpyi2Vr8aXik0DGuvEaKjm4EP88Misin6to754h2KUhO2LKzwv8dpiG4IM+xO+
         O6HA50+DI+zbg4kXVQok0i/9ESu36tsMEEwy5BMARHhgys2nd9kPFJrW39uxePwloE+5
         TUXgrDuDdLsiDiPrD7Z458WTMctP15zSh2rkc/r98gUuMsOkqWgFBg3PlHJ66VUtDSzO
         h/HA==
X-Gm-Message-State: ANhLgQ2ThdQZjuKnhoN+bn1GmS+Kp1csTGcJcQjYPboPM890R9QMYkmr
        qPm33aCGlcD7IsGAWZtO3hGizNW5KZu5VlvtzAamlVIygOm1
X-Google-Smtp-Source: ADFU+vvoP77tQvalO/3AcQYK9mCfMxkhredppU15qtPshGkXvl9JQIQ7Tv6WFpslKkkEwls6chJfJJLjjpwH1viYlAIclLxVUmc0
MIME-Version: 1.0
X-Received: by 2002:a92:a192:: with SMTP id b18mr10295266ill.199.1585251193677;
 Thu, 26 Mar 2020 12:33:13 -0700 (PDT)
Date:   Thu, 26 Mar 2020 12:33:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047770d05a1c70ecb@google.com>
Subject: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
From:   syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e31ba7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
dashboard link: https://syzkaller.appspot.com/bug?extid=313d95e8a7a49263f88d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13850447e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119a26f5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com

RSP: 002b:00007ffca409c958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffca409c970 RCX: 00000000004411c9
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: null-ptr-deref in memset include/linux/string.h:366 [inline]
BUG: KASAN: null-ptr-deref in bitmap_zero include/linux/bitmap.h:232 [inline]
BUG: KASAN: null-ptr-deref in cpumask_clear include/linux/cpumask.h:406 [inline]
BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0xea/0xe90 block/blk-mq.c:2502
Write of size 8 at addr 0000000000000118 by task syz-executor083/7593

CPU: 0 PID: 7593 Comm: syz-executor083 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x32 mm/kasan/report.c:510
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x128/0x190 mm/kasan/generic.c:192
 memset+0x20/0x40 mm/kasan/common.c:108
 memset include/linux/string.h:366 [inline]
 bitmap_zero include/linux/bitmap.h:232 [inline]
 cpumask_clear include/linux/cpumask.h:406 [inline]
 blk_mq_map_swqueue+0xea/0xe90 block/blk-mq.c:2502
 blk_mq_init_allocated_queue+0xf21/0x13c0 block/blk-mq.c:2943
 blk_mq_init_queue+0x5c/0xa0 block/blk-mq.c:2733
 loop_add+0x2cb/0x8a0 drivers/block/loop.c:2022
 loop_control_ioctl drivers/block/loop.c:2175 [inline]
 loop_control_ioctl+0x153/0x340 drivers/block/loop.c:2157
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4411c9
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffca409c958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffca409c970 RCX: 00000000004411c9
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
