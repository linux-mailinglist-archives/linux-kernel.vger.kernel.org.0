Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D4118536
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLJKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 05:37:01 -0500
Received: from foss.arm.com ([217.140.110.172]:38950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfLJKhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:37:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B0E1FB;
        Tue, 10 Dec 2019 02:37:00 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 564973F6CF;
        Tue, 10 Dec 2019 02:36:59 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:36:57 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: fix find_idlest_group() to handle CPU
 affinity
Message-ID: <20191210103656.637xilg2egtdwv5b@e107158-lin.cambridge.arm.com>
References: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 19:21, Vincent Guittot wrote:
> Because of CPU affinity, the local group can be skipped which breaks the
> assumption that statistics are always collected for local group. With
> uninitialized local_sgs, the comparison is meaningless and the behavior
> unpredictable. This can even end up to use local pointer which is to
> NULL in this case.

For the record; I think this is safe and I can't see how the local_sgs can be
used uninitialized, but experience shows that if this happened once it's likely
to happen again when things change. So I think it'd be safer to always
initialize local_sgs to something sensible and avoid future trouble. I don't
see any cost to initializing it.

My 2p :-) The change is good for me as-is otherwise.

Cheers

--
Qais Yousef

> 
> If the local group has been skipped because of CPU affinity, we return
> the idlest group.
> 
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: John Stultz <john.stultz@linaro.org>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e..146b6c8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8417,6 +8417,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  	if (!idlest)
>  		return NULL;
>  
> +	/* The local group has been skipped because of CPU affinity */
> +	if (!local)
> +		return idlest;
> +
>  	/*
>  	 * If the local group is idler than the selected idlest group
>  	 * don't try and push the task.
> -- 
> 2.7.4
> 
