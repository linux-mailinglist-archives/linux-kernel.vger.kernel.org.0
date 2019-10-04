Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D3CBD96
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfJDOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 10:41:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388733AbfJDOlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:41:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7730AC69;
        Fri,  4 Oct 2019 14:41:51 +0000 (UTC)
Date:   Fri, 4 Oct 2019 16:41:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
Message-ID: <20191004144150.GO9578@dhcp22.suse.cz>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
 <20191004105824.GD9578@dhcp22.suse.cz>
 <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
 <1570193776.5576.270.camel@lca.pw>
 <20191004130713.GK9578@dhcp22.suse.cz>
 <1570195839.5576.273.camel@lca.pw>
 <20191004133814.GM9578@dhcp22.suse.cz>
 <1570197360.5576.275.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570197360.5576.275.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 09:56:00, Qian Cai wrote:
> On Fri, 2019-10-04 at 15:38 +0200, Michal Hocko wrote:
> > On Fri 04-10-19 09:30:39, Qian Cai wrote:
> > > On Fri, 2019-10-04 at 15:07 +0200, Michal Hocko wrote:
> > > > On Fri 04-10-19 08:56:16, Qian Cai wrote:
> > > > [...]
> > > > > It might be a good time to rethink if it is really a good idea to dump_page()
> > > > > at all inside has_unmovable_pages(). As it is right now, it is a a potential
> > > > > deadlock between console vs memory offline. More details are in this thread,
> > > > > 
> > > > > https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/
> > > > 
> > > > Huh. That would imply we cannot do any printk from that path, no?
> > > 
> > > Yes, or use something like printk_deferred()
> > 
> > This is just insane. The hotplug code is in no way special wrt printk.
> > It is never called from the printk code AFAIK and thus there is no real
> > reason why this particular code should be any special. Not to mention
> > it calls printk indirectly from a code that is shared with other code
> > paths.
> 
> Basically, printk() while holding the zone_lock will be problematic as console
> is doing the opposite as it always needs to allocate some memory. Then, it will
> always find some way to form this chain,
> 
> console_lock -> * -> zone_lock.

So this is not as much a hotplug specific problem but zone->lock ->
printk -> alloc chain that is a problem, right? Who is doing an
allocation from this atomic context? I do not see any atomic allocation
in kernel/printk/printk.c.
-- 
Michal Hocko
SUSE Labs
