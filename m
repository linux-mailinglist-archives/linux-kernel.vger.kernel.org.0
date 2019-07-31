Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F597BC97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfGaJG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 05:06:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbfGaJGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:06:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90E14ABE9;
        Wed, 31 Jul 2019 09:06:54 +0000 (UTC)
Date:   Wed, 31 Jul 2019 11:06:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190731090653.GD9330@dhcp22.suse.cz>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
 <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-07-19 12:57:43, Andrew Morton wrote:
> On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Add mempool allocations for struct kmemleak_object and
> > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > under memory pressure. Additionally, mask out all the gfp flags passed
> > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > 
> > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > different minimum pool size (defaulting to NR_CPUS * 4).
> 
> Why would anyone ever want to alter this?  Is there some particular
> misbehaviour which this will improve?  If so, what is it?

I do agree with Andrew here. Can we simply go with no tunning for now
and only add it based on some real life reports that the auto-tuning is
not sufficient?

-- 
Michal Hocko
SUSE Labs
