Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C591465A32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfGKPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 11:15:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45961 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfGKPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:15:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so2891233pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSAfzihkBVubvwbGX9ZrlE6NTtzUO3EOukswRzxGahk=;
        b=VFbVfXvYNAmrk8fEvvRWt5qmnjJGk0vBhLfcOJ5/cL7y3yFfU4LztkHnr7wHWcZ/Jv
         VSNlf6h+TrpDM0KLVXdxI1373NscxYlyHtnQd7wW0W8Y3rbtGCo3w8guIQdXVhdB8Ts1
         JOzHxHgsiXG6VcEN4oQkiWDLb7QnlGTmPBCzY8cMs0mfQzu3qwPhM2eM/GU9d7r/6AKl
         yAMETZcXypWr0loYBlDTq4K336w8Y6ELlf8B38wdd3glvHhnUBX7LfJaB1tUosr0s+i8
         GXzOju3i50puudzMmvEq/oGHcU3QBG4TSThxvls3piC9D/nG6E8V4iZmWXkb34ToNURI
         2TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSAfzihkBVubvwbGX9ZrlE6NTtzUO3EOukswRzxGahk=;
        b=Fmhq4wub18cKBDLsUSL+Fitm2bTDbH+uvs499qthRhkDhj3sxfPkg2YMLTig5rvViU
         4MkuKdljBBWElMn7bPZ4cpe0IWx1bjNkOs9cEgho4PMDhRLp+mO7XZLP4wkwSut9uzie
         sJYg9WyuZktqN08yKYVgESXC5wPxGp7o8/0NQnEnuCaU5DEObjd2PDk94edvqqhGfOBa
         qEOIbskLGrZmJIMnpZ+4EFdvvKCRcz0nduANI6OhzJXWe0rwCmc2z+ps1ShUS/GY0+XW
         A4LV76IFxJ792gFm/gkkQBq3poAPXzVZZ0Qz7LG+wN6MAcNTSu7JaH6+FySQ/H2Nk49d
         czHg==
X-Gm-Message-State: APjAAAX2+uDhPOl6dW15iUqciAzQ24ZIDTHj0DIu+Vvse0mWIzzdGTk/
        epI5UVh5ukpZ3NHeVHH5tvzovg==
X-Google-Smtp-Source: APXvYqzmMtkuBfKjFvauyK+dpeSUQ1cBgUt9Vc22gTwPWrIDaxvy+lhE4EouscliQ8F41wdlpdEGrQ==
X-Received: by 2002:a17:90a:7d04:: with SMTP id g4mr5476744pjl.41.1562858122182;
        Thu, 11 Jul 2019 08:15:22 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 64sm6083195pfe.128.2019.07.11.08.15.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:15:21 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:16:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v3 08/14] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Message-ID: <20190711151631.GI7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-9-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-9-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
> to keep the software model of the clock in line with reality, the
> framework transverses the clock tree and disables those clocks that
> were enabled by the firmware but have not been enabled by any device
> driver.
> 
> If CPUFREQ is enabled, early during the system boot, it might attempt
> to change the CPU frequency ("set_rate"). If the HFPLL is selected as
> a provider, it will then change the rate for this clock.
> 
> As boot continues, clk_disable_unused_subtree will run. Since it wont
> find a valid counter (enable_count) for a clock that is actually
> enabled it will attempt to disable it which will cause the CPU to
> stop.

But if CPUfreq has acquired the CPU clock and the hfpll is the currently
selected input, why does the clock framework not know about this clock
being used?

> Notice that in this driver, calls to check whether the clock is
> enabled are routed via the is_enabled callback which queries the
> hardware.
> 
> The following commit, rather than marking the clock critical and
> forcing the clock to be always enabled, addresses the above scenario
> making sure the clock is not disabled but it continues to rely on the
> firmware to enable the clock.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>


I can see that we have a real issue in the case where CPUfreq is not
enabled and hence there are no clients, according to Linux. And that I
don't know another way to guard against.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/hfpll.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index 0ffed0d41c50..d5fd27938e7b 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -58,6 +58,13 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  		.parent_names = (const char *[]){ "xo" },
>  		.num_parents = 1,
>  		.ops = &clk_ops_hfpll,
> +		/*
> +		 * rather than marking the clock critical and forcing the clock
> +		 * to be always enabled, we make sure that the clock is not
> +		 * disabled: the firmware remains responsible of enabling this
> +		 * clock (for more info check the commit log)
> +		 */
> +		.flags = CLK_IGNORE_UNUSED,
>  	};
>  
>  	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
> -- 
> 2.21.0
> 
