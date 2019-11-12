Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59459F8AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKLImc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 03:42:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36409 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfKLIma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:42:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so17525859wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HzvYoikEhzEV6lsuLR4at0JgoNFuCTedoPfyEqd82fk=;
        b=BmHOPmBMRfv3GGPBxmR72PUMl/3ZWPI+1+BNAVyBkqC5Tpc+2sZUdn6AzT8M4A3ova
         Nkyeg/Q7B6tdMFpe8A3fOI5TKQXKrmh6xfCfIuprnDVAbYfnsnPORunYnT50ETPK/MnC
         5hkYWMXyrYmi/d0hS1MqKwbkaKpVwxTYOW+9Sn5xher1rZzd48Na9dG2XwqLRK2OD1iw
         M+ih+ZUi+q9V6kXktF3bZadGi2GMRMuH7dWEOUjqGtGZ0+s2tUq/ojfMMmD08wSJ4UdY
         zyyUp86Z/19Y8gb9WXH8RUP29WbdUDbWxfrP7na8Wtwf+upPBLFGsLZtAnLShEzy/34X
         KznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HzvYoikEhzEV6lsuLR4at0JgoNFuCTedoPfyEqd82fk=;
        b=QGeBff/46QklEcc592dMRUpSRbCIEpdwOjFAfaClNGY4dKC0neqhjg0DlHy4u0ZPp4
         2WnLDSeZE67gH58H69jExV4Z5hZJC6WgyMJ+JUrvLt5aU50OGl3FL3oZ7iuDmA6sjDAR
         vvoKZ8FX+FECuZ3mAiaEYG1MCH951CZL//sEkLccohI8SGm9Hh8AWb1y2E6fxOhqbjPq
         nKajbsPaD0sHcH7AYs/RZrxzJIa3HJ3RamFiOjm/4fGZ0e0l1kei8ofnaW51hrIEHijt
         XUhOpp1s9R1ZYpT4ueXAbwE5jHFNeiV85Y04smqRLIeo7dfp+5zuo8piiZDOnK/aviiH
         f+7Q==
X-Gm-Message-State: APjAAAUUzCgZeCcyzVG3dJ3dC/2bMyUKdBoBDOA2KilpHAFKXv3Uz47T
        H4aZoEMJ9AXaTz/8VzS1J5edLA==
X-Google-Smtp-Source: APXvYqzO1tf7n21rpRAYsuA0hCRyRuoIczMjkpOTlOH4itbZj239HUwQUPygk/Y8AFRAdhyysyqD3Q==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr16349306wrw.222.1573548146216;
        Tue, 12 Nov 2019 00:42:26 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id 189sm3583144wmc.7.2019.11.12.00.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 00:42:26 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:42:25 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     kvalo@codeaurora.org, davem@davemloft.net,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath10k: Fix qmi init error handling
Message-ID: <20191112084225.casuncbo7z54vu4g@netronome.com>
References: <20191106231650.1580-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106231650.1580-1-jeffrey.l.hugo@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:16:50PM -0800, Jeffrey Hugo wrote:
> When ath10k_qmi_init() fails, the error handling does not free the irq
> resources, which causes an issue if we EPROBE_DEFER as we'll attempt to
> (re-)register irqs which are already registered.
> 
> Fixes: ba94c753ccb4 ("ath10k: add QMI message handshake for wcn3990 client")
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index fc15a0037f0e..f2a0b7aaad3b 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1729,7 +1729,7 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
>  	ret = ath10k_qmi_init(ar, msa_size);
>  	if (ret) {
>  		ath10k_warn(ar, "failed to register wlfw qmi client: %d\n", ret);
> -		goto err_core_destroy;
> +		goto err_free_irq;
>  	}

From a casual examination of the code this seems like a step in the right
direction. But does this error path also need to call ath10k_hw_power_off() ?

>  
>  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc probe\n");
> -- 
> 2.17.1
> 
