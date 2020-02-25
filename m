Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB57A16B752
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 02:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgBYBsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 20:48:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:49211 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgBYBsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:48:13 -0500
Received: by mail-il1-f197.google.com with SMTP id p7so21998291ilq.16
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 17:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DwOxWulic73RxjwFhGbAWG6xr0sogpuOtGMOVnENdpw=;
        b=NwQGGv2izcZhSD+sIEw7x3kD9Vh67H7I5pIBUmBI8QvhY9NVzo69ruuSlFrQQlVhg7
         u3jlBxLmSxcdN/54VBxR0aFsywELiwvjyBBYMa+Tg+o9D769nsA2gquWWxC4dkNv3LbO
         0kQ39hDVw3wzBajfIYahe3CI2VBaLJtXe1/p1Gj1pq9upsvv4LI2LA2rU0gaZwVmqbjy
         K8nSY+Abc+FMFien0vJ3Y5IVg/OB5hfiQIio5BlpDkuhXZaLphJ1BWV2GcXxwfdH75rf
         7ntEC+AU8XAMId8Bt1GkDgZOrfD27isZU8SQTjUNza1mWln9BNMjjGJsQJk/HGAAK/kY
         dttA==
X-Gm-Message-State: APjAAAXqNSYbqs6yMBLyIdeJTi4xzVwGBcdUK18o5t0j6wbIc08dSGIR
        5Xpj8d2AypYR/vME96J0+Hgi3jEsUsUdZ6/AOUWrtYMSTgk+
X-Google-Smtp-Source: APXvYqysWAPjtehiszFnrhai12UfjdJ3bI84iQaIcNhRqURAGFrtrNs42drBRzQjHNh7uUtIidVuEt9Zu2YpT4DSFhngSQf2Dkt/
MIME-Version: 1.0
X-Received: by 2002:a02:cdd9:: with SMTP id m25mr53570273jap.123.1582595293217;
 Mon, 24 Feb 2020 17:48:13 -0800 (PST)
Date:   Mon, 24 Feb 2020 17:48:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046895c059f5cae37@google.com>
Subject: INFO: trying to register non-static key in xa_destroy
From:   syzbot <syzbot+2e80962bedd9559fe0b3@syzkaller.appspotmail.com>
To:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2045e158 r8169: remove RTL_EVENT_NAPI constants
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14791c81e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b8906eb6a7d6028
dashboard link: https://syzkaller.appspot.com/bug?extid=2e80962bedd9559fe0b3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1277fe09e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108d9109e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e80962bedd9559fe0b3@syzkaller.appspotmail.com

RBP: 00007ffcc52aa360 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 9669 Comm: syz-executor271 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:880 [inline]
 register_lock_class+0x179e/0x1850 kernel/locking/lockdep.c:1189
 __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3836
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
 xa_destroy+0xb8/0x2f0 lib/xarray.c:1990
 siw_device_cleanup+0x19/0x30 drivers/infiniband/sw/siw/siw_main.c:86
 ib_dealloc_device+0x48/0x230 drivers/infiniband/core/device.c:617
 siw_device_create drivers/infiniband/sw/siw/siw_main.c:436 [inline]
 siw_newlink drivers/infiniband/sw/siw/siw_main.c:556 [inline]
 siw_newlink+0x10aa/0x1310 drivers/infiniband/sw/siw/siw_main.c:542
 nldev_newlink+0x28a/0x430 drivers/infiniband/core/nldev.c:1538
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x5d9/0x980 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:672
 ____sys_sendmsg+0x753/0x880 net/socket.c:2343
 ___sys_sendmsg+0x100/0x170 net/socket.c:2397
 __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
 __do_sys_sendmsg net/socket.c:2439 [inline]
 __se_sys_sendmsg net/socket.c:2437 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441219
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcc52aa348 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441219
RDX: 0000000000000000 RSI: 00000000200031c0 RDI: 0000000000000003
RBP: 00007ffcc52aa360 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
