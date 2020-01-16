Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE71A13D561
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbgAPHwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 02:52:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40550 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgAPHwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:52:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id i23so14801385lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 23:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTIsjgMo7EQgCCOyFJEg9cuy7bHjnBKfDHzHv5nLeB4=;
        b=kERPx04OirVwGcSXAOdKY8CLreaYJ0pKntO0tLVP/F4xp5Ta1UgI4VpgD8qOA0h7mS
         TZSeIwPY8EESbnclJGeCUr0ikHWZ7vOomwT40Jpo9K6itypK2GhZtrM4J2CeQDQrT4AV
         4QnkQtEC6fuUfGjCOPfGw+KPTb/oLt2I9cjgWCQpZkXvSqB2bO2gUyLi052om92OgZ0H
         oeTjYlxjA8PHAKFEhT7Axfd0dAVpcJH2KVA00mP+ZLLO6YvVnGRwVhNesuh9/u1jU5Gv
         U/Ped2YJJLtE2JX9oIZpliGluFcNzdm3u4IwJEQ5ETyjoV+bTwEXSM29yPZdGRPcq3U6
         955Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTIsjgMo7EQgCCOyFJEg9cuy7bHjnBKfDHzHv5nLeB4=;
        b=Rwz3VGirypePYz0ycOTPfHl1SpTr93iXCKyx9g1NK5lBzGu1W5OWpQztH8jhckm4wq
         2SaZIe/CD1iaHiZynHa9s7vqKh1E4nTlBRT84JG+yiqRCQx5FDDBn0++Y1N8E8l6XWqc
         GSgM7iSoXkoKYr72fOrcwwM6x2fEvlpBCGKE8k51E/Zv0djhaa88IhyaKlAFngjQaeSm
         e/kWOhqQZRlUgU8jNyccRe0zhM5ewDYhXeuA3/rghjF/m/tJXKVk4ki+JeV5CjiiS9VA
         oCQPX+OAnAhgkfwFixwbPD5a80a4MKkAY/Y7vWObxY+ZDd2cpWQ1MAeQKM3cnEqs0Be6
         5K7A==
X-Gm-Message-State: APjAAAU4Sp1UIC3qbQBb3fNf3IQu7d9iZzGQYyMfOXW4sc+cYn7nQukg
        e3TBMDmbowZ10bQIIARed7qnh45WvJWPQOMn//GlJg==
X-Google-Smtp-Source: APXvYqzruswP3R0Mq3OAW4FjQ4c6p5vxJhmQxEUYr4iV1lRvOZC/jR+ohL6MkmyjYSFkl/MqaWKMF5TAbkspmZp/LCQ=
X-Received: by 2002:ac2:5468:: with SMTP id e8mr1652009lfn.113.1579161138240;
 Wed, 15 Jan 2020 23:52:18 -0800 (PST)
MIME-Version: 1.0
References: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org> <dd966dc1-db11-dd64-6b88-13e0dcf45fd7@arm.com>
In-Reply-To: <dd966dc1-db11-dd64-6b88-13e0dcf45fd7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Jan 2020 08:52:06 +0100
Message-ID: <CAKfTPtDTB0EO7_VPcONhtpzi5R=OOxz69dLNEXYKw8f2n70w_w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: remove redundant call to cpufreq_update_util
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 at 21:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 15/01/2020 11:20, Vincent Guittot wrote:
> > With commit bef69dd87828 ("sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()")
> > update_load_avg() has become the central point for calling cpufreq (not
> > including the update of blocked load). This change helps to simplify
> > further the number of call to cpufreq_update_util() and to remove last
> > redundant ones. With update_load_avg(), we are now sure that
> > cpufreq_update_util() will be called after every task attachment to a
> > cfs_rq and especially after propagating this event down to the util_avg of
> > the root cfs_rq, which is the level that is used by cpufreq governors like
> > schedutil to set the frequency of a CPU.
> >
> > The SCHED_CPUFREQ_MIGRATION flag forces an early call to cpufreq when the
> > migration happens in a cgroup whereas util_avg of root cfs_rq is not yet
> > updated and this call is duplicated with the one that happens immediately
> > after when the migration event reaches the root cfs_rq. The dedicated flag
> > SCHED_CPUFREQ_MIGRATION is now useless and can be removed. The interface of
> > attach_entity_load_avg() can also be simplified accordingly.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> LGTM. Doesn't this allow to get rid of the 'int flags' in
> cfs_rq_util_change() as well?

I asked myself the same question but decided to keep the same
interface as cpufreq_update_util

>
> 8<---
>
>  kernel/sched/fair.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 328d59e8afba..f82f4fde0cd3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3110,7 +3110,7 @@ static inline void update_cfs_group(struct sched_entity *se)
>  }
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> -static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> +static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
>  {
>         struct rq *rq = rq_of(cfs_rq);
>
> @@ -3129,7 +3129,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>                  *
>                  * See cpu_util().
>                  */
> -               cpufreq_update_util(rq, flags);
> +               cpufreq_update_util(rq, 0);
>         }
>  }
>
> @@ -3556,7 +3556,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>
>         add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>
> -       cfs_rq_util_change(cfs_rq, 0);
> +       cfs_rq_util_change(cfs_rq);
>
>         trace_pelt_cfs_tp(cfs_rq);
>  }
> @@ -3577,7 +3577,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>
>         add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
>
> -       cfs_rq_util_change(cfs_rq, 0);
> +       cfs_rq_util_change(cfs_rq);
>
>         trace_pelt_cfs_tp(cfs_rq);
>  }
> @@ -3618,7 +3618,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                 update_tg_load_avg(cfs_rq, 0);
>
>         } else if (decayed) {
> -               cfs_rq_util_change(cfs_rq, 0);
> +               cfs_rq_util_change(cfs_rq);
>
>                 if (flags & UPDATE_TG)
>                         update_tg_load_avg(cfs_rq, 0);
> @@ -3851,7 +3851,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
> -       cfs_rq_util_change(cfs_rq, 0);
> +       cfs_rq_util_change(cfs_rq);
>  }
>
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> --
> 2.17.1
