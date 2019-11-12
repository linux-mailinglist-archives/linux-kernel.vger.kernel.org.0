Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F97F8EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKLLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 06:37:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:59930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfKLLhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:37:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DDD6B1A7;
        Tue, 12 Nov 2019 11:37:17 +0000 (UTC)
Date:   Tue, 12 Nov 2019 12:37:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: handle freed page at the first place
Message-ID: <20191112113716.GC2763@dhcp22.suse.cz>
References: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191112080401.GA2763@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112080401.GA2763@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-11-19 09:04:01, Michal Hocko wrote:
> On Tue 12-11-19 06:09:25, Yang Shi wrote:
> > When doing migration if the freed page is met, we just return without
> > migrating it since it is pointless to migrate a freed page.  But, the
> > current code did two things before handling freed page:
> > 
> > 1. Return -ENOMEM if the page is THP and THP migration is not supported.
> > 2. Allocate target page unconditionally.
> > 
> > Both makes not too much sense.  If we handle freed page at the first place
> > we don't have to worry about allocating/freeing target page and split
> > THP at all.
> > 
> > For example (worst case) if we are trying to migrate a freed THP without
> > THP migration supported, the migrate_pages() would just split the THP then
> > retry to migrate base pages one by one by pointless allocating and freeing
> > pages, this is just waste of time.
> > 
> > I didn't run into any actual problem with the current code (or I may
> > just not notice it yet), it was found by visual inspection.
> 
> It would be preferable to accompany a change like this with some actual
> numbers. A race with page freeing should be a very rare situation. Maybe
> it is not under some workloads but that would better be checked and
> documented. I also do not like to do page state changes for THP
> migration without a support. I cannot really say this is 100% correct
> from top of my head and I do not see a sufficient justification to go
> and chase all those tiny details because that is time consuming.

And I forgot to mention one thing. I wouldn't be really opposed to
moving the allocation after the race check because that makes sense even
when the race is rare but moving the thp support check down is far from
clear without a much better justification. 
-- 
Michal Hocko
SUSE Labs
