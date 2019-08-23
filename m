Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702FC9B19C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbfHWOHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 10:07:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38652 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHWOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YKuQj4mAn7Ly5b7a4x9QRIt1a/TDbvR4K88H+PiPWaY=; b=pLeDF2JRWvn5cV6HVnEDw3VLF
        m6eg1WFTuIkTWXy/lA95iK0Ff+Ac3qqG7mLkMqzJnT5sh0kFAMPkyhTnHF0ObSzu5cOOSYXkv4tyS
        okxtf6Uc8yCdeZ7c236qvdKh/NoFGDK7/Ti7lMgUFd/or3ObdSQstPTL+isWWUyFCgJzKIwdrWHHk
        uLGRqW0XJlsVnbiO99fDPHpYfC+GXdqwSgf/L2sUCn3oi6eZ3yKbdS/Tkg4RD1eqsMG/kHAbOtFYt
        0i3/a/MJg+FHF9xSxttoVoi9RtyiTlKVAaynNJpYkhjPA4JQF/8KRtSwV6XEQw2gbS58lOIvz97TV
        NeA22XXQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i1ACp-00023P-9v; Fri, 23 Aug 2019 14:06:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A117307510;
        Fri, 23 Aug 2019 16:05:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99EF9202245FF; Fri, 23 Aug 2019 16:06:15 +0200 (CEST)
Date:   Fri, 23 Aug 2019 16:06:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20190823140615.GJ2369@hirez.programming.kicks-ass.net>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-4-daniel.vetter@ffwll.ch>
 <20190820202440.GH11147@phenom.ffwll.local>
 <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
 <CAKMK7uGw_7uD=wH3bcR9xXSxAcAuYTLOZt3ue4TEvst1D0KzLQ@mail.gmail.com>
 <20190823121234.GB12968@ziepe.ca>
 <CAKMK7uHzSkd2j4MvSMoHhCaSE0BT0zMo9osF4FUBYwNZrVfYDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHzSkd2j4MvSMoHhCaSE0BT0zMo9osF4FUBYwNZrVfYDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:42:47PM +0200, Daniel Vetter wrote:
> I'm assuming the lockdep one will land, so not going to resend that.

I was assuming you'd wake the might_lock_nested() along with the i915
user through the i915/drm tree. If want me to take some or all of that,
lemme know.
