Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077E41525AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 05:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgBEEsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 23:48:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35919 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgBEEsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:48:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so335843pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 20:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZhwhXFLLIQr7DVIGzMKuSw5rQqYRmjKeHJ5MjcqT160=;
        b=fWaJC9jSvY4uEOCiYJdDkHdKoWKQNtYzVMAMvwQNnjlm/pmzTFpVTEtcCL6Ast/pgv
         AX9FUIi02T7oEhIaCVRZLau5W+ti4OccS6em7n2nPeBO+7wv1Ak8NfmuL9RxA2aJx39k
         eZE2vIW5dIJtWsuDMVXlpgUBflvjvJyjT5JiFa3ygh1kfcilsFWCVcWTFr4QRNJk2IbJ
         trPOEhPzOKFuli7CmQYQ0dUU6O1KsE/1CioUT5aIlnv1OebXfURckfnC8dsFiNJk2gK7
         o4bZTDlX7ZIiU8IiW6fM4cX+n61wdnTu7+djgOWvKz6iHmsj7A1dIAhid2uTydOPzx0d
         ogDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZhwhXFLLIQr7DVIGzMKuSw5rQqYRmjKeHJ5MjcqT160=;
        b=tBA7y/ThVgPi3Y6re2ilR8Uh6jFZRvE/hvePXf3x2ouujxUN0xswLHKLTrUoKgfbjw
         17Vg9PrD3dYn4Se1wiavcO5BlQg2mDqFRZpBQaLcPHX3aak/OG3nfaucTNsSaBD10XWS
         hnFMXyY0QVjTFDMIUxdFC4xrHK23lLkkAoWOOEs+N0UQYxcScXyEm6yi3M3E/3l9ye8j
         NznEAF+PNAlOx/6PkNOwZsNFhhX48SgDwnpBdqUf8FKKmZjrumjSc2AtWcrrg27hB4ef
         OpZHnuGHBOBUaIf0R13B2oPkrKJ5g0y1PARsVXIeyoMHguvzjIhXgTeP+m17j/7Z9D5T
         /EbQ==
X-Gm-Message-State: APjAAAVaaLh1u9hU+OL2ACxWznm6SN6KCd/W9XySd4/Bxc4i3xFbKNTM
        2gI61N+qdhHWxJWu4rQZbdM=
X-Google-Smtp-Source: APXvYqxrzxKcOq3aJDsD1kQQ78eR9+ySGuSeeWuRs81gkmuawDA4Y1++2D0EpLklAslxp0LyC1lIvw==
X-Received: by 2002:a63:d24b:: with SMTP id t11mr24931760pgi.443.1580878131245;
        Tue, 04 Feb 2020 20:48:51 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id k63sm5252053pjb.10.2020.02.04.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 20:48:50 -0800 (PST)
Date:   Wed, 5 Feb 2020 13:48:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     lijiang <lijiang@redhat.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200205044848.GH41358@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/05 12:25), lijiang wrote:
[..]
> [   42.111004] Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   42.111005] general protection fault: 0000 [#1] SMP PTI
> [   42.111005] CPU: 15 PID: 1395 Comm: systemd-journal Not tainted 5.5.0-rc7+ #4
> [   42.111005] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.6024.071720181717 07/17/2018
> [   42.111006] RIP: 0010:copy_data+0xf2/0x1e0
> [   42.111006] Code: eb 08 49 83 c4 08 0f 84 8e 00 00 00 4c 89 74 24 08 4c 89 cd 41 89 d6 44 89 44 24 04 49 39 db 0f 87 c6 00 00 00 4d 85 c9 74 43 <41> c7 01 00 00 00 00 48 85 db 74 37 4c 89 e7 48 89 da 41 bf 01 00
> [   42.111007] RSP: 0018:ffffbbe207a7bd80 EFLAGS: 00010002
> [   42.111007] RAX: ffffa075d44ca000 RBX: 00000000000000a8 RCX: fffffffffff000b0
> [   42.111008] RDX: 00000000000000a8 RSI: 00000fffffffff01 RDI: ffffffffa1456e00
> [   42.111008] RBP: 0801364600307073 R08: 0000000000002000 R09: 0801364600307073
> [   42.111008] R10: fffffffffff00000 R11: 00000000000000a8 R12: ffffffffa1e98330
> [   42.111009] R13: 00000000d7efbe00 R14: 00000000000000a8 R15: 00000000ffffc000
> [   42.111009] FS:  00007f7c5642a980(0000) GS:ffffa075df5c0000(0000) knlGS:0000000000000000
> [   42.111010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.111010] CR2: 00007ffe95f4c4c0 CR3: 000000084fbfc004 CR4: 00000000003606e0
> [   42.111011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   42.111011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   42.111012] Call Trace:
> [   42.111012]  _prb_read_valid+0xd8/0x190
> [   42.111012]  prb_read_valid+0x15/0x20
> [   42.111013]  devkmsg_read+0x9d/0x2a0
> [   42.111013]  vfs_read+0x91/0x140
> [   42.111013]  ksys_read+0x59/0xd0
> [   42.111014]  do_syscall_64+0x55/0x1b0
> [   42.111014]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   42.111014] RIP: 0033:0x7f7c55740b62
> [   42.111015] Code: 94 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 e6 d8 20 00 85 c0 75 12 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
> [   42.111015] RSP: 002b:00007ffe95f4c4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   42.111016] RAX: ffffffffffffffda RBX: 00007ffe95f4e500 RCX: 00007f7c55740b62
> [   42.111016] RDX: 0000000000002000 RSI: 00007ffe95f4c4b0 RDI: 0000000000000008
> [   42.111017] RBP: 0000000000000000 R08: 0000000000000100 R09: 0000000000000003
> [   42.111017] R10: 0000000000000100 R11: 0000000000000246 R12: 00007ffe95f4c4b0

So there is a General protection fault. That's the type of a problem that
kills the boot for me as well (different backtrace, tho).

	-ss
