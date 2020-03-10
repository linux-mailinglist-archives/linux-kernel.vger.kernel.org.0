Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42B180BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 23:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCJWyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 18:54:47 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52141 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCJWyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:54:47 -0400
Received: by mail-pj1-f66.google.com with SMTP id y7so1064362pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pn2IeIJZT4wK6H02E6y5ecz8EG7gDk1sSFKOAbcfk2k=;
        b=qryzW/wVV9l8Wn95biULg24zBxX93PnpefSAxVrn/suh/Qpu8ZOR34sujiajHBWkYJ
         0waEAvvc+bDNGFZWOTGRQoSh1GDnQvJwAIeKhV0dDBitKrKCWlxk95FqzGZdY1FZklWd
         KBn/3UjYlAZkcTnYP2DgxnKBuJNinFBVsV1Jit79ftYNqFiTbA5PbjZoPVWWmzYVgA+R
         0RNwHhOCnpQLiJVIjdiPX1rWts+ZL+bKWG+lzJp/8LrTsXrCqe3+H2BR/+rVbLwl1in5
         1As82gS8TYFJ/36vXvZNvB+7ZL3XTzNxnv/7bCYBZIKe/N1uRMSEhXNHBKBthc4NKrGF
         d9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pn2IeIJZT4wK6H02E6y5ecz8EG7gDk1sSFKOAbcfk2k=;
        b=uCpHNRyP1EzVhYiko7CPauD53gVrsWOTUadIuzxnxzSJdhjx1ON55lWP/olkutqA+/
         rDCNnOZ2jkmmupd7yc54VLtWqD2AuhLE9qyeAXZ48N3wl1TI6HLDiGviBw3IldsygHbv
         vxKdTM749HoaV4CjGgcd/acFNk7oD7elFNhyCYR4TRXxl+NggKHDekV6hFdUVnOtsCbo
         oS7zdP881030uEowbFy2FhPQ9JVBwBqHGcI4Uap77w8bzbPRWb4Bjn0NC2v/3psFXaBN
         uRp/KKnWfvLpFVGVGwCsfK+DoxK53Q5zGUdHNmORxY6HlHl8Wxh88YmwIg46tEdCym3E
         se8Q==
X-Gm-Message-State: ANhLgQ0AIG4x/n0eSCFXsSwKdswdZwaoptlXLvtb3p8VzLJPokSFjuVW
        nabdOsUOgUGjbxgo10aU6Z9tbw==
X-Google-Smtp-Source: ADFU+vvsJy92r0e/eX1DaCqmB8YLYATdU4ODk+lXpiz+KQj5xYEzpHBfKUBLzF09vZmkssIX5bqUoA==
X-Received: by 2002:a17:902:7d97:: with SMTP id a23mr193773plm.31.1583880885792;
        Tue, 10 Mar 2020 15:54:45 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c4sm645650pfc.88.2020.03.10.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:54:45 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:54:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>,
        Robert Kolchmeyer <rkolchmeyer@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
In-Reply-To: <20200310221938.GF8447@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com> <20200310221938.GF8447@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020, Michal Hocko wrote:

> On Tue 10-03-20 14:55:50, David Rientjes wrote:
> > Killing a user process as a result of hitting memcg limits is a serious
> > decision that is unfortunately needed only when no forward progress in
> > reclaiming memory can be made.
> > 
> > Deciding the appropriate oom victim can take a sufficient amount of time
> > that allows another process that is exiting to actually uncharge to the
> > same memcg hierarchy and prevent unnecessarily killing user processes.
> > 
> > An example is to prevent *multiple* unnecessary oom kills on a system
> > with two cores where the oom kill occurs when there is an abundance of
> > free memory available:
> > 
> > Memory cgroup out of memory: Killed process 628 (repro) total-vm:41944kB, anon-rss:40888kB, file-rss:496kB, shmem-rss:0kB, UID:0 pgtables:116kB oom_score_adj:0
> > <immediately after>
> > repro invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
> > CPU: 1 PID: 629 Comm: repro Not tainted 5.6.0-rc5+ #130
> > Call Trace:
> >  dump_stack+0x78/0xb6
> >  dump_header+0x55/0x240
> >  oom_kill_process+0xc5/0x170
> >  out_of_memory+0x305/0x4a0
> >  try_charge+0x77b/0xac0
> >  mem_cgroup_try_charge+0x10a/0x220
> >  mem_cgroup_try_charge_delay+0x1e/0x40
> >  handle_mm_fault+0xdf2/0x15f0
> >  do_user_addr_fault+0x21f/0x420
> >  async_page_fault+0x2f/0x40
> > memory: usage 61336kB, limit 102400kB, failcnt 74
> > 
> > Notice the second memcg oom kill shows usage is >40MB below its limit of
> > 100MB but a process is still unnecessarily killed because the decision has
> > already been made to oom kill by calling out_of_memory() before the
> > initial victim had a chance to uncharge its memory.
> 
> Could you be more specific about the specific workload please?
> 

Robert, could you elaborate on the user-visible effects of this issue that 
caused it to initially get reported?

> > Make a last minute check to determine if an oom kill is really needed to
> > prevent unnecessary oom killing.
> 
> I really see no reason why the memcg oom should behave differently from
> the global case. In both cases there will be a point of no return.
> Where-ever it is done it will be racy and the oom victim selection will
> play the race window role. There is simply no way around that without
> making the whole thing completely synchronous. This all looks like a
> micro optimization and I would really like to see a relevant real world
> usecase presented before new special casing is added.
> 

The patch certainly prevents unnecessary oom kills when there is a pending 
victim that uncharges its memory between invoking the oom killer and 
finding MMF_OOM_SKIP in the list of eligible tasks and its much more 
common on systems with limited cpu cores.

Adding support for the global case is more difficult because we rely on 
multiple heuristics, not only watermarks, to determine if we can allocate.  
It would likely require using a lot of the logic from the page allocator 
(alloc flags, watermark check, mempolicy awareness, cpusets) to make it 
work reliably and not miss a corner-case where we actually don't end up on 
oom killing anything at all.

Memcg charging, on the other hand, is much simpler as exhibited by this 
patch since it's only about the number of pages to charge and avoiding 
unnecessarily oom killing a user process is of paramount importance to 
that user.

Basically: it becomes very difficult for a cloud provider to say "look, 
your process was oom killed and it shows usage is 60MB in a memcg limited 
to 100MB" :)

> > 
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >  include/linux/memcontrol.h |  7 +++++++
> >  mm/memcontrol.c            |  2 +-
> >  mm/oom_kill.c              | 16 +++++++++++++---
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -445,6 +445,8 @@ void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
> >  int mem_cgroup_scan_tasks(struct mem_cgroup *,
> >  			  int (*)(struct task_struct *, void *), void *);
> >  
> > +unsigned long mem_cgroup_margin(struct mem_cgroup *memcg);
> > +
> >  static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
> >  {
> >  	if (mem_cgroup_disabled())
> > @@ -945,6 +947,11 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> >  	return 0;
> >  }
> >  
> > +static inline unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
> >  {
> >  	return 0;
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1286,7 +1286,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
> >   * Returns the maximum amount of memory @mem can be charged with, in
> >   * pages.
> >   */
> > -static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
> > +unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
> >  {
> >  	unsigned long margin = 0;
> >  	unsigned long count;
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -972,9 +972,6 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >  	}
> >  	task_unlock(victim);
> >  
> > -	if (__ratelimit(&oom_rs))
> > -		dump_header(oc, victim);
> > -
> >  	/*
> >  	 * Do we need to kill the entire memory cgroup?
> >  	 * Or even one of the ancestor memory cgroups?
> > @@ -982,6 +979,19 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >  	 */
> >  	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
> >  
> > +	if (is_memcg_oom(oc)) {
> > +		cond_resched();
> > +
> > +		/* One last check: do we *really* need to kill? */
> > +		if (mem_cgroup_margin(oc->memcg) >= (1 << oc->order)) {
> > +			put_task_struct(victim);
> > +			return;
> > +		}
> > +	}
> > +
> > +	if (__ratelimit(&oom_rs))
> > +		dump_header(oc, victim);
> > +
> >  	__oom_kill_process(victim, message);
> >  
> >  	/*
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
