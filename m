Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAAC82E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 10:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfHFI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 04:58:07 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198]:33665 "EHLO
        mail-oi1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbfHFI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:58:07 -0400
Received: by mail-oi1-f198.google.com with SMTP id e11so34195197oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uj9DgGBQ1081hcSAOYOtXJSIxxfURrcQW5RTMV36yYs=;
        b=ZyWMcovSdcBJ7LNWcgxgpZxpEm+sa/rvXFSPk/Pi0gnKhlNl7JiM1JpL9Gk3Rew0/Q
         zpIVYy8Qc0/ukCnyMw6LzGn3d/2qIzNogkUAyK+hggN0Dj0QxhzQ/drNq9muef13HKo+
         IkmTjHn8JR8jeVhlHLcdsniCeMt9KngiP8S+Egi2kWQmeRK0sINTkIp4MwkbVK3bjAKa
         Uhyi2c+R5s0skwkmaG7X6YkwTxnEAUx+QQ+T3uEQyK/5ZRGPJ8faf4IFziywvC1DYC3f
         gAzcFZestpzoUtoa0uIl2QjpVMaJkHRF+rLppGvWl2oQ59WjDI9fJktofvNMSui1ie83
         f9+g==
X-Gm-Message-State: APjAAAVc6OkdzFgnKqFnYwM6TMCVpNZ0AGN9IETIhhGRaUJqvm/a57re
        eOJRgQAgdNw+K0UGdHtogW96D8uiWgt7FhgmvyJkq0BD1INa
X-Google-Smtp-Source: APXvYqwdt1Ei4nZhSslwmCb3EgbDh4JGzGVOf/rludFlIA1aCMimM+WBiJtWCEPAt38qRTde63ifQwO4/WGTiQxhHRgtKQ/7rQvF
MIME-Version: 1.0
X-Received: by 2002:a6b:b985:: with SMTP id j127mr2508318iof.186.1565081885800;
 Tue, 06 Aug 2019 01:58:05 -0700 (PDT)
Date:   Tue, 06 Aug 2019 01:58:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9038f058f6f053a@google.com>
Subject: memory leak in internal_dev_create
From:   syzbot <syzbot+13210896153522fe1ee5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pshelar@ovn.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e78030e Merge tag 'mmc-v5.3-rc1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148d3d1a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30cef20daf3e9977
dashboard link: https://syzkaller.appspot.com/bug?extid=13210896153522fe1ee5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136aa8c4600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109ba792600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+13210896153522fe1ee5@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881207e4100 (size 128):
   comm "syz-executor032", pid 7014, jiffies 4294944027 (age 13.830s)
   hex dump (first 32 bytes):
     00 70 16 18 81 88 ff ff 80 af 8c 22 81 88 ff ff  .p........."....
     00 b6 23 17 81 88 ff ff 00 00 00 00 00 00 00 00  ..#.............
   backtrace:
     [<000000000eb78212>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000000eb78212>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000000eb78212>] slab_alloc mm/slab.c:3319 [inline]
     [<000000000eb78212>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000006ea6c6>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000006ea6c6>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000006ea6c6>] ovs_vport_alloc+0x37/0xf0  
net/openvswitch/vport.c:130
     [<00000000f9a04a7d>] internal_dev_create+0x24/0x1d0  
net/openvswitch/vport-internal_dev.c:164
     [<0000000056ee7c13>] ovs_vport_add+0x81/0x190  
net/openvswitch/vport.c:199
     [<000000005434efc7>] new_vport+0x19/0x80 net/openvswitch/datapath.c:194
     [<00000000b7b253f1>] ovs_dp_cmd_new+0x22f/0x410  
net/openvswitch/datapath.c:1614
     [<00000000e0988518>] genl_family_rcv_msg+0x2ab/0x5b0  
net/netlink/genetlink.c:629
     [<00000000d0cc9347>] genl_rcv_msg+0x54/0x9c net/netlink/genetlink.c:654
     [<000000006694b647>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<0000000088381f37>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:665
     [<00000000dad42a47>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<00000000dad42a47>] netlink_unicast+0x1ec/0x2d0  
net/netlink/af_netlink.c:1328
     [<0000000067e6b079>] netlink_sendmsg+0x270/0x480  
net/netlink/af_netlink.c:1917
     [<00000000aab08a47>] sock_sendmsg_nosec net/socket.c:637 [inline]
     [<00000000aab08a47>] sock_sendmsg+0x54/0x70 net/socket.c:657
     [<000000004cb7c11d>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2311
     [<00000000c4901c63>] __sys_sendmsg+0x80/0xf0 net/socket.c:2356
     [<00000000c10abb2d>] __do_sys_sendmsg net/socket.c:2365 [inline]
     [<00000000c10abb2d>] __se_sys_sendmsg net/socket.c:2363 [inline]
     [<00000000c10abb2d>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2363

BUG: memory leak
unreferenced object 0xffff88811723b600 (size 64):
   comm "syz-executor032", pid 7014, jiffies 4294944027 (age 13.830s)
   hex dump (first 32 bytes):
     01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 02 00 00 00 05 35 82 c1  .............5..
   backtrace:
     [<00000000352f46d8>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000352f46d8>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000352f46d8>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000352f46d8>] __do_kmalloc mm/slab.c:3653 [inline]
     [<00000000352f46d8>] __kmalloc+0x169/0x300 mm/slab.c:3664
     [<000000008e48f3d1>] kmalloc include/linux/slab.h:557 [inline]
     [<000000008e48f3d1>] ovs_vport_set_upcall_portids+0x54/0xd0  
net/openvswitch/vport.c:343
     [<00000000541e4f4a>] ovs_vport_alloc+0x7f/0xf0  
net/openvswitch/vport.c:139
     [<00000000f9a04a7d>] internal_dev_create+0x24/0x1d0  
net/openvswitch/vport-internal_dev.c:164
     [<0000000056ee7c13>] ovs_vport_add+0x81/0x190  
net/openvswitch/vport.c:199
     [<000000005434efc7>] new_vport+0x19/0x80 net/openvswitch/datapath.c:194
     [<00000000b7b253f1>] ovs_dp_cmd_new+0x22f/0x410  
net/openvswitch/datapath.c:1614
     [<00000000e0988518>] genl_family_rcv_msg+0x2ab/0x5b0  
net/netlink/genetlink.c:629
     [<00000000d0cc9347>] genl_rcv_msg+0x54/0x9c net/netlink/genetlink.c:654
     [<000000006694b647>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<0000000088381f37>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:665
     [<00000000dad42a47>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<00000000dad42a47>] netlink_unicast+0x1ec/0x2d0  
net/netlink/af_netlink.c:1328
     [<0000000067e6b079>] netlink_sendmsg+0x270/0x480  
net/netlink/af_netlink.c:1917
     [<00000000aab08a47>] sock_sendmsg_nosec net/socket.c:637 [inline]
     [<00000000aab08a47>] sock_sendmsg+0x54/0x70 net/socket.c:657
     [<000000004cb7c11d>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2311
     [<00000000c4901c63>] __sys_sendmsg+0x80/0xf0 net/socket.c:2356

BUG: memory leak
unreferenced object 0xffff8881228ca500 (size 128):
   comm "syz-executor032", pid 7015, jiffies 4294944622 (age 7.880s)
   hex dump (first 32 bytes):
     00 f0 27 18 81 88 ff ff 80 ac 8c 22 81 88 ff ff  ..'........"....
     40 b7 23 17 81 88 ff ff 00 00 00 00 00 00 00 00  @.#.............
   backtrace:
     [<000000000eb78212>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000000eb78212>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000000eb78212>] slab_alloc mm/slab.c:3319 [inline]
     [<000000000eb78212>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000006ea6c6>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000006ea6c6>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000006ea6c6>] ovs_vport_alloc+0x37/0xf0  
net/openvswitch/vport.c:130
     [<00000000f9a04a7d>] internal_dev_create+0x24/0x1d0  
net/openvswitch/vport-internal_dev.c:164
     [<0000000056ee7c13>] ovs_vport_add+0x81/0x190  
net/openvswitch/vport.c:199
     [<000000005434efc7>] new_vport+0x19/0x80 net/openvswitch/datapath.c:194
     [<00000000b7b253f1>] ovs_dp_cmd_new+0x22f/0x410  
net/openvswitch/datapath.c:1614
     [<00000000e0988518>] genl_family_rcv_msg+0x2ab/0x5b0  
net/netlink/genetlink.c:629
     [<00000000d0cc9347>] genl_rcv_msg+0x54/0x9c net/netlink/genetlink.c:654
     [<000000006694b647>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<0000000088381f37>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:665
     [<00000000dad42a47>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<00000000dad42a47>] netlink_unicast+0x1ec/0x2d0  
net/netlink/af_netlink.c:1328
     [<0000000067e6b079>] netlink_sendmsg+0x270/0x480  
net/netlink/af_netlink.c:1917
     [<00000000aab08a47>] sock_sendmsg_nosec net/socket.c:637 [inline]
     [<00000000aab08a47>] sock_sendmsg+0x54/0x70 net/socket.c:657
     [<000000004cb7c11d>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2311
     [<00000000c4901c63>] __sys_sendmsg+0x80/0xf0 net/socket.c:2356
     [<00000000c10abb2d>] __do_sys_sendmsg net/socket.c:2365 [inline]
     [<00000000c10abb2d>] __se_sys_sendmsg net/socket.c:2363 [inline]
     [<00000000c10abb2d>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2363



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
