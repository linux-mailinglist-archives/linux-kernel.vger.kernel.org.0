Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7B2D391
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 04:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfE2CHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 22:07:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33886 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2CHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:07:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so347329plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 19:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=k/uph6k0VSxFUt6vW23NqyCeXeXQzEMPpEsp1IyAYdM=;
        b=tyrAmgJzpZqcjc3vBI1Kw8+OX3zVsiBwZ9+K0m4cxBIt5H5QPyo40KU++IQXdQyrAr
         5R4JxTMSIZXCF1lDAsTFph51tkhFwwHCdCR4czEIqiH4HVAtnVQ5EUUaQIcv8hXUexw6
         nqZQ38a6Xd2RzSRQ7GK5n9ImdFKOcIWZbSUtBjKhsa44nA6Sr6j6KLjtmRqyTRnJ3u2B
         ho7VQBDynkDQwu5biBGl/WOVgod3pqdsAJ6/boOt5HVFMiC6IMZV2Bgw7EI53NGrHDWI
         RVuTqnvdVsOhlpErJ5K5q6hU+ZOwspFkkHWkZWYy2sEY3VeRvLf2q8LZB/7L6Gcfn6SR
         Omvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=k/uph6k0VSxFUt6vW23NqyCeXeXQzEMPpEsp1IyAYdM=;
        b=pR32od3rHf0AkGmma7TPckbopWBCGOUH6KRlgX/RW0afgGLXYXgOR/2+rJ0BriQMOZ
         rtvw4IsGyegNY64YFGoNHKWnihX/Ll9g/gmEGWn9uJYU+KUyES3O6tG5lisw2DSHqDqI
         y/VmfKW4D8PuzcSfIKEuNYTn+GhIZBiB3dWTH/5PR/hcZ8WlF7Z3Usdlwfio10TVgPCT
         OsZm3yQUfqMAlcuyZ53KPwVvv800TvXNQn+FxLj4EGSoMB0DySvJF+/PAnVmveubFUBJ
         Dy2rvCsS/t/zitOePKuf3koc4TpGk5mhOuas25aog8o680hWKGtP8PUsPsFj+Y6gO20L
         s5iw==
X-Gm-Message-State: APjAAAW67TWGUKMiRna1feGsc9MvDELo+JNhxgFdnPX93LfE3JuKsRvt
        SHSORWlSH91puZqAjGLIlqePOQ==
X-Google-Smtp-Source: APXvYqybhE51tYlXSXFeLLyMrHntdA396Ff4w4Uc+K8kWaM6Xff9spvB8kQdJb2DbhT9dJbTk0CE9g==
X-Received: by 2002:a17:902:e60a:: with SMTP id cm10mr127625731plb.316.1559095619659;
        Tue, 28 May 2019 19:06:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h123sm17427729pfe.80.2019.05.28.19.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 19:06:58 -0700 (PDT)
Date:   Tue, 28 May 2019 19:06:57 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
In-Reply-To: <20190524202931.GB11202@redhat.com>
Message-ID: <alpine.DEB.2.21.1905281840470.86034@chino.kir.corp.google.com>
References: <20190503223146.2312-1-aarcange@redhat.com> <20190503223146.2312-3-aarcange@redhat.com> <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com> <20190520153621.GL18914@techsingularity.net> <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org> <20190524202931.GB11202@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Andrea Arcangeli wrote:

> > > We are going in circles, *yes* there is a problem for potential swap 
> > > storms today because of the poor interaction between memory compaction and 
> > > directed reclaim but this is a result of a poor API that does not allow 
> > > userspace to specify that its workload really will span multiple sockets 
> > > so faulting remotely is the best course of action.  The fix is not to 
> > > cause regressions for others who have implemented a userspace stack that 
> > > is based on the past 3+ years of long standing behavior or for specialized 
> > > workloads where it is known that it spans multiple sockets so we want some 
> > > kind of different behavior.  We need to provide a clear and stable API to 
> > > define these terms for the page allocator that is independent of any 
> > > global setting of thp enabled, defrag, zone_reclaim_mode, etc.  It's 
> > > workload dependent.
> > 
> > um, who is going to do this work?
> 
> That's a good question. It's going to be a not simple patch to
> backport to -stable: it'll be intrusive and it will affect
> mm/page_alloc.c significantly so it'll reject heavy. I wouldn't
> consider it -stable material at least in the short term, it will
> require some testing.
> 

Hi Andrea,

I'm not sure what patch you're referring to, unfortunately.  The above 
comment was referring to APIs that are made available to userspace to 
define when to fault locally vs remotely and what the preference should be 
for any form of compaction or reclaim to achieve that.  Today we have 
global enabling options, global defrag settings, enabling prctls, and 
madvise options.  The point it makes is that whether a specific workload 
fits into a single socket is workload dependant and thus we are left with 
prctls and madvise options.  The prctl either enables thp or it doesn't, 
it is not interesting here; the madvise is overloaded in four different 
ways (enabling, stalling at fault, collapsability, defrag) so it's not 
surprising that continuing to overload it for existing users will cause 
undesired results.  It makes an argument that we need a clear and stable 
means of defining the behavior, not changing the 4+ year behavior and 
giving those who regress no workaround.

> This is why applying a simple fix that avoids the swap storms (and the
> swap-less pathological THP regression for vfio device assignment GUP
> pinning) is preferable before adding an alloc_pages_multi_order (or
> equivalent) so that it'll be the allocator that will decide when
> exactly to fallback from 2M to 4k depending on the NUMA distance and
> memory availability during the zonelist walk. The basic idea is to
> call alloc_pages just once (not first for 2M and then for 4k) and
> alloc_pages will decide which page "order" to return.
> 

The commit description doesn't mention the swap storms that you're trying 
to fix, it's probably better to describe that again and why it is not 
beneficial to swap unless an entire pageblock can become free or memory 
compaction has indicated that additional memory freeing would allow 
migration to make an entire pageblock free.  I understand that's a 
invasive code change, but merging this patch changes the 4+ year behavior 
that started here:

commit 077fcf116c8c2bd7ee9487b645aa3b50368db7e1
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Feb 11 15:27:12 2015 -0800

    mm/thp: allocate transparent hugepages on local node

And that commit's description describes quite well the regression that we 
encounter if we remove __GFP_THISNODE here.  That's because the access 
latency regression is much more substantial than what was reported for 
Naples in your changelog.

In the interest of making forward progress, can we agree that swapping 
from the local node *never* makes sense unless we can show that an entire 
pageblock can become free or that it enables memory compaction to migrate 
memory that can make an entire pageblock free?  Are you reporting swap 
storms for the local node when one of these is true?

> > Implementing a new API doesn't help existing userspace which is hurting
> > from the problem which this patch addresses.
> 
> Yes, we can't change all apps that may not fit in a single NUMA
> node. Currently it's unsafe to turn "transparent_hugepages/defrag =
> always" or the bad behavior can then materialize also outside of
> MADV_HUGEPAGE. Those apps that use MADV_HUGEPAGE on their long lived
> allocations (i.e. guest physical memory) like qemu are affected even
> with the default "defrag = madvise". Those apps are using
> MADV_HUGEPAGE for more than 3 years and they are widely used and open
> source of course.
> 

I continue to reiterate that the 4+ year long standing behavior of 
MADV_HUGEPAGE is overloaded; you are anticipating a specific behavior for 
workloads that do not fit in a single NUMA node whereas other users 
developed in the past four years are anticipating a different behavior.  
I'm trying to propose solutions that can not cause regressions for any 
user, such as the prctl() example that is inherited across fork, and can 
be used to define the behavior.  This could be a very trivial extension to 
prctl(PR_SET_THP_DISABLE) or it could be more elaborate as an addition.  
This would be set by any thread that forks qemu and can define that the 
workload prefers remote hugepages because it spans more than one node.  
Certainly we should agree that the majority of Linux workloads do not span 
more than one socket.  However, it *may* be possible to define this as a 
global thp setting since most machines that run large guests are only 
running large guests so the default machine-level policy can reflect that.
