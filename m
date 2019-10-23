Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F233E139C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 10:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbfJWII1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 04:08:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:48720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390035AbfJWII1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:08:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99998BB64;
        Wed, 23 Oct 2019 08:08:25 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:08:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v1] memcg: add memcg lru for page reclaiming
Message-ID: <20191023080823.GH754@dhcp22.suse.cz>
References: <20191022133050.15620-1-hdanton@sina.com>
 <20191023044448.16484-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023044448.16484-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 12:44:48, Hillf Danton wrote:
> 
> On Tue, 22 Oct 2019 15:58:32 +0200 Michal Hocko wrote:
> > 
> > On Tue 22-10-19 21:30:50, Hillf Danton wrote:
[...]
> > > in this RFC after ripping pages off
> > > the first victim, the work finishes with the first ancestor of the victim
> > > added to lru.
> > > 
> > > Recaliming is defered until kswapd becomes active.
> > 
> > This is a wrong assumption because high limit might be configured way
> > before kswapd is woken up.
> 
> This change was introduced because high limit breach looks not like a
> serious problem in the absence of memory pressure. Lets do the hard work,
> reclaiming one memcg a time up through the hierarchy, when kswapd becomes
> active. It also explains the BH introduced.

But this goes against the main motivation for the high limit - to
throttle. It is not all that important that there is not global memory
pressure. The preventive high limit reclaim is there to make sure that
the specific memcg is kept in a reasonable containment.
-- 
Michal Hocko
SUSE Labs
