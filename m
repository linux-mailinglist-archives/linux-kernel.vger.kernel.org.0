Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819EF19AD76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbgDAOKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 10:10:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732856AbgDAOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:09:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so141950wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UOCBrsLhDTGLPX2D6iB/6Fd9JweEhJ8isj0WlI9VYo=;
        b=GS+PKjPZdueEZOw07f8wlD524/gBWG9HptdU97U/RJGApgq2iEgM5G15XbY45x5aCH
         q9BaQ6f6w7coFGDbNBgcXdy07Ox2kLCqOAchGxx9Oaq+xg6lmlwBlGrbSspoIkd7Du/u
         BC9Rw/g3x3+t70uwn7d0kBu/gIb/FBgOJwna0bdfCrGrzd2m4DJa6gLLvmZlf6wyW9VU
         0bhuxZu1yTUIGAbuRNLamD/c5AsPZVDb+9PLz6QXUAv8gFUDSVPLwgJuMsmIlHEsGIbq
         OAejhv/hrMUXWBBf8YspoMo1TXqx3UC0ziP2qXzMhB8MUCFDZIuPGTrZ81q/5xJu/feP
         bK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UOCBrsLhDTGLPX2D6iB/6Fd9JweEhJ8isj0WlI9VYo=;
        b=WFH/Gv/RWdIy+SYq+SwLb8aPrKlvAz4qQMsqOrsz0jNzXlKzp7uvlBCU6g9M5WCzKb
         uX23EL/jKlNhoRwiZj7LX8i3qRJyJ2hs9vL/8bpScUkbAXE1Fo3t+XP1b0HKq5es8qxr
         CvxvznfFVczfA3KqAPHXM338u/9fcEm8eqTL4vEk+IojXoZiTeFUR7R4DgvxbMhcz0iX
         RX7avxl18gQO2LcH3gnVjImMyEUNGWXLq2mIHxqIczv/lHqZcLKXWT44AycYuAj0Q5zo
         URgFk9mwpR4l3hMPrkF9DygsnbOICmJPnnnd0YADduLzAuaNdtvCpQmeXv9LGv635Aku
         ffcQ==
X-Gm-Message-State: ANhLgQ3x69TmGS+Sj0REsUgXNrmRJarS+OuPphYRHc9ppKQI8Ckzpiyw
        MxauJztaArzqzbR/5qhdUW+mH9ED03ceU0fgulQ=
X-Google-Smtp-Source: ADFU+vsZFudrdRTmHThHRp1Kdwv807i/mSI/kjsy9A0RjL6q27gGUig6/lTGxWoN/1Czr+86omvg0X5J5lrvCkjhok4=
X-Received: by 2002:a5d:674f:: with SMTP id l15mr25618140wrw.196.1585750197939;
 Wed, 01 Apr 2020 07:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200401104156.11564-1-david@redhat.com> <20200401104156.11564-2-david@redhat.com>
In-Reply-To: <20200401104156.11564-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 1 Apr 2020 16:09:46 +0200
Message-ID: <CAM9Jb+hoWTb1NEOzyTpz_cyW7x9cA_3eiGTEfaKO7+w3c5auzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix RCU stalls during deferred page initialization
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yiqian Wei <yiwei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> With CONFIG_DEFERRED_STRUCT_PAGE_INIT and without CONFIG_PREEMPT, it can
> happen that we get RCU stalls detected when booting up.
>
> [   60.474005] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   60.475000] rcu:  1-...0: (0 ticks this GP) idle=02a/1/0x4000000000000000 softirq=1/1 fqs=15000
> [   60.475000] rcu:  (detected by 0, t=60002 jiffies, g=-1199, q=1)
> [   60.475000] Sending NMI from CPU 0 to CPUs 1:
> [    1.760091] NMI backtrace for cpu 1
> [    1.760091] CPU: 1 PID: 20 Comm: pgdatinit0 Not tainted 4.18.0-147.9.1.el8_1.x86_64 #1
> [    1.760091] Hardware name: Red Hat KVM, BIOS 1.13.0-1.module+el8.2.0+5520+4e5817f3 04/01/2014
> [    1.760091] RIP: 0010:__init_single_page.isra.65+0x10/0x4f
> [    1.760091] Code: 48 83 cf 63 48 89 f8 0f 1f 40 00 48 89 c6 48 89 d7 e8 6b 18 80 ff 66 90 5b c3 31 c0 b9 10 00 00 00 49 89 f8 48 c1 e6 33 f3 ab <b8> 07 00 00 00 48 c1 e2 36 41 c7 40 34 01 00 00 00 48 c1 e0 33 41
> [    1.760091] RSP: 0000:ffffba783123be40 EFLAGS: 00000006
> [    1.760091] RAX: 0000000000000000 RBX: fffffad34405e300 RCX: 0000000000000000
> [    1.760091] RDX: 0000000000000000 RSI: 0010000000000000 RDI: fffffad34405e340
> [    1.760091] RBP: 0000000033f3177e R08: fffffad34405e300 R09: 0000000000000002
> [    1.760091] R10: 000000000000002b R11: ffff98afb691a500 R12: 0000000000000002
> [    1.760091] R13: 0000000000000000 R14: 000000003f03ea00 R15: 000000003e10178c
> [    1.760091] FS:  0000000000000000(0000) GS:ffff9c9ebeb00000(0000) knlGS:0000000000000000
> [    1.760091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.760091] CR2: 00000000ffffffff CR3: 000000a1cf20a001 CR4: 00000000003606e0
> [    1.760091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.760091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.760091] Call Trace:
> [    1.760091]  deferred_init_pages+0x8f/0xbf
> [    1.760091]  deferred_init_memmap+0x184/0x29d
> [    1.760091]  ? deferred_free_pages.isra.97+0xba/0xba
> [    1.760091]  kthread+0x112/0x130
> [    1.760091]  ? kthread_flush_work_fn+0x10/0x10
> [    1.760091]  ret_from_fork+0x35/0x40
> [   89.123011] node 0 initialised, 1055935372 pages in 88650ms
>
> The issue becomes visible when having a lot of memory (e.g., 4TB)
> assigned to a single NUMA node - a system that can easily be created
> using QEMU. Inside VMs on a hypervisor with quite some memory
> overcommit, this is fairly easy to trigger.
>
> Adding the cond_resched() makes RCU happy.
>
> Reported-by: Yiqian Wei <yiwei@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ca1453204e66..084cabffc90d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1877,6 +1877,7 @@ static int __init deferred_init_memmap(void *data)
>                         prev_nr_pages = nr_pages;
>                         pgdat->first_deferred_pfn = spfn;
>                         pgdat_resize_unlock(pgdat, &flags);
> +                       cond_resched();
>                         goto again;
>                 }
>         }
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.25.1
>
>
