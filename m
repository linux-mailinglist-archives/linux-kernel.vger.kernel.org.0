Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C54873E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405855AbfHIITC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 04:19:02 -0400
Received: from verein.lst.de ([213.95.11.211]:53350 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfHIITC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:19:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2822D68AFE; Fri,  9 Aug 2019 10:18:58 +0200 (CEST)
Date:   Fri, 9 Aug 2019 10:18:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
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
Message-ID: <20190809081857.GB21967@lst.de>
References: <20190806084821.GA17129@lst.de> <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806143457.GF475@lakrids.cambridge.arm.com> <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com> <20190807123807.GD54191@lakrids.cambridge.arm.com> <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com> <20190807164958.GA44765@lakrids.cambridge.arm.com> <CAJs_Fx71T=kJEgt28TWqzw+jOahSbLQynCg83+szQW7op4xBkQ@mail.gmail.com> <20190808075947.GE30308@lst.de> <CAJs_Fx5fJ31CsFODBgBbhcCvoxSX_D1NHDjQs4LtJ_0GwuxMVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx5fJ31CsFODBgBbhcCvoxSX_D1NHDjQs4LtJ_0GwuxMVA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:44:32AM -0700, Rob Clark wrote:
> > GFP_HIGHUSER basically just means that this is an allocation that could
> > dip into highmem, in which case it would not have a kernel mapping.
> > This can happen on arm + LPAE, but not on arm64.
> 
> Just a dumb question, but why is *all* memory in the linear map on
> arm64?  It would seem useful to have a source of pages that is not in
> the linear map.
> I guess it is mapped as huge pages (or something larger than 4k pages)?

In general that is just how the Linux kernel always worked, on all
architectures - we always had a linear mapping for all memory in the
kernel to make accessing it simple.  That started to break down a bit
with the 32-bit x86 PAE mode that supported more physical addressing
that virtual, which required the "high" memory to not be mapped into
the kernel direct mapping.  Similar schemes later showed up on various
other 32-bit architectures.

There is a patchset called XPFO that ensures memory is either in the
kernel direct map, or in userspace but not both to work around
speculation related vulnerabilities, but it has a pretty big performance
impact.

> Any recommended reading to understand how/why the kernel address space
> is setup the way it is (so I can ask fewer dumb questions)?

I don't really have a good pointer.  But usually there is just dumb
answers, not dumb questions.
