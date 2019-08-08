Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B7485FB5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfHHKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 06:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHKdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:33:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB142173E;
        Thu,  8 Aug 2019 10:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565260383;
        bh=FQ6+FsASdUdEGiZDnohQHtyEdIqjQg4sf53ogeYronU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0cpkV6yxp9rMymSHvxjKf0jsHk3h+WHG95kn4WWQPwZZAhvUGd7+TO3nZ23eheGH
         A1Bc1VB+y4plVRkxLuTagWC3CwLI59ZuuyCt8w7z6tlpdftzRnlxyD9l5Azt8tFrEI
         fWGfWW3kB9p8pDXuOdw6q+Z0Q4YvrTZy9VrwpRPc=
Date:   Thu, 8 Aug 2019 11:32:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <20190808103257.4tqpip7ty4gf7eqf@willie-the-truck>
References: <20190805211451.20176-1-robdclark@gmail.com>
 <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806143457.GF475@lakrids.cambridge.arm.com>
 <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com>
 <20190807123807.GD54191@lakrids.cambridge.arm.com>
 <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com>
 <20190807164958.GA44765@lakrids.cambridge.arm.com>
 <20190808075827.GD30308@lst.de>
 <20190808102053.GA46901@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808102053.GA46901@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:20:53AM +0100, Mark Rutland wrote:
> On Thu, Aug 08, 2019 at 09:58:27AM +0200, Christoph Hellwig wrote:
> > On Wed, Aug 07, 2019 at 05:49:59PM +0100, Mark Rutland wrote:
> > > For arm64, we can tear down portions of the linear map, but that has to
> > > be done explicitly, and this is only possible when using rodata_full. If
> > > not using rodata_full, it is not possible to dynamically tear down the
> > > cacheable alias.
> > 
> > Interesting.  For this or next merge window I plan to add support to the
> > generic DMA code to remap pages as uncachable in place based on the
> > openrisc code.  Aѕ far as I can tell the requirement for that is
> > basically just that the kernel direct mapping doesn't use PMD or bigger
> > mapping so that it supports changing protection bits on a per-PTE basis.
> > Is that the case with arm64 + rodata_full?
> 
> Yes, with the added case that on arm64 we can also have contiguous
> entries at the PTE level, which we also have to disable.
> 
> Our kernel page table creation code does that for rodata_full or
> DEBUG_PAGEALLOC. See arch/arm64/mmu.c, in map_mem(), where we pass
> NO_{BLOCK,CONT}_MAPPINGS down to our pagetable creation code.

FWIW, we made rodata_full the default a couple of releases ago, so if
solving the cacheable alias for non-cacheable DMA buffers requires this
to be present, then we could probably just refuse to probe non-coherent
DMA-capable devices on systems where rodata_full has been disabled.

Will
