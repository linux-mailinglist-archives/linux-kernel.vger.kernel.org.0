Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D41DEC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 14:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfJUMck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 08:32:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:32:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so1272010wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YSNbD0PByWlljM0tltuyIHBfRs/cFkXbsMwoXfP9xNQ=;
        b=S+Mwsua59XN67/GSiILSsQdKYodDH+CWLAETt/iEQ+WCYBv4iADwrNG/eACZ58pyrj
         BO6b5GYW55DhQ9GoxgH0oQHKr53qMOPogTY/8lO7gPRL+o8LeWFgPZC/FWShX4mq/rZu
         MO2cHAEvmVRiaZIixjEGDEilcJXjvaXa6Ne+MGi+PqqerpCjH9BtFho3C59jY5aqbZn6
         6cyBPXlfjA42ARw9f1uowEi9ddN0u8Ps2Y9xlcdx893lCND3OolalLFeGQ4FrEbO6EJe
         +hCwEH3Fs4tmWyNSS/8hV4joXu7lHI6DVwLY7QPXzX62J1zKAKRTM6GfC95aoXAfl1Ga
         GnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YSNbD0PByWlljM0tltuyIHBfRs/cFkXbsMwoXfP9xNQ=;
        b=k++BKbsBc5FUEh14c+RsWlTydVjqBKfX1tkOHHRYf4sczS/rfh8u9VE+ZASY9/IOEA
         7O62rTqnG0IiBTOtz8T9e7ljT8a8ujlCN1bklLJgCfQd+ArhUIIHK8adaflAGLS003AF
         0v5x87ovklkhKgSlNCthUGbnRE2+i5czP0zf4rTteo3p1RxjmjPc8RRCfA9pagjNUwTP
         Rb5XgWI3q+qSfk01xZL3EyrIMAF9sv2Gl95HarILVFnimm6SUIJ7qcStR88ehEHhL6Af
         M6PWfzJ/JEoFI3CFv16B+MWpBfpWJs7Rw53MLz1jVwYOrGiTRz/L9xNThV+WyYJ0eAJu
         z+FA==
X-Gm-Message-State: APjAAAXcpp/LD5wvOz72lpSvSpRskSg8wFqbfMZzv7w5U1xlVOHicxFF
        JtQjHqCnQiNN/GeaA/PXBY0Q6A==
X-Google-Smtp-Source: APXvYqzRxQ5KE5HsIm1jEL4loTOSOacNYbr+dsBUdHuVKjcRV0so0RxsxKayHoKAUfSL1zQgTIfR9A==
X-Received: by 2002:a1c:108:: with SMTP id 8mr10489788wmb.25.1571661157724;
        Mon, 21 Oct 2019 05:32:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s13sm13453572wmc.28.2019.10.21.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:32:37 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:32:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 7/9] mfd: mfd-core: Protect against NULL call-back
 function pointer
Message-ID: <20191021123235.royyfp4mxrvsgioh@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-8-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:20AM +0100, Lee Jones wrote:
> If a child device calls mfd_cell_{en,dis}able() without an appropriate
> call-back being set, we are likely to encounter a panic.  Avoid this
> by adding suitable checking.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/mfd-core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 8126665bb2d8..90b43b44a15a 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -28,6 +28,11 @@ int mfd_cell_enable(struct platform_device *pdev)
>  	const struct mfd_cell *cell = mfd_get_cell(pdev);
>  	int err = 0;
>  
> +	if (!cell->enable) {
> +		dev_dbg(&pdev->dev, "No .enable() call-back registered\n");
> +		return 0;
> +	}
> +
>  	/* only call enable hook if the cell wasn't previously enabled */
>  	if (atomic_inc_return(cell->usage_count) == 1)
>  		err = cell->enable(pdev);
> @@ -45,6 +50,11 @@ int mfd_cell_disable(struct platform_device *pdev)
>  	const struct mfd_cell *cell = mfd_get_cell(pdev);
>  	int err = 0;
>  
> +	if (!cell->enable) {

Oops.

Cancel the R-B: ;-). Shouldn't this be !cell->disable() ?


Daniel.



> +		dev_dbg(&pdev->dev, "No .disable() call-back registered\n");
> +		return 0;
> +	}
> +
>  	/* only disable if no other clients are using it */
>  	if (atomic_dec_return(cell->usage_count) == 0)
>  		err = cell->disable(pdev);
> -- 
> 2.17.1
> 
