Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6C56D168
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbfGRPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 11:51:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35947 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:51:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so30793786edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1/2Vj7xsNu11SnVwjU6bjgxspYgWkQ65EmdfVPZ5+g=;
        b=rrnpLwV7JKspeC+AT2HYLoo9is9pcRiv0lSu2Nwr16wbT8io4MRCltJUtLp6gxkOOp
         GrvYZW/wmX6ePV5SX6KzndxJF3rnLFHo6k0CuBRfOWW7BAyYgmWLia99W9sKY1XNqlMK
         S5F5yW2QFJVUeLDjwjndf4LM+WJ0CKJPICGGDQMqytNQgTmapQHO+cMj/SOFj2fF/Jlo
         Jl6iXHrdvgP1MaHj23a2/dWBd5A/yd+r2BTot1UI8B8CM19+Keu1npKPe3BosAitZu8m
         ZZIkNpY6HoTnZrMG1UIFMxz2Ev7Xe3Wft58UOkLropjQF4PlPrjtcdZAAY7o492IKrcY
         o8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1/2Vj7xsNu11SnVwjU6bjgxspYgWkQ65EmdfVPZ5+g=;
        b=bbiGtGgiveZJCd54I76j2y7SYraPBDa4AJtZIHPC7Oblf0yHxLB6/HIsbCo8G7RxtD
         KFWiCKOFaCAcorqdrwz1wfar0uDOi0QwHgZoDYm2KmAWwT6YOo0NAEw1m0mPz/8GTm7W
         sqUqlmNGRQz1ExC6bf6S+H37vsdwUn92rvjNP3i58AIW3qJJGGpf2HXS7DnrqhTq8ZAJ
         ubJgN2M1EeEvUm7/Ir85Cq7TjvzicmIUE9TiuBqT9RPXpf3StbLXvfJigEPd+M39zTTc
         zx9RRd6t9hCovFO8vw7kEyK29dSYC15NsiAhhmu6q3GbtckoECmwoQoGhTL9O6ASukXe
         5pYw==
X-Gm-Message-State: APjAAAXOWu0FxFPWDMWYBEIQYPDRPJxvSHRNpXTemGcqhhn+Yv3SFp0h
        2OvKoIigTF9iYE3cMf+TN1OK9chq2Pz2+yLm7eDbGQ==
X-Google-Smtp-Source: APXvYqw00ujty99sE0UwyCrWserbFlWAFCGTN+6SZBiwaPFyqiJ29qMg1gTGBJT2Tgv5+5XWImY/7i+W2RoFb/dclQs=
X-Received: by 2002:a17:906:4bcb:: with SMTP id x11mr36854194ejv.1.1563465110036;
 Thu, 18 Jul 2019 08:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150532.GB17098@dennisz-mbp>
In-Reply-To: <20190708150532.GB17098@dennisz-mbp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Jul 2019 17:51:37 +0200
Message-ID: <CACT4Y+YevDd-y4Au33=mr-0-UQPy8NR0vmG8zSiCfmzx6gTB-w@mail.gmail.com>
Subject: Re: kasan: paging percpu + kasan causes a double fault
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Tejun Heo <tj@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 5:05 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> Hi Andrey, Alexander, and Dmitry,
>
> It was reported to me that when percpu is ran with param
> percpu_alloc=page or the embed allocation scheme fails and falls back to
> page that a double fault occurs.
>
> I don't know much about how kasan works, but a difference between the
> two is that we manually reserve vm area via vm_area_register_early().
> I guessed it had something to do with the stack canary or the irq_stack,
> and manually mapped the shadow vm area with kasan_add_zero_shadow(), but
> that didn't seem to do the trick.
>
> RIP resolves to the fixed_percpu_data declaration.
>
> Double fault below:
> [    0.000000] PANIC: double fault, error_code: 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7-00007-ge0afe6d4d12c-dirty #299
> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> [    0.000000] RIP: 0010:no_context+0x38/0x4b0
> [    0.000000] Code: df 41 57 41 56 4c 8d bf 88 00 00 00 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd 4c8
> [    0.000000] RSP: 0000:ffffc8ffffffff28 EFLAGS: 00010096
> [    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff50 RCX: 000000000000000b
> [    0.000000] RDX: fffff52000000030 RSI: 0000000000000003 RDI: ffffc90000000130
> [    0.000000] RBP: ffffc900000000a8 R08: 0000000000000001 R09: 0000000000000000
> [    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> [    0.000000] R13: fffff52000000030 R14: 0000000000000000 R15: ffffc90000000130
> [    0.000000] FS:  0000000000000000(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.000000] CR2: ffffc8ffffffff18 CR3: 0000000002e0d001 CR4: 00000000000606b0
> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.000000] Call Trace:
> [    0.000000] Kernel panic - not syncing: Machine halted.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7-00007-ge0afe6d4d12c-dirty #299
> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> [    0.000000] Call Trace:
> [    0.000000]  <#DF>
> [    0.000000]  dump_stack+0x5b/0x90
> [    0.000000]  panic+0x17e/0x36e
> [    0.000000]  ? __warn_printk+0xdb/0xdb
> [    0.000000]  ? spurious_kernel_fault_check+0x1a/0x60
> [    0.000000]  df_debug+0x2e/0x39
> [    0.000000]  do_double_fault+0x89/0xb0
> [    0.000000]  double_fault+0x1e/0x30
> [    0.000000] RIP: 0010:no_context+0x38/0x4b0
> [    0.000000] Code: df 41 57 41 56 4c 8d bf 88 00 00 00 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd 4c8
> [    0.000000] RSP: 0000:ffffc8ffffffff28 EFLAGS: 00010096
> [    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff50 RCX: 000000000000000b
> [    0.000000] RDX: fffff52000000030 RSI: 0000000000000003 RDI: ffffc90000000130
> [    0.000000] RBP: ffffc900000000a8 R08: 0000000000000001 R09: 0000000000000000
> [    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> [ 0.000000] R13: fffff52000000030 R14: 0000000000000000 R15: ffffc90000000130


Hi Dennis,

I don't have lots of useful info, but a naive question: could you stop
using percpu_alloc=page with KASAN? That should resolve the problem :)
We could even add a runtime check that will clearly say that this
combintation does not work.

I see that setup_per_cpu_areas is called after kasan_init which is
called from setup_arch. So KASAN should already map final shadow at
that point.
The only potential reason that I see is that setup_per_cpu_areas maps
the percpu region at address that is not covered/expected by
kasan_init. Where is page-based percpu is mapped? Is that covered by
kasan_init?
Otherwise, seeing the full stack trace of the fault may shed some light.
