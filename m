Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04D1973CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfHUHrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 03:47:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:36352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbfHUHrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:47:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4FBCB027;
        Wed, 21 Aug 2019 07:47:23 +0000 (UTC)
Date:   Wed, 21 Aug 2019 09:47:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Edward Chron <echron@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process
 message
Message-ID: <20190821074721.GY3111@dhcp22.suse.cz>
References: <20190821001445.32114-1-echron@arista.com>
 <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
 <20190821064732.GW3111@dhcp22.suse.cz>
 <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-08-19 00:19:37, David Rientjes wrote:
> On Wed, 21 Aug 2019, Michal Hocko wrote:
> 
> > > vm.oom_dump_tasks is pretty useful, however, so it's curious why you 
> > > haven't left it enabled :/
> > 
> > Because it generates a lot of output potentially. Think of a workload
> > with too many tasks which is not uncommon.
> 
> Probably better to always print all the info for the victim so we don't 
> need to duplicate everything between dump_tasks() and dump_oom_summary().

I believe that the motivation was to have a one line summary that is already
parsed by log consumers. And that is in __oom_kill_process one.

Also I do not think this patch improves things much for two reasons
at leasts a) it doesn't really give you the whole list of killed tasks
(this might be the whole memcg) and b) we already do have most important
information in __oom_kill_process. If something is missing there I do
not see a strong reason we cannot add it there. Like in this case.

> Edward, how about this?
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -420,11 +420,17 @@ static int dump_task(struct task_struct *p, void *arg)
>   * State information includes task's pid, uid, tgid, vm size, rss,
>   * pgtables_bytes, swapents, oom_score_adj value, and name.
>   */
> -static void dump_tasks(struct oom_control *oc)
> +static void dump_tasks(struct oom_control *oc, struct task_struct *victim)
>  {
>  	pr_info("Tasks state (memory values in pages):\n");
>  	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
>  
> +	/* If vm.oom_dump_tasks is disabled, only show the victim */
> +	if (!sysctl_oom_dump_tasks) {
> +		dump_task(victim, oc);
> +		return;
> +	}
> +
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>  	else {
> @@ -465,8 +471,8 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  		if (is_dump_unreclaim_slabs())
>  			dump_unreclaimable_slab();
>  	}
> -	if (sysctl_oom_dump_tasks)
> -		dump_tasks(oc);
> +	if (p || sysctl_oom_dump_tasks)
> +		dump_tasks(oc, p);
>  	if (p)
>  		dump_oom_summary(oc, p);
>  }

-- 
Michal Hocko
SUSE Labs
