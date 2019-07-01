Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3195A49980
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfFRGyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbfFRGyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:54:22 -0400
Received: from brain-police (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0AB20665;
        Tue, 18 Jun 2019 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560840861;
        bh=h6KCEecYqvEUsVXMGsOj14p5VeuD+CI26MOesVKK8tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBvX088a/fOuuObjn7+ntF6Kq5hoY2/4Hpn4C9r/FHAPQ18VfSrKIN6FL5H8J8wzc
         BBR26SXGwC+04hPIj6pp4cWe3SMe5tW99SFutH5DZAbPe6caLBBE0uSV5X3hETFvma
         RU/jAfOdqr0dwXiPJhdVASX8az+JIm0olJ4+olBE=
Date:   Tue, 18 Jun 2019 07:54:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
Message-ID: <20190618065414.GA15875@brain-police>
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
 <20190604142338.GC24467@lakrids.cambridge.arm.com>
 <20190610114326.GF15979@fuggles.cambridge.arm.com>
 <1560187575.6132.70.camel@lca.pw>
 <20190611100348.GB26409@lakrids.cambridge.arm.com>
 <20190613121100.GB25164@rapoport-lnx>
 <20190617151252.GF16810@rapoport-lnx>
 <20190617163630.GH30800@fuggles.cambridge.arm.com>
 <20190618061259.GB15497@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618061259.GB15497@rapoport-lnx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:12:59AM +0300, Mike Rapoport wrote:
> On Mon, Jun 17, 2019 at 05:36:30PM +0100, Will Deacon wrote:
> > On Mon, Jun 17, 2019 at 06:12:52PM +0300, Mike Rapoport wrote:
> > > Andrew, can you please add the patch below as an incremental fix?
> > > 
> > > With this the arm64::pgd_alloc() should be in the right shape.
> > > 
> > > 
> > > From 1c1ef0bc04c655689c6c527bd03b140251399d87 Mon Sep 17 00:00:00 2001
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > Date: Mon, 17 Jun 2019 17:37:43 +0300
> > > Subject: [PATCH] arm64/mm: don't initialize pgd_cache twice
> > > 
> > > When PGD_SIZE != PAGE_SIZE, arm64 uses kmem_cache for allocation of PGD
> > > memory. That cache was initialized twice: first through
> > > pgtable_cache_init() alias and then as an override for weak
> > > pgd_cache_init().
> > > 
> > > After enabling accounting for the PGD memory, this created a confusion for
> > > memcg and slub sysfs code which resulted in the following errors:
> > > 
> > > [   90.608597] kobject_add_internal failed for pgd_cache(13:init.scope) (error: -2 parent: cgroup)
> > > [   90.678007] kobject_add_internal failed for pgd_cache(13:init.scope) (error: -2 parent: cgroup)
> > > [   90.713260] kobject_add_internal failed for pgd_cache(21:systemd-tmpfiles-setup.service) (error: -2 parent: cgroup)
> > > 
> > > Removing the alias from pgtable_cache_init() and keeping the only pgd_cache
> > > initialization in pgd_cache_init() resolves the problem and allows
> > > accounting of PGD memory.
> > > 
> > > Reported-by: Qian Cai <cai@lca.pw>
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/arm64/include/asm/pgtable.h | 3 +--
> > >  arch/arm64/mm/pgd.c              | 5 +----
> > >  2 files changed, 2 insertions(+), 6 deletions(-)
> > 
> > Looks like this actually fixes caa841360134 ("x86/mm: Initialize PGD cache
> > during mm initialization") due to an unlucky naming conflict!
> > 
> > In which case, I'd actually prefer to take this fix asap via the arm64
> > tree. Is that ok?
> 
> I suppose so, it just won't apply as is. Would you like a patch against the
> current upstream?

Yes, please. I'm assuming it's a straightforward change (please shout if it
isn't).

Will
