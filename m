Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1E14380A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:07:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:45007 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:07:09 -0500
Received: by mail-il1-f197.google.com with SMTP id h87so1560216ild.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/e/lbhOe50qLSQCly7199QAK89GWh0HEe/CGSD5GHRI=;
        b=rO/CzGeyHfApWt2/BOJc+F1SMh9JJupucQqpL/I5p+cH4jnc2Vu3GhfucnYijonDwj
         fg2lRvoCg9fNEbA8uAbtlzUq5PoR1GdzQLQ5i2/MDTPmRCYNiEs9Vzj0H/9iIp0fUdlY
         zsaC7CC7mi3nz/Sa6lmWUsz+9NRnuxRhtuCqzPIjzN/MSXUbdDifRDd5mlBCE5bGu821
         2X5CNCBSQElobEPI8jWO/5iec2Wmhkkw1JJ6+UOO05E3KSmxVq7eN3K3o3v29q2Ylekm
         ln4dV/91534DzlXg0f0p+Jteh2BEsoJky+dUK9r2R6xro5s8IK8rpGTdzIgSdNIXDU/P
         BfmQ==
X-Gm-Message-State: APjAAAU7eHRTA+cniaDKKUyD2MWP1YP1/a3DwHaNubCbw0hV4cXWX3Yx
        KhCVOaaCRtQacbJKdX1Yixctqy8oTRZRw58E2Z6EloTnatdM
X-Google-Smtp-Source: APXvYqxRf9Qnop/0zsfFWue0r4AHS9BRK0CbENBtYV1hFFYh4DeFyryU6a4UvxoHQZu15EBy01C8EvKzg+xpQzzuEGIbZyR7UzTp
MIME-Version: 1.0
X-Received: by 2002:a92:503:: with SMTP id q3mr2391008ile.160.1579594028856;
 Tue, 21 Jan 2020 00:07:08 -0800 (PST)
Date:   Tue, 21 Jan 2020 00:07:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fabdd0059ca1e400@google.com>
Subject: KASAN: slab-out-of-bounds Read in fb_pad_aligned_buffer
From:   syzbot <syzbot+be70641646cda31e78d9@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2747d5fd Add linux-next specific files for 20200116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c99b59e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22f506e7a3a37fe2
dashboard link: https://syzkaller.appspot.com/bug?extid=be70641646cda31e78d9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+be70641646cda31e78d9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0x138/0x160 drivers/video/fbdev/core/fbmem.c:116
Read of size 1 at addr ffff88804eb51fd0 by task syz-executor.4/12300

CPU: 0 PID: 12300 Comm: syz-executor.4 Not tainted 5.5.0-rc6-next-20200116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
 fb_pad_aligned_buffer+0x138/0x160 drivers/video/fbdev/core/fbmem.c:116
 bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:99 [inline]
 bit_putcs+0xd14/0xf10 drivers/video/fbdev/core/bitblit.c:185
 fbcon_putcs+0x33c/0x3e0 drivers/video/fbdev/core/fbcon.c:1359
 con_flush drivers/tty/vt/vt.c:2546 [inline]
 do_con_write.part.0+0xebd/0x1ef0 drivers/tty/vt/vt.c:2799
 do_con_write drivers/tty/vt/vt.c:2565 [inline]
 con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
 __vfs_write+0x8a/0x110 fs/read_write.c:494
 vfs_write+0x268/0x5d0 fs/read_write.c:558
 ksys_write+0x14f/0x290 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b349
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7d0c75ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7d0c75b6d4 RCX: 000000000045b349
RDX: 00000000000000fc RSI: 0000000020000180 RDI: 0000000000000007
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000be9 R14: 00000000004c8999 R15: 000000000075bfd4

Allocated by task 10134:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x163/0x770 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 fbcon_set_font+0x32d/0x860 drivers/video/fbdev/core/fbcon.c:2669
 con_font_set drivers/tty/vt/vt.c:4538 [inline]
 con_font_op+0xe30/0x1270 drivers/tty/vt/vt.c:4603
 vt_ioctl+0x181a/0x26d0 drivers/tty/vt/vt_ioctl.c:965
 tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:760
 __do_sys_ioctl fs/ioctl.c:769 [inline]
 __se_sys_ioctl fs/ioctl.c:767 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:767
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9748:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 skb_free_head+0x93/0xb0 net/core/skbuff.c:592
 pskb_expand_head+0x2bd/0xff0 net/core/skbuff.c:1662
 netlink_trim+0x1fe/0x260 net/netlink/af_netlink.c:1284
 netlink_broadcast_filtered+0x67/0xd20 net/netlink/af_netlink.c:1489
 netlink_broadcast net/netlink/af_netlink.c:1534 [inline]
 nlmsg_multicast include/net/netlink.h:968 [inline]
 nlmsg_notify+0x93/0x250 net/netlink/af_netlink.c:2520
 nfnetlink_send+0x63/0x80 net/netfilter/nfnetlink.c:141
 nf_tables_flowtable_notify+0x22f/0x380 net/netfilter/nf_tables_api.c:6441
 nf_tables_commit+0x1137/0x3c90 net/netfilter/nf_tables_api.c:7184
 nfnetlink_rcv_batch+0xdb5/0x1780 net/netfilter/nfnetlink.c:485
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:543 [inline]
 nfnetlink_rcv+0x3e7/0x460 net/netfilter/nfnetlink.c:561
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
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

The buggy address belongs to the object at ffff88804eb50000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 8144 bytes inside of
 8192-byte region [ffff88804eb50000, ffff88804eb52000)
The buggy address belongs to the page:
page:ffffea00013ad400 refcount:1 mapcount:0 mapping:ffff8880aa4021c0 index:0x0 compound_mapcount: 0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea00013ad308 ffffea00013b6c08 ffff8880aa4021c0
raw: 0000000000000000 ffff88804eb50000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88804eb51e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804eb51f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88804eb51f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                 ^
 ffff88804eb52000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804eb52080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
