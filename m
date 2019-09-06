Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385C3AC19C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbfIFUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 16:49:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45011 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfIFUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:49:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id k1so3734098pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kfkmrxQuYct5oda3TZXHJcSutKY7WtItarpPz/Nika8=;
        b=m6qyufmEcA1q9csq0wvc9P3T85Zka9N0eqyLSBh6LtA/fSqOYqiggb4Ti2x2ytUbiJ
         yUdHJSySkoGNZ+1W9HcLm+OD7jsC+Gv0cqDWk665ODM6mHUTOj08YT8DkrBbSV59Z9KU
         zxKj8uQu5nxC4ULrTctqNbcfSAJyQoirBL3f9KTf6SNyOiDTT3FJ1RQ2ERrpH9T9TzdA
         zdt0Fh4Ev7UV7jEo4PoUSijNkpV2nIpUtB+dOJyRTilhN9UMY11E8inHe914UH1WVMBK
         9wOADohZm/M7em58IJUCXEEGifWj+LsSxXvHcHpSKXtxagT0zNuHaQA702TGS/gpaw7B
         q0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kfkmrxQuYct5oda3TZXHJcSutKY7WtItarpPz/Nika8=;
        b=Y4Jh7/95U7l4qgyGMNsg/6u+xGifXnVpfkqNbxuUQyu8m7veMtgZ64GHW66rOja4cV
         MYDTReGWOfT7utBe/tH08KwM6PBIlR0XQOe2SLc79eibzAsG0B1/e8oAm55/pZu+c/6t
         o8PR8jKCFB/yjlzauR70LHPGS8IBgbckfa/9bNUvw3UfU2wkMCTfPqWsNxnb+W/8j6Hv
         TNKgj74bdc3VE0BIGUH+EzhPBZh4A6tMeNRMwS9t5gQvzmlFMWCKFqHIAVgeVMATkIEQ
         MtV88rGoqNHkl3jdSjETy1SU7iuayVMQjF8CPHQsmbu2V5dQDU//+nd5N/3CJdhHsDCT
         cbcw==
X-Gm-Message-State: APjAAAXwGJY/p0Nbjw8gFdJOf/9piMxm9LUH2yc46F5tQTf6OiekCWh+
        JS0TSEex4689oamP0go+7Yx06Q==
X-Google-Smtp-Source: APXvYqxcT8C6ufZz91jvAjOHySnglu91710xPdmO0DFJ0rNT9RX8NEXCxbTVx9NOXfVHnwfBSagVng==
X-Received: by 2002:a17:902:3363:: with SMTP id a90mr11288893plc.270.1567802989095;
        Fri, 06 Sep 2019 13:49:49 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l26sm5589994pgb.90.2019.09.06.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 13:49:48 -0700 (PDT)
Date:   Fri, 6 Sep 2019 13:49:47 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [rfc 3/4] mm, page_alloc: avoid expensive reclaim when compaction
 may not succeed
In-Reply-To: <fab91766-da33-d62f-59fb-c226e4790a91@suse.cz>
Message-ID: <alpine.DEB.2.21.1909061341150.150656@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com> <alpine.DEB.2.21.1909041253390.94813@chino.kir.corp.google.com> <20190905090009.GF3838@dhcp22.suse.cz> <fab91766-da33-d62f-59fb-c226e4790a91@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Vlastimil Babka wrote:

> >>  - failing order-0 watermark checks in memory compaction does not account
> >>    for how far below the watermarks the zone actually is: to enable
> >>    migration, there must be *some* free memory available.  Per the above,
> >>    watermarks are not always suffficient if isolate_freepages() cannot
> >>    find the free memory but it could require hundreds of MBs of reclaim to
> >>    even reach this threshold (read: potentially very expensive reclaim with
> >>    no indication compaction can be successful), and
> 
> I doubt it's hundreds of MBs for a 2MB hugepage.
> 

I'm not sure how you presume to know, we certainly have incidents where 
compaction is skipped because free pages are are 100MB+ under low 
watermarks.

> >> For hugepage allocations, these are quite substantial drawbacks because
> >> these are very high order allocations (order-9 on x86) and falling back to
> >> doing reclaim can potentially be *very* expensive without any indication
> >> that compaction would even be successful.
> 
> You seem to lump together hugetlbfs and THP here, by saying "hugepage",
> but these are very different things - hugetlbfs reservations are
> expected to be potentially expensive.
> 

Mike Kravetz followed up and I can make a simple change to this fix to 
only run the new logic if the allocation is not using __GFP_RETRY_MAYFAIL 
which would exclude hugetlb allocations and include transparent hugepage 
allocations.

> >> Reclaim itself is unlikely to free entire pageblocks and certainly no
> >> reliance should be put on it to do so in isolation (recall lumpy reclaim).
> >> This means we should avoid reclaim and simply fail hugepage allocation if
> >> compaction is deferred.
> 
> It is however possible that reclaim frees enough to make even a
> previously deferred compaction succeed.
> 

This is another way that the return value that we get from memory 
compaction can be improved since right now we only check 
compaction_deferred() at the priorities we care about.  This discussion 
has revealed several areas where we can get more reliable and actionable 
return values from memory compaction to implement a sane default policy in 
the page allocator that works for everybody.

> >> It is also not helpful to thrash a zone by doing excessive reclaim if
> >> compaction may not be able to access that memory.  If order-0 watermarks
> >> fail and the allocation order is sufficiently large, it is likely better
> >> to fail the allocation rather than thrashing the zone.
> >>
> >> Signed-off-by: David Rientjes <rientjes@google.com>
> >> ---
> >>  mm/page_alloc.c | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -4458,6 +4458,28 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >>  		if (page)
> >>  			goto got_pg;
> >>  
> >> +		 if (order >= pageblock_order && (gfp_mask & __GFP_IO)) {
> >> +			/*
> >> +			 * If allocating entire pageblock(s) and compaction
> >> +			 * failed because all zones are below low watermarks
> >> +			 * or is prohibited because it recently failed at this
> >> +			 * order, fail immediately.
> >> +			 *
> >> +			 * Reclaim is
> >> +			 *  - potentially very expensive because zones are far
> >> +			 *    below their low watermarks or this is part of very
> >> +			 *    bursty high order allocations,
> >> +			 *  - not guaranteed to help because isolate_freepages()
> >> +			 *    may not iterate over freed pages as part of its
> >> +			 *    linear scan, and
> >> +			 *  - unlikely to make entire pageblocks free on its
> >> +			 *    own.
> >> +			 */
> >> +			if (compact_result == COMPACT_SKIPPED ||
> >> +			    compact_result == COMPACT_DEFERRED)
> >> +				goto nopage;
> 
> As I said, I expect this will make hugetlbfs reservations fail
> prematurely - Mike can probably confirm or disprove that.
> I think it also addresses consequences, not the primary problem, IMHO.
> I believe the primary problem is that we reclaim something even if
> there's enough memory for compaction. This won't change with your patch,
> as compact_result won't be SKIPPED in that case. 

I'm relying only on Andrea's one line feedback saying that this would 
address the swap storms that he is reporting, more details on why it 
doesn't, if it doesn't, would definitely be helpful.

> Then we continue
> through to __alloc_pages_direct_reclaim(), shrink_zones() which will
> call compaction_ready(), which will only return true and skip reclaim of
> the zone, if there's high_watermark (!!!) + compact_gap() pages.

Interesting find, that heuristic certainly doesn't appear consistent.  
Another thing to add to the list for how the memory compaction, direct 
reclaim, and page allocator feedback loop can be improved to provide sane 
default behavior for everybody.

If you'd like to send a patch to address this issue specifically, that 
would be very helpful!  I'm hoping Andrea can test it.
