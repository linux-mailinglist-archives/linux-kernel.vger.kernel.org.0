Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF6DEC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfJUMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 08:30:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43508 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUMaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:30:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so8528614wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKfn7Qq96hAb4iGxGvvNjTY5LcHJmhrRPIK5yxoQ9Y0=;
        b=TzdDrmtjzpZq+YFruP5kGDkrOcTZBWWoDy/kM/gOgpKmgg23xYaLmHj5R8rF6f5dAt
         dd8ByMJTZf/pih6wLCgc/KnCi7nlZnF3bfjN9+1/fScNSZrbk5bgL1XGUHvRk7WdEXlL
         Wf+MZ+DkJvOR3vCE6hmM0i2ejVqPpx1Fr4zkJfVnut5jO3oHRYQTwcdyWXzZpEsx5hBX
         YzVRhfmpFJThu3t8wDMfwpWydj6DE62w6j1KOLDzklot9hGksSJA/hVn+JXrnWWfOfMt
         OZ8q52wqSAA1ckfJ+loIpVjz9rRsdolUyTAi4vuH9KmPhVkfifDA2XFrqqYD0W8dkyAg
         vj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKfn7Qq96hAb4iGxGvvNjTY5LcHJmhrRPIK5yxoQ9Y0=;
        b=tSe0scBleo6q+q5KhrO6lxgRf18JUjcGWjotSsnXaEjPH4ny0QmYEdV+zPj6Olg4gq
         QCtMzPueVAN0mB1h3J5f6ujae6kX/RuqQQ6ZJZPM0u0kTGZv8u98dswdjELSFG2C65ai
         /0LTGdqvjt/JNDv6QRA6calhGlkjF9cKBXutT9HtdrFOMtVHsty8T1U9IFZGMvXwrC1i
         H05p3wCQ7oJXH7VMiiG/Ar5t+1kUJ3/mCwZK7oeCY5p1g70JwjfFzZHpkalrh7/rso11
         k5sA2DSn/gCiPxIJiMe7NzmiuI06BpfvH61WyeuUAQKuMxp+SljRJm1HWRlF2cTh0SCH
         2QBQ==
X-Gm-Message-State: APjAAAUSIMCPpJUpQt6iH28S4xoRAdKe55DzIaXmBYJj9ITxk2vvxMQE
        208qafnFup1EpT/QfjD95buGCg==
X-Google-Smtp-Source: APXvYqyg0YciwtBGWYvFialeJsnKQ0DH2VQACLRJSaRErKbjHyZ+SvIDbc2UI9ay8YKCDrU2GiDlUQ==
X-Received: by 2002:adf:c143:: with SMTP id w3mr19822761wre.77.1571661014249;
        Mon, 21 Oct 2019 05:30:14 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r9sm9332012wrx.28.2019.10.21.05.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:30:13 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:30:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 7/9] mfd: mfd-core: Protect against NULL call-back
 function pointer
Message-ID: <20191021123012.qpk7tgyjtwp3wtxv@holly.lan>
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

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

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
