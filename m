Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5683104A41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 06:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfKUFaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 00:30:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43341 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfKUFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:30:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so1051907pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4D4X+d65vB46upiDHWg7wE4kF7eD+7kjNy1cehfn2oQ=;
        b=Dbi54ISi74aXHnims2c664T10I9251duW3uNmME/xUGikSdVwFN/kJO9t75CZczLn/
         80PrUc1q/Fb/svH2iL+Jiw8RaNlYxgbj/zrNAOGN7tFrUHS3/DN7Ft7Ay6gNk4g4Xwrv
         rhWQahqO73uWtaerIzF0eFXGWcBgroFFE/lxTeAGJefrenneJKaROgQTFuWaG0xseUY0
         XUflwQN5Y+2w1PTEmoxeUVGA55FDBOILKb16/mohbEuG+A6j4mf3bGUGt9CmmhDAzoMz
         6TPv6OkZsQS7InXknusyVr6YQMB8E17dMXjqv7hSMNSNYNqRJjtSuovTHUUl9rMHyUdC
         n1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4D4X+d65vB46upiDHWg7wE4kF7eD+7kjNy1cehfn2oQ=;
        b=F5Dzhlgx19UOhdtBv+s/rSpZSpRRojYpgUWvIYMNjMkZj1PF6/PeoqG5YKbP5XCPzk
         cBSiXa8WYS7PPlHm5UZEULv8704tRhdN6XloJhxy0ECNjq3xN5t3baYxNO7+oxRq2bt4
         /bznZC3kn7JN+O46XwYdsoFmmgcmd09KLRyfpdbRLeamfexTX7QES8ofpyjgk2RI7Ycn
         /DQg+y7UqNGRcuR/3EoCcfIP9ObYLZDs3qMpt2xzqPNq02MY7bewtSrKXTNoATKmo5rf
         tS55xXebrv+fiYlMOR4mXKTBw6AEYhvKNS4tFbxBJUGs6rDfQWQ8WZIpOZ3k4YVEcePY
         o3RA==
X-Gm-Message-State: APjAAAVKm+J73iWHiAuI/XWYi9qjKLlsTcGG4y+8XHQMiSv1vobhMThV
        q9igGGuDjxAjMSgCRCipFjooiw==
X-Google-Smtp-Source: APXvYqyqTn5XWsO1zfG9ZOJXWRgzwqe/HV9l7wVKSf9rtf+6rI+k7zCzilzgiWRkEhSvL0fgS3rNmQ==
X-Received: by 2002:aa7:9314:: with SMTP id 20mr8314051pfj.231.1574314221707;
        Wed, 20 Nov 2019 21:30:21 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id p3sm1318953pfb.163.2019.11.20.21.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 21:30:20 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:00:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix Kconfig indentation
Message-ID: <20191121053014.tcnw63yz7w3koj7x@vireshk-i7>
References: <20191120134232.15900-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120134232.15900-1-krzk@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-19, 21:42, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/cpufreq/Kconfig.x86 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index dfa6457deaf6..6eec6ccb14cb 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -9,12 +9,12 @@ config X86_INTEL_PSTATE
>         select ACPI_PROCESSOR if ACPI
>         select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
>         help
> -          This driver provides a P state for Intel core processors.
> +	  This driver provides a P state for Intel core processors.
>  	  The driver implements an internal governor and will become
> -          the scaling driver and governor for Sandy bridge processors.
> +	  the scaling driver and governor for Sandy bridge processors.
>  
>  	  When this driver is enabled it will become the preferred
> -          scaling driver for Sandy bridge processors.
> +	  scaling driver for Sandy bridge processors.
>  
>  	  If in doubt, say N.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
