Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13889128A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfECHVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 03:21:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32800 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:21:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so2295553plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cuSlUL65Xiw709t0yCxPP8D9MQj3q7kiVJeq2I3hujg=;
        b=VYeihwAthmmT61RYkOnOcb6q+9n+gbWqi60UQimsI9/9mDBote8mHHNY/Me7oDCN/I
         83elSHOXuEbO+1KhEMiOh8ERvYrYzVBYR5ztvK5PnvQ+bWX1LJbC00lnKNgvp2/3U10u
         M9DFrJ901h+wgC/9KBugvwZrmkZazcrE9J3EVEOxUGSWVtsSfl7mcfm+RHP0g5y2sBYJ
         2ISuxAE3nznT+/7VBdc2PH6s799QU2vTOJoVqu5eCddLyEK1laGnRxiOSNVnEykZTmZn
         1rdN0oydsy/lZ3PtdSDjDgO2k5jKqpjrnRJaODQcBVOYj5qcab7uz+ZVqvewQhoFHfAj
         A6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cuSlUL65Xiw709t0yCxPP8D9MQj3q7kiVJeq2I3hujg=;
        b=KEpFbvbV4Ps+6t1CIjcFdZ95h7KSTcy0V3hBPfS/1VwQXj8H5wlQNPxwWC6nVu1f6y
         eEzvtHVFE+MN7StW21x05ptYgHWhlR+S6myc5a0yCDYlZZxplWeHXulxtISoBPWPaKaJ
         Fv4VONnRpd+Zqlo6uDN//lJ4XYgNH8PX4cDaqUz9lJU2cuWnVq03g4n2oe3nUxwvSVON
         2ka+cz+9HTxfvA+VJAKB4rbfbvaCaIwdLq5uIkuuE4z52AXiVZwEEloZRtlc2Z6Fx6Vd
         pKfPk6EXsbjXtRWuQirWxlOn/scwQ9PeIZrHbaRHYES6381SttZl3J9byi+hlee/bgTL
         KIig==
X-Gm-Message-State: APjAAAU3ieFFkMxYnhVJ27DOsXMlWd/dUbuyR8zDeN1PsCbAdxiSd7IY
        xBX+3pfy3IKpdN29IIqvxJiSpg==
X-Google-Smtp-Source: APXvYqx0sjBi/uQUbVukjr1ZlV+7VB+uA96jSCHmJbR//3T/bGuSLeTjAs7jL9nJZkSTJKuSKtfFdw==
X-Received: by 2002:a17:902:3281:: with SMTP id z1mr8326525plb.44.1556868084055;
        Fri, 03 May 2019 00:21:24 -0700 (PDT)
Received: from localhost ([171.61.121.242])
        by smtp.gmail.com with ESMTPSA id f14sm1602581pgj.24.2019.05.03.00.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 00:21:23 -0700 (PDT)
Date:   Fri, 3 May 2019 12:51:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Actually trace CPU load in
 thermal_power_cpu_get_power
Message-ID: <20190503072120.bm7xtvxc6k4s2kyc@vireshk-i7>
References: <20190502183238.182058-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502183238.182058-1-mka@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-19, 11:32, Matthias Kaehlcke wrote:
> The CPU load values passed to the thermal_power_cpu_get_power
> tracepoint are zero for all CPUs, unless, unless the
> thermal_power_cpu_limit tracepoint is enabled too:
> 
>   irq/41-rockchip-98    [000] ....   290.972410: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x0,0x0,0x0,0x0}} dynamic_power=4815
> 
> vs
> 
>   irq/41-rockchip-96    [000] ....    95.773585: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x56,0x64,0x64,0x5e}} dynamic_power=4959
>   irq/41-rockchip-96    [000] ....    95.773596: thermal_power_cpu_limit:
>   cpus=0000000f freq=408000 cdev_state=10 power=416
> 
> There seems to be no good reason for omitting the CPU load information
> depending on another tracepoint. My guess is that the intention was to
> check whether thermal_power_cpu_get_power is (still) enabled, however
> 'load_cpu != NULL' already indicates that it was at least enabled when
> cpufreq_get_requested_power() was entered, there seems little gain
> from omitting the assignment if the tracepoint was just disabled, so
> just remove the check.
> 
> Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator governor")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..b437804e099b 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -458,7 +458,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
>  			load = 0;
>  
>  		total_load += load;
> -		if (trace_thermal_power_cpu_limit_enabled() && load_cpu)
> +		if (load_cpu)
>  			load_cpu[i] = load;
>  
>  		i++;

@Javi: I find this change to be fine, do you have any comments on this ?

-- 
viresh
