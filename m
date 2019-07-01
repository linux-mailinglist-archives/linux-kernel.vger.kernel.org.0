Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDE54ADE9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfFRWhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 18:37:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48787 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfFRWhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:37:09 -0400
Received: by mail-io1-f71.google.com with SMTP id z19so17934023ioi.15
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 15:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5Z9WFP7V56BODtQ5UPOd/al4TrzSmswoyoPkjw+h188=;
        b=NPZx7kMzVZ25nDWAAXlbD2DRAlG3FbDxRmCQMSaVzyge71iDAdF9af6XsBWLBLxrPH
         /03oIlWYxERp2FkGP7IdKw+RhcGtVABTTNDTnOnBeT9VIHO00y5ojB/M1oUN1BgjBZU6
         v0tSeU8ruDKoDMT5LFbDTU+jgdswTHpxh5c54Cqu+2emy4zQljI/AlMWyVaoTb+NGG+t
         vvas2mHIrYmnph3sz80ksalCkTh/9oXkWXAq4fAKfgdPxLfG99RQGp8fQOGJv4ebJabZ
         cMsG6wZM/++baOqK2lK7PX8A6I0roG8EaY1PX6oDPJGu1VIIO6yPg1j6Jg3CxQ/rZy2w
         rY0A==
X-Gm-Message-State: APjAAAUML9QPvvb2TEMtSuGSBnYmF9qas8WS2JM2Qg7DLJMiXLyDIwBX
        /nfUUn/1/FdoD30C8216vLIgIvhnV3P/KkNMOiGN47Wn6I6F
X-Google-Smtp-Source: APXvYqxsUJJOKCWaPTd9Fq0B/2WwT4QJvL7Zcwv/ZJMc1ARDihT7NgaySKG/S93W/iYTgFuMV1PFh2BGWVmLMHvAB1OmeySLqKf+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:149:: with SMTP id y9mr66822563jao.76.1560897428867;
 Tue, 18 Jun 2019 15:37:08 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:37:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c75fb7058ba0c0e4@google.com>
Subject: memory leak in bio_copy_user_iov
From:   syzbot <syzbot+03e5c8ebd22cc6c3a8cb@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0011572c Merge branch 'for-5.2-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15193256a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
dashboard link: https://syzkaller.appspot.com/bug?extid=03e5c8ebd22cc6c3a8cb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13244221a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117b2432a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+03e5c8ebd22cc6c3a8cb@syzkaller.appspotmail.com

ram
executing program
BUG: memory leak
unreferenced object 0xffff8881204d7800 (size 2048):
   comm "syz-executor855", pid 6936, jiffies 4294941958 (age 26.780s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     20 00 00 00 02 01 00 00 00 00 00 00 08 00 00 00   ...............
   backtrace:
     [<00000000c5e27070>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000c5e27070>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c5e27070>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000c5e27070>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000c5e27070>] __kmalloc+0x161/0x2c0 mm/slab.c:3669
     [<000000004415e750>] kmalloc include/linux/slab.h:552 [inline]
     [<000000004415e750>] bio_alloc_bioset+0x1b8/0x2c0 block/bio.c:439
     [<000000002da58d1d>] bio_kmalloc include/linux/bio.h:391 [inline]
     [<000000002da58d1d>] bio_copy_user_iov+0x113/0x4a0 block/bio.c:1275
     [<00000000b4b23d95>] __blk_rq_map_user_iov block/blk-map.c:67 [inline]
     [<00000000b4b23d95>] blk_rq_map_user_iov+0xc6/0x2b0 block/blk-map.c:136
     [<00000000edad5f7e>] blk_rq_map_user+0x71/0xb0 block/blk-map.c:166
     [<00000000c94723b5>] sg_start_req drivers/scsi/sg.c:1813 [inline]
     [<00000000c94723b5>] sg_common_write.isra.0+0x619/0xa10  
drivers/scsi/sg.c:809
     [<00000000b11f3605>] sg_write.part.0+0x325/0x570 drivers/scsi/sg.c:709
     [<00000000aba41953>] sg_write+0x44/0x64 drivers/scsi/sg.c:617
     [<00000000afecd177>] __vfs_write+0x43/0xa0 fs/read_write.c:494
     [<00000000de690898>] vfs_write fs/read_write.c:558 [inline]
     [<00000000de690898>] vfs_write+0xee/0x210 fs/read_write.c:542
     [<00000000705a35b0>] ksys_write+0x7c/0x130 fs/read_write.c:611
     [<000000009efb9e6c>] __do_sys_write fs/read_write.c:623 [inline]
     [<000000009efb9e6c>] __se_sys_write fs/read_write.c:620 [inline]
     [<000000009efb9e6c>] __x64_sys_write+0x1e/0x30 fs/read_write.c:620
     [<00000000f9e48771>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000d5cff9fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
