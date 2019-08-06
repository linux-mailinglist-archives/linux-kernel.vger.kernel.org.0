Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D295E83402
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfHFOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 10:35:03 -0400
Received: from foss.arm.com ([217.140.110.172]:34232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfHFOfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:35:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C162B344;
        Tue,  6 Aug 2019 07:35:01 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5F23F706;
        Tue,  6 Aug 2019 07:34:59 -0700 (PDT)
Date:   Tue, 6 Aug 2019 15:34:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190806143457.GF475@lakrids.cambridge.arm.com>
References: <20190805211451.20176-1-robdclark@gmail.com>
 <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> On Tue, Aug 6, 2019 at 1:48 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > This goes in the wrong direction.  drm_cflush_* are a bad API we need to
> > get rid of, not add use of it.  The reason for that is two-fold:
> >
> >  a) it doesn't address how cache maintaince actually works in most
> >     platforms.  When talking about a cache we three fundamental operations:
> >
> >         1) write back - this writes the content of the cache back to the
> >            backing memory
> >         2) invalidate - this remove the content of the cache
> >         3) write back + invalidate - do both of the above
> 
> Agreed that drm_cflush_* isn't a great API.  In this particular case
> (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> out to memory later, and so that I don't get a cache hit on
> uncached/wc mmap'ing.

Is there a cacheable alias lying around (e.g. the linear map), or are
these addresses only mapped uncached/wc?

If there's a cacheable alias, performing an invalidate isn't sufficient,
since a CPU can allocate a new (clean) entry at any point in time (e.g.
as a result of prefetching or arbitrary speculation).

Thanks,
Mark.
