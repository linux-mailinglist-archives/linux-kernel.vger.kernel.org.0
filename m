Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D247D59D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfHAGl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:41:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfHAGl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:41:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8003FAD1E;
        Thu,  1 Aug 2019 06:41:55 +0000 (UTC)
Date:   Thu, 1 Aug 2019 08:41:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190801064153.GD11627@dhcp22.suse.cz>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
 <20190730130215.919b31c19df935cc5f1483e6@linux-foundation.org>
 <20190731154450.GB17773@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731154450.GB17773@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 16:44:50, Catalin Marinas wrote:
> On Tue, Jul 30, 2019 at 01:02:15PM -0700, Andrew Morton wrote:
> > On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > > Add mempool allocations for struct kmemleak_object and
> > > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > > under memory pressure. Additionally, mask out all the gfp flags passed
> > > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > > 
> > > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > > different minimum pool size (defaulting to NR_CPUS * 4).
> > 
> > btw, the checkpatch warnings are valid:
> > 
> > WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
> > #70: FILE: mm/kmemleak.c:197:
> > +static int min_object_pool = NR_CPUS * 4;
> > 
> > WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
> > #71: FILE: mm/kmemleak.c:198:
> > +static int min_scan_area_pool = NR_CPUS * 1;
> > 
> > There can be situations where NR_CPUS is much larger than
> > num_possible_cpus().  Can we initialize these tunables within
> > kmemleak_init()?
> 
> We could and, at least on arm64, cpu_possible_mask is already
> initialised at that point. However, that's a totally made up number. I
> think we would better go for a Kconfig option (defaulting to, say, 1024)
> similar to the CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE and we grow it if
> people report better values in the future.

If you really want/need to make this configurable then the command line
parameter makes more sense - think of distribution kernel users for
example. But I am still not sure why this is really needed. The initial
size is a "made up" number of course. There is no good estimation to
make (without a crystal ball). The value might be increased based on
real life usage.
-- 
Michal Hocko
SUSE Labs
