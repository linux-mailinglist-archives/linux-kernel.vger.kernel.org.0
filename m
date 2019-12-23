Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B301129135
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 04:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWDtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 22:49:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35390 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfLWDtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:49:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id k16so15751885otb.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 19:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kiCXGPZXgpSzjSeZbiC9HBf0MuW0dLWXna1FagE79Cs=;
        b=Xb+5oODyqounFHjcwkIAuNFUiCFv1rl+CTda+SmFFuTzFfoKD4AjOVb6F/IS3r7I5z
         fFJnjKtOtb9wfoAtEt/VrNoWCVFt/n8jEnVLZosnu8LrjK0twQVukap/p5pi79b2MikR
         CsSEyol1C22q4TCdEC/peFVNycqKSJdAB8+PlFtsRgC/WPH+qFaqlyJ0IScjj9y56EJK
         I6TgQ6fuEttxroI1fxSZHfSDWIM+IRw6z5OnjRTAqIQfIO+bc1QC3XkG9Rk8Gre/UM3n
         GCZcWryXr+fAOxbKjAOoRYRWIDd3KvNnxfdFC3/xLWu1HprXwVaMfloYtUpVlwxeXbrz
         Tgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kiCXGPZXgpSzjSeZbiC9HBf0MuW0dLWXna1FagE79Cs=;
        b=gyD9iYHQvdTctigeSC8xEIJar1hthz9QJvKg7LzUkqFN84tkSGVc1dY+OX+N6cxdHf
         qFijQiwew48fVVLDGNzHd2hbenSOgvTB61Z29Qwtt0a09tAxMnJQlAIRNuAZdyzyX53F
         k7Oq9Lfag/VAyzUIpYn6maGK7Cm+hAgezCCKxZS5X+9K58+YNwovIoKiMZN4iVA95ZLr
         /Uy8TFuMGPBeqjCY7PmEyoTbN9pkZmegdD6umg0PVvgk4vdDSd002r0K9KiqTMC2qVyq
         3ZZjjJJ2+y6vZIwqfSh1E3JJQfz5c+ioVatrQf3Ku2LGdcPzWrOVSB5OFnFkvbBg6Q9n
         R0jA==
X-Gm-Message-State: APjAAAUb2w56vQ+bzMs/crr00LMBee0V3Fbzem9edocH2WuXnIfxR6EP
        tRXa9JMAkN7N0jjKQFWyo2cjtA==
X-Google-Smtp-Source: APXvYqyI3S+x9p8y1eSummxbvtYmeZzED7tGwrAqjo7rZ5bX4P1K4t1oD00WlnokkGJnRYHEUHtHeA==
X-Received: by 2002:a9d:32a2:: with SMTP id u31mr28643418otb.249.1577072942928;
        Sun, 22 Dec 2019 19:49:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id c7sm6793376otm.63.2019.12.22.19.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 19:49:02 -0800 (PST)
Date:   Mon, 23 Dec 2019 11:48:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Message-ID: <20191223034852.GB3981@leoy-ThinkPad-X240s>
References: <20191220110525.30131-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220110525.30131-1-james.clark@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Dec 20, 2019 at 11:05:25AM +0000, James Clark wrote:
> This patch fixes an issue when non Arm SPE events are specified after an
> Arm SPE event. In that case, perf will exit with an error code and not
> produce a record file. This is because a loop index is used to store the
> location of the relevant Arm SPE PMU, but if non SPE PMUs follow, that
> index will be overwritten. Fix this issue by saving the PMU into a
> variable instead of using the index, and also add an error message.
> 
> Before the fix:
>     ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>     237
> 
> After the fix:
>     ./perf record -e arm_spe/ts_enable=1/ -e branch-misses ls; echo $?
>     ...
>     0

Just bring up a question related with PMU event registration.  Let's
see the DT binding in arch/arm64/boot/dts/arm/fvp-base-revc.dts:

         spe-pmu {
                 compatible = "arm,statistical-profiling-extension-v1";
                 interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
         };


Now SPE registers PMU event for every CPU; seem to me, though SPE is an
IP binding per CPU, it should register into perf framework with single
pmu event, ARM's PMU/ETM/IntelPT all use this way to regsiter PMU event;
this can allow perf tool logic to be more neat.

After the driver changes to use single PMU registration, the perf tool
code can be changed to use simple way to find perf_pmu and this data
structure can be not bound to a specific CPU.  Finally, this bug can
be smoothly dismissed.

Thanks,
Leo

> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Igor Lubashev <ilubashe@akamai.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c  | 10 +++++-----
>  tools/perf/arch/arm64/util/arm-spe.c |  1 +
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 0a6e75b8777a..230f03b622e1 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -54,9 +54,9 @@ struct auxtrace_record
>  *auxtrace_record__init(struct evlist *evlist, int *err)
>  {
>  	struct perf_pmu	*cs_etm_pmu;
> +	struct perf_pmu *arm_spe_pmu = NULL;
>  	struct evsel *evsel;
>  	bool found_etm = false;
> -	bool found_spe = false;
>  	static struct perf_pmu **arm_spe_pmus = NULL;
>  	static int nr_spes = 0;
>  	int i = 0;
> @@ -79,13 +79,13 @@ struct auxtrace_record
>  
>  		for (i = 0; i < nr_spes; i++) {
>  			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> -				found_spe = true;
> +				arm_spe_pmu = arm_spe_pmus[i];
>  				break;
>  			}
>  		}
>  	}
>  
> -	if (found_etm && found_spe) {
> +	if (found_etm && arm_spe_pmu) {
>  		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
>  		*err = -EOPNOTSUPP;
>  		return NULL;
> @@ -95,8 +95,8 @@ struct auxtrace_record
>  		return cs_etm_record_init(err);
>  
>  #if defined(__aarch64__)
> -	if (found_spe)
> -		return arm_spe_recording_init(err, arm_spe_pmus[i]);
> +	if (arm_spe_pmu)
> +		return arm_spe_recording_init(err, arm_spe_pmu);
>  #endif
>  
>  	/*
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index eba6541ec0f1..b7d17d8724df 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -178,6 +178,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
>  	struct arm_spe_recording *sper;
>  
>  	if (!arm_spe_pmu) {
> +		pr_err("Attempted to initialise null SPE PMU\n");
>  		*err = -ENODEV;
>  		return NULL;
>  	}
> -- 
> 2.24.0
> 
