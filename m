Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC817CBCC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 04:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCGDyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 22:54:14 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34238 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCGDyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:54:14 -0500
Received: by mail-il1-f200.google.com with SMTP id l13so3154436ils.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 19:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=esyWbH1Gj/R54x9zfOlnXI9LhxcAna8EcNnnF2nLEZs=;
        b=nTZhAidxQ2wzJxjVCCzvf69j47QvhSNo6pnwh7QzWzDiVwFZ4X3pxSqSiMy0W8LOd0
         bT7rDRKXD42ZAx+QoTGZ9PwDii/MQjiEtBq8oSqC4x4PlpsNkgGWCP8Q12w//ol5ZU36
         F5eHtFY4M+/1GIIkmct30QzfEFFacASQZ8UcS4oXacD9DAkp7ccmzCD77+sl7v9/Sbz7
         61t2/YixaFh6EAWpCpSlz2ONoV4ArFzuKvV2j51s6gxRVultQpAb3n/iQ02SegPP1TNs
         XwU7SHxEbA/rV+teeHMhyX1oTUobydBYG3WDK8q9Cr4Ms80eo7zUNoAseqiygb9M4V+W
         aBCA==
X-Gm-Message-State: ANhLgQ3iAboEP5y11v5CuEklK5MmKwyX6kx4x2fjxG4Q552Eug0I711c
        c/+TPtjDe3vZlyaow01DAQTMpyqsPhr5cOIfYxXRI65OXjcT
X-Google-Smtp-Source: ADFU+vvMTAoPYSJdt0NqjeATWdk3ATQuBZJY8iF7dnyUzRDhkPyMGfMUAN60SOi43wEZNbEKenUPvO9/8JJD9SkaCKNsAwL1rAdJ
MIME-Version: 1.0
X-Received: by 2002:a5d:905a:: with SMTP id v26mr5532361ioq.77.1583553253718;
 Fri, 06 Mar 2020 19:54:13 -0800 (PST)
Date:   Fri, 06 Mar 2020 19:54:13 -0800
In-Reply-To: <000000000000d5529b05a03b2251@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bc0ca05a03bb963@google.com>
Subject: Re: general protection fault in __loop_clr_fd
From:   syzbot <syzbot+3967212746d25888b189@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141e2ae3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=3967212746d25888b189
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177ae1fde00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178fdfa1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3967212746d25888b189@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 0 PID: 10149 Comm: blkid Not tainted 5.6.0-rc3-next-20200228-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:workqueue_sysfs_unregister kernel/workqueue.c:5691 [inline]
RIP: 0010:destroy_workqueue+0x2e/0x6b0 kernel/workqueue.c:4351
Code: 49 89 fe 41 55 41 54 55 53 48 83 ec 08 e8 8a 6a 26 00 49 8d be 08 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e0 05 00 00 49 8b 9e 08 01 00 00 48 85 db 74 19
RSP: 0018:ffffc90002f27c30 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000021 RSI: ffffffff814c2af6 RDI: 0000000000000108
RBP: ffff8882189978f0 R08: ffff888096c505c0 R09: fffffbfff185270a
R10: fffffbfff1852709 R11: ffffffff8c29384f R12: ffff888218997800
R13: ffff88808dc478a0 R14: 0000000000000000 R15: ffff88808dc47680
FS:  00007fd99f56e740(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3095dcd000 CR3: 00000000a4478000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 loop_unprepare_queue drivers/block/loop.c:891 [inline]
 __loop_clr_fd+0x185/0x1280 drivers/block/loop.c:1210
 lo_release+0x1ad/0x1e7 drivers/block/loop.c:1928
 __blkdev_put+0x509/0x690 fs/block_dev.c:1896
 blkdev_close+0x86/0xb0 fs/block_dev.c:1965
 __fput+0x2da/0x850 fs/file_table.c:280
 task_work_run+0x13f/0x1b0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x672/0x790 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fd99ee762b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0 07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007ffc0a7acc98 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fd99ee762b0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000164a030
R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000005
Modules linked in:
---[ end trace 607b7fe0e8c7e1ae ]---
RIP: 0010:workqueue_sysfs_unregister kernel/workqueue.c:5691 [inline]
RIP: 0010:destroy_workqueue+0x2e/0x6b0 kernel/workqueue.c:4351
Code: 49 89 fe 41 55 41 54 55 53 48 83 ec 08 e8 8a 6a 26 00 49 8d be 08 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e0 05 00 00 49 8b 9e 08 01 00 00 48 85 db 74 19
RSP: 0018:ffffc90002f27c30 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000021 RSI: ffffffff814c2af6 RDI: 0000000000000108
RBP: ffff8882189978f0 R08: ffff888096c505c0 R09: fffffbfff185270a
R10: fffffbfff1852709 R11: ffffffff8c29384f R12: ffff888218997800
R13: ffff88808dc478a0 R14: 0000000000000000 R15: ffff88808dc47680
FS:  00007fd99f56e740(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3095dcd000 CR3: 00000000a4478000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

