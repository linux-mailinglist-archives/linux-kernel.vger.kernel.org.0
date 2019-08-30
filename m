Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44EA3283
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH3Ibi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 04:31:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfH3Ibi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:31:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BD1AAF47;
        Fri, 30 Aug 2019 08:31:36 +0000 (UTC)
Date:   Fri, 30 Aug 2019 10:31:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 3/6] mm/memory_hotplug: Process all zones when
 removing memory
Message-ID: <20190830083135.GU28313@dhcp22.suse.cz>
References: <20190826101012.10575-1-david@redhat.com>
 <20190826101012.10575-4-david@redhat.com>
 <20190829153936.GJ28313@dhcp22.suse.cz>
 <c01ceaab-4032-49cd-3888-45838cb46e11@redhat.com>
 <20190829162704.GL28313@dhcp22.suse.cz>
 <b5a9f070-b43a-c21d-081b-9926b2007f5c@redhat.com>
 <20190830060100.GP28313@dhcp22.suse.cz>
 <18aed12d-0611-7d35-2994-075d09269513@redhat.com>
 <20190830064724.GT28313@dhcp22.suse.cz>
 <17de8d65-592f-72be-0891-6eaaedfd26f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17de8d65-592f-72be-0891-6eaaedfd26f2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 09:07:59, David Hildenbrand wrote:
> On 30.08.19 08:47, Michal Hocko wrote:
> > On Fri 30-08-19 08:20:32, David Hildenbrand wrote:
> > [...]
> >> Regarding shrink_zone_span(), I suspect it was introduced by
> >>
> >> d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
> > 
> > zone shrinking code is much older - 815121d2b5cd5. But I do not think
> > this is really needed for Fixes tag.
> > 
> 
> Yes it's older, but since d0dc12e86b31 we could run into uninitialized
> nids for added memory when trying to shrink the zone.

Well, not really. Strictly speaking pre d0dc12e86b31 would initialize
struct page to zero so it is initialized but that doesn't mean that the
struct page has a meaningfull and usable content. Zone index would be 0
so the lowest zone which is not something you want to use on the
hotremove path.

-- 
Michal Hocko
SUSE Labs
