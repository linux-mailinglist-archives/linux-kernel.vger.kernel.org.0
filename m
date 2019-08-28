Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518C29FB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfH1HKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:10:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:58822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbfH1HKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:10:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BB25B116;
        Wed, 28 Aug 2019 07:10:22 +0000 (UTC)
Date:   Wed, 28 Aug 2019 09:10:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     akpm@linux-foundation.org, penguin-kernel@I-love.SAKURA.ne.jp,
        guro@fb.com, shakeelb@google.com, yuzhoujian@didichuxing.com,
        jglisse@redhat.com, ebiederm@xmission.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: Re: [PATCH] mm/oom_kill.c: fox oom_cpuset_eligible() comment
Message-ID: <20190828071021.GD7386@dhcp22.suse.cz>
References: <1566959929-10638-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566959929-10638-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s@fox@fix@

On Wed 28-08-19 10:38:49, Yi Wang wrote:
> Commit ac311a14c682 ("oom: decouple mems_allowed from oom_unkillable_task")
> changed the function has_intersects_mems_allowed() to
> oom_cpuset_eligible(), but didn't change the comment meanwhile.
> 
> Let's fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/oom_kill.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eda2e2a..65c092e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -73,7 +73,7 @@ static inline bool is_memcg_oom(struct oom_control *oc)
>  /**
>   * oom_cpuset_eligible() - check task eligiblity for kill
>   * @start: task struct of which task to consider
> - * @mask: nodemask passed to page allocator for mempolicy ooms
> + * @oc: pointer to struct oom_control
>   *
>   * Task eligibility is determined by whether or not a candidate task, @tsk,
>   * shares the same mempolicy nodes as current if it is bound by such a policy
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
