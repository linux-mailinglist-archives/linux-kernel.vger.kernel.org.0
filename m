Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD53102249
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 11:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKSKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 05:51:12 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44865 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:51:12 -0500
Received: by mail-vs1-f66.google.com with SMTP id j85so13859613vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xtsF1Sv+l+9zrpE4z0KioV1mHpXZsbvecSOZbkb/Q8=;
        b=hq9IXkC5JKzFG1aE2B51COqqquq5bFvThTVH4Gj/fldrzI5Ih6wXfn8pRZtOIvDcHK
         TRmglLfHOF89Yqcd16P05oO2z3Mdqk5uq7Qg11ljMwZjl2b/RmJjIfD2jaeAl1sooMRx
         lbHE39wwvW4fQxrzcA5mvM2tv3VmDvWqxYWp45B+g0+B5lfPIau2Mo5JUKISVZ2RLRpH
         VPMcP9Y19RjKPtx8vC2M2dxJQsNerXAKWZPfhnekCyVD3gS+RXpmqV07yAKmRnyjOqio
         w71saYZE26s3KxvG8TI3xUBpK4mVz11A2rzF2ADEr8SOYxKEpurX27BOx+LXK3yWHKqb
         CwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xtsF1Sv+l+9zrpE4z0KioV1mHpXZsbvecSOZbkb/Q8=;
        b=YjNRoHVN7uLlEDU+cU7CCMm/8Aq21xQJqbnakaEht4vl4EI2hE2DNJxkbYTB+J+GR3
         eY9XOmhaD0YNDPvtqmRxrlwrzDiHU9ft/w7biG87uihIEH0XoDNb6c3u0vgRoMthRdcM
         XtLtmMl4YvE3syesTRZg2aXZlTvQTA2Yi8YNmE7iUZOqcmweREwpKEaVUPdPNT25Xtd4
         KWtujx+V784SFMMXP1Rj9OsPoW+oioi9rwX08KSQKy31TqsIAfYPyfqL4PYA/Db97EJw
         NqUqHW56VlrFJDmYhatLp3sdZM3rrcJiM4A/LREw+b+ayFhhyrtxU8VtBFOaCOPs4cBH
         CX8A==
X-Gm-Message-State: APjAAAXuWusJWTjsYAdqF+E2JxCLZ86sN0g5utKrky9c6/4PZ1WhRyCV
        uhk0zN0nl7IJw3k6XRDWn87svAfUEAZrrlxdF3WbsHYs
X-Google-Smtp-Source: APXvYqwPaPOP/tvcGP9mQYoUq0M6Kxu+nl2EbUWFxWA6q3Mapgn1ahClizb5eOnSjYBRzGlia1hHLCKzm9KhCHqtPYA=
X-Received: by 2002:a67:da85:: with SMTP id w5mr22162061vsj.159.1574160669891;
 Tue, 19 Nov 2019 02:51:09 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org> <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 19 Nov 2019 16:20:58 +0530
Message-ID: <CAHLCerP6AyB1QZrUdL9XU6PcTjQWgRuQdRvPamtWjBNJNhL=HA@mail.gmail.com>
Subject: Re: [Patch v5 1/6] sched/pelt.c: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, qperret@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:20 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Extrapolating on the exisiting framework to track rt/dl utilization using
> pelt signals, add a similar mechanism to track thermal pressure. The
> difference here from rt/dl utilization tracking is that, instead of
> tracking time spent by a cpu running a rt/dl task through util_avg,
> the average thermal pressure is tracked through load_avg. This is
> because thermal pressure signal is weighted "delta" capacity
> and is not binary(util_avg is binary). "delta capacity" here
> means delta between the actual capacity of a cpu and the decreased
> capacity a cpu due to a thermal event.

Use a blank line here. And reflow the paragraph text.

> In order to track average thermal pressure, a new sched_avg variable
> avg_thermal is introduced. Function update_thermal_load_avg can be called
> to do the periodic bookeeping (accumulate, decay and average)
> of the thermal pressure.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/pelt.c  | 13 +++++++++++++
>  kernel/sched/pelt.h  |  7 +++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 21 insertions(+)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..3821069 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>         return 0;
>  }
>
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       if (___update_load_sum(now, &rq->avg_thermal,
> +                              capacity,
> +                              capacity,
> +                              capacity)) {
> +               ___update_load_avg(&rq->avg_thermal, 1, 1);
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  /*
>   * irq:
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index afff644..c74226d 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>  int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
>
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  int update_irq_load_avg(struct rq *rq, u64 running);
> @@ -159,6 +160,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  }
>
>  static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       return 0;
> +}
> +
> +static inline int
>  update_irq_load_avg(struct rq *rq, u64 running)
>  {
>         return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0db2c1b..d5d82c8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -944,6 +944,7 @@ struct rq {
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         struct sched_avg        avg_irq;
>  #endif
> +       struct sched_avg        avg_thermal;

Have your considered putting this inside a #ifdef
CONFIG_HAVE_SCHED_THERMAL_PRESSURE?


>         u64                     idle_stamp;
>         u64                     avg_idle;
>
> --
> 2.1.4
>
