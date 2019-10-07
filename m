Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE23FCDFA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfJGKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 06:51:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36523 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfJGKvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:51:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so12103805qkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/leRBOsNsqe76Ah8fFAhq4JY83SUXLtPEp8isBCEQQA=;
        b=ZblYnebKy5nVmD4w5DCdzfBr9RCyf/gfRyRExhiXMdwiQOYMPHPC/Mi5qi1NI+SBMk
         h2ThS+4OSFTOObKHItH85FPN4X6LrdNLhXDmpYYy2jtdFKgtlHzi4N539t36onsz+Nvu
         PxjoDCPThWd136RCLi3JZSCu632jouv1Ljcn/8hysNpNclbMfcWvYfe8q+5oVIFL20x3
         NGgpYIXTcHLzzgijHVkrFXT2ZR2TPE+k1dwtfiyUyUGPE2/dsO9p5DT+BZDis/FrOs3P
         nLTo7OaXxhIhc7WEsU3bxcO+tUS1CUqTgxGBlq3754JtXSPxluPbjgBKrlutpMp6Yn4N
         fIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/leRBOsNsqe76Ah8fFAhq4JY83SUXLtPEp8isBCEQQA=;
        b=A2PDD+RRnWCXbB820lXq/ecKBoRoIRTTnXmnG2I5iDTONspNcRjBcpW5hGViHVlpt6
         MhinMs6UAwHKLeNds811dor7OdolURV3uK+zBUOq29FDDDDPksEt+pyznLxsjwMFQspQ
         p2juUGocn9VlWny2HuUURTQSaQbe/FSjyjjv49yd+JFQz6hflf8SNoc7Psr+zilwYzzZ
         Q42qq4Dw513H8TPJ3PcSeRFDaxlso7ZsrViwpr0aCC93ipNsmdNQTta9IPzVZTjdaX8J
         7gYPKeGdnCxJYgauXAqLAwgu9T8xlO29/qQfazZfF3nqRvh5aVavHCL1+pNlyV7OUH+I
         nRxw==
X-Gm-Message-State: APjAAAU+EneEj0csbOcMRezwqREPULTkW80kwvJAMHfUffNySle9ipPr
        MIJ46cMC4hT7V9K2sIbFDgJZ1VGkvEuJa9QHKHZhvw==
X-Google-Smtp-Source: APXvYqwdre+IkJSeHtcfjRYYH3e+7r7rE9zRTH1UAe52gIZ0ERyXzgBOt0MPcj4HlrY+CdQvjcYaUK159P3C2rVyKK8=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr23248727qke.250.1570445513471;
 Mon, 07 Oct 2019 03:51:53 -0700 (PDT)
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
 <CACT4Y+ZvhomaeXFKr4za6MJi=fW2SpPaCFP=fk06CMRhNcmFvQ@mail.gmail.com>
 <1570182257.19702.109.camel@mtksdccf07> <CACT4Y+ZnWPEO-9DkE6C3MX-Wo+8pdS6Gr6-2a8LzqBS=2fe84w@mail.gmail.com>
 <1570190718.19702.125.camel@mtksdccf07> <CACT4Y+YbkjuW3_WQJ4BB8YHWvxgHJyZYxFbDJpnPzfTMxYs60g@mail.gmail.com>
 <1570418576.4686.30.camel@mtksdccf07> <CACT4Y+aho7BEvQstd2+a2be-jJ0dEsjGebH7bcUFhYp-PoRDxQ@mail.gmail.com>
 <1570436289.4686.40.camel@mtksdccf07> <CACT4Y+Z6QObZ2fvVxSmvv16YQAu4GswOqfOVQK_1_Ncz0eir_g@mail.gmail.com>
 <1570438317.4686.44.camel@mtksdccf07> <CACT4Y+Yc86bKxDp4ST8+49rzLOWkTXLkjs0eyFtohCi_uSjmLQ@mail.gmail.com>
 <1570439032.4686.50.camel@mtksdccf07> <CACT4Y+YL=8jFXrj2LOuQV7ZyDe-am4W8y1WHEDJJ0-mVNJ3_Cw@mail.gmail.com>
 <1570440492.4686.59.camel@mtksdccf07> <1570441833.4686.66.camel@mtksdccf07>
In-Reply-To: <1570441833.4686.66.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Oct 2019 12:51:41 +0200
Message-ID: <CACT4Y+Z0A=Zi4AxEjn4jpHk0xG9+Nh2Q-OYEnOmooW0wN-_vfQ@mail.gmail.com>
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

On Mon, Oct 7, 2019 at 11:50 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Mon, 2019-10-07 at 17:28 +0800, Walter Wu wrote:
> > On Mon, 2019-10-07 at 11:10 +0200, Dmitry Vyukov wrote:
> > > On Mon, Oct 7, 2019 at 11:03 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > >
> > > > On Mon, 2019-10-07 at 10:54 +0200, Dmitry Vyukov wrote:
> > > > > On Mon, Oct 7, 2019 at 10:52 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > >
> > > > > > On Mon, 2019-10-07 at 10:24 +0200, Dmitry Vyukov wrote:
> > > > > > > On Mon, Oct 7, 2019 at 10:18 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > > > The patchsets help to produce KASAN report when size is negative numbers
> > > > > > > > in memory operation function. It is helpful for programmer to solve the
> > > > > > > > undefined behavior issue. Patch 1 based on Dmitry's review and
> > > > > > > > suggestion, patch 2 is a test in order to verify the patch 1.
> > > > > > > >
> > > > > > > > [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > > > > > > [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
> > > > > > > >
> > > > > > > > Walter Wu (2):
> > > > > > > > kasan: detect invalid size in memory operation function
> > > > > > > > kasan: add test for invalid size in memmove
> > > > > > > >
> > > > > > > >  lib/test_kasan.c          | 18 ++++++++++++++++++
> > > > > > > >  mm/kasan/common.c         | 13 ++++++++-----
> > > > > > > >  mm/kasan/generic.c        |  5 +++++
> > > > > > > >  mm/kasan/generic_report.c | 12 ++++++++++++
> > > > > > > >  mm/kasan/tags.c           |  5 +++++
> > > > > > > >  mm/kasan/tags_report.c    | 12 ++++++++++++
> > > > > > > >  6 files changed, 60 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > commit 5b3b68660b3d420fd2bd792f2d9fd3ccb8877ef7
> > > > > > > > Author: Walter-zh Wu <walter-zh.wu@mediatek.com>
> > > > > > > > Date:   Fri Oct 4 18:38:31 2019 +0800
> > > > > > > >
> > > > > > > >     kasan: detect invalid size in memory operation function
> > > > > > > >
> > > > > > > >     It is an undefined behavior to pass a negative numbers to
> > > > > > > > memset()/memcpy()/memmove()
> > > > > > > >     , so need to be detected by KASAN.
> > > > > > > >
> > > > > > > >     If size is negative numbers, then it has two reasons to be defined
> > > > > > > > as out-of-bounds bug type.
> > > > > > > >     1) Casting negative numbers to size_t would indeed turn up as a
> > > > > > > > large
> > > > > > > >     size_t and its value will be larger than ULONG_MAX/2, so that this
> > > > > > > > can
> > > > > > > >     qualify as out-of-bounds.
> > > > > > > >     2) Don't generate new bug type in order to prevent duplicate reports
> > > > > > > > by
> > > > > > > >     some systems, e.g. syzbot.
> > > > > > > >
> > > > > > > >     KASAN report:
> > > > > > > >
> > > > > > > >      BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
> > > > > > > >      Read of size 18446744073709551608 at addr ffffff8069660904 by task
> > > > > > > > cat/72
> > > > > > > >
> > > > > > > >      CPU: 2 PID: 72 Comm: cat Not tainted
> > > > > > > > 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
> > > > > > > >      Hardware name: linux,dummy-virt (DT)
> > > > > > > >      Call trace:
> > > > > > > >       dump_backtrace+0x0/0x288
> > > > > > > >       show_stack+0x14/0x20
> > > > > > > >       dump_stack+0x10c/0x164
> > > > > > > >       print_address_description.isra.9+0x68/0x378
> > > > > > > >       __kasan_report+0x164/0x1a0
> > > > > > > >       kasan_report+0xc/0x18
> > > > > > > >       check_memory_region+0x174/0x1d0
> > > > > > > >       memmove+0x34/0x88
> > > > > > > >       kmalloc_memmove_invalid_size+0x70/0xa0
> > > > > > > >
> > > > > > > >     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > > > > > >
> > > > > > > >     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > > > > >     Reported -by: Dmitry Vyukov <dvyukov@google.com>
> > > > > > > >     Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > > > > > > >
> > > > > > > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > > > > > > index 6814d6d6a023..6ef0abd27f06 100644
> > > > > > > > --- a/mm/kasan/common.c
> > > > > > > > +++ b/mm/kasan/common.c
> > > > > > > > @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
> > > > > > > >  #undef memset
> > > > > > > >  void *memset(void *addr, int c, size_t len)
> > > > > > > >  {
> > > > > > > > -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > > > > > > > +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > > > > > > > +               return NULL;
> > > > > > > >
> > > > > > > >         return __memset(addr, c, len);
> > > > > > > >  }
> > > > > > > > @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
> > > > > > > >  #undef memmove
> > > > > > > >  void *memmove(void *dest, const void *src, size_t len)
> > > > > > > >  {
> > > > > > > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > > > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > > > > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > > > > > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > > > > > > +               return NULL;
> > > > > > > >
> > > > > > > >         return __memmove(dest, src, len);
> > > > > > > >  }
> > > > > > > > @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t
> > > > > > > > len)
> > > > > > > >  #undef memcpy
> > > > > > > >  void *memcpy(void *dest, const void *src, size_t len)
> > > > > > > >  {
> > > > > > > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > > > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > > > > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > > > > > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > > > > > > +               return NULL;
> > > > > > > >
> > > > > > > >         return __memcpy(dest, src, len);
> > > > > > > >  }
> > > > > > > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > > > > > > index 616f9dd82d12..02148a317d27 100644
> > > > > > > > --- a/mm/kasan/generic.c
> > > > > > > > +++ b/mm/kasan/generic.c
> > > > > > > > @@ -173,6 +173,11 @@ static __always_inline bool
> > > > > > > > check_memory_region_inline(unsigned long addr,
> > > > > > > >         if (unlikely(size == 0))
> > > > > > > >                 return true;
> > > > > > > >
> > > > > > > > +       if (unlikely((long)size < 0)) {
> > > > > > > > +               kasan_report(addr, size, write, ret_ip);
> > > > > > > > +               return false;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > >         if (unlikely((void *)addr <
> > > > > > > >                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> > > > > > > >                 kasan_report(addr, size, write, ret_ip);
> > > > > > > > diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> > > > > > > > index 36c645939bc9..ed0eb94cb811 100644
> > > > > > > > --- a/mm/kasan/generic_report.c
> > > > > > > > +++ b/mm/kasan/generic_report.c
> > > > > > > > @@ -107,6 +107,18 @@ static const char *get_wild_bug_type(struct
> > > > > > > > kasan_access_info *info)
> > > > > > > >
> > > > > > > >  const char *get_bug_type(struct kasan_access_info *info)
> > > > > > > >  {
> > > > > > > > +       /*
> > > > > > > > +        * If access_size is negative numbers, then it has two reasons
> > > > > > > > +        * to be defined as out-of-bounds bug type.
> > > > > > > > +        * 1) Casting negative numbers to size_t would indeed turn up as
> > > > > > > > +        * a 'large' size_t and its value will be larger than ULONG_MAX/2,
> > > > > > > > +        * so that this can qualify as out-of-bounds.
> > > > > > > > +        * 2) Don't generate new bug type in order to prevent duplicate
> > > > > > > > reports
> > > > > > > > +        * by some systems, e.g. syzbot.
> > > > > > > > +        */
> > > > > > > > +       if ((long)info->access_size < 0)
> > > > > > > > +               return "out-of-bounds";
> > > > > > >
> > > > > > > "out-of-bounds" is the _least_ frequent KASAN bug type. It won't
> > > > > > > prevent duplicates. "heap-out-of-bounds" is the frequent one.
> > > > > >
> > > > > >
> > > > > >     /*
> > > > > >      * If access_size is negative numbers, then it has two reasons
> > > > > >      * to be defined as out-of-bounds bug type.
> > > > > >      * 1) Casting negative numbers to size_t would indeed turn up as
> > > > > >      * a  "large" size_t and its value will be larger than ULONG_MAX/2,
> > > > > >      *    so that this can qualify as out-of-bounds.
> > > > > >      * 2) Don't generate new bug type in order to prevent duplicate
> > > > > > reports
> > > > > >      *    by some systems, e.g. syzbot. "out-of-bounds" is the _least_
> > > > > > frequent KASAN bug type.
> > > > > >      *    It won't prevent duplicates. "heap-out-of-bounds" is the
> > > > > > frequent one.
> > > > > >      */
> > > > > >
> > > > > > We directly add it into the comment.
> > > > >
> > > > >
> > > > > OK, let's start from the beginning: why do you return "out-of-bounds" here?
> > > > >
> > > > Uh, comment 1 and 2 should explain it. :)
> > >
> > > The comment says it will cause duplicate reports. It does not explain
> > > why you want syzbot to produce duplicate reports and spam kernel
> > > developers... So why do you want that?
> > >
> > We don't generate new bug type in order to prevent duplicate by some
> > systems, e.g. syzbot. Is it right? If yes, then it should not have
> > duplicate report.
> >
> Sorry, because we don't generate new bug type. it should be duplicate
> report(only one report which may be oob or size invlid),
> the duplicate report goal is that invalid size is oob issue, too.
>
> I would not introduce a new bug type.
> These are parsed and used by some systems, e.g. syzbot. If size is
> user-controllable, then a new bug type for this will mean 2 bug
> reports.

To prevent duplicates, the new crash title must not just match _any_
crash title that kernel can potentially produce. It must match exactly
the crash that kernel produces for this bug on other input data.

Consider, userspace passes size=123, KASAN produces "heap-out-of-bounds in foo".
Now userspace passes size=-1 and KASAN produces "invalid-size in foo".
This will be a duplicate bug report.
Now if KASAN will produce "out-of-bounds in foo", it will also lead to
a duplicate report.
Only iff KASAN will produce "heap-out-of-bounds in foo" for size=-1,
it will not lead to a duplicate report.
