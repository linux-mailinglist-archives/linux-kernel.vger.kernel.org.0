Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F381F56268
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFZGhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 02:37:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41355 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:37:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id y72so703397pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ulju9cyok8EhZLzJkm6HOPS5fcX/Htl+DZbhZzeBbcU=;
        b=a6+5sIZiD0nVb1R7BQJaxqjmWS0X7+NIktIS03BwIaF/s/fDV9gypnLfcx8wAwLRwD
         pWOFYQFmV+9zlv7IXWCNsD3db6hnvyca2vxexElpbGek3puYnEdTOqguDs6z2/Xt5woO
         0KF4FkqztPAfqq8FqkN/b3FjR4u3zvHKGJbVsEHIHqAws5jWLYCJJXLrQVvwDDptdPUF
         Q+/YUy2HmDIIach3VxRudAqY80ynW4/O3cHyQKvihNuPbtJIhyoBL4N8F9hRTSCIz/jV
         u8IPd6qxqEZPml0Neor4IYja9bdmEdB9zJMkk0npnxfYlEW9Qvq0h3Q6Tls1we3/Zir2
         St6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ulju9cyok8EhZLzJkm6HOPS5fcX/Htl+DZbhZzeBbcU=;
        b=bPTF70heexZRofctupKGOGeb6nddPSwkVpCl3HPWwYOutjqBeIipeOAmrJ/bED96M0
         LYLVnbdJm5FzfOfhxdeO+YwGND3bnbsJeMKctAp1szPoa+fHJpPrdSa69QshcPX8cnxb
         WXVpT1rFWTjSCDWQX076pA5nCDyGDdeUfyHB9/r2j1sYNkq0vLkIxYO2EK2kWs70ojNh
         bFJadRBLTU29om2F9K123BoZ8kzQBpCcyEZjYwYCGSNR6EQAPT15ZQCYH0JpHS4Cwh8m
         mY3QsdwpE10rcba2oxYv7/4OrgVku0m/Mq5RQKaYs0hl121GBSrG5NUl6W6qpCRFM9vg
         npYg==
X-Gm-Message-State: APjAAAVyeFfdAzgZ7gIXmzSTx4nwqApO4DdQV0LfU93mGbmJ4BVDA2Yx
        PVo1oy9tGSyC3gLnP+nP2LvFxA==
X-Google-Smtp-Source: APXvYqx7TTUQo7RU0eIOLKo3zgmmKH3tUXAM08KcSIuTB/xlfkZkplQmU+BRYnzQc+wOuFKRXmJnSw==
X-Received: by 2002:a65:510c:: with SMTP id f12mr1298010pgq.92.1561531039015;
        Tue, 25 Jun 2019 23:37:19 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id a21sm10252143pgd.45.2019.06.25.23.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 23:37:18 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:07:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH V3 2/3] thermal/drivers/cpu_cooling: Unregister with the
 policy
Message-ID: <20190626063716.cechnzsb75q5lclr@vireshk-i7>
References: <20190625113244.18146-1-daniel.lezcano@linaro.org>
 <20190625113244.18146-2-daniel.lezcano@linaro.org>
 <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
 <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-19, 08:02, Daniel Lezcano wrote:
> On 26/06/2019 04:58, Viresh Kumar wrote:
> > On 25-06-19, 13:32, Daniel Lezcano wrote:
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index aee024e42618..f07454249fbc 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1379,8 +1379,8 @@ static int cpufreq_online(unsigned int cpu)
> >>  		cpufreq_driver->ready(policy);
> >>  
> >>  	if (cpufreq_thermal_control_enabled(cpufreq_driver))
> >> -		policy->cdev = of_cpufreq_cooling_register(policy);
> >> -
> >> +		of_cpufreq_cooling_register(policy);
> >> +	
> > 
> > We don't need any error checking here anymore ?
> 
> There was no error checking initially. This comment and the others below
> are for an additional patch IMO, not a change in this one.

right, but ...

> >> -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> >> +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
> >>  {
> >>  	struct cpufreq_cooling_device *cpufreq_cdev;
> >>  	bool last;
> >>  
> >> -	if (!cdev)
> >> -		return;

we used to return without any errors from here. Now we will have
problems if regsitering fails for some reason.

-- 
viresh
