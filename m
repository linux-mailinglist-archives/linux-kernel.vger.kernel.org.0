Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5C18D275
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCTPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:11:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40217 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCTPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:11:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id 19so6764827ljj.7;
        Fri, 20 Mar 2020 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uhFGy5vD5fOErExrsoJO9yiwiyB9HUKnXCIyG1RqDs8=;
        b=ppCJxqLJhb5yLDjQraYLfoDnvFU2b6tFbN0snn7kAH4s9Ux8hMBjRimDit8ij4a0+J
         XjXO4l3b32XlKel6ZNVZuDrUoAJxnXq98YS8P+eNKRhbq8LKmL+LztOJNUK4QQ+zAwpZ
         OzOiRNJrpiib29FEuhjwH4VeXkr5btAEiqzOv8lWcAT/ej7IRWffUOYWCY8HxRMfnUco
         u01h9+0E7NDI4RY4U82An2ENbe1fhjnmbir/oK2iuPP4mlPEgozxVyrEpgSCB68x8Pjv
         9Uowktf/Vqe1yHD4t5Md/PFTmFYieuQdMDoE3EIBpPkUM8A7i+kg680pzRnpuJfTmrRM
         wk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhFGy5vD5fOErExrsoJO9yiwiyB9HUKnXCIyG1RqDs8=;
        b=R/0fGTozfVFVma0kQKcUdkW6nT+4/AWHfXuup/u4H2yHIYLIKBgQZcrNcCCDLM/AfG
         sIzLSwmgLxVRFXWEFVxeqH7FwHJUkxG1RlwLeHbmyys4XeRwqTtCC79KDwRyl+I0xFyh
         sf2jA7yc1dreHyUcEDddgm3tRySKy/G1ODEWJ1VDqqKU8JMkF9Wre6M/3UfJmiBsLd4M
         74A/XwIdoZwMrIa4Fjk/rUpVuomfE5Z/FMUr2CFAZeOgmRsHPKZrxagWf5i1sQccRqzJ
         JU6wcpexrRP0uC4JAPC0FhU3tCEvVJ9ycpxaar/l6A9JOaHOMOpyOAtrrlVbVhEw7TJd
         S3jg==
X-Gm-Message-State: ANhLgQ3YMwenVaQbohY3PzHB0D232db/ciH1nV9e0NBdTB29ni5A6zMS
        ZBFkUcqLLRgjO6H6wdGls+qYIkTi
X-Google-Smtp-Source: ADFU+vvt/lfrBid0UlknHY23uJupdxcC74xtAPrDSi/+bdM3/BI8wjyaitPi4Hc6B9Eq9jYfAZo6vg==
X-Received: by 2002:a2e:9a52:: with SMTP id k18mr5211493ljj.242.1584717066306;
        Fri, 20 Mar 2020 08:11:06 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id 64sm3470082ljj.41.2020.03.20.08.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 08:11:05 -0700 (PDT)
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <48b2099c-dd83-d4dc-aab4-8c6f68a215cf@gmail.com>
Date:   Fri, 20 Mar 2020 18:11:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320133452.3705040-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.03.2020 16:34, Thierry Reding пишет:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently this only supports a single watchdog, which uses a timer in
> the background for countdown. Eventually the timers could be used for
> various time-keeping tasks, but by default the architected timer will
> already provide that functionality.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

...
> +config TEGRA186_TIMER
> +	bool "NVIDIA Tegra186 timer driver"

tristate?

> +	depends on ARCH_TEGRA || COMPILE_TEST

depends on WATCHDOG && WATCHDOG_CORE?

> +	select TIMER_OF
> +	help
> +	  Enables support for the timers and watchdogs found on NVIDIA
> +	  Tegra186 and later SoCs.
