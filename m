Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE71175F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfEHK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 06:27:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39413 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfEHK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:27:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id v10so1233128wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lCih+DCGInijuPBCSy9aRkv9fkrHdV+rypo2WmJiniM=;
        b=QEsqHORDJ3ObMcxrRROnnNTK90FKXLLfq8Um+qnX+Qq8i9//pMaMBNnhqcJiBSXyqc
         DNY/jc4X6y+3ixVTw3IrCrrGpIg6imJX/7XQ/LgPClHyPpP0qGIgEv6sCmOWTIglvx+2
         xjsd3HkzbaJdK73JshAKGao4PdjDHTqbKMFBT3skx0jErDDhHcZIQ/uLOE66NRqqZarg
         8tmKKcQqCAiKPFacfFCKS7dIjkr7S0nLNk4X9iIt0xJ6X3XSMykR23qMgHrjU+pK86UU
         lsGVkaLpf5k+CVwks7KWYDa7ger4FnkoH1oEpjujQkPTyGMSaIZxOJHUJuMmfkfCRTHS
         rp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lCih+DCGInijuPBCSy9aRkv9fkrHdV+rypo2WmJiniM=;
        b=RD9r6lDUfgcsaq/u52OjNt89EAPqFhfMB9NFkIn1JkXs6IJqLM2zMZVOTwviYyu9r+
         IYqQ2YPKpAxS5GHSt99caiI/SL4K1Cr/S2FKJA2D0/zcfNfGPhGs1JgF7p5XVxpRxOzg
         UjRhwmGuJsaim6sDStd+YVwlwO1FFwY51byffZs88zZSaEYsKSbQ9vcPUsUSdgNbbaW1
         u+4W9VR1O7MV+ePD2OZ7aIcdcGQCEDQ0CAWf9RReKejUzgdf84dxJVoiA7nSMRh390oK
         8yl2jf3lsuRLQ370BxrR/qvE45pnnHHXTDXvOSyUv73zXQQFtYMxMERV3h5pGp0OnMyG
         U15Q==
X-Gm-Message-State: APjAAAW2uiIako9jhcyoKjVs4Mx/ROqvJR6dP0DsaGtcy0tsak1HlcgB
        uiu2evODHYw1xvrZ/6eynz5mRQ==
X-Google-Smtp-Source: APXvYqyIfnN4naXX0LqsppNJbXgKLlcy9pz+RkZsZUQumZdMDzNWPkBsHgqJZhr+H8yNEoe3pMpKqw==
X-Received: by 2002:adf:f108:: with SMTP id r8mr16643728wro.221.1557311224451;
        Wed, 08 May 2019 03:27:04 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id r64sm7397196wmr.0.2019.05.08.03.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:27:03 -0700 (PDT)
Date:   Wed, 8 May 2019 11:27:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, javier@dowhile0.org
Subject: Re: [PATCH] spi: TI power management: add missing of table
 registration
Message-ID: <20190508102701.GI3995@dell>
References: <1555960190-8645-1-git-send-email-dagmcr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555960190-8645-1-git-send-email-dagmcr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject line is not correct.  This is an MFD driver.

When submitting you should follow the convention for the subsystem you
are patching against.  The following command is helpful:

  `git log --oneline -- <SUBSYSTEM>`

I will fix it for you this time (and for the other patch I see).

On Mon, 22 Apr 2019, Daniel Gomez wrote:

> MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
> OF mathing mechanism and register it.
> 
> Before this patch:
> modinfo drivers/mfd/tps65912-spi.ko | grep alias
> alias:          spi:tps65912
> 
> After this patch:
> modinfo drivers/mfd/tps65912-spi.ko | grep alias
> alias:          of:N*T*Cti,tps65912C*
> alias:          of:N*T*Cti,tps65912
> alias:          spi:tps65912
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---
>  drivers/mfd/tps65912-spi.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
