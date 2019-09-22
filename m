Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22884BA14B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 08:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfIVG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 02:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbfIVG6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 02:58:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1E12ACC6;
        Sun, 22 Sep 2019 06:58:02 +0000 (UTC)
Date:   Sun, 22 Sep 2019 08:58:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: threads-max observe limits
Message-ID: <20190922065801.GB18814@dhcp22.suse.cz>
References: <20190917100350.GB1872@dhcp22.suse.cz>
 <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
 <20190917153830.GE1872@dhcp22.suse.cz>
 <87ftku96md.fsf@x220.int.ebiederm.org>
 <20190918071541.GB12770@dhcp22.suse.cz>
 <87h8585bej.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8585bej.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-09-19 14:33:24, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Tue 17-09-19 12:26:18, Eric W. Biederman wrote:
[...]
> >> Michal is it a very small effect your customers are seeing?
> >> Is it another bug somewhere else?
> >
> > I am still trying to get more information. Reportedly they see a
> > different auto tuned limit between two kernel versions which results in
> > an applicaton complaining. As already mentioned this might be a side
> > effect of something else and this is not yet fully analyzed. My main
> > point for bringing up this discussion is ...
> 
> Please this sounds like the kind of issue that will reveal something
> deeper about what is going on.

Yes, I have pushed for that information even before starting discussion
here. I haven't heard from the customer yet unfortunatelly.
 
> >> b) Not being able to bump threads_max to the physical limit of
> >>    the machine is very clearly a regression.
> >
> > ... exactly this part. The changelog of the respective patch doesn't
> > really exaplain why it is needed except of "it sounds like a good idea
> > to be consistent".
> 
> I suggest doing a partial revert to just:
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7a74ade4e7d6..de8264ea34a7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2943,7 +2943,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
>  	if (ret || !write)
>  		return ret;
>  
> -	set_max_threads(threads);
> +	max_threads = threads;
>  
>  	return 0;
>  }
> 
> proc_dointvec_minmax limiting the values to MIN_THREADS and MAX_THREADS
> is justifiable.  Those are the minimum and maximum values the kernel can
> function with.

MAX_THREADS limit makes perfect sense because crossing it reflects a
real constrain for correctness. MIN_THREADS, on the other hand, is only
the low gate for auto tuning to not come with an unbootable system. I do
not think we should jump into the admin call on the lower bound. There
might be a good reason to restrict the number of threads to 1. So here
is what I would like to go with.

From 711000fdc243b6bc68a92f9ef0017ae495086d39 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Sun, 22 Sep 2019 08:45:28 +0200
Subject: [PATCH] kernel/sysctl.c: do not override max_threads provided by
 userspace

Partially revert 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
because the patch is causing a regression to any workload which needs to
override the auto-tuning of the limit provided by kernel.

set_max_threads is implementing a boot time guesstimate to provide a
sensible limit of the concurrently running threads so that runaways will
not deplete all the memory. This is a good thing in general but there
are workloads which might need to increase this limit for an application
to run (reportedly WebSpher MQ is affected) and that is simply not
possible after the mentioned change. It is also very dubious to override
an admin decision by an estimation that doesn't have any direct relation
to correctness of the kernel operation.

Fix this by dropping set_max_threads from sysctl_max_threads so any
value is accepted as long as it fits into MAX_THREADS which is important
to check because allowing more threads could break internal robust futex
restriction. While at it, do not use MIN_THREADS as the lower boundary
because it is also only a heuristic for automatic estimation and admin
might have a good reason to stop new threads to be created even when
below this limit.

Fixes: 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
Cc: stable
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..ef865be37e98 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2929,7 +2929,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
 	struct ctl_table t;
 	int ret;
 	int threads = max_threads;
-	int min = MIN_THREADS;
+	int min = 1;
 	int max = MAX_THREADS;
 
 	t = *table;
@@ -2941,7 +2941,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
 	if (ret || !write)
 		return ret;
 
-	set_max_threads(threads);
+	max_threads = threads;
 
 	return 0;
 }
-- 
2.20.1

-- 
Michal Hocko
SUSE Labs
