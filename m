Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644716E516
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfGSLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 07:36:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbfGSLgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:36:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A675DAB98;
        Fri, 19 Jul 2019 11:36:48 +0000 (UTC)
Date:   Fri, 19 Jul 2019 13:36:47 +0200
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
Message-ID: <20190719113647.GS30461@dhcp22.suse.cz>
References: <20190718142239.7205-1-david@redhat.com>
 <20190719084239.GO30461@dhcp22.suse.cz>
 <eff19965-f280-6124-8fc5-56e3101f67cb@redhat.com>
 <20190719091313.GR30461@dhcp22.suse.cz>
 <48ea1d5d-ce40-aaad-b9fe-006488ed71dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ea1d5d-ce40-aaad-b9fe-006488ed71dc@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-07-19 11:20:43, David Hildenbrand wrote:
> On 19.07.19 11:13, Michal Hocko wrote:
> > On Fri 19-07-19 11:05:51, David Hildenbrand wrote:
> >> On 19.07.19 10:42, Michal Hocko wrote:
> >>> On Thu 18-07-19 16:22:39, David Hildenbrand wrote:
> >>>> We don't allow to offline memory block devices that belong to multiple
> >>>> numa nodes. Therefore, such devices can never get removed. It is
> >>>> sufficient to process a single node when removing the memory block.
> >>>>
> >>>> Remember for each memory block if it belongs to no, a single, or mixed
> >>>> nodes, so we can use that information to skip unregistering or print a
> >>>> warning (essentially a safety net to catch BUGs).
> >>>
> >>> I do not really like NUMA_NO_NODE - 1 thing. This is yet another invalid
> >>> node that is magic. Why should we even care? In other words why is this
> >>> patch an improvement?
> >>
> >> Oh, and to answer that part of the question:
> >>
> >> We no longer have to iterate over each pfn of a memory block to be removed.
> > 
> > Is it possible that we are overzealous when unregistering syfs files and
> > we should simply skip the pfn walk even without this change?
> > 
> 
> I assume you mean something like v1 without the warning/"NUMA_NO_NODE -1"?
> 
> See what I have right now below.

Yes. I didn'g get to look closely but you caught the idea. Thanks!
-- 
Michal Hocko
SUSE Labs
