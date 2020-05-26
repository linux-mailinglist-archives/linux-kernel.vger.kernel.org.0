Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E5519A5DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbgDAHEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 03:04:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44811 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbgDAHEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:04:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so25974769qkc.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=El2QKEKkvpg6iAWNInUHfxZbiEumudKWoBkgubLXWZA=;
        b=s2hg2htp5hxoEWqtFZrybH253BnBuQZC/c0U+8hvebmFiQtkag4z9EhA/VJNkOnXwe
         y+obuAWSIsWOpse5qXc3sud4KwnYfQTkDRFwqGJ1xIs7a7Ghs5Dwx9vQcZ1gEER9tyWY
         Q17Anv/lWhT7McaHWAQE/1HeSSFxApEeLbcLPdk1v7TKw6/DsH/bzMHi+ckTG97/hvcm
         I/qEnik5ZAcvV+h71O0P/xwU6gqLXsRLKB7/3VZXuVzRW8Mg4JSAtvzTyA9f7cLBME8l
         5faDnwVDBpgKekEzmm5yMzZemyunI3qEBP48FzW51grEdzWJM3STVyF6doy8SvFx6+gp
         Sy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=El2QKEKkvpg6iAWNInUHfxZbiEumudKWoBkgubLXWZA=;
        b=CwAT+VyNHJjorGDxrRdmFELc37P6Yxtp9X2U1gZZsDUq9Duor0jB+DaevUAnQh+zjg
         iJ1WWdtY7UzsUUzt270JlW7la5uhxkn51VB7UlbwzMMwVk6kYI+0kreuwwZ4WS+Moqsd
         /pMIwb+d2WehADgqoMF97bQFMJ8/yAnaRKEg0HglPJE3RhPqxt6skD5XA+4Y5TWZFJVQ
         HVYPNlHBTfCwHms1OWvqrdJP8VZGWYGRjY+H9ckqcnbKFr0Yps6lUA+LEQw+iL3DSy+y
         leNTejrDqS/Q1Ztj6kEY+BpkpkiRaY5hpegTkt5kJomgs48q8MhJVi9YXhC7bk8p/P2k
         KVJw==
X-Gm-Message-State: ANhLgQ0I1kI0S08RjI9nbMx63QHBvBAD/56Co2kuZv/AZP6mwm1VE9bV
        B62ZDGLyZQX14UKaJTmAb+QEE8916nfyRJx+tToOBQ==
X-Google-Smtp-Source: ADFU+vuy057DXLdO0dRHxTb9pVmk5NJNDwnCh8OY/djQ716fL1PpAmxCQddIqpx3KaHqqAo9ftsvkmk929QeZ3/HlEo=
X-Received: by 2002:a37:664d:: with SMTP id a74mr8311709qkc.256.1585724661328;
 Wed, 01 Apr 2020 00:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009d5cef05a22baa95@google.com> <20200331202706.GA127606@gmail.com>
In-Reply-To: <20200331202706.GA127606@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Apr 2020 09:04:10 +0200
Message-ID: <CACT4Y+ZSTjPmPmiL_1JEdroNZXYgaKewDBEH6RugnhsDVd+bUQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in glue_cbc_decrypt_req_128bit / glue_cbc_decrypt_req_128bit
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+6a6bca8169ffda8ce77b@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        David Miller <davem@davemloft.net>,
        Marco Elver <elver@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:27 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Mar 31, 2020 at 12:35:13PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    b12d66a6 mm, kcsan: Instrument SLAB free with ASSERT_EXCLU..
> > git tree:       https://github.com/google/ktsan.git kcsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=111f0865e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=10bc0131c4924ba9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6a6bca8169ffda8ce77b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+6a6bca8169ffda8ce77b@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in glue_cbc_decrypt_req_128bit / glue_cbc_decrypt_req_128bit
> >
> > write to 0xffff88809966e128 of 8 bytes by task 24119 on cpu 0:
> >  u128_xor include/crypto/b128ops.h:67 [inline]
> >  glue_cbc_decrypt_req_128bit+0x396/0x460 arch/x86/crypto/glue_helper.c:144
> >  cbc_decrypt+0x26/0x40 arch/x86/crypto/serpent_avx2_glue.c:152
> >  crypto_skcipher_decrypt+0x65/0x90 crypto/skcipher.c:652
> >  _skcipher_recvmsg crypto/algif_skcipher.c:142 [inline]
> >  skcipher_recvmsg+0x7fa/0x8c0 crypto/algif_skcipher.c:161
> >  skcipher_recvmsg_nokey+0x5e/0x80 crypto/algif_skcipher.c:279
> >  sock_recvmsg_nosec net/socket.c:886 [inline]
> >  sock_recvmsg net/socket.c:904 [inline]
> >  sock_recvmsg+0x92/0xb0 net/socket.c:900
> >  ____sys_recvmsg+0x167/0x3a0 net/socket.c:2566
> >  ___sys_recvmsg+0xb2/0x100 net/socket.c:2608
> >  __sys_recvmsg+0x9d/0x160 net/socket.c:2642
> >  __do_sys_recvmsg net/socket.c:2652 [inline]
> >  __se_sys_recvmsg net/socket.c:2649 [inline]
> >  __x64_sys_recvmsg+0x51/0x70 net/socket.c:2649
> >  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > read to 0xffff88809966e128 of 8 bytes by task 24118 on cpu 1:
> >  u128_xor include/crypto/b128ops.h:67 [inline]
> >  glue_cbc_decrypt_req_128bit+0x37c/0x460 arch/x86/crypto/glue_helper.c:144
> >  cbc_decrypt+0x26/0x40 arch/x86/crypto/serpent_avx2_glue.c:152
> >  crypto_skcipher_decrypt+0x65/0x90 crypto/skcipher.c:652
> >  _skcipher_recvmsg crypto/algif_skcipher.c:142 [inline]
> >  skcipher_recvmsg+0x7fa/0x8c0 crypto/algif_skcipher.c:161
> >  skcipher_recvmsg_nokey+0x5e/0x80 crypto/algif_skcipher.c:279
> >  sock_recvmsg_nosec net/socket.c:886 [inline]
> >  sock_recvmsg net/socket.c:904 [inline]
> >  sock_recvmsg+0x92/0xb0 net/socket.c:900
> >  ____sys_recvmsg+0x167/0x3a0 net/socket.c:2566
> >  ___sys_recvmsg+0xb2/0x100 net/socket.c:2608
> >  __sys_recvmsg+0x9d/0x160 net/socket.c:2642
> >  __do_sys_recvmsg net/socket.c:2652 [inline]
> >  __se_sys_recvmsg net/socket.c:2649 [inline]
> >  __x64_sys_recvmsg+0x51/0x70 net/socket.c:2649
> >  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 24118 Comm: syz-executor.1 Not tainted 5.6.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > ==================================================================
> >
>
> I think this is a problem for almost all the crypto code.  Due to AF_ALG, both
> the source and destination buffers can be userspace pages that were gotten with
> get_user_pages().  Such pages can be concurrently modified, not just by the
> kernel but also by userspace.
>
> I'm not sure what can be done about this.

Oh, I thought it's something more serious like a shared crypto object.
Thanks for debugging.
I think I've seen this before in another context (b/149818448):

BUG: KCSAN: data-race in copyin / copyin

write to 0xffff888103c8b000 of 4096 bytes by task 20917 on cpu 0:
 instrument_copy_from_user include/linux/instrumented.h:106 [inline]
 copyin+0xab/0xc0 lib/iov_iter.c:151
 copy_page_from_iter_iovec lib/iov_iter.c:296 [inline]
 copy_page_from_iter+0x23f/0x5f0 lib/iov_iter.c:942
 process_vm_rw_pages mm/process_vm_access.c:46 [inline]
 process_vm_rw_single_vec mm/process_vm_access.c:120 [inline]
 process_vm_rw_core.isra.0+0x448/0x820 mm/process_vm_access.c:218
 process_vm_rw+0x1c4/0x1e0 mm/process_vm_access.c:286
 __do_sys_process_vm_writev mm/process_vm_access.c:308 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
 __x64_sys_process_vm_writev+0x8b/0xb0 mm/process_vm_access.c:303
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff888103c8b000 of 4096 bytes by task 20918 on cpu 1:
 instrument_copy_from_user include/linux/instrumented.h:106 [inline]
 copyin+0xab/0xc0 lib/iov_iter.c:151
 copy_page_from_iter_iovec lib/iov_iter.c:296 [inline]
 copy_page_from_iter+0x23f/0x5f0 lib/iov_iter.c:942
 process_vm_rw_pages mm/process_vm_access.c:46 [inline]
 process_vm_rw_single_vec mm/process_vm_access.c:120 [inline]
 process_vm_rw_core.isra.0+0x448/0x820 mm/process_vm_access.c:218
 process_vm_rw+0x1c4/0x1e0 mm/process_vm_access.c:286
 __do_sys_process_vm_writev mm/process_vm_access.c:308 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
 __x64_sys_process_vm_writev+0x8b/0xb0 mm/process_vm_access.c:303
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9


Marco, I think we need to ignore all memory that comes from
get_user_pages() somehow. Either not set watchpoints at all, or
perhaps filter them out later if the check is not totally free.
