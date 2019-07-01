Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34643C4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391364AbfFKHJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 03:09:07 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:52717 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391234AbfFKHJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:09:06 -0400
Received: by mail-it1-f198.google.com with SMTP id 192so1652869itx.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 00:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5M1tc8/aqZvB4gNuzBZv3Ea92eBulPyHsVIZCvpnu90=;
        b=PgTMbr7piycrQwqVXiPV7xy6BPTEyKPxQ2VB2M4COUTF1uwTItGFHDzLhXDK1g/siz
         9vTF/k5GExke0XxEwO5XjRGuWzZJT8B1Ukom3BteaXngEcyhcYmKsKbhFl0DpdRX/gbc
         E/YXHVgQst7Q2+ohS7IKkrOWrOl4YHOL0Wbk8iZA42Sp/Poq/ZmLWwK2zxyy55N+UU6r
         B4NaFGo2vXKc46xhBTEu80Oeg+19LJZDCe/q795ItXItS+p/xQlVXvHcFD9KRmPNOGux
         fENXFoQHwLIV9BfmVC3DSEpCBEsXeUdILcvFkLrMG0OGsBiikEJ96UVG0LA7PM5osPc/
         znKA==
X-Gm-Message-State: APjAAAUj/hvGfvow8lGbgOzeMQQx2AtONMxCdprnu+GKeBuwe4E56D4c
        qPRmNxSQjXw3egde5k31iVRq1pUNr9VRExM2M3peA3lQFgcV
X-Google-Smtp-Source: APXvYqxs6GzvFYBLbpypMgb72qVe7CERCuVKE4hBlaTuA0aWCQoEpeaImdXVUMPYJa/bJfROw7cce/WFbTKBmFMgZjwtxXH2Fy8c
MIME-Version: 1.0
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr35230149iok.252.1560236945456;
 Tue, 11 Jun 2019 00:09:05 -0700 (PDT)
Date:   Tue, 11 Jun 2019 00:09:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e64753058b06f83f@google.com>
Subject: WARNING: locking bug in icmp6_send (2)
From:   syzbot <syzbot+0ee50f3d30ce6a28b3cd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8d94a873 Merge branch 'PTP-support-for-the-SJA1105-DSA-dri..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137ca32ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7a0e5816ab80450
dashboard link: https://syzkaller.appspot.com/bug?extid=0ee50f3d30ce6a28b3cd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0ee50f3d30ce6a28b3cd@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 1 PID: 21834 at kernel/locking/lockdep.c:3765  
__lock_acquire+0x17b5/0x5490 kernel/locking/lockdep.c:3765
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 21834 Comm: syz-executor.1 Not tainted 5.2.0-rc3+ #21
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  __warn.cold+0x20/0x4d kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:__lock_acquire+0x17b5/0x5490 kernel/locking/lockdep.c:3765
Code: d2 0f 85 c7 2c 00 00 44 8b 3d e7 cf 29 08 45 85 ff 0f 85 57 f3 ff ff  
48 c7 c6 a0 c4 6b 87 48 c7 c7 80 9b 6b 87 e8 e9 d3 eb ff <0f> 0b e9 40 f3  
ff ff 0f 0b e9 83 f1 ff ff 8b 0d 07 b7 0e 09 85 c9
RSP: 0018:ffff88821af7ef30 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000008682 RSI: ffffffff815ac936 RDI: ffffed10435efdd8
RBP: ffff88821af7f0e0 R08: ffff8880a4f0a380 R09: fffffbfff1173161
R10: fffffbfff1173160 R11: ffffffff88b98b03 R12: 0000000087f13009
R13: 0000000000000090 R14: 0000000000049009 R15: 0000000000000000
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4303
  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
  _raw_spin_trylock+0x62/0x80 kernel/locking/spinlock.c:135
  spin_trylock include/linux/spinlock.h:348 [inline]
  icmpv6_xmit_lock net/ipv6/icmp.c:117 [inline]
  icmp6_send+0xf90/0x1de0 net/ipv6/icmp.c:529
  icmpv6_send+0xec/0x230 net/ipv6/ip6_icmp.c:43
  ip6_protocol_deliver_rcu+0x11bf/0x16c0 net/ipv6/ip6_input.c:419
  ip6_input_finish+0x84/0x170 net/ipv6/ip6_input.c:438
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  ip6_input+0xe4/0x3f0 net/ipv6/ip6_input.c:447
  dst_input include/net/dst.h:439 [inline]
  ip6_rcv_finish+0x1de/0x310 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  ipv6_rcv+0x10e/0x420 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x113/0x1a0 net/core/dev.c:4981
  __netif_receive_skb+0x2c/0x1d0 net/core/dev.c:5095
  netif_receive_skb_internal+0x108/0x390 net/core/dev.c:5185
  napi_frags_finish net/core/dev.c:5736 [inline]
  napi_gro_frags+0xad9/0xd10 net/core/dev.c:5810
  tun_get_user+0x2f3c/0x3ff0 drivers/net/tun.c:1982
  tun_chr_write_iter+0xbd/0x156 drivers/net/tun.c:2028
  call_write_iter include/linux/fs.h:1872 [inline]
  do_iter_readv_writev+0x5f8/0x8f0 fs/read_write.c:693
  do_iter_write fs/read_write.c:970 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:951
  vfs_writev+0x1b3/0x2f0 fs/read_write.c:1015
  do_writev+0x15b/0x330 fs/read_write.c:1058
  __do_sys_writev fs/read_write.c:1131 [inline]
  __se_sys_writev fs/read_write.c:1128 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1128
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459131
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 b9 fb ff c3 48  
83 ec 08 e8 fa 2c 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 43 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fb9afed2ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000003e RCX: 0000000000459131
RDX: 0000000000000001 RSI: 00007fb9afed2c00 RDI: 00000000000000f0
RBP: 000000000075bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fb9afed36d4
R13: 00000000004c7f9b R14: 00000000004de700 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
