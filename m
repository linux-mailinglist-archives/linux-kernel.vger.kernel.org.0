Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861399E75D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfH0MJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbfH0MJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:09:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 284E9AF19;
        Tue, 27 Aug 2019 12:09:25 +0000 (UTC)
Date:   Tue, 27 Aug 2019 14:09:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        kirill.shutemov@linux.intel.com,
        Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190827120923.GB7538@dhcp22.suse.cz>
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <ee048bbf-3563-d695-ea58-5f1504aee35c@suse.cz>
 <20190822152934.w6ztolutdix6kbvc@box>
 <20190826074035.GD7538@dhcp22.suse.cz>
 <20190826131538.64twqx3yexmhp6nf@box>
 <20190827060139.GM7538@dhcp22.suse.cz>
 <20190827110210.lpe36umisqvvesoa@box>
 <aaaf9742-56f7-44b7-c3db-ad078b7b2220@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaaf9742-56f7-44b7-c3db-ad078b7b2220@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 14:01:56, Vlastimil Babka wrote:
> On 8/27/19 1:02 PM, Kirill A. Shutemov wrote:
> > On Tue, Aug 27, 2019 at 08:01:39AM +0200, Michal Hocko wrote:
> >> On Mon 26-08-19 16:15:38, Kirill A. Shutemov wrote:
> >>>
> >>> Unmapped completely pages will be freed with current code. Deferred split
> >>> only applies to partly mapped THPs: at least on 4k of the THP is still
> >>> mapped somewhere.
> >>
> >> Hmm, I am probably misreading the code but at least current Linus' tree
> >> reads page_remove_rmap -> [page_remove_anon_compound_rmap ->\ deferred_split_huge_page even
> >> for fully mapped THP.
> > 
> > Well, you read correctly, but it was not intended. I screwed it up at some
> > point.
> > 
> > See the patch below. It should make it work as intened.
> > 
> > It's not bug as such, but inefficientcy. We add page to the queue where
> > it's not needed.
> 
> But that adding to queue doesn't affect whether the page will be freed
> immediately if there are no more partial mappings, right? I don't see
> deferred_split_huge_page() pinning the page.
> So your patch wouldn't make THPs freed immediately in cases where they
> haven't been freed before immediately, it just fixes a minor
> inefficiency with queue manipulation?

Ohh, right. I can see that in free_transhuge_page now. So fully mapped
THPs really do not matter and what I have considered an odd case is
really happening more often.

That being said this will not help at all for what Yang Shi is seeing
and we need a more proactive deferred splitting as I've mentioned
earlier.

-- 
Michal Hocko
SUSE Labs
