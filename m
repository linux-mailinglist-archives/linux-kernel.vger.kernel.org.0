Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E911899E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCRKuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:50:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43039 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgCRKuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:50:07 -0400
Received: by mail-ua1-f68.google.com with SMTP id q24so4371505ual.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2D4VLK9woLJ/gRcaJ6QDKOFST4uIYnbsZHB1rL9ChCY=;
        b=E/81nzIaUVYCJup+L1XxtlH+uLrj5iQRaFlQy6E3/dBY1t0t/VHJ19Ra7Ctr9+BIij
         u5JMkHAIFTm4LLZLQn83ylFk7deTVvUEuA6qsm5ONebElFZ4eyIy6Gs6SyFcMoLxv610
         +hYMznHbyTSSQRewpj4Y0WU2/NLOj5bL9W4DNPoUE+HWpwqRKoAQ0LVIiOurdIvwCeir
         I6r7I3+kyGr/uMDlEMTEjVMPe8siLyvlsr1+W7qRifM1Lh5Q1TFtfL9PO1/QH6HTI6Il
         qEdo2FKC6Ooj0fpoNNvvnVUe0tjH6G/KTjOzOUI+OtkyKqyoxr96e10T/dv73EnvwXiJ
         7B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2D4VLK9woLJ/gRcaJ6QDKOFST4uIYnbsZHB1rL9ChCY=;
        b=f/h+S0O4LaeQesOM2SW9i3vhKTgS5/afELU3FyRvFoA2AcrN9IwP2YxUPxg0ZYSLSG
         4qkwuq6sJO8HNWhY1cLFBfyvedaIeNkFCJ0PMQXZS15aRMpt/RiHyTga0gx8zkUHoHKd
         kxkORKBbTg7Zr27+Ly6OltE1J8fLwFGpRVpfXRpfvVzo9DBcFVZxgIZQ8lPhs8AvV8ql
         zCAWGxZrb0J5b3fkiF88GPuNR2k4Sp0OXRrpihXe2j/mLz8P7UFsZS83P06ORlL5KQEj
         p55DF3D6O6IaY71cu8etBMkJZ7mGaSRT3qu8chy0QkmTBUq2KvHO9cprc0kiNbznCd7n
         qgHA==
X-Gm-Message-State: ANhLgQ0weG0hL6Hpd9i+KQkrGiwxQz0XCUAb7I0rXNE1DW70Q7Tew+/S
        IE2Ku06eNUcts9Pv+KlVcMvmDoUQb67sf/cNkDwRQyA2KlI=
X-Google-Smtp-Source: ADFU+vsbDhVCAtRkn3Xf8fAqKu/Khqon8tFNS8ablxsWi2YqF0MPMO75AJqn7DKJj92EjYVN42De0gpZnRkR/bwLmhw=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr2268852uas.19.1584528606336;
 Wed, 18 Mar 2020 03:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200316210843.11678-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200316210843.11678-1-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Mar 2020 11:49:30 +0100
Message-ID: <CAPDyKFraE=JYehuLUER+tL=fyPbUwZDvu2PB4ebnYk5f6atWeA@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuidle: consolidate calls to time capture
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 at 22:10, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> A few years ago, we changed the code in cpuidle to replace ktime_get()
> by a local_clock() to get rid of potential seq lock in the path and an
> extra latency.
>
> Meanwhile, the code evolved and we are getting the time in some other
> places like the power domain governor and in the future break even
> deadline proposal.
>
> Unfortunately, as the time must be compared across the CPU, we have no
> other option than using the ktime_get() again. Hopefully, we can
> factor out all the calls to local_clock() and ktime_get() into a
> single one when the CPU is entering idle as the value will be reuse in
> different places.
>
> We can assume the time to go through the code path distance is small
> enough between ktime_get() call in the cpuidle_enter() function and
> the other users inspecting the value.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/power/domain_governor.c | 4 +++-
>  drivers/cpuidle/cpuidle.c            | 6 +++---
>  include/linux/cpuidle.h              | 1 +
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index daa8c7689f7e..bee97f7b7b8d 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -279,8 +279,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>                 }
>         }
>
> +       dev = per_cpu(cpuidle_devices, smp_processor_id());
> +
>         /* The minimum idle duration is from now - until the next wakeup. */
> -       idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
> +       idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, dev->idle_start));
>         if (idle_duration_ns <= 0)
>                 return false;
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c149d9e20dfd..9db14581759b 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -206,7 +206,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>
>         struct cpuidle_state *target_state = &drv->states[index];
>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
> -       ktime_t time_start, time_end;
> +       ktime_t time_end;
>
>         /*
>          * Tell the time framework to switch to a broadcast timer because our
> @@ -228,14 +228,14 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         sched_idle_set_state(target_state);
>
>         trace_cpu_idle_rcuidle(index, dev->cpu);
> -       time_start = ns_to_ktime(local_clock());
> +       dev->idle_start = ktime_get();

I fully agree with Rafael, this is bad for all cases where the
local_clock is sufficient.

To avoid the ktime_get() in the cpu_power_down_ok() for the genpd
governor, I think a better option could be to use the
"ts->idle_entrytime", that has been set in tick_nohz_start_idle().

>
>         stop_critical_timings();
>         entered_state = target_state->enter(dev, drv, index);
>         start_critical_timings();
>
>         sched_clock_idle_wakeup_event();
> -       time_end = ns_to_ktime(local_clock());
> +       time_end = ktime_get();
>         trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>
>         /* The cpu is no longer idle or about to enter idle. */
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index ec2ef63771f0..112494658e01 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -89,6 +89,7 @@ struct cpuidle_device {
>         unsigned int            poll_time_limit:1;
>         unsigned int            cpu;
>         ktime_t                 next_hrtimer;
> +       ktime_t                 idle_start;
>
>         int                     last_state_idx;
>         u64                     last_residency_ns;
> --
> 2.17.1
>

Kind regards
Uffe
