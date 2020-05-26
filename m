Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6F199F32
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgCaTfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:35:14 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:54100 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgCaTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:35:14 -0400
Received: by mail-il1-f200.google.com with SMTP id a15so5498504ilh.20
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2lew1a0pD6ctFtAcsbPWqwFLxKM5Fc4DIihP/2hJOgM=;
        b=BhswKrpmanU6dTvfiDfBf4VTeFLJRxQbbpoZxs8wR4Nop4XBn3OKeaxR7FKhTImE0z
         mXfmoj94xps3ETETvitC5N3Al+SXnyZZ5OwhQtqlBK3N0lucNYjPNbHgn/W+zNRtiqaI
         BvKTS+WbGC1rnhJoR///zbis6W06w2jKXpbINDW29AJpjRe2ZdjPFmgpCg9jmOLyGyez
         Xl0LrSPcGXS6XvmlIihG1mh3lya8M/ftcGhyEqNgswg7AxFbeQ7mKhzApcHmyXPcFudL
         leP44MkRZ1ZxPNBqQZVCR3at56W+kf/CFypYBjHLq9fG0tZ/S9a5wIrOmIaE0CzZH8fr
         xSag==
X-Gm-Message-State: ANhLgQ0BIMvzJAlcIGYO9NOGCG8UEd3+zdaShO6J8opmlWZ8+xdKCu5f
        XKy3w0b5FBeY+v2j4JA2Au+8T1jyvYRf9f39zjvw5xEsx5CT
X-Google-Smtp-Source: ADFU+vtkND+tSDYyT9HIoKmY2lYsK3oP0SYPitgI/bMPIaOrmyf/BeUZRdmqTf4KEf7YXQRx5jYW3KzV4EPlQvZW1H505116gC8s
MIME-Version: 1.0
X-Received: by 2002:a02:9a18:: with SMTP id b24mr17919080jal.110.1585683313284;
 Tue, 31 Mar 2020 12:35:13 -0700 (PDT)
Date:   Tue, 31 Mar 2020 12:35:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d5cef05a22baa95@google.com>
Subject: KCSAN: data-race in glue_cbc_decrypt_req_128bit / glue_cbc_decrypt_req_128bit
From:   syzbot <syzbot+6a6bca8169ffda8ce77b@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, elver@google.com,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b12d66a6 mm, kcsan: Instrument SLAB free with ASSERT_EXCLU..
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=111f0865e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10bc0131c4924ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=6a6bca8169ffda8ce77b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a6bca8169ffda8ce77b@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in glue_cbc_decrypt_req_128bit / glue_cbc_decrypt_req_128bit

write to 0xffff88809966e128 of 8 bytes by task 24119 on cpu 0:
 u128_xor include/crypto/b128ops.h:67 [inline]
 glue_cbc_decrypt_req_128bit+0x396/0x460 arch/x86/crypto/glue_helper.c:144
 cbc_decrypt+0x26/0x40 arch/x86/crypto/serpent_avx2_glue.c:152
 crypto_skcipher_decrypt+0x65/0x90 crypto/skcipher.c:652
 _skcipher_recvmsg crypto/algif_skcipher.c:142 [inline]
 skcipher_recvmsg+0x7fa/0x8c0 crypto/algif_skcipher.c:161
 skcipher_recvmsg_nokey+0x5e/0x80 crypto/algif_skcipher.c:279
 sock_recvmsg_nosec net/socket.c:886 [inline]
 sock_recvmsg net/socket.c:904 [inline]
 sock_recvmsg+0x92/0xb0 net/socket.c:900
 ____sys_recvmsg+0x167/0x3a0 net/socket.c:2566
 ___sys_recvmsg+0xb2/0x100 net/socket.c:2608
 __sys_recvmsg+0x9d/0x160 net/socket.c:2642
 __do_sys_recvmsg net/socket.c:2652 [inline]
 __se_sys_recvmsg net/socket.c:2649 [inline]
 __x64_sys_recvmsg+0x51/0x70 net/socket.c:2649
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff88809966e128 of 8 bytes by task 24118 on cpu 1:
 u128_xor include/crypto/b128ops.h:67 [inline]
 glue_cbc_decrypt_req_128bit+0x37c/0x460 arch/x86/crypto/glue_helper.c:144
 cbc_decrypt+0x26/0x40 arch/x86/crypto/serpent_avx2_glue.c:152
 crypto_skcipher_decrypt+0x65/0x90 crypto/skcipher.c:652
 _skcipher_recvmsg crypto/algif_skcipher.c:142 [inline]
 skcipher_recvmsg+0x7fa/0x8c0 crypto/algif_skcipher.c:161
 skcipher_recvmsg_nokey+0x5e/0x80 crypto/algif_skcipher.c:279
 sock_recvmsg_nosec net/socket.c:886 [inline]
 sock_recvmsg net/socket.c:904 [inline]
 sock_recvmsg+0x92/0xb0 net/socket.c:900
 ____sys_recvmsg+0x167/0x3a0 net/socket.c:2566
 ___sys_recvmsg+0xb2/0x100 net/socket.c:2608
 __sys_recvmsg+0x9d/0x160 net/socket.c:2642
 __do_sys_recvmsg net/socket.c:2652 [inline]
 __se_sys_recvmsg net/socket.c:2649 [inline]
 __x64_sys_recvmsg+0x51/0x70 net/socket.c:2649
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 24118 Comm: syz-executor.1 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
