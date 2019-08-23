Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313979AF37
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391833AbfHWMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 08:22:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbfHWMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V/BSRc/5Dyzi5nNWjFuzygHkjpKjWnqloHD8aW/Vxqo=; b=QhVuHj1dAZl1mSQGXJo2iAGCW
        hgIo2M3LHfplbLuqjQQKsp+jqghpnaWYkE+8TJagxpAooKMVQSfkyCiWzwg0J/FebKHV2fgd5dRkD
        62k1PTj5cLwTATA9cUqki8XfXOsA+hV4kL5THNjT0pglSIqU3PgXGRmhGuQI+/mv+yaebEm22DsFZ
        NsW/tHvQOSWbR9a8c7n66Br1OziopIZBpxN0M1Rr5TYPorCcXRqMoWvj4KXCSJZtqjcrT7O74s0uW
        yu/81Xxv4oF8izJ2tOAHVHMs3+/ib0gg12YdbCPetCqufa/tIbQUDfbnN9QLO9xSKQaHM0oj+tX+W
        gWXahD2LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i18ab-0007UH-8z; Fri, 23 Aug 2019 12:22:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48F1A307691;
        Fri, 23 Aug 2019 14:22:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67A3B201E04D9; Fri, 23 Aug 2019 14:22:42 +0200 (CEST)
Date:   Fri, 23 Aug 2019 14:22:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/4] kernel.h: Add non_block_start/end()
Message-ID: <20190823122242.GN2349@hirez.programming.kicks-ass.net>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-4-daniel.vetter@ffwll.ch>
 <20190820202440.GH11147@phenom.ffwll.local>
 <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
 <CAKMK7uGw_7uD=wH3bcR9xXSxAcAuYTLOZt3ue4TEvst1D0KzLQ@mail.gmail.com>
 <20190823121234.GB12968@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823121234.GB12968@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 09:12:34AM -0300, Jason Gunthorpe wrote:

> I still haven't heard a satisfactory answer why a whole new scheme is
> needed and a simple:
> 
>    if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
>         preempt_disable()
> 
> isn't sufficient to catch the problematic cases during debugging??
> IMHO the fact preempt is changed by the above when debugging is not
> material here. I think that information should be included in the
> commit message at least.

That has a much larger impact and actually changes behaviour, while the
relatively simple patch Daniel proposed only adds a warning but doesn't
affect behaviour.
