Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3715111FF39
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 08:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLPHwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 02:52:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:56290 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:52:08 -0500
Received: by mail-io1-f72.google.com with SMTP id z21so5158451iob.22
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 23:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/SUc6L9CEGTC6EK9DhB6P/6ByCfTnI7ryM7zsKSq2Yo=;
        b=hnQ2UdkAQe+vMrpXt0x4ooXoXsO4236In3+zJGExMN0+7VxP2wMBinTmPmRvQnvqvD
         0L2zEKZ9+qy7NNoTfmvmWzjfKe7Ww2tkxcoiwVeDb4SVzI+2ARnbuaX6eHhAhCalBYIU
         Crhgl8ruAIhfvV5OyYrT0SKQgasCQGWAzkL6p404/7OLDxjyFFJXN3ZDpDOyyub9UWMp
         PTcT/a5eP4PbScjE0fLNw88AWOeau/T/8ywPpZaQOKg79tZS7icl8b/WDDMmrykcdWcR
         A/MyBBMfw0LudrDRD5348g7vGPdnC+i2Yx3cgSZvPtW3GUJ1N5TsU85dr5hv7x1dmGEC
         ecJg==
X-Gm-Message-State: APjAAAXpf5AB8fXrVZPIcC1mu6Ix/Dubzs0ABTHThCoShpsKJv5Vt0y5
        twI5ZOkJUU5lAEKZKDIZLwLFVoAy/1ZY8U1k5UIvAqYq05ok
X-Google-Smtp-Source: APXvYqzw3Jy5wWYhvIcHtkV9KjuZFfCXkESDGPp/aVBkPUsGuhs34omo7If4I8wqh/sCN4Z2aEuFnpAuM+C2TEVM07ISqow0YtNZ
MIME-Version: 1.0
X-Received: by 2002:a92:3b98:: with SMTP id n24mr10933075ilh.189.1576482728132;
 Sun, 15 Dec 2019 23:52:08 -0800 (PST)
Date:   Sun, 15 Dec 2019 23:52:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000147a30599cd7d93@google.com>
Subject: general protection fault in _initial_num_blocks_is_ADDR
From:   syzbot <syzbot+b9cab61577c8d0a3c48e@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    07c4b9e9 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1049e3dee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=b9cab61577c8d0a3c48e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b9cab61577c8d0a3c48e@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 26867 Comm: kworker/u4:3 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: pencrypt_parallel padata_parallel_worker
RIP: 0010:_initial_num_blocks_is_017529+0x2f7/0x3e1
Code: 00 00 c4 e2 71 dd c8 c4 e2 69 dd d0 c4 e2 61 dd d8 c4 e2 59 dd e0 c4  
e2 51 dd e8 c4 e2 49 dd f0 c4 e2 41 dd f8 c4 62 39 dd c0 <c4> 21 7a 6f 24  
19 c4 c1 71 ef cc c4 a1 7a 7f 0c 1a c4 21 7a 6f 64
RSP: 0018:ffffc90004ed7680 EFLAGS: 00010206
RAX: 0000000000000010 RBX: 0000000000000f80 RCX: 0005088000000080
RDX: ffff888066da800d RSI: ffffc90004ed78f0 RDI: ffff888062285850
RBP: ffffc90004ed7b20 R08: 0000000000000f80 R09: 000000000000000d
R10: 0000000000000080 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000f80 R14: ffffc90004ed7728 R15: 0000000000004000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d333000 CR3: 0000000094a09000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  gcmaes_encrypt arch/x86/crypto/aesni-intel_glue.c:840 [inline]
  generic_gcmaes_encrypt+0x10d/0x160 arch/x86/crypto/aesni-intel_glue.c:1019
  crypto_aead_encrypt+0xaf/0xf0 crypto/aead.c:94
  simd_aead_encrypt+0x1a6/0x2b0 crypto/simd.c:335
  crypto_aead_encrypt+0xaf/0xf0 crypto/aead.c:94
  pcrypt_aead_enc+0x19/0x80 crypto/pcrypt.c:76
  padata_parallel_worker+0x28f/0x470 kernel/padata.c:81
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 26867 at kernel/locking/mutex.c:1419  
mutex_trylock+0x279/0x2f0 kernel/locking/mutex.c:1427


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
