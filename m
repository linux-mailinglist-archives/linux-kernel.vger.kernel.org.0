Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8A82444
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfHERwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 13:52:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55953 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHERwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:52:07 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so93039841ioh.22
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2CgEpJm4dc6plTMBewlYD9DVekR0ydsouo6c7dRQapo=;
        b=cB2l6TvhOyeUCKU1sG5rvvaQBBB7ELaSZ2yppWMmX/BoiMPi0FE0cVgY0OvWM3opv/
         5+ezvnq+LsOqJVsj9FFKwgWQRcuQxQ275sCFQ/IE3qdcejbAdWPQGZTsPNcN2YoYAEDv
         3V1082YRJJjEg/4jT1Kbf7pVitM2peWDQrKpaoALbaGfL4UaCetNwDKXx2ESYN6QTJgK
         7FJogd9ofbv+gX7AgVrOIMsKAuGM8X8vBMYpD/I0Js+43lWLxw8IHrHVeecSOOW8Wvnr
         oa7m8S4ykkCXwUYiYjArMyiXoJ1otPhuzo17lzz1tVpKk0gFrUfbs6XBVcJjTeYAqxfQ
         yS6w==
X-Gm-Message-State: APjAAAVNWCmPLbWvkibAJr6slp7vgV/0VrnsgUxUEGHGMtBZR8124HLP
        lGx3j3WWNx8qR6Ntd4AuRq+cq5u8d41EO8oJpVB87kD731KC
X-Google-Smtp-Source: APXvYqxRmARPYj4Nqgkpm82Fmphfj/+y18LbFnUWEzBcKGuASRhHNGfHfj0iftlQPvnLkcEhCpUTKLHZyPFDxPqVcpvSANlleQ5f
MIME-Version: 1.0
X-Received: by 2002:a6b:dd17:: with SMTP id f23mr1252383ioc.213.1565027527087;
 Mon, 05 Aug 2019 10:52:07 -0700 (PDT)
Date:   Mon, 05 Aug 2019 10:52:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0df7f058f625d13@google.com>
Subject: WARNING: refcount bug in blk_mq_free_request (2)
From:   syzbot <syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e21a712a Linux 5.3-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cf349a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=f4316dab9d4518b755eb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117a1906600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa11aa600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 16 at lib/refcount.c:190 refcount_sub_and_test_checked  
lib/refcount.c:190 [inline]
WARNING: CPU: 1 PID: 16 at lib/refcount.c:190  
refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.3.0-rc3 #98
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
RIP: 0010:refcount_sub_and_test_checked lib/refcount.c:190 [inline]
RIP: 0010:refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
Code: 1d 7e b3 64 06 31 ff 89 de e8 9c a3 35 fe 84 db 75 94 e8 53 a2 35 fe  
48 c7 c7 80 02 c6 87 c6 05 5e b3 64 06 01 e8 18 15 07 fe <0f> 0b e9 75 ff  
ff ff e8 34 a2 35 fe e9 6e ff ff ff 48 89 df e8 b7
RSP: 0018:ffff8880a990fbb0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000100 RSI: ffffffff815c3ba6 RDI: ffffed1015321f68
RBP: ffff8880a990fc48 R08: ffff8880a9900440 R09: ffffed1015d24101
R10: ffffed1015d24100 R11: ffff8880ae920807 R12: 00000000ffffffff
R13: 0000000000000001 R14: ffff8880a990fc20 R15: 0000000000000000
  refcount_dec_and_test_checked+0x1b/0x20 lib/refcount.c:220
  blk_mq_free_request+0x3b8/0x580 block/blk-mq.c:524
  __blk_mq_end_request block/blk-mq.c:550 [inline]
  blk_mq_end_request+0x456/0x560 block/blk-mq.c:559
  nbd_complete_rq+0x42/0x50 drivers/block/nbd.c:322
  blk_done_softirq+0x2fe/0x4d0 block/blk-softirq.c:37
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:603 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
  smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
