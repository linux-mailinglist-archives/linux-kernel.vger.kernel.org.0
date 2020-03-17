Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994AB187AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgCQHwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 03:52:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44826 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgCQHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:52:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id y2so8821407wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 00:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuaQPF1ZWPKes0ddeJfIKVDXd4T44v9s14fJWIErxcE=;
        b=P26j+LlnYmTOJWCP87P5Oc6WyLoDiFgOq6TGdOUvjakZxcrmx/bver+N+U/0235vw3
         IIDtVhR1uKWRTFoo3Gyo333/g7NdW+R3V2Lby0b7Wk08lmV22zBnaLzKJ0TTXwIbJBb7
         7bZvXKyYToZiRJuMXSrDpninocK5fN+Dk86Ug1VzwbcSHSkr6JweMcWPOrx5MGJKXbDq
         b7IPlX4+qw3SiF556yN1zFAzLFn3Pg/lPenqU0wMzPDF4v3dlWCjSc9he8fVYtaI5OLi
         ixMnHij3JDKlRaw6PIFxAHPrZb5nEpsoM2qbNsYi5IlC0MaD9sNlzxeuejwxjESMESO7
         6HRg==
X-Gm-Message-State: ANhLgQ0AKyvqT3+zHE4xKs/GtYmLpm/2caUD3rQU5+WaX8ME0hxdNt3/
        aooUebuKocG3aiNElvcAwmM=
X-Google-Smtp-Source: ADFU+vuAYroYBbemsZbZfWLaUtPDVfvJGwI/+NUsFg3a4LiTnMlH4PpyoJvKi6hxXHz8t2ZqTxqXeQ==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr4372448wro.76.1584431534404;
        Tue, 17 Mar 2020 00:52:14 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id z11sm2875547wmc.30.2020.03.17.00.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 00:52:13 -0700 (PDT)
Date:   Tue, 17 Mar 2020 08:52:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: make memory.oom.group tolerable to task
 migration
Message-ID: <20200317075212.GC26018@dhcp22.suse.cz>
References: <20200316223510.3176148-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316223510.3176148-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-03-20 15:35:10, Roman Gushchin wrote:
> If a task is getting moved out of the OOMing cgroup, it might
> result in unexpected OOM killings if memory.oom.group is used
> anywhere in the cgroup tree.
> 
> Imagine the following example:
> 
>           A (oom.group = 1)
>          / \
>   (OOM) B   C
> 
> Let's say B's memory.max is exceeded and it's OOMing. The OOM killer
> selects a task in B as a victim, but someone asynchronously moves
> the task into C.

I can see Reported-by here, does that mean that the race really happened
in real workloads? If yes, I would be really curious. Mostly because
moving tasks outside of the oom domain is quite questionable without
charge migration.

> mem_cgroup_get_oom_group() will iterate over all
> ancestors of C up to the root cgroup. In theory it had to stop
> at the oom_domain level - the memory cgroup which is OOMing.
> But because B is not an ancestor of C, it's not happening.
> Instead it chooses A (because it's oom.group is set), and kills
> all tasks in A. This behavior is wrong because the OOM happened in B,
> so there is no reason to kill anything outside.
> 
> Fix this by checking it the memory cgroup to which the task belongs
> is a descendant of the oom_domain. If not, memory.oom.group should
> be ignored, and the OOM killer should kill only the victim task.

I was about to suggest storing the memcg in oom_evaluate_task but then I
have realized that this would be both more complex and I am not yet
sure it would be better so much better after all.

The thing is that killing the selected task makes a lot of sense
because it was the largest consumer. No matter it has run away. On the
other hand if your B was oom.group = 1 then one could expect that any
OOM killer event in that group will result in the whole group tear
down. This is however a gray zone because we do emit MEMCG_OOM event but
MEMCG_OOM_KILL event will go to the victim's at-the-time memcg. So the
observer B could think that the oom was resolved without killing while
observer C would see a kill event without oom.

That being said, please try to think about the above. I will give it
some more time as well. Killing the selected victim is the obviously
correct thing and your patch does that so it is correct in that regard
but I believe that the group oom behavior in the original oom domain
remains an open question.

Fixes: 3d8b38eb81ca ("mm, oom: introduce memory.oom.group")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Dan Schatzberg <dschatzberg@fb.com>
> ---
>  mm/memcontrol.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index daa399be4688..d8c4b7aa4e73 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1930,6 +1930,14 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>  	if (memcg == root_mem_cgroup)
>  		goto out;
>  
> +	/*
> +	 * If the victim task has been asynchronously moved to a different
> +	 * memory cgroup, we might end up killing tasks outside oom_domain.
> +	 * In this case it's better to ignore memory.group.oom.
> +	 */
> +	if (unlikely(!mem_cgroup_is_descendant(memcg, oom_domain)))
> +		goto out;
> +
>  	/*
>  	 * Traverse the memory cgroup hierarchy from the victim task's
>  	 * cgroup up to the OOMing cgroup (or root) to find the
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
