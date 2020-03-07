Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70D17CB6D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 04:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCGDMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 22:12:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56298 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGDMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:12:13 -0500
Received: by mail-il1-f197.google.com with SMTP id p7so3062232ilr.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 19:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rGa49jzL97d8NBTpQJxKinf44vLh+Dm5/2B8sc7NuXA=;
        b=Y7E98pE/gpx1hKGpip3Su53aKiDapZMYxpeXXfw4qKk1qwNNBUoiZWgPcch2D7luit
         Y/x8tr5l7Zjff4jMjJOKNQja14yJosgBAp4B350Hg4X62WAv6AMstlWfBn3saGcvPfri
         tX5ZwsBZxeVrTsDsyWeUT1f1zi8we/jkELPv/JaRdUcSUzHW31V3sMhLYNXDUm6kWMvK
         Npd8RI71cFCcOI9S4gOPrTIfAuWfdJwZErGWls0+D8LDcsFa0AhB1WJuc2WCGQ69G6Ra
         uk9HsjgpUr02lkKkKUEhdj9JxkTsS4lJ2YK4HUX61inpz+1FPkCSDUV/3IikzluwR7kc
         2zMQ==
X-Gm-Message-State: ANhLgQ1em9K3A4sfQwgt3PTVFhTa3TWg/qHZzuj+3YS+XwlsvIictnZO
        q3QiyhTFZvMC/ie5NjQD5BX1a8ChZS4PZnEnRfXzyu+7wQA1
X-Google-Smtp-Source: ADFU+vsn/jjdVuTsM+rDcGkrH4gL31+pb5vITFI0gP9q2qHLjfECDFBd2lLhVSwRagNzG10JKg/QKQAqFU4pLgfZHfte7M+CxLyM
MIME-Version: 1.0
X-Received: by 2002:a92:6c0e:: with SMTP id h14mr3695514ilc.81.1583550731471;
 Fri, 06 Mar 2020 19:12:11 -0800 (PST)
Date:   Fri, 06 Mar 2020 19:12:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5529b05a03b2251@google.com>
Subject: general protection fault in __loop_clr_fd
From:   syzbot <syzbot+3967212746d25888b189@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=103aee2de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=3967212746d25888b189
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fc670de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3967212746d25888b189@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 1 PID: 9504 Comm: syz-executor.1 Not tainted 5.6.0-rc3-next-20200228-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:workqueue_sysfs_unregister kernel/workqueue.c:5691 [inline]
RIP: 0010:destroy_workqueue+0x2e/0x6b0 kernel/workqueue.c:4351
Code: 49 89 fe 41 55 41 54 55 53 48 83 ec 08 e8 8a 6a 26 00 49 8d be 08 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e0 05 00 00 49 8b 9e 08 01 00 00 48 85 db 74 19
RSP: 0018:ffffc90002277cc8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000021 RSI: ffffffff814c2af6 RDI: 0000000000000108
RBP: ffff888218af18f0 R08: ffff88809880e480 R09: fffffbfff185270a
R10: fffffbfff1852709 R11: ffffffff8c29384f R12: ffff888218af1800
R13: ffff888218af1804 R14: 0000000000000000 R15: 0000000000004c01
FS:  00000000027e1940(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa010a7d000 CR3: 0000000088d30000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 loop_unprepare_queue drivers/block/loop.c:891 [inline]
 __loop_clr_fd+0x185/0x1280 drivers/block/loop.c:1210
 loop_clr_fd drivers/block/loop.c:1335 [inline]
 lo_ioctl+0x2b4/0x1460 drivers/block/loop.c:1704
 __blkdev_driver_ioctl block/ioctl.c:321 [inline]
 blkdev_ioctl+0x25b/0x660 block/ioctl.c:717
 block_ioctl+0xe9/0x130 fs/block_dev.c:1983
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c317
Code: 48 83 c4 08 48 89 d8 5b 5d c3 66 0f 1f 84 00 00 00 00 00 48 89 e8 48 f7 d8 48 39 c3 0f 92 c0 eb 92 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 0d b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd75653418 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045c317
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000075 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd75653450 R14: 0000000000016fbc R15: 00007ffd75653460
Modules linked in:
---[ end trace 4ad871aadd3b1dba ]---
RIP: 0010:workqueue_sysfs_unregister kernel/workqueue.c:5691 [inline]
RIP: 0010:destroy_workqueue+0x2e/0x6b0 kernel/workqueue.c:4351
Code: 49 89 fe 41 55 41 54 55 53 48 83 ec 08 e8 8a 6a 26 00 49 8d be 08 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e0 05 00 00 49 8b 9e 08 01 00 00 48 85 db 74 19
RSP: 0018:ffffc90002277cc8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000021 RSI: ffffffff814c2af6 RDI: 0000000000000108
RBP: ffff888218af18f0 R08: ffff88809880e480 R09: fffffbfff185270a
R10: fffffbfff1852709 R11: ffffffff8c29384f R12: ffff888218af1800
R13: ffff888218af1804 R14: 0000000000000000 R15: 0000000000004c01
FS:  00000000027e1940(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f692de4b110 CR3: 0000000088d30000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
