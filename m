Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B309C2CDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfE1Reg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 13:34:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56572 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1Ref (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:34:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVfzd-0006to-PJ; Tue, 28 May 2019 11:34:33 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVfzc-0005WW-Pi; Tue, 28 May 2019 11:34:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     arnd@arndb.de, christian@brauner.io, deepa.kernel@gmail.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com>
References: <000000000000410d500588adf637@google.com>
Date:   Tue, 28 May 2019 12:34:28 -0500
In-Reply-To: <000000000000410d500588adf637@google.com> (syzbot's message of
        "Sun, 12 May 2019 03:07:05 -0700")
Message-ID: <87woia5vq3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hVfzc-0005WW-Pi;;;mid=<87woia5vq3.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+FvoIQYQPMYGzOzxLcqpXiLwLlcEocec4=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 634 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.4%), b_tie_ro: 1.84 (0.3%), parse: 0.73
        (0.1%), extract_message_metadata: 16 (2.6%), get_uri_detail_list: 3.3
        (0.5%), tests_pri_-1000: 12 (1.9%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 30 (4.8%), check_bayes: 29
        (4.6%), b_tokenize: 9 (1.5%), b_tok_get_all: 10 (1.6%), b_comp_prob:
        2.8 (0.4%), b_tok_touch_all: 4.9 (0.8%), b_finish: 0.57 (0.1%),
        tests_pri_0: 558 (88.0%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 3.4 (0.5%), poll_dns_idle: 0.30 (0.0%), tests_pri_10:
        1.88 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: KMSAN: kernel-infoleak in copy_siginfo_to_user (2)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Didn't someone already provide a fix for this one?

I thought  I saw that hit your tree a while ago.  I am looking in
ptrace.c and I don't see anything that would have fixed this issue.

If there isn't a fix in the queue I will take a stab at it.

Thank you
Eric

syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d062d017 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       kmsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=137348b4a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=67ebf8b3cce62ce7
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d602a1b0d8c95bdf299
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175d65e0a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ae05c0a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com
>
> ptrace attach of "./syz-executor353086472"[10278] was attempted by
> "./syz-executor353086472"[10279]
> ptrace attach of "./syz-executor353086472"[10280] was attempted by
> "./syz-executor353086472"[10281]
> ptrace attach of "./syz-executor353086472"[10282] was attempted by
> "./syz-executor353086472"[10283]
> ==================================================================
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
> CPU: 1 PID: 10284 Comm: syz-executor353 Not tainted 5.1.0-rc7+ #5
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>  kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:619
>  kmsan_internal_check_memory+0x974/0xa80 mm/kmsan/kmsan.c:713
>  kmsan_copy_to_user+0xa9/0xb0 mm/kmsan/kmsan_hooks.c:492
>  _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
>  copy_to_user include/linux/uaccess.h:174 [inline]
>  copy_siginfo_to_user+0x80/0x160 kernel/signal.c:3059
>  ptrace_peek_siginfo kernel/ptrace.c:742 [inline]
>  ptrace_request+0x24bd/0x2950 kernel/ptrace.c:913
>  arch_ptrace+0x9fa/0x1090 arch/x86/kernel/ptrace.c:868
>  __do_sys_ptrace kernel/ptrace.c:1155 [inline]
>  __se_sys_ptrace+0x2b9/0x7b0 kernel/ptrace.c:1120
>  __x64_sys_ptrace+0x56/0x70 kernel/ptrace.c:1120
>  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x441cc9
> Code: e8 bc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 1b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00000000007efdd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
> RAX: ffffffffffffffda RBX: 0000000000000063 RCX: 0000000000441cc9
> RDX: 00000000200000c0 RSI: 0000000000000007 RDI: 0000000000004209
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000716000 R11: 0000000000000246 R12: 0000000000000002
> R13: 0000000000402a00 R14: 0000000000000000 R15: 0000000000000000
>
> Local variable description: ----info.i@ptrace_request
> Variable was created at:
>  ptrace_peek_siginfo kernel/ptrace.c:714 [inline]
>  ptrace_request+0x2161/0x2950 kernel/ptrace.c:913
>  arch_ptrace+0x9fa/0x1090 arch/x86/kernel/ptrace.c:868
>
> Bytes 0-47 of 48 are uninitialized
> Memory access of size 48 starts at ffff8880a902fd70
> Data copied to user address 0000000000716000
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
