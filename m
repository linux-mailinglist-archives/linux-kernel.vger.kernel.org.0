Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547894815F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFQL6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 07:58:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45150 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFQL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:58:10 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so20377932ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueOYS1wFyeCCBxDCVsPVG5+an3vWjzFueCDlI0BJDTQ=;
        b=m/nic/1gMsqRM3aXpp3S0P7cl9f86+N1HuW0xsCIUi26svfLi1qjvD8/zHDJfv4CtC
         agTG9FTFwES2e6fKPNgesel4PIaXyheHVvmzttqU9n3CyDEI5yYSs0KzLEhRXDmkIDiU
         BoHvb5PH7lF6fHNpMMcZCbfokLgEMLHe9fSGVjgWlkE+tshkqtTNJW8XqsM7EiTbmZYV
         zY9Uiv1rua98ZWBS7vxyFk1D1Qek2WDw0hPW2R1nacVvqRmslLdyg7GzuKjnyjdUSKAy
         n8cKtLfeAZ7oUirrutBaSPmjmPh9zhy8sGDCjUK9FZlC0Yr3nw5q6M2O+M/R+2cooSGO
         gHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueOYS1wFyeCCBxDCVsPVG5+an3vWjzFueCDlI0BJDTQ=;
        b=S5Gv6dzkAbDKfTiAM6vMXdGH8J3pgP6ymP5g0FcB4CVlFTqeWpwWZLIWTWnPbh9RSa
         +BvxTJZOt/Z5XAZSjJa+cSbcgtqld81vec1iJDQUZvo88LdH23Aii/Zs6/IqunrrfclI
         XtakDR9HaAeqK0F0HgRkeBk/qB0XnpIKnQJteE/nBcDz6wwae+LfQTlKCSq8KQgp5YKV
         2/wkkr6Od+bYWwfLfq55N5s+dpwijwUKfwMe+fSHKm8X1DeuquC4PvPj5QqNPxBqXwyh
         wEIQ6afSN1otOvXb7stm2pWVt1Z/iVkUtQmqnl+DjT3zx50KcPUvmGWlUsxlUSOq0Ys5
         QTGw==
X-Gm-Message-State: APjAAAXE6uZ0+SAxMj9shaLrdZ08WDFzxLallU4+alnuAThdxKiOeq7p
        B01bItj/CgQlNp1kArhcL9KnjmIXSv9H9y3X8H1JVQ==
X-Google-Smtp-Source: APXvYqyOINj8pYwe8/fYWKy7ldMuXS6N4CTb8JVK/ENXznnn8FSbnUbfvDwebsRKohu4YhwgVY4D0h3ZXjEurUCWfuY=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr2795600iog.266.1560772688590;
 Mon, 17 Jun 2019 04:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com>
 <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com> <1560447999.15814.15.camel@mtksdccf07>
 <1560479520.15814.34.camel@mtksdccf07> <1560744017.15814.49.camel@mtksdccf07>
In-Reply-To: <1560744017.15814.49.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Jun 2019 13:57:57 +0200
Message-ID: <CACT4Y+Y3uS59rXf92ByQuFK_G4v0H8NNnCY1tCbr4V+PaZF3ag@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:00 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Fri, 2019-06-14 at 10:32 +0800, Walter Wu wrote:
> > On Fri, 2019-06-14 at 01:46 +0800, Walter Wu wrote:
> > > On Thu, 2019-06-13 at 15:27 +0300, Andrey Ryabinin wrote:
> > > >
> > > > On 6/13/19 11:13 AM, Walter Wu wrote:
> > > > > This patch adds memory corruption identification at bug report for
> > > > > software tag-based mode, the report show whether it is "use-after-free"
> > > > > or "out-of-bound" error instead of "invalid-access" error.This will make
> > > > > it easier for programmers to see the memory corruption problem.
> > > > >
> > > > > Now we extend the quarantine to support both generic and tag-based kasan.
> > > > > For tag-based kasan, the quarantine stores only freed object information
> > > > > to check if an object is freed recently. When tag-based kasan reports an
> > > > > error, we can check if the tagged addr is in the quarantine and make a
> > > > > good guess if the object is more like "use-after-free" or "out-of-bound".
> > > > >
> > > >
> > > >
> > > > We already have all the information and don't need the quarantine to make such guess.
> > > > Basically if shadow of the first byte of object has the same tag as tag in pointer than it's out-of-bounds,
> > > > otherwise it's use-after-free.
> > > >
> > > > In pseudo-code it's something like this:
> > > >
> > > > u8 object_tag = *(u8 *)kasan_mem_to_shadow(nearest_object(cacche, page, access_addr));
> > > >
> > > > if (access_addr_tag == object_tag && object_tag != KASAN_TAG_INVALID)
> > > >   // out-of-bounds
> > > > else
> > > >   // use-after-free
> > >
> > > Thanks your explanation.
> > > I see, we can use it to decide corruption type.
> > > But some use-after-free issues, it may not have accurate free-backtrace.
> > > Unfortunately in that situation, free-backtrace is the most important.
> > > please see below example
> > >
> > > In generic KASAN, it gets accurate free-backrace(ptr1).
> > > In tag-based KASAN, it gets wrong free-backtrace(ptr2). It will make
> > > programmer misjudge, so they may not believe tag-based KASAN.
> > > So We provide this patch, we hope tag-based KASAN bug report is the same
> > > accurate with generic KASAN.
> > >
> > > ---
> > >     ptr1 = kmalloc(size, GFP_KERNEL);
> > >     ptr1_free(ptr1);
> > >
> > >     ptr2 = kmalloc(size, GFP_KERNEL);
> > >     ptr2_free(ptr2);
> > >
> > >     ptr1[size] = 'x';  //corruption here
> > >
> > >
> > > static noinline void ptr1_free(char* ptr)
> > > {
> > >     kfree(ptr);
> > > }
> > > static noinline void ptr2_free(char* ptr)
> > > {
> > >     kfree(ptr);
> > > }
> > > ---
> > >
> > We think of another question about deciding by that shadow of the first
> > byte.
> > In tag-based KASAN, it is immediately released after calling kfree(), so
> > the slub is easy to be used by another pointer, then it will change
> > shadow memory to the tag of new pointer, it will not be the
> > KASAN_TAG_INVALID, so there are many false negative cases, especially in
> > small size allocation.
> >
> > Our patch is to solve those problems. so please consider it, thanks.
> >
> Hi, Andrey and Dmitry,
>
> I am sorry to bother you.
> Would you tell me what you think about this patch?
> We want to use tag-based KASAN, so we hope its bug report is clear and
> correct as generic KASAN.
>
> Thanks your review.
> Walter

Hi Walter,

I will probably be busy till the next week. Sorry for delays.
