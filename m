Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC4CB732
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfJDJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 05:18:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43374 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbfJDJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:18:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so5123362qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6I9+yrZlBnu9vvasQaMrKa3ARAxTk84lZcanDGArco=;
        b=O59mJcJXAE0a9gcD7AD3Yp9bGocXLU+GGCmLSOzXLdgDN27W/eQAy05/1K1m+plcUc
         qnLOYNWUEf+SsN9dhYeXrX9pt6F/3vW1UWKD2d5azvtlxXaUhVr/uXk+j0xZY6MTg8Gh
         a+IsQNhDMJJf5ZASgmH8rr0eLlNtpx8sKdPfSvmWvkqiuQ0A+UDOkpH+82M7i5hmqB4s
         ShgpxMbaNvWDTsLfbHTVp4Uv+ZlaFZ+0feY33fqJOr01UsjoIGDrGeNIVXGXRqwH2kjK
         4/trCgveBJDzademehYq0oEJgCo07tnbjaipEsGHMinMhPUOTt339wG7aiCIlSdwNsuN
         ym/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6I9+yrZlBnu9vvasQaMrKa3ARAxTk84lZcanDGArco=;
        b=AaZGwanXDdLvUmuLi1LJzvfbdSvAJKASN+EvVF476mQDBvbG9q35w8rCK/IP7FvvVZ
         LUpBGPRq/ZVMMZYR9eX0fWjL7eZ98BmfIZLmoDvCUNdof/vHrnr38BIyk/m5QaKdDKa5
         MJR1Bsy94tRongcHd+7ue/T+fk0rI2sXHSOviswxuNFLDwN5ghmxtyCzmzHkpBsMBzIQ
         IOPmxNsUIgzLAnwtQZKL5imZoH4wsfHA+gcqDoOekl0Of7n9lMtRP4V15Xak02Mdw5Zx
         lKNTcPlxSS4eN2o4/NOW/1uxQYrxPKEwauVuu1rWacvI4RQonNvKDwscEBQ/qTF8wS8e
         2SwA==
X-Gm-Message-State: APjAAAVu2bNYI0ThZZYDYJYPbW6aeNiioMBHrU+znWKj9OsKF7y059ZE
        QjaBgkmv5Ufsur7x5BtU/A7HaXPIGj82mIL9ZN0eHw==
X-Google-Smtp-Source: APXvYqyjhhu83fr5eJLtYQWY7lriwK62bdmC7FDlzxTSblvQJIzzEYUbbFV10zD+6wFkh9cLT3vWPb2NXWm55+vafpU=
X-Received: by 2002:a37:985:: with SMTP id 127mr8947602qkj.43.1570180722548;
 Fri, 04 Oct 2019 02:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
 <1569594142.9045.24.camel@mtksdccf07> <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
 <1569818173.17361.19.camel@mtksdccf07> <1570018513.19702.36.camel@mtksdccf07>
 <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
 <1570069078.19702.57.camel@mtksdccf07> <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
 <1570095525.19702.59.camel@mtksdccf07> <1570110681.19702.64.camel@mtksdccf07>
 <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
 <1570164140.19702.97.camel@mtksdccf07> <1570176131.19702.105.camel@mtksdccf07>
In-Reply-To: <1570176131.19702.105.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Oct 2019 11:18:31 +0200
Message-ID: <CACT4Y+ZvhomaeXFKr4za6MJi=fW2SpPaCFP=fk06CMRhNcmFvQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 10:02 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Fri, 2019-10-04 at 12:42 +0800, Walter Wu wrote:
> > On Thu, 2019-10-03 at 16:53 +0200, Dmitry Vyukov wrote:
> > > On Thu, Oct 3, 2019 at 3:51 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:>
> > > >
> > > >  static void print_error_description(struct kasan_access_info *info)
> > > >  {
> > > > -       pr_err("BUG: KASAN: %s in %pS\n",
> > > > -               get_bug_type(info), (void *)info->ip);
> > > > -       pr_err("%s of size %zu at addr %px by task %s/%d\n",
> > > > -               info->is_write ? "Write" : "Read", info->access_size,
> > > > -               info->access_addr, current->comm, task_pid_nr(current));
> > > > +       if ((long)info->access_size < 0) {
> > > > +               pr_err("BUG: KASAN: invalid size %zu in %pS\n",
> > > > +                       info->access_size, (void *)info->ip);
> > >
> > > I would not introduce a new bug type.
> > > These are parsed and used by some systems, e.g. syzbot. If size is
> > > user-controllable, then a new bug type for this will mean 2 bug
> > > reports.
> > > It also won't harm to print Read/Write, definitely the address, so no
> > > reason to special case this out of a dozen of report formats.
> > > This can qualify as out-of-bounds (definitely will cross some
> > > bounds!), so I would change get_bug_type() to return
> > > "slab-out-of-bounds" (as the most common OOB) in such case (with a
> > > comment).
> > >
> > Print Read/Write and address information, it is ok.
> > But if we can directly point to the root cause of this problem, why we
> > not do it?  see 1) and 2) to get a point, if we print OOB, then user
> > needs one minute to think what is root case of this problem, but if we
> > print invalid size, then user can directly get root case. this is my
> > original thinking.
> > 1)Invalid size is true then OOB is true.
> > 2)OOB is true then invalid size may be true or false.
> >
> > But I see you say some systems have used bug report so that avoid this
> > trouble, i will print the wrong type is "out-of-bound" in a unified way
> > when size<0.
> >
>
> Updated my patch, please help to review it.
> thanks.
>
> commit 13e10a7e4264eb25c5a14193068027afc9c261f6
> Author: Walter-zh Wu <walter-zh.wu@mediatek.com>
> Date:   Fri Oct 4 15:27:17 2019 +0800
>
>     kasan: detect negative size in memory operation function
>
>     It is an undefined behavior to pass a negative value to
> memset()/memcpy()/memmove()
>     , so need to be detected by KASAN.
>
>     If size is negative value, then it will be larger than ULONG_MAX/2,
>     so that we will qualify as out-of-bounds issue.
>
>     KASAN report:
>
>      BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
>      Read of size 18446744073709551608 at addr ffffff8069660904 by task
> cat/72
>
>      CPU: 2 PID: 72 Comm: cat Not tainted
> 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
>      Hardware name: linux,dummy-virt (DT)
>      Call trace:
>       dump_backtrace+0x0/0x288
>       show_stack+0x14/0x20
>       dump_stack+0x10c/0x164
>       print_address_description.isra.9+0x68/0x378
>       __kasan_report+0x164/0x1a0
>       kasan_report+0xc/0x18
>       check_memory_region+0x174/0x1d0
>       memmove+0x34/0x88
>       kmalloc_memmove_invalid_size+0x70/0xa0
>
>     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
>
>     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
>     Reported -by: Dmitry Vyukov <dvyukov@google.com>
>     Suggested-by: Dmitry Vyukov <dvyukov@google.com>
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 49cc4d570a40..06942cf585cc 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -283,6 +283,23 @@ static noinline void __init
> kmalloc_oob_in_memset(void)
>         kfree(ptr);
>  }
>
> +static noinline void __init kmalloc_memmove_invalid_size(void)
> +{
> +       char *ptr;
> +       size_t size = 64;
> +
> +       pr_info("invalid size in memmove\n");
> +       ptr = kmalloc(size, GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       memset((char *)ptr, 0, 64);
> +       memmove((char *)ptr, (char *)ptr + 4, -2);
> +       kfree(ptr);
> +}
> +
>  static noinline void __init kmalloc_uaf(void)
>  {
>         char *ptr;
> @@ -773,6 +790,7 @@ static int __init kmalloc_tests_init(void)
>         kmalloc_oob_memset_4();
>         kmalloc_oob_memset_8();
>         kmalloc_oob_memset_16();
> +       kmalloc_memmove_invalid_size();
>         kmalloc_uaf();
>         kmalloc_uaf_memset();
>         kmalloc_uaf2();
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6814d6d6a023..97dd6eecc3e7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
>  {
> -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> +               return NULL;
>
>         return __memset(addr, c, len);
>  }
> @@ -110,7 +111,8 @@ void *memset(void *addr, int c, size_t len)
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_))
> +               return NULL;
>         check_memory_region((unsigned long)dest, len, true, _RET_IP_);

I would check both calls.
The current code seems to be over-specialized for handling of invalid
size (you assume that if it's invalid size, then the first
check_memory_region will detect it and checking the second one is
pointless, right?).
But check_memory_region can return false in other cases too.
Also seeing first call checked, but the second not checked just hurts
my eyes when reading code (whenever I will read such code my first
reaction will be "why?").


>
>         return __memmove(dest, src, len);
> @@ -119,7 +121,8 @@ void *memmove(void *dest, const void *src, size_t
> len)
>  #undef memcpy
>  void *memcpy(void *dest, const void *src, size_t len)
>  {
> -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_))
> +               return NULL;
>         check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>
>         return __memcpy(dest, src, len);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 616f9dd82d12..02148a317d27 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -173,6 +173,11 @@ static __always_inline bool
> check_memory_region_inline(unsigned long addr,
>         if (unlikely(size == 0))
>                 return true;
>
> +       if (unlikely((long)size < 0)) {
> +               kasan_report(addr, size, write, ret_ip);
> +               return false;
> +       }
> +
>         if (unlikely((void *)addr <
>                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
>                 kasan_report(addr, size, write, ret_ip);
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index 36c645939bc9..ae9596210394 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -107,6 +107,13 @@ static const char *get_wild_bug_type(struct
> kasan_access_info *info)
>
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +       /*
> +        * if access_size < 0, then it will be larger than ULONG_MAX/2,
> +        * so that this can qualify as out-of-bounds.
> +        */
> +       if ((long)info->access_size < 0)
> +               return "out-of-bounds";

"out-of-bounds" is the _least_ frequent KASAN bug type. So saying
"out-of-bounds" has downsides of both approaches and won't prevent
duplicate reports by syzbot...

> +
>         if (addr_has_shadow(info->access_addr))
>                 return get_shadow_bug_type(info);
>         return get_wild_bug_type(info);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 0e987c9ca052..b829535a3ad7 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t
> size, bool write,
>         if (unlikely(size == 0))
>                 return true;
>
> +       if (unlikely((long)size < 0)) {
> +               kasan_report(addr, size, write, ret_ip);
> +               return false;
> +       }
> +
>         tag = get_tag((const void *)addr);
>
>         /*
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> index 969ae08f59d7..1e1ca81214b5 100644
> --- a/mm/kasan/tags_report.c
> +++ b/mm/kasan/tags_report.c
> @@ -36,6 +36,13 @@
>
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> +       /*
> +        * if access_size < 0, then it will be larger than ULONG_MAX/2,
> +        * so that this can qualify as out-of-bounds.
> +        */
> +       if ((long)info->access_size < 0)
> +               return "out-of-bounds";
> +
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>         struct kasan_alloc_meta *alloc_meta;
>         struct kmem_cache *cache;
>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1570176131.19702.105.camel%40mtksdccf07.
