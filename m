Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B08CDE2F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfJGJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 05:28:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36587 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727456AbfJGJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:28:22 -0400
X-UUID: d337c6f1a130489abf84f5df6d276c03-20191007
X-UUID: d337c6f1a130489abf84f5df6d276c03-20191007
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 654482753; Mon, 07 Oct 2019 17:28:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Oct 2019 17:28:11 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Oct 2019 17:28:11 +0800
Message-ID: <1570440492.4686.59.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Mon, 7 Oct 2019 17:28:12 +0800
In-Reply-To: <CACT4Y+YL=8jFXrj2LOuQV7ZyDe-am4W8y1WHEDJJ0-mVNJ3_Cw@mail.gmail.com>
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
         <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
         <1569594142.9045.24.camel@mtksdccf07>
         <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
         <1569818173.17361.19.camel@mtksdccf07>
         <1570018513.19702.36.camel@mtksdccf07>
         <CACT4Y+bbZhvz9ZpHtgL8rCCsV=ybU5jA6zFnJBL7gY2cNXDLyQ@mail.gmail.com>
         <1570069078.19702.57.camel@mtksdccf07>
         <CACT4Y+ZwNv2-QBrvuR2JvemovmKPQ9Ggrr=ZkdTg6xy_Ki6UAg@mail.gmail.com>
         <1570095525.19702.59.camel@mtksdccf07>
         <1570110681.19702.64.camel@mtksdccf07>
         <CACT4Y+aKrC8mtcDTVhM-So-TTLjOyFCD7r6jryWFH6i2he1WJA@mail.gmail.com>
         <1570164140.19702.97.camel@mtksdccf07>
         <1570176131.19702.105.camel@mtksdccf07>
         <CACT4Y+ZvhomaeXFKr4za6MJi=fW2SpPaCFP=fk06CMRhNcmFvQ@mail.gmail.com>
         <1570182257.19702.109.camel@mtksdccf07>
         <CACT4Y+ZnWPEO-9DkE6C3MX-Wo+8pdS6Gr6-2a8LzqBS=2fe84w@mail.gmail.com>
         <1570190718.19702.125.camel@mtksdccf07>
         <CACT4Y+YbkjuW3_WQJ4BB8YHWvxgHJyZYxFbDJpnPzfTMxYs60g@mail.gmail.com>
         <1570418576.4686.30.camel@mtksdccf07>
         <CACT4Y+aho7BEvQstd2+a2be-jJ0dEsjGebH7bcUFhYp-PoRDxQ@mail.gmail.com>
         <1570436289.4686.40.camel@mtksdccf07>
         <CACT4Y+Z6QObZ2fvVxSmvv16YQAu4GswOqfOVQK_1_Ncz0eir_g@mail.gmail.com>
         <1570438317.4686.44.camel@mtksdccf07>
         <CACT4Y+Yc86bKxDp4ST8+49rzLOWkTXLkjs0eyFtohCi_uSjmLQ@mail.gmail.com>
         <1570439032.4686.50.camel@mtksdccf07>
         <CACT4Y+YL=8jFXrj2LOuQV7ZyDe-am4W8y1WHEDJJ0-mVNJ3_Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 11:10 +0200, Dmitry Vyukov wrote:
> On Mon, Oct 7, 2019 at 11:03 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > On Mon, 2019-10-07 at 10:54 +0200, Dmitry Vyukov wrote:
> > > On Mon, Oct 7, 2019 at 10:52 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > >
> > > > On Mon, 2019-10-07 at 10:24 +0200, Dmitry Vyukov wrote:
> > > > > On Mon, Oct 7, 2019 at 10:18 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > The patchsets help to produce KASAN report when size is negative numbers
> > > > > > in memory operation function. It is helpful for programmer to solve the
> > > > > > undefined behavior issue. Patch 1 based on Dmitry's review and
> > > > > > suggestion, patch 2 is a test in order to verify the patch 1.
> > > > > >
> > > > > > [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > > > > [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
> > > > > >
> > > > > > Walter Wu (2):
> > > > > > kasan: detect invalid size in memory operation function
> > > > > > kasan: add test for invalid size in memmove
> > > > > >
> > > > > >  lib/test_kasan.c          | 18 ++++++++++++++++++
> > > > > >  mm/kasan/common.c         | 13 ++++++++-----
> > > > > >  mm/kasan/generic.c        |  5 +++++
> > > > > >  mm/kasan/generic_report.c | 12 ++++++++++++
> > > > > >  mm/kasan/tags.c           |  5 +++++
> > > > > >  mm/kasan/tags_report.c    | 12 ++++++++++++
> > > > > >  6 files changed, 60 insertions(+), 5 deletions(-)
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > commit 5b3b68660b3d420fd2bd792f2d9fd3ccb8877ef7
> > > > > > Author: Walter-zh Wu <walter-zh.wu@mediatek.com>
> > > > > > Date:   Fri Oct 4 18:38:31 2019 +0800
> > > > > >
> > > > > >     kasan: detect invalid size in memory operation function
> > > > > >
> > > > > >     It is an undefined behavior to pass a negative numbers to
> > > > > > memset()/memcpy()/memmove()
> > > > > >     , so need to be detected by KASAN.
> > > > > >
> > > > > >     If size is negative numbers, then it has two reasons to be defined
> > > > > > as out-of-bounds bug type.
> > > > > >     1) Casting negative numbers to size_t would indeed turn up as a
> > > > > > large
> > > > > >     size_t and its value will be larger than ULONG_MAX/2, so that this
> > > > > > can
> > > > > >     qualify as out-of-bounds.
> > > > > >     2) Don't generate new bug type in order to prevent duplicate reports
> > > > > > by
> > > > > >     some systems, e.g. syzbot.
> > > > > >
> > > > > >     KASAN report:
> > > > > >
> > > > > >      BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
> > > > > >      Read of size 18446744073709551608 at addr ffffff8069660904 by task
> > > > > > cat/72
> > > > > >
> > > > > >      CPU: 2 PID: 72 Comm: cat Not tainted
> > > > > > 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
> > > > > >      Hardware name: linux,dummy-virt (DT)
> > > > > >      Call trace:
> > > > > >       dump_backtrace+0x0/0x288
> > > > > >       show_stack+0x14/0x20
> > > > > >       dump_stack+0x10c/0x164
> > > > > >       print_address_description.isra.9+0x68/0x378
> > > > > >       __kasan_report+0x164/0x1a0
> > > > > >       kasan_report+0xc/0x18
> > > > > >       check_memory_region+0x174/0x1d0
> > > > > >       memmove+0x34/0x88
> > > > > >       kmalloc_memmove_invalid_size+0x70/0xa0
> > > > > >
> > > > > >     [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
> > > > > >
> > > > > >     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > > >     Reported -by: Dmitry Vyukov <dvyukov@google.com>
> > > > > >     Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > > > > >
> > > > > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > > > > index 6814d6d6a023..6ef0abd27f06 100644
> > > > > > --- a/mm/kasan/common.c
> > > > > > +++ b/mm/kasan/common.c
> > > > > > @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
> > > > > >  #undef memset
> > > > > >  void *memset(void *addr, int c, size_t len)
> > > > > >  {
> > > > > > -       check_memory_region((unsigned long)addr, len, true, _RET_IP_);
> > > > > > +       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
> > > > > > +               return NULL;
> > > > > >
> > > > > >         return __memset(addr, c, len);
> > > > > >  }
> > > > > > @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
> > > > > >  #undef memmove
> > > > > >  void *memmove(void *dest, const void *src, size_t len)
> > > > > >  {
> > > > > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > > > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > > > > +               return NULL;
> > > > > >
> > > > > >         return __memmove(dest, src, len);
> > > > > >  }
> > > > > > @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t
> > > > > > len)
> > > > > >  #undef memcpy
> > > > > >  void *memcpy(void *dest, const void *src, size_t len)
> > > > > >  {
> > > > > > -       check_memory_region((unsigned long)src, len, false, _RET_IP_);
> > > > > > -       check_memory_region((unsigned long)dest, len, true, _RET_IP_);
> > > > > > +       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
> > > > > > +       !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
> > > > > > +               return NULL;
> > > > > >
> > > > > >         return __memcpy(dest, src, len);
> > > > > >  }
> > > > > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > > > > index 616f9dd82d12..02148a317d27 100644
> > > > > > --- a/mm/kasan/generic.c
> > > > > > +++ b/mm/kasan/generic.c
> > > > > > @@ -173,6 +173,11 @@ static __always_inline bool
> > > > > > check_memory_region_inline(unsigned long addr,
> > > > > >         if (unlikely(size == 0))
> > > > > >                 return true;
> > > > > >
> > > > > > +       if (unlikely((long)size < 0)) {
> > > > > > +               kasan_report(addr, size, write, ret_ip);
> > > > > > +               return false;
> > > > > > +       }
> > > > > > +
> > > > > >         if (unlikely((void *)addr <
> > > > > >                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
> > > > > >                 kasan_report(addr, size, write, ret_ip);
> > > > > > diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> > > > > > index 36c645939bc9..ed0eb94cb811 100644
> > > > > > --- a/mm/kasan/generic_report.c
> > > > > > +++ b/mm/kasan/generic_report.c
> > > > > > @@ -107,6 +107,18 @@ static const char *get_wild_bug_type(struct
> > > > > > kasan_access_info *info)
> > > > > >
> > > > > >  const char *get_bug_type(struct kasan_access_info *info)
> > > > > >  {
> > > > > > +       /*
> > > > > > +        * If access_size is negative numbers, then it has two reasons
> > > > > > +        * to be defined as out-of-bounds bug type.
> > > > > > +        * 1) Casting negative numbers to size_t would indeed turn up as
> > > > > > +        * a 'large' size_t and its value will be larger than ULONG_MAX/2,
> > > > > > +        * so that this can qualify as out-of-bounds.
> > > > > > +        * 2) Don't generate new bug type in order to prevent duplicate
> > > > > > reports
> > > > > > +        * by some systems, e.g. syzbot.
> > > > > > +        */
> > > > > > +       if ((long)info->access_size < 0)
> > > > > > +               return "out-of-bounds";
> > > > >
> > > > > "out-of-bounds" is the _least_ frequent KASAN bug type. It won't
> > > > > prevent duplicates. "heap-out-of-bounds" is the frequent one.
> > > >
> > > >
> > > >     /*
> > > >      * If access_size is negative numbers, then it has two reasons
> > > >      * to be defined as out-of-bounds bug type.
> > > >      * 1) Casting negative numbers to size_t would indeed turn up as
> > > >      * a  "large" size_t and its value will be larger than ULONG_MAX/2,
> > > >      *    so that this can qualify as out-of-bounds.
> > > >      * 2) Don't generate new bug type in order to prevent duplicate
> > > > reports
> > > >      *    by some systems, e.g. syzbot. "out-of-bounds" is the _least_
> > > > frequent KASAN bug type.
> > > >      *    It won't prevent duplicates. "heap-out-of-bounds" is the
> > > > frequent one.
> > > >      */
> > > >
> > > > We directly add it into the comment.
> > >
> > >
> > > OK, let's start from the beginning: why do you return "out-of-bounds" here?
> > >
> > Uh, comment 1 and 2 should explain it. :)
> 
> The comment says it will cause duplicate reports. It does not explain
> why you want syzbot to produce duplicate reports and spam kernel
> developers... So why do you want that?
> 
We don't generate new bug type in order to prevent duplicate by some
systems, e.g. syzbot. Is it right? If yes, then it should not have
duplicate report.

> > > > > >         if (addr_has_shadow(info->access_addr))
> > > > > >                 return get_shadow_bug_type(info);
> > > > > >         return get_wild_bug_type(info);
> > > > > > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > > > > > index 0e987c9ca052..b829535a3ad7 100644
> > > > > > --- a/mm/kasan/tags.c
> > > > > > +++ b/mm/kasan/tags.c
> > > > > > @@ -86,6 +86,11 @@ bool check_memory_region(unsigned long addr, size_t
> > > > > > size, bool write,
> > > > > >         if (unlikely(size == 0))
> > > > > >                 return true;
> > > > > >
> > > > > > +       if (unlikely((long)size < 0)) {
> > > > > > +               kasan_report(addr, size, write, ret_ip);
> > > > > > +               return false;
> > > > > > +       }
> > > > > > +
> > > > > >         tag = get_tag((const void *)addr);
> > > > > >
> > > > > >         /*
> > > > > > diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> > > > > > index 969ae08f59d7..012fbe3a793f 100644
> > > > > > --- a/mm/kasan/tags_report.c
> > > > > > +++ b/mm/kasan/tags_report.c
> > > > > > @@ -36,6 +36,18 @@
> > > > > >
> > > > > >  const char *get_bug_type(struct kasan_access_info *info)
> > > > > >  {
> > > > > > +       /*
> > > > > > +        * If access_size is negative numbers, then it has two reasons
> > > > > > +        * to be defined as out-of-bounds bug type.
> > > > > > +        * 1) Casting negative numbers to size_t would indeed turn up as
> > > > > > +        * a 'large' size_t and its value will be larger than ULONG_MAX/2,
> > > > > > +        * so that this can qualify as out-of-bounds.
> > > > > > +        * 2) Don't generate new bug type in order to prevent duplicate
> > > > > > reports
> > > > > > +        * by some systems, e.g. syzbot.
> > > > > > +        */
> > > > > > +       if ((long)info->access_size < 0)
> > > > > > +               return "out-of-bounds";
> > > > > > +
> > > > > >  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > > > > >         struct kasan_alloc_meta *alloc_meta;
> > > > > >         struct kmem_cache *cache;
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > commit fb5cf7bd16e939d1feef229af0211a8616c9ea03
> > > > > > Author: Walter-zh Wu <walter-zh.wu@mediatek.com>
> > > > > > Date:   Fri Oct 4 18:32:03 2019 +0800
> > > > > >
> > > > > >     kasan: add test for invalid size in memmove
> > > > > >
> > > > > >     Test size is negative vaule in memmove in order to verify
> > > > > >     if it correctly get KASAN report.
> > > > > >
> > > > > >     Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > > >
> > > > > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > > > > index 49cc4d570a40..06942cf585cc 100644
> > > > > > --- a/lib/test_kasan.c
> > > > > > +++ b/lib/test_kasan.c
> > > > > > @@ -283,6 +283,23 @@ static noinline void __init
> > > > > > kmalloc_oob_in_memset(void)
> > > > > >         kfree(ptr);
> > > > > >  }
> > > > > >
> > > > > > +static noinline void __init kmalloc_memmove_invalid_size(void)
> > > > > > +{
> > > > > > +       char *ptr;
> > > > > > +       size_t size = 64;
> > > > > > +
> > > > > > +       pr_info("invalid size in memmove\n");
> > > > > > +       ptr = kmalloc(size, GFP_KERNEL);
> > > > > > +       if (!ptr) {
> > > > > > +               pr_err("Allocation failed\n");
> > > > > > +               return;
> > > > > > +       }
> > > > > > +
> > > > > > +       memset((char *)ptr, 0, 64);
> > > > > > +       memmove((char *)ptr, (char *)ptr + 4, -2);
> > > > > > +       kfree(ptr);
> > > > > > +}
> > > > > > +
> > > > > >  static noinline void __init kmalloc_uaf(void)
> > > > > >  {
> > > > > >         char *ptr;
> > > > > > @@ -773,6 +790,7 @@ static int __init kmalloc_tests_init(void)
> > > > > >         kmalloc_oob_memset_4();
> > > > > >         kmalloc_oob_memset_8();
> > > > > >         kmalloc_oob_memset_16();
> > > > > > +       kmalloc_memmove_invalid_size();
> > > > > >         kmalloc_uaf();
> > > > > >         kmalloc_uaf_memset();
> > > > > >         kmalloc_uaf2();


