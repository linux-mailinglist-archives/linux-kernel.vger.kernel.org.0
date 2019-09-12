Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19F4B0C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfILKEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 06:04:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43911 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730917AbfILKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:04:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so16637777oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFjR3x/t1L8W9OoYLALGOfYGjUCMKVWWBDyHX/ClFE4=;
        b=O1R3twuZdgB/0wVEPderGXPJb8QeX+HDCWhgCCmAvQbhINY3fGeMKvtqjRAC8uZlOi
         7WV/wsZdNuCx0QUuF7ixAY5ht1cowZIQZ35Y+Y+aDg/WsMgzna84cXAvgTyPvMcP/P88
         OcCubk/+H22yu37EmTrVxHOlyqFjA/30DHug/4v41K+jJwdr4J7q9B5QW9WmBZIp6mRt
         4tJ+ZbsvTt4AccOstVGEFMdPUgQe2eUtUsKy2I7eClhFtnf3F7lgtckmzdssrSF1e6JL
         WgjQpjrlk5ohbLwDt4QPd1UoPe1oddZsCnCX/q//qNfuduQADvw+NWcaQepYrkor4INC
         hwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFjR3x/t1L8W9OoYLALGOfYGjUCMKVWWBDyHX/ClFE4=;
        b=udgCneofdXCx+ZsA9ZLLvfx1q3kXr2ymG+Y0rAzFM03RgJm+nBIzy1g8dL0NuBZYp2
         nVXnGGipTxUn3cWugjpCzCU2ePNySHFiyjiURIexwx7gBFHforR8HcxxKXMdIST1Jk06
         roqtV0C/joEg4/u9GvNpwzWNiMfc2/1TMwE+QXJqi52ijcgr5axi8GMtFgRULugxgU70
         IXop8Q5s5Y8ibxLBAEI+gL2TK7KdLFXdjgMdZQSgCoZB7uU6rgkqYVZpUdxWEFIBWogy
         iA06W1IZZA76bKJkX8F1br6wU7H7X7YrDO+yaQOKa2kvXqEuNLwkxZXQ8Svc10d5NrLn
         VaiQ==
X-Gm-Message-State: APjAAAXSUr8mcD13aWJtqceUlFT9043Y45JYk6BHH1R5kMLLGKmb0B9l
        SlWqS7ytD+2Bu5aK9e3Wx/oNOWKbdHHxZN84WOrjiqPS
X-Google-Smtp-Source: APXvYqzTHtjr800SpTkA3FJPkS86GPBitapU7qiuAv6Ols1z9JLy3t8YBJ7+2jCoA3T85RzLqHVGV+gCE+kaDV0hNPg=
X-Received: by 2002:aca:ed52:: with SMTP id l79mr7515716oih.47.1568282669811;
 Thu, 12 Sep 2019 03:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190912083649.4688-1-chunguo.feng@amlogic.com>
In-Reply-To: <20190912083649.4688-1-chunguo.feng@amlogic.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 12 Sep 2019 12:04:18 +0200
Message-ID: <CAHUa44EEnBp5iaxWPzYyJyN0yuYFvmB44khtbz_Pi5F4P1_ufg@mail.gmail.com>
Subject: Re: [PATCH] tee: fix kasan check slab-out-of-bounds error.
To:     chunguo feng <chunguo.feng@amlogic.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunguo,

On Thu, Sep 12, 2019 at 10:36 AM chunguo feng <chunguo.feng@amlogic.com> wrote:
>
> From: fengchunguo <chunguo.feng@amlogic.com>
>
> Physical address should be set one shifting, but not cover shm struct data.
> If offs was set 0, it cause KASAN error.
>
> Log:
> [22.345259@0] BUG: KASAN: slab-out-of-bounds in optee_handle_rpc+0x644/0x858
> [22.352221@0] Read of size 4 at addr ffffffc0445485dc by task tee_preload_fw/2505
> [22.361280@0] CPU: 0 PID: 2505 Comm: tee_preload_fw Tainted: G    B   W  O
>                 4.19.53-01721-g11b1db7-dirty #417
> [22.376617@0] Call trace:
> [22.379220@0]  dump_backtrace+0x0/0x1b4
> [22.383003@0]  show_stack+0x20/0x28
> [22.386459@0]  dump_stack+0x8c/0xb4
> [22.389909@0]  print_address_description+0x10c/0x274
> [22.394819@0]  kasan_report+0x224/0x370
> [22.398616@0]  __asan_load4+0x6c/0x84
> [22.402238@0]  optee_handle_rpc+0x644/0x858
> [22.406375@0]  optee_do_call_with_arg+0x148/0x160
> [22.411033@0]  optee_open_session+0x1b0/0x340
> [22.415352@0]  tee_ioctl_open_session+0x28c/0x784
> [22.420006@0]  tee_ioctl+0x210/0x800
> [22.423546@0]  do_vfs_ioctl+0x104/0xe7c
> [22.427337@0]  __arm64_sys_ioctl+0xac/0xc0
> [22.431393@0]  invoke_syscall+0xd4/0xf4
> [22.435187@0]  el0_svc_common+0x88/0x128
> [22.439066@0]  el0_svc_handler+0x40/0x84
> [22.442947@0]  el0_svc+0x8/0xc
> [22.445962@0]
> [22.447602@0] Allocated by task 2508:
> [22.451231@0]  kasan_kmalloc.part.5+0x50/0x124
> [22.455627@0]  kasan_kmalloc+0xc4/0xe4
> [22.459334@0]  kmem_cache_alloc_trace+0x154/0x2bc
> [22.463994@0]  tee_shm_alloc+0xa0/0x340
> [22.467788@0]  tee_ioctl+0x39c/0x800
> [22.471324@0]  do_vfs_ioctl+0x104/0xe7c
> [22.475119@0]  __arm64_sys_ioctl+0xac/0xc0
> [22.479172@0]  invoke_syscall+0xd4/0xf4
> [22.482967@0]  el0_svc_common+0x88/0x128
> [22.486849@0]  el0_svc_handler+0x40/0x84
> [22.490728@0]  el0_svc+0x8/0xc
> [22.493743@0]
> [22.495384@0] Freed by task 0:
> [22.498408@0]  __kasan_slab_free+0x11c/0x21c
> [22.502631@0]  kasan_slab_free+0x10/0x18
> [22.506511@0]  kfree+0x8c/0x284
> [22.509625@0]  selinux_cred_free+0x48/0x64
> [22.513672@0]  security_cred_free+0x48/0x64
> [22.517817@0]  put_cred_rcu+0x3c/0x108
> [22.521523@0]  rcu_process_callbacks+0x308/0x7ac
> [22.526092@0]  __do_softirq+0x1c8/0x5c8
> [22.529882@0]
> [22.531527@0] The buggy address belongs to the object at ffffffc044548580
> [22.531527@0]  which belongs to the cache kmalloc-128 of size 128
> [22.544291@0] The buggy address is located 92 bytes inside of
> [22.544291@0]  128-byte region [ffffffc044548580, ffffffc044548600)
> [22.556190@0] The buggy address belongs to the page:
> [22.561110@0] page:ffffffbf01115200 count:1 mapcount:0 mapping:ffffffc04540c400 index:0x0 compound_mapcount: 0
> [22.571029@0] flags: 0x20094e4b00010200(slab|head)
> [22.575780@0] raw: 20094e4b00010200 ffffffbf01113408 ffffffbf01119508 ffffffc04540c400
> [22.583622@0] raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
> [22.591466@0] page dumped because: kasan: bad access detected
> [22.597157@0]
> [22.598797@0] Memory state around the buggy address:
> [22.603719@0]  ffffffc044548480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [22.611048@0]  ffffffc044548500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [22.618379@0] >ffffffc044548580: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
> [22.625707@0]                                                     ^
> [22.631920@0]  ffffffc044548600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [22.639251@0]  ffffffc044548680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [22.646580@0] ==================================================================
>
> Test:
> 1. Set offs range,then test tee_preload successfully.
> / # tee_preload_fw
> use default tee_preload_fw pathfw_path=/lib/firmware/video/video_ucode.bin
> tee preload video fw ok
> / # echo $?
> 0
>
> Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
> ---
>  drivers/tee/tee_shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 0b9ab1d0dd45..585361cd8dd9 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -461,7 +461,7 @@ int tee_shm_get_pa(struct tee_shm *shm, size_t offs, phys_addr_t *pa)
>         if (offs >= shm->size)
>                 return -EINVAL;
>         if (pa)
> -               *pa = shm->paddr + offs;
> +               *pa = shm->paddr + shm->size;

This can't be right, "offs" is used to calculate the physical address
from the start of a shared memory range.
With this you're ignoring "offs" and always return past the end of the
region. I don't see how that can help.

Cheers,
Jens

>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_get_pa);
> --
> 2.22.0
>
