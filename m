Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EA819477F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 20:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCZTgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 15:36:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:36:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id bd14so8282572edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WugekyqNe14NZjUCrzuU8f/PMfy4ymjEA2uErv+hnjQ=;
        b=dh6db2Pxk89VoPBRilHdEG0cV3Zu1adly6w6kDu3jnNIDxVlP7JBOlI2vZtqoSxrWM
         znN99ZukPEtiO3LavWJFP5reZ248Ntxhou87Nm71MmHDaa2BDM4cW28SEX14TyIBGS6e
         DKCHkENogCptCU+mAJAks/5NR+OcetEihnM2U2RVrBEhj5RopDG+xZo8aeuWz+Ahkr2+
         x5/O0UWynQXC3rlf2kBgIc6qCclcRAFST0BXeiAPfzZZ9x+u2FLsMZSJvtsyC75tMMwW
         Xl9XSzIHgN23oCwJyEAdpmJvU9qv7p1Bxr4k3BRD931qfvinqUhRE+q/lOWoJf6xbCyI
         7ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WugekyqNe14NZjUCrzuU8f/PMfy4ymjEA2uErv+hnjQ=;
        b=Bm1k5Psk++AZI3xo5GRE2dNTl3n5rmw2UOSvQhbp+Oj5yTvFcZq/ZBa9g34PYN1f79
         v9G56H+K2ut2uwVvHEQSYCgaXO/doRWgz3zlPN1GAyjQ2KX36+qqCpgoXZVQDpCusrLD
         tuQm+RdB3Mt4aZiYpK2+zLT+AN8DJXFcQmgfG3y0/AySt+/eH20tToF2XxboYHh/zvjV
         R+WDeKQMh/DQob1pZZtUW+FfOxVlsbYOhiEzt6i+1cCE3sLIdyHtbJ9d4uZSacz6ivTe
         rWcoP81H4sRoTASXix2qJ5FLbnLLc4s2ylGrh6RcVIoU812OXg6nb+inSHK5ulu+2QPj
         Ra4A==
X-Gm-Message-State: ANhLgQ03i3mWpdmKkOgGgeJrZZAHQ63z1nvNb9q1drJnEebjoMruuU9q
        SCQQn9TcmiLbNoGfgDLypnuNsGAcW0qq8lOsu8bzz29KMWw=
X-Google-Smtp-Source: ADFU+vsBU5F1g5OOozpI/LyJFQB5VzQ5aZ6h1YtcTorDcGLBMNSy2c7ITmZZtVE87VaZaC+EiMPS7U7XATe74J3v8uo=
X-Received: by 2002:a17:906:65ca:: with SMTP id z10mr9030915ejn.368.1585251400312;
 Thu, 26 Mar 2020 12:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200319190512.cwnvgvv3upzcchkm@ca-dmjordan1.us.oracle.com> <20200326185822.6n56yl2llvdranur@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20200326185822.6n56yl2llvdranur@ca-dmjordan1.us.oracle.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 Mar 2020 15:36:29 -0400
Message-ID: <CA+CK2bDQ6qPfLsx=81L3_DVzvoCjkBRKvcw0Tz4Gd=Fd6pgQ3A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with Daniel, we should look into approach where
pgdat_resize_lock is taken only for the duration of updating tracking
values such as pgdat->first_deferred_pfn (perhaps we would need to add
another tracker that would show chunks that are currently being worked
on).

The vast duration of struct page initialization process should happen
outside of this lock, and only be taken when we update globally seen
data structures: lists, tracking variables. This way we can solve
several problems: 1. allow interrupt threads to grow zones if
required. 2. keep jiffies happy. 3. allow future scaling when we will
add inner node threads to initialize struct pages (i.e. ktasks from
Daniel).

Pasha

On Thu, Mar 26, 2020 at 2:58 PM Daniel Jordan
<daniel.m.jordan@oracle.com> wrote:
>
> On Thu, Mar 19, 2020 at 03:05:12PM -0400, Daniel Jordan wrote:
> > Regardless,
> > Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>
> Darn, I spoke too soon.
>
> On a two-socket Xeon, smaller values of TICK_PAGE_COUNT caused the deferred
> init timestamp to grow by over 25%.  This was with pgdatinit0 bound to the
> timer interrupt CPU to make sure the issue always reproduces.
>
>                TICK_PAGE_COUNT     node 0 deferred
>                                    init time (ms)
>                ---------------     ---------------
>                           4096                 610
>                           8192                 587
>                          16384                 487
>                          32768                 480    // used in the patch
>
> Instead of trying to find a constant that lets the timer interrupt run often
> enough, I think a better way forward is to reconsider how we handle the resize
> lock.  I plan to prototype something and reply back with what I get.
