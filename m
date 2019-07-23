Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CF71CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfGWQTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 12:19:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40677 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGWQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:19:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so19382797pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5cCrOYr2TnsV7hg1z4ufQ0QBSkAleXOLlrvwjgt7a8c=;
        b=HjeaCWMLzBkFGJqQXljhwWJsnBNJDOLusXlLORvuiIX/zx47EgSI3ZrqqVgboAZcu8
         7iWFwjZ5BjM7HIHuANs0ekokz4x8ZTpITs2xKvANVd3ZdXsURbsbuDegN/qvnNVqrN50
         V+yZCblOlSH2jvDDHbD2+ADTwZQdrdaxF6WjYfhb9O3diIcqypig3RXF8mycJaRu+YFn
         OxQbHaICJMlMnqii2Z3EnbN0tuk2udnq7NAWXa6V9vZn/BX+P4a5uj7nY2OAJ/kTwhuJ
         me2N02/lAa/H/UKkiXS9rATXXHjTdKa5XxSa5Dx/pVfi6TpE16b+jwTThiUQNOqnasNY
         Qy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5cCrOYr2TnsV7hg1z4ufQ0QBSkAleXOLlrvwjgt7a8c=;
        b=tTn7BucjXNWbzI2iXQECILFcKkEXCZFy84rKN8MiZK7HpdkTRFgbIXYIQLNNF3xSvQ
         NGS+UVy5tdXgfEp8aN/54FxFMyBTadUUdIoUNnLrwjznWeYAxCSBKSIEOZq86Sonnz74
         HwCSJR7mYnQD0o+KKElF/XCsAcinhiLuB7IWl2MMhdzsQxtfrIvDM66XuVk7kLPK1Otr
         EqQs7KteRhFNL/dy8ojxOY5QxDS6yCPh0eqWMx7qFzEIdFfWVqhjCPzU1FVq7p/uG6rp
         tiH6tBpWH93z7GqDf/+tRrpv5hKlQoZHCrJDzW0bwQS0Rg+9bNCcOeOuuHvZ2MLDU+/T
         nmvQ==
X-Gm-Message-State: APjAAAVcz9vn8PVTH7t4EocgpLQGuwgzCI+bg4OFooUzx+qQ9tsVCqj1
        t+GHmQl7vYDBmgNADc4291E=
X-Google-Smtp-Source: APXvYqydcQW2cCafiPIaF7/QZPrBBYpr4qob4CqJ6cgqd3IcA6gfMn0T2uK4ay1hxtAi5OTtmdf/bQ==
X-Received: by 2002:a17:90a:21cc:: with SMTP id q70mr85533665pjc.56.1563898748328;
        Tue, 23 Jul 2019 09:19:08 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id e124sm68442200pfh.181.2019.07.23.09.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 09:19:07 -0700 (PDT)
Date:   Tue, 23 Jul 2019 21:49:02 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Steven Price <steven.price@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rqchip/stm32: Remove unneeded call to kfree
Message-ID: <20190723161902.GA2910@hari-Inspiron-1545>
References: <20190719184606.GA4701@hari-Inspiron-1545>
 <1d9aa4be-4da2-b532-4787-c98869c0bd9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9aa4be-4da2-b532-4787-c98869c0bd9d@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:26:09AM +0100, Steven Price wrote:
> On 19/07/2019 19:46, Hariprasad Kelam wrote:
> > Memory allocated by devm_ alloc will be freed upon device detachment. So
> > we may not require free memory.
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  drivers/irqchip/irq-stm32-exti.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> > index e00f2fa..46ec0af 100644
> > --- a/drivers/irqchip/irq-stm32-exti.c
> > +++ b/drivers/irqchip/irq-stm32-exti.c
> > @@ -779,8 +779,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
> >  	irq_domain_remove(domain);
> >  out_unmap:
> >  	iounmap(host_data->base);
> > -	kfree(host_data->chips_data);
> > -	kfree(host_data);
> 
> In the commit this is based on these variables are not allocated using a
> devm_ alloc function:
> 
> $ git show e00f2fa | grep -A12 *stm32_exti_host_init
> > stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
> > 					   struct device_node *node)
> > {
> > 	struct stm32_exti_host_data *host_data;
> > 
> > 	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
> > 	if (!host_data)
> > 		return NULL;
> > 
> > 	host_data->drv_data = dd;
> > 	host_data->chips_data = kcalloc(dd->bank_nr,
> > 					sizeof(struct stm32_exti_chip_data),
> > 					GFP_KERNEL);
> The function stm32_exti_probe *does* use devm_k?alloc, so perhaps you
> were getting confused with that?
> 
> Steve
>
  Yes thanks  for explanation. Please ignore this patch

  Thanks,
  Hariprasad k
> >  	return ret;
> >  }
> >  
> > 
> 
