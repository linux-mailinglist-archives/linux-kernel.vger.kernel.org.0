Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B18B0976
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 09:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfILHZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 03:25:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55313 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfILHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 03:25:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so6174494wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pE4ey+kgf0K/yvQf3TkEv9R6at6V7MIRvEU3qtgfEeI=;
        b=S70aVJojoJNzX00lW8gBfknxQBzbYOb3UHASmElA1vV1Aub/AyevwnQxDAFWbRYhig
         biI4R3ZvnZLTkwtinX7FG20OOepqfH2TE2bIlzo2fVKZ46FNMwUt5EY8oRVQjCTQDQO1
         X7OElxMKCBpnmv8ssJJB5nd7bYsq/Kd292VaMA4TN58TQoF2JkajvTjDXjRHFAFck7F/
         NuIjsm9JmfFjd9ZiXtza38oVLzkGD3Bped9r7SkJmSLvWkxfdlsChKfp60H1Kg+Mb/vz
         HLqWbsbgqrOYpxN6RoOnwTOViYGBNdz2cz3krS8ZvMUUEUCTFUFqBX2pbtUFL+fgo3Yl
         r9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pE4ey+kgf0K/yvQf3TkEv9R6at6V7MIRvEU3qtgfEeI=;
        b=TEa62mnEh/+ckgFSfhrzlcchwckL8W/1HbpaVHbubEMvN84vsIPuFxDUaEFjwpkDQ6
         R181aYSdMZJD4aU04zwrLaJZBGVuaTuvX4ZsjBpFqma/cnhHjU3YyIXTz6MdJXuvBeKc
         fdrApTsYV4XMUjoniGnEbboqBB5RH6wyZR2kGugcq5aullfn73HS1k95f1ELuWP/74n4
         pj1E/ZMQ0oiEp/9J4CDYn6a4tJsikU4IL0weLfJX2IG1XAWFVaQZMN+iZ8GTOCvRz6CZ
         7fG3s2pQqhy0DSSP3imjPtnOQNlzXfoi4gaXGtKuITUiNNAGk666BAW4NBghDvBl4jJQ
         rMBw==
X-Gm-Message-State: APjAAAUu0YnGn5xa8lUBJQC7Sos2B0C+Orlx3IKNTtPlto48ukuOyB1A
        yS6Q1ph0DmkY0OOO8ZzdjxjBgA==
X-Google-Smtp-Source: APXvYqzS1MEA5VYDnug0r29ts6c7ea3SXPENbkQVkyYaFvJSZ6gqdTC0RzgFRatbvOfdsF8LES5NPA==
X-Received: by 2002:a1c:60c1:: with SMTP id u184mr6721994wmb.32.1568273096578;
        Thu, 12 Sep 2019 00:24:56 -0700 (PDT)
Received: from igloo (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id r9sm39125167wra.19.2019.09.12.00.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 00:24:55 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Linaro" <jorge.ramirez-ortiz@linaro.org>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Linaro" <JorgeRamirez-Ortiz>
Date:   Thu, 12 Sep 2019 09:24:54 +0200
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        bjorn.andersson@linaro.org, wim@linux-watchdog.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: qcom: support pre-timeout when the bark
 irq is available
Message-ID: <20190912072454.GA11651@igloo>
References: <20190906205411.31666-1-jorge.ramirez-ortiz@linaro.org>
 <20190906205411.31666-2-jorge.ramirez-ortiz@linaro.org>
 <20190910180655.GA25286@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910180655.GA25286@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/19 11:06:55, Guenter Roeck wrote:
> On Fri, Sep 06, 2019 at 10:54:10PM +0200, Jorge Ramirez-Ortiz wrote:
> > Use the bark interrupt as the pre-timeout notifier whenever this
> > interrupt is available.
> > 
> > By default, the pretimeout notification shall occur one second earlier
> > than the timeout.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> 
> Nitpick below, otherwise:
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> > ---
> >  drivers/watchdog/qcom-wdt.c | 70 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 65 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > index 7be7f87be28f..935c78a882a3 100644
> > --- a/drivers/watchdog/qcom-wdt.c
> > +++ b/drivers/watchdog/qcom-wdt.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright (c) 2014, The Linux Foundation. All rights reserved.
> >   */
> > +#include <linux/bits.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -19,6 +21,9 @@ enum wdt_reg {
> >  	WDT_BITE_TIME,
> >  };
> >  
> > +#define QCOM_WDT_ENABLE		BIT(0)
> > +#define QCOM_WDT_ENABLE_IRQ	BIT(1)
> > +
> >  static const u32 reg_offset_data_apcs_tmr[] = {
> >  	[WDT_RST] = 0x38,
> >  	[WDT_EN] = 0x40,
> > @@ -54,15 +59,35 @@ struct qcom_wdt *to_qcom_wdt(struct watchdog_device *wdd)
> >  	return container_of(wdd, struct qcom_wdt, wdd);
> >  }
> >  
> > +static inline int qcom_get_enable(struct watchdog_device *wdd)
> > +{
> > +	int enable = QCOM_WDT_ENABLE;
> > +
> > +	if (wdd->pretimeout)
> > +		enable |= QCOM_WDT_ENABLE_IRQ;
> > +
> > +	return enable;
> > +}
> > +
> > +static irqreturn_t qcom_wdt_isr(int irq, void *arg)
> > +{
> > +	struct watchdog_device *wdd = arg;
> > +
> > +	watchdog_notify_pretimeout(wdd);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int qcom_wdt_start(struct watchdog_device *wdd)
> >  {
> >  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
> > +	unsigned int bark = wdd->timeout - wdd->pretimeout;
> >  
> >  	writel(0, wdt_addr(wdt, WDT_EN));
> >  	writel(1, wdt_addr(wdt, WDT_RST));
> > -	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
> > +	writel(bark * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
> >  	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
> > -	writel(1, wdt_addr(wdt, WDT_EN));
> > +	writel(qcom_get_enable(wdd), wdt_addr(wdt, WDT_EN));
> >  	return 0;
> >  }
> >  
> > @@ -89,6 +114,13 @@ static int qcom_wdt_set_timeout(struct watchdog_device *wdd,
> >  	return qcom_wdt_start(wdd);
> >  }
> >  
> > +static int qcom_wdt_set_pretimeout(struct watchdog_device *wdd,
> > +				   unsigned int timeout)
> > +{
> > +	wdd->pretimeout = timeout;
> > +	return qcom_wdt_start(wdd);
> > +}
> > +
> >  static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
> >  			    void *data)
> >  {
> > @@ -105,7 +137,7 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
> >  	writel(1, wdt_addr(wdt, WDT_RST));
> >  	writel(timeout, wdt_addr(wdt, WDT_BARK_TIME));
> >  	writel(timeout, wdt_addr(wdt, WDT_BITE_TIME));
> > -	writel(1, wdt_addr(wdt, WDT_EN));
> > +	writel(QCOM_WDT_ENABLE, wdt_addr(wdt, WDT_EN));
> >  
> >  	/*
> >  	 * Actually make sure the above sequence hits hardware before sleeping.
> > @@ -121,6 +153,7 @@ static const struct watchdog_ops qcom_wdt_ops = {
> >  	.stop		= qcom_wdt_stop,
> >  	.ping		= qcom_wdt_ping,
> >  	.set_timeout	= qcom_wdt_set_timeout,
> > +	.set_pretimeout	= qcom_wdt_set_pretimeout,
> >  	.restart        = qcom_wdt_restart,
> >  	.owner		= THIS_MODULE,
> >  };
> > @@ -133,6 +166,15 @@ static const struct watchdog_info qcom_wdt_info = {
> >  	.identity	= KBUILD_MODNAME,
> >  };
> >  
> > +static const struct watchdog_info qcom_wdt_pt_info = {
> > +	.options	= WDIOF_KEEPALIVEPING
> > +			| WDIOF_MAGICCLOSE
> > +			| WDIOF_SETTIMEOUT
> > +			| WDIOF_PRETIMEOUT
> > +			| WDIOF_CARDRESET,
> > +	.identity	= KBUILD_MODNAME,
> > +};
> > +
> >  static void qcom_clk_disable_unprepare(void *data)
> >  {
> >  	clk_disable_unprepare(data);
> > @@ -146,7 +188,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
> >  	struct device_node *np = dev->of_node;
> >  	const u32 *regs;
> >  	u32 percpu_offset;
> > -	int ret;
> > +	int irq, ret;
> >  
> >  	regs = of_device_get_match_data(dev);
> >  	if (!regs) {
> > @@ -204,7 +246,25 @@ static int qcom_wdt_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	wdt->wdd.info = &qcom_wdt_info;
> > +	/* check if there is pretimeout support */
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq > 0) {
> > +		ret = devm_request_irq(dev, irq, qcom_wdt_isr,
> > +				       IRQF_TRIGGER_RISING,
> > +				       "wdt_bark", &wdt->wdd);
> > +		if (ret)
> > +			return ret;
> > +
> > +		wdt->wdd.info = &qcom_wdt_pt_info;
> > +		wdt->wdd.pretimeout = 1;
> > +	} else {
> > +		if (irq == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +
> > +		wdt->wdd.info = &qcom_wdt_info;
> > +		wdt->wdd.pretimeout = 0;
> 
> It is not necessary to set pretimeout to 0; the data structure was
> allocated with devm_kzalloc(). The compiler won't know that and
> generate unnecessary code otherwise.

will you need me to send another version or could you pick it up as is?

> 
> > +	}
> > +
> >  	wdt->wdd.ops = &qcom_wdt_ops;
> >  	wdt->wdd.min_timeout = 1;
> >  	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
