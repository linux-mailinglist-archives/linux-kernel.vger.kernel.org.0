Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE064A044B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfH1OKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:10:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44067 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfH1OKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:10:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id e24so2690095ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKt821ZOo8b4wunZdO5Tqq/lepKvMI98la3oRAg9cpY=;
        b=syWVlYNgyF0AL8fpECZjp/ozllB/yxhtEUFeqG68NY9/b4WeLLUgS3JpqM+L+lU6pD
         c4Z7WbQEHAiY7XHtqIzEkU8le2+KZI9mpjdu9z4JrFodapFqSMQMQSAB/K9E7RKwfvWQ
         XbYJlxKlAw6eW3qkmNMwzIOcW2reyqMkeajNHdfZ3b6Yov+9P5tlmdqM0Aau/NmHnqDR
         6lPtKac+htOL3D21fR0eRolm2Jrm5Sr0eEg6oEKUixX1h/0PrZCxZOMwFaC9AoKgxzNT
         F2tN3y0nvd27MvJ1w9dE+gDVTH5edhFMqJ+BY0FysImafsg6J68YqKtywwiRP+dH17qd
         M+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKt821ZOo8b4wunZdO5Tqq/lepKvMI98la3oRAg9cpY=;
        b=PF0UyYANR8XOHZow6FbtagCovnM3GzlsKwaDkzrddyKF9/WxUu23i2peOd8V6oqfVf
         dWxLpeWvoBK3HnjZNgAjLOOsDNyyyqn8rzANHH+/uG5Nu5b+NcaMiRjykeiDB3nCNjlp
         DeNm8Mn9rzveQks+d+dw2hiM+cTNS1nHHS6mUdmGJo3ZLWqAqkAX8tpNL5uRCxdyW+PZ
         19GgipPK1L7LYLsOd6Sa2bHzMtJxAMennq3aXUkvxsq+TSkq6S6hb87KUwKzLZdbdpRZ
         4Lu94yyFBw5WjmVRfO4/Sjs9SuOA3McTIelH09AJa/7RLfcNcx1nQj03F7yLE1yy7v5z
         gsjA==
X-Gm-Message-State: APjAAAVkWCbXSHGzGHBYFokxc2NHxZh+JVMAhFUQYhqfXCsED2TnQ44F
        0wTiqv1WVDjixvPSfg46jaUG/uf8vk6ulWROfWQ4tQ==
X-Google-Smtp-Source: APXvYqx1HYdaOVRgR53coEk7YAqre/jCVJ11CH7izTFp08UzGAn+yD4ntT2znZqIPvgIrvqUHKd4MxoMSalqcOzpP8M=
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr2181891ljj.24.1567001400206;
 Wed, 28 Aug 2019 07:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-6-riel@surriel.com>
In-Reply-To: <20190822021740.15554-6-riel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Aug 2019 16:09:49 +0200
Message-ID: <CAKfTPtAoZwmZXthcaP6VQO-0oEOtPfTWwDPtgHfKwBt=+TO2XA@mail.gmail.com>
Subject: Re: [PATCH 05/15] sched,fair: remove cfs_rqs from leaf_cfs_rq_list
 bottom up
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
>
> Reducing the overhead of the CPU controller is achieved by not walking
> all the sched_entities every time a task is enqueued or dequeued.
>
> One of the things being checked every single time is whether the cfs_rq
> is on the rq->leaf_cfs_rq_list.
>
> By only removing a cfs_rq from the list once it no longer has children
> on the list, we can avoid walking the sched_entity hierarchy if the bottom
> cfs_rq is on the list, once the runqueues have been flattened.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a48d0dbfc232..04b216234265 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -369,6 +369,39 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
>         SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
>  }
>
> +/*
> + * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> + * immediately before a parent cfs_rq, and cfs_rqs are removed from the list
> + * bottom-up, we only have to test whether the cfs_rq before us on the list
> + * is our child.
> + */
> +static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
> +{
> +       struct cfs_rq *prev_cfs_rq;
> +       struct list_head *prev;
> +
> +       prev = cfs_rq->leaf_cfs_rq_list.prev;
> +       prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
> +
> +       return (prev_cfs_rq->tg->parent == cfs_rq->tg);
> +}
> +
> +/*
> + * Remove a cfs_rq from the list if it has no children on the list.
> + * The scheduler iterates over the list regularly; if conditions for
> + * removal are still true, we'll get to this cfs_rq in the future.
> + */
> +static inline void list_del_leaf_cfs_rq_bottom(struct cfs_rq *cfs_rq)
> +{
> +       if (!cfs_rq->on_list)
> +               return;
> +
> +       if (child_cfs_rq_on_list(cfs_rq))
> +               return;
> +
> +       list_del_leaf_cfs_rq(cfs_rq);
> +}
> +
>  /* Iterate thr' all leaf cfs_rq's on a runqueue */
>  #define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)                     \
>         list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,    \
> @@ -7723,7 +7756,7 @@ static void update_blocked_averages(int cpu)
>                  * decayed cfs_rqs linger on the list.
>                  */
>                 if (cfs_rq_is_decayed(cfs_rq))
> -                       list_del_leaf_cfs_rq(cfs_rq);
> +                       list_del_leaf_cfs_rq_bottom(cfs_rq);
>
>                 /* Don't need periodic decay once load/util_avg are null */
>                 if (cfs_rq_has_blocked(cfs_rq))
> --
> 2.20.1
>
