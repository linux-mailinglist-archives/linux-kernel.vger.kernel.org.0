Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1E64437
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 11:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfGJJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 05:15:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42989 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfGJJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:15:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so907430plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rs5UUXtAqT5R1zFPxyCMoObdvjFrpKQLMGjYPWWR+M4=;
        b=xuDFEEprPQrx+CqmzvYG12VzfgLPfkFe3i9dDO9PYcL0P6GlYTHeg9CvVU75INDcfo
         /B1HQzUaYBWgrSQr4QqLDllN0ySewu+Aucrj6f3rYqEBvPfKYmVNRP1VtkFAgR4Dnnwy
         wYK2HDv8BW4cYA9i/YOEeHB71zoM56WjB5FZ3hXxzmZPy9bJzNvQoO/LSjPqNJY6AuEs
         HWjsDnM8bx+F1bAhlBhUe+v3UezS0KGgbT9g5qtl1N77SC8yRCWJCMX7840BuAklPao/
         IpNwuqYKXD16xdMURhUJ5FuGtedK5vsNiT/iKtpo1WWCo82zqV15hKbbCfwOv35Xraho
         ACWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rs5UUXtAqT5R1zFPxyCMoObdvjFrpKQLMGjYPWWR+M4=;
        b=sNb8Gvj7Mt9N+G0xHju4lKC/ai47/S3K2JXRQZ+poNJrmdwQy+9XH2Ap71fHHRuXvB
         yYIbwIeCH01OcsmiWOUt/og5pjKmjTxXXGXVC8jAoddNo0XSNPpwjITQB/7SkyVApVpK
         L4aAVq7EeR37G8TJ0WUvrUQUFEHDRlIJosCb0Dm3pqVYWk/0PkO+4RuqkRW6YkTL9O/b
         4/ZywvQSLlxESyfr3PMw9plY89hGopHshzPg7bTwhdyW8jnrUHgBg5OxVOYqTve0cB9V
         93TRl2bzg1fiQA+mKnCW5mANpDdlx8iA0KX8ARfWSc6u9wUOqRHNh5edpazbSTXIOxja
         wNLw==
X-Gm-Message-State: APjAAAUh+KqDxpsCVFAnkp5PehyCa5bLMDQz0VkYNQkqP57MO8LYcdUr
        fNCYCEtCb3K+L9AYyWzbs7uU4w==
X-Google-Smtp-Source: APXvYqzWzbSazZ8noBpanqTTfe68a2rHVdItZzY1mNR00meLwg0PgqjSVl0my2iNIShhy2iItWQJMw==
X-Received: by 2002:a17:902:b43:: with SMTP id 61mr38449888plq.322.1562750145655;
        Wed, 10 Jul 2019 02:15:45 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id z20sm3555377pfk.72.2019.07.10.02.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 02:15:45 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:45:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND, PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU
 scaling driver
Message-ID: <20190710091543.yqcthfgzmxvku5ws@vireshk-i7>
References: <20190612162816.31713-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612162816.31713-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-19, 12:28, Yangtao Li wrote:
> Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.
> 
> Yangtao Li (2):
>   cpufreq: Add sun50i nvmem based CPU scaling driver
>   dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
> 
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/cpufreq/Kconfig.arm                   |  12 +
>  drivers/cpufreq/Makefile                      |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
>  6 files changed, 415 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
>  create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c
> 
> ---
> v4:
> -Remove sunxi_cpufreq_soc_data structure for now.
> -Convert to less generic name.
> -Update soc_bin xlate.

Applied. Thanks.

I will push it only after 5.3-rc1 is released.

-- 
viresh
