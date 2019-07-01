Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F28F1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfD3IMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 04:12:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33806 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfD3IMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:12:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id h5so10154094lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ozURogrBkqi6N/9N92/2fxrEWVZwyBMFji8R7JKkYU=;
        b=M7/9voiOZsA0i1tciJ1pUBbgPG/0StQIPxDKbDg1g11ZPSQamC313AwO8BFToT/wgy
         jG5v7Jaa1HuDkspbMSzWg4k/0BPxqnWvC7d0HkRJXvOE+JgIfSQ/HrDd2aKFR8RoBjyw
         hc10L4REu9iSGrekmG8BkHY/7uXuiagFhqAR4tpIikdIw026IAXARahgOqOjL8SJLwYe
         cajE7QCavHx+j0JgCM7Yj7oy9Tit01jlFZIBFKrIWEF6Viw+CYaGg6488w6erNBKtIQh
         dRqHKyhDfAXQ7K43g2i74TUI40bO0jJXM8JkJmXXkgbOS9whCTc2J9jGj1ybM6iLdH7c
         Aviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ozURogrBkqi6N/9N92/2fxrEWVZwyBMFji8R7JKkYU=;
        b=nHInheWnCB0pDWt10qnMGRgB1wgI4xINxF/T3QyFg3ED/Ar7uV0DfDDy0E/7g8Hmwk
         QPVRL9Tmv6ZCE2bbv8zSuaq0XetaH8k1+qQOOngFj5J7TkeZiXD9EPMLEt2LBMoh4K/8
         8/gQEiq7ip4TwX7Eye2fWx/gUt0jyMPvjtX4jLjiEjjV8sRv7E6UszKTgdSujO2DzPhM
         fUDQWC16VYm2I9HdgchhvFJUNSqVZRh8n07vuObjpqeEnirZYD78ZNyaFDXrIpaxw11U
         anAjGKSk13MFgUo1cyWJWMPQ1A+oljU3repVPmXGXythiJg/Nfc+8liRESZAnJCvx6HK
         ipEw==
X-Gm-Message-State: APjAAAWxH1VE2GODjkt1YPMYeuq3vzqNsYQsk1vbjDPqxoVW2iLbmJt0
        gjva/2b9g3/fc7h1bLqEDXrJ+A6mJ78=
X-Google-Smtp-Source: APXvYqyi6TzPSwc+vP/6cCmv5b05hWr4xC/ARTHKOTUqoAS7o4TuMr/9HAqCRgURLMrWPpVgpHblvA==
X-Received: by 2002:a19:f801:: with SMTP id a1mr36540071lff.150.1556611964646;
        Tue, 30 Apr 2019 01:12:44 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.195])
        by smtp.gmail.com with ESMTPSA id h21sm3290136ljf.16.2019.04.30.01.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 01:12:43 -0700 (PDT)
Subject: Re: [PATCH 2/5] irqchip/renesas-irqc: Remove
 devm_kzalloc()/ioremap_nocache() error printing
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190429152006.22593-1-geert+renesas@glider.be>
 <20190429152006.22593-3-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3ecf87e2-4e70-9159-a364-d41f1b744f7b@cogentembedded.com>
Date:   Tue, 30 Apr 2019 11:12:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429152006.22593-3-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 29.04.2019 18:20, Geert Uytterhoeven wrote:

> There is no need to print a message if devm_kzalloc() or

    Just kzalloc() in this case.

> ioremap_nocache() fails, as the memory allocation core already takes
> care of that.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/irqchip/irq-renesas-irqc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
> index 438a063c76156d98..0955ffe12b32eb36 100644
> --- a/drivers/irqchip/irq-renesas-irqc.c
> +++ b/drivers/irqchip/irq-renesas-irqc.c
> @@ -133,7 +133,6 @@ static int irqc_probe(struct platform_device *pdev)
>   
>   	p = kzalloc(sizeof(*p), GFP_KERNEL);
>   	if (!p) {
> -		dev_err(&pdev->dev, "failed to allocate driver data\n");
>   		ret = -ENOMEM;
>   		goto err0;
>   	}
> @@ -173,7 +172,6 @@ static int irqc_probe(struct platform_device *pdev)
>   	/* ioremap IOMEM and setup read/write callbacks */
>   	p->iomem = ioremap_nocache(io->start, resource_size(io));
>   	if (!p->iomem) {
> -		dev_err(&pdev->dev, "failed to remap IOMEM\n");
>   		ret = -ENXIO;

    -ENOMEM?

[...]

MBR, Sergei
