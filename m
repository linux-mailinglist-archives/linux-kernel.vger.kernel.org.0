Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328313570A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFEGeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 02:34:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfFEGeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:34:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so6221996pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MDnhT69i4+3igVNMGRO0Olac0iYlmd7+e9rYlDGKlMQ=;
        b=b0zeeCKtZnHGuRksL/MviXPn9ETjzaS+XVRjInqPSn3MmRYG1h2xHNGblAhI+hwSgW
         27ZfCX1Gruevo4QQpULxZqIYe5C+Zgz/G1c55aHrsLCR1l4SuO6Zl2rqHMz/HhFh9Z9Q
         QxMw+vu3nl1p1nftk6+cafNIaL0Qc2EIwNB2KxZMrgxWW1jAV1G6l5NzkuLcxcGZCAGE
         4WVEq1fL81w0hRjY+jxAYMV+Z8z5ugYVoDpGILoXwPvhIzQqgv5xTEOy7KxvxfLB+J1S
         ODzal5jdUT/lQkiRAr2R384iYKbide9/PJ3H67SHJn10yNgF/PbuaKGoJUtwsqQIGR2B
         g+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDnhT69i4+3igVNMGRO0Olac0iYlmd7+e9rYlDGKlMQ=;
        b=SL8+RdzVJpNOtljIcDpHo+heZv/juBUNUgD+4ggvCwWnfLrobOsfGWMpPA8HC/BJUZ
         LjHPEDugzLIYyVxPBXWNE+FnustgPCMOWQPTtxIauD1orvopJfXFEI00osqY3hu5urJn
         3cCGqC9pGWHzTbwJ7czyrcNW3+4aQTK2PEio5TLyf21RtCzqRrvdMQN69BA1ODenMRBu
         ozeg9eCBrJ3sr7qKKy9eo2ENGNNeTbSUKcuYwkaGzMIWAX6PfTj2dccElTrk5gaw/x0l
         Lgu9jYPdJYhbQgYgG5h9TelSURx+zWBYqqwljFCJ1Vj0rl2K9K3m3rxeNwHRlAl8L/7S
         dolg==
X-Gm-Message-State: APjAAAUWpqOLuQeAxdBRvBoPoOUHe6waMfZHf4gFyVzC3Gm4ZjfbbaOE
        emI3qZ5sQa9L5qwMoHOi2dSKbA==
X-Google-Smtp-Source: APXvYqy3bNsHWjS/PwRCl4JZk2sWXQhzg3FwJWCnisZBOEnbpp0qgkByrv0MfZW4pI4x2RdDmUP25g==
X-Received: by 2002:a63:f146:: with SMTP id o6mr2228929pgk.179.1559716463205;
        Tue, 04 Jun 2019 23:34:23 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k8sm8144854pfk.177.2019.06.04.23.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 23:34:22 -0700 (PDT)
Date:   Tue, 4 Jun 2019 23:35:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, kramasub@codeaurora.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 6/8] usb: dwc3: qcom: Add support for booting with ACPI
Message-ID: <20190605063507.GM22737@tuxbook-pro>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604104455.8877-6-lee.jones@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
[..]
> @@ -373,7 +416,7 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
>  
>  	qcom->num_clocks = count;
>  
> -	if (!count)
> +	if (!count || ACPI_HANDLE(dev))
>  		return 0;

Afaict you call this with count = of_count_phandle_with_args(), which
should be 0. But why not skip calling this at all?

>  
>  	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
> @@ -409,12 +452,28 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
>  	return 0;
>  }
>  
> +static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
> +	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
> +	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
> +	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
> +	.hs_phy_irq_index = 1,
> +	.dp_hs_phy_irq_index = 4,
> +	.dm_hs_phy_irq_index = 3,
> +	.ss_phy_irq_index = 2
> +};
> +
> +static const struct acpi_device_id dwc3_qcom_acpi_match[] = {
> +	{ "QCOM2430", (unsigned long)&sdm845_acpi_pdata },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, dwc3_qcom_acpi_match);

Analog to of_device_get_match_data() there seems to be a
acpi_device_get_match_data(), if you use this you should be able to
have you acpi_device_id array next to the of_device_id.

> +
>  static int dwc3_qcom_probe(struct platform_device *pdev)

It seems that all that's left unconditional on ACPI_HANDLE() in this
function are the optional pieces and the tail. Wouldn't it be cleaner to
split it out in different functions?

Regards,
Bjorn
