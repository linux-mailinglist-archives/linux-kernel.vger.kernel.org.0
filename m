Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184CA6E329
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfGSJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 05:09:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:45578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfGSJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:09:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A89D6AF61;
        Fri, 19 Jul 2019 09:09:43 +0000 (UTC)
Date:   Fri, 19 Jul 2019 11:09:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] drivers/base/node.c: Simplify
 unregister_memory_block_under_nodes()
Message-ID: <20190719090942.GQ30461@dhcp22.suse.cz>
References: <20190718142239.7205-1-david@redhat.com>
 <20190719084239.GO30461@dhcp22.suse.cz>
 <4eefc51b-4cda-0ede-72d1-0f1c33d87ce8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eefc51b-4cda-0ede-72d1-0f1c33d87ce8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-07-19 10:48:19, David Hildenbrand wrote:
> On 19.07.19 10:42, Michal Hocko wrote:
> > On Thu 18-07-19 16:22:39, David Hildenbrand wrote:
> >> We don't allow to offline memory block devices that belong to multiple
> >> numa nodes. Therefore, such devices can never get removed. It is
> >> sufficient to process a single node when removing the memory block.
> >>
> >> Remember for each memory block if it belongs to no, a single, or mixed
> >> nodes, so we can use that information to skip unregistering or print a
> >> warning (essentially a safety net to catch BUGs).
> > 
> > I do not really like NUMA_NO_NODE - 1 thing. This is yet another invalid
> > node that is magic. Why should we even care? In other words why is this
> > patch an improvement?
> 
> I mean we can of course go ahead and drop the "NUMA_NO_NODE - 1" thingy
> from the patch. A memory block with multiple nodes would (as of now)
> only indicate one of the nodes.

Yes and that seemed to work reasonably well so far. Sure there is a
potential confusion but platforms with interleaved nodes are rare enough
to somebody to even notice so far.

> Then there is simply no way to WARN_ON_ONCE() in case unexpected things
> would happen. (I mean it really shouldn't happen or we have a BUG
> somewhere else)

I do not really see much point to warn here. What can user potentially
do?

> Alternative: Add "bool mixed_nids;" to "struct memory block".

That would be certainly possible but do we actually care?
-- 
Michal Hocko
SUSE Labs
