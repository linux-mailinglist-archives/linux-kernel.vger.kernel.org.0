Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309EA6FD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfGVJwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:52:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58370 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728129AbfGVJwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:52:50 -0400
X-UUID: 4416e42ecd35467192de92f81e192f6f-20190722
X-UUID: 4416e42ecd35467192de92f81e192f6f-20190722
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1042474360; Mon, 22 Jul 2019 17:52:43 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 17:52:42 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 17:52:42 +0800
Message-ID: <1563789162.31223.3.camel@mtksdccf07>
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Mon, 22 Jul 2019 17:52:42 +0800
In-Reply-To: <9ab1871a-2605-ab34-3fd3-4b44a0e17ab7@virtuozzo.com>
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com>
         <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
         <1560447999.15814.15.camel@mtksdccf07>
         <1560479520.15814.34.camel@mtksdccf07>
         <1560744017.15814.49.camel@mtksdccf07>
         <CACT4Y+Y3uS59rXf92ByQuFK_G4v0H8NNnCY1tCbr4V+PaZF3ag@mail.gmail.com>
         <1560774735.15814.54.camel@mtksdccf07>
         <1561974995.18866.1.camel@mtksdccf07>
         <CACT4Y+aMXTBE0uVkeZz+MuPx3X1nESSBncgkScWvAkciAxP1RA@mail.gmail.com>
         <ebc99ee1-716b-0b18-66ab-4e93de02ce50@virtuozzo.com>
         <1562640832.9077.32.camel@mtksdccf07>
         <d9fd1d5b-9516-b9b9-0670-a1885e79f278@virtuozzo.com>
         <1562839579.5846.12.camel@mtksdccf07>
         <37897fb7-88c1-859a-dfcc-0a5e89a642e0@virtuozzo.com>
         <1563160001.4793.4.camel@mtksdccf07>
         <9ab1871a-2605-ab34-3fd3-4b44a0e17ab7@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-18 at 19:11 +0300, Andrey Ryabinin wrote:
> 
> On 7/15/19 6:06 AM, Walter Wu wrote:
> > On Fri, 2019-07-12 at 13:52 +0300, Andrey Ryabinin wrote:
> >>
> >> On 7/11/19 1:06 PM, Walter Wu wrote:
> >>> On Wed, 2019-07-10 at 21:24 +0300, Andrey Ryabinin wrote:
> >>>>
> >>>> On 7/9/19 5:53 AM, Walter Wu wrote:
> >>>>> On Mon, 2019-07-08 at 19:33 +0300, Andrey Ryabinin wrote:
> >>>>>>
> >>>>>> On 7/5/19 4:34 PM, Dmitry Vyukov wrote:
> >>>>>>> On Mon, Jul 1, 2019 at 11:56 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >>>>
> >>>>>>>
> >>>>>>> Sorry for delays. I am overwhelm by some urgent work. I afraid to
> >>>>>>> promise any dates because the next week I am on a conference, then
> >>>>>>> again a backlog and an intern starting...
> >>>>>>>
> >>>>>>> Andrey, do you still have concerns re this patch? This change allows
> >>>>>>> to print the free stack.
> >>>>>>
> >>>>>> I 'm not sure that quarantine is a best way to do that. Quarantine is made to delay freeing, but we don't that here.
> >>>>>> If we want to remember more free stacks wouldn't be easier simply to remember more stacks in object itself?
> >>>>>> Same for previously used tags for better use-after-free identification.
> >>>>>>
> >>>>>
> >>>>> Hi Andrey,
> >>>>>
> >>>>> We ever tried to use object itself to determine use-after-free
> >>>>> identification, but tag-based KASAN immediately released the pointer
> >>>>> after call kfree(), the original object will be used by another
> >>>>> pointer, if we use object itself to determine use-after-free issue, then
> >>>>> it has many false negative cases. so we create a lite quarantine(ring
> >>>>> buffers) to record recent free stacks in order to avoid those false
> >>>>> negative situations.
> >>>>
> >>>> I'm telling that *more* than one free stack and also tags per object can be stored.
> >>>> If object reused we would still have information about n-last usages of the object.
> >>>> It seems like much easier and more efficient solution than patch you proposing.
> >>>>
> >>> To make the object reused, we must ensure that no other pointers uses it
> >>> after kfree() release the pointer.
> >>> Scenario:
> >>> 1). The object reused information is valid when no another pointer uses
> >>> it.
> >>> 2). The object reused information is invalid when another pointer uses
> >>> it.
> >>> Do you mean that the object reused is scenario 1) ?
> >>> If yes, maybe we can change the calling quarantine_put() location. It
> >>> will be fully use that quarantine, but at scenario 2) it looks like to
> >>> need this patch.
> >>> If no, maybe i miss your meaning, would you tell me how to use invalid
> >>> object information? or?
> >>>
> >>
> >>
> >> KASAN keeps information about object with the object, right after payload in the kasan_alloc_meta struct.
> >> This information is always valid as long as slab page allocated. Currently it keeps only one last free stacktrace.
> >> It could be extended to record more free stacktraces and also record previously used tags which will allow you
> >> to identify use-after-free and extract right free stacktrace.
> > 
> > Thanks for your explanation.
> > 
> > For extend slub object, if one record is 9B (sizeof(u8)+ sizeof(struct
> > kasan_track)) and add five records into slub object, every slub object
> > may add 45B usage after the system runs longer. 
> > Slub object number is easy more than 1,000,000(maybe it may be more
> > bigger), then the extending object memory usage should be 45MB, and
> > unfortunately it is no limit. The memory usage is more bigger than our
> > patch.
> 
> No, it's not necessarily more.
> And there are other aspects to consider such as performance, how simple reliable the code is.
> 
> > 
> > We hope tag-based KASAN advantage is smaller memory usage. If it’s
> > possible, we should spend less memory in order to identify
> > use-after-free. Would you accept our patch after fine tune it?
> 
> Sure, if you manage to fix issues and demonstrate that performance penalty of your
> patch is close to zero.


I remember that there are already the lists which you concern. Maybe we
can try to solve those problems one by one.

1. deadlock issue? cause by kmalloc() after kfree()?
2. decrease allocation fail, to modify GFP_NOWAIT flag to GFP_KERNEL?
3. check whether slim 48 bytes (sizeof (qlist_object) +
sizeof(kasan_alloc_meta)) and additional unique stacktrace in
stackdepot?
4. duplicate struct 'kasan_track' information in two different places

Would you have any other concern? or?




