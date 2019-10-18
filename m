Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D18DC581
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410128AbfJRMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 08:54:54 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:49182 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbfJRMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:54:54 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id DE62698C34
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:54:51 +0100 (IST)
Received: (qmail 7074 invoked from network); 18 Oct 2019 12:54:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Oct 2019 12:54:51 -0000
Date:   Fri, 18 Oct 2019 13:54:49 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Recalculate per-cpu page allocator batch and high
 limits after deferred meminit
Message-ID: <20191018125449.GJ3321@techsingularity.net>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018115849.GH4065@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191018115849.GH4065@codeblueprint.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:58:49PM +0100, Matt Fleming wrote:
> On Fri, 18 Oct, at 11:56:03AM, Mel Gorman wrote:
> > A private report stated that system CPU usage was excessive on an AMD
> > EPYC 2 machine while building kernels with much longer build times than
> > expected. The issue is partially explained by high zone lock contention
> > due to the per-cpu page allocator batch and high limits being calculated
> > incorrectly. This series addresses a large chunk of the problem. Patch 1
> > is mostly cosmetic but prepares for patch 2 which is the real fix. Patch
> > 3 is definiely cosmetic but was noticed while implementing the fix. Proper
> > details are in the changelog for patch 2.
> > 
> >  include/linux/mm.h |  3 ---
> >  mm/internal.h      |  3 +++
> >  mm/page_alloc.c    | 33 ++++++++++++++++++++-------------
> >  3 files changed, 23 insertions(+), 16 deletions(-)
> 
> Just to confirm, these patches don't fix the issue we're seeing on the
> EPYC 2 machines, but they do return the batch sizes to sensible values.

To be clear, does the patch a) fix *some* of the issue and there is
something else also going on that needs to be chased down or b) has no
impact on build time or system CPU usage on your machine?

-- 
Mel Gorman
SUSE Labs
