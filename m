Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3101131147
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgAFLRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 06:17:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35308 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAFLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:17:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so49150945wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cQ5rRwhZnemiZ9ZgJkoSlgV14RD99l4994u/SctoHeo=;
        b=blZaf2bFuxBU4cD6pJRn+51r8JWOy5QWF2F430FbI8HqUUzl+OPeskJIWiyY/JDCZx
         88XvGXaKRCV0dnzNWHZBJxdgUXYt2kG/mzd06sIJZEVInapSITQBdfrB/aUivHHBJAfM
         zvkaHDv8sj2/pP0sc2gYkaI+iDRI5oRNQIBaveatD32kxvgbPnOjNtDGGPlXS8E3VnHS
         eNgcJhvAEkC/CLoBdSBd04QBg+TTi8vQoJ687Lauk1SHjv2FbNM3FKSKj23i1NFZwCTH
         MABrMCYsgRPBD4kGM/Px0TVcWKN+wAOrvkFES/SL6hNQxf4tBImR6JY+lYedt1kY/tHw
         fKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cQ5rRwhZnemiZ9ZgJkoSlgV14RD99l4994u/SctoHeo=;
        b=HyugvmoJBJt0HVzM57R/KtYHAHRZBJhHqzufb5hcnGJpCCGQXCdZV+ccAFLc0JqGzZ
         4a4NhRq7gsF/O7hNc6CFZ9yXZN8pP/7WFa9FUalJ/ZbmtuDW+UCzBdlZbaZRy5pTYoAm
         V9GaLLoGedfZZNHRFxxtst/FshZu+eIpVmU1FAlG4xKIlVUgwg48ZfNOuaK9MSHUnytu
         2esMsGaZeL9qf53MVsVjORzt3P3CihBVwi6Gojm0xiIdbWezaKg2EI7QXAnsdZzGlEJl
         WR/mX7by7QrQwXwuWVS/JsmQnp2X7hbJ3iSBn7SotpavpcSZLneQLrxTw99WeRPncA+z
         NJJg==
X-Gm-Message-State: APjAAAW2LONkDwuPcxn11iaVrCflJ3Fq5ErKzHr+o8+cjs5iegDUSFbt
        lG3vSkMC0Fl+oG1k9KjQw1dXLA==
X-Google-Smtp-Source: APXvYqylPmSsm/jdoHEzDEZJDy4X9QFHopZzpjkRxI4lqV6QC3VSnW0i//kRQXYflqWhCMD3z4M38Q==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr109310594wrr.266.1578309452254;
        Mon, 06 Jan 2020 03:17:32 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id v8sm71653041wrw.2.2020.01.06.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 03:17:31 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:17:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>
Subject: Re: [PATCH] mfd: max77650: Select REGMAP_IRQ in Kconfig
Message-ID: <20200106111737.GB14821@dell>
References: <20200103114156.20089-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103114156.20089-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jan 2020, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> MAX77650 MFD driver uses regmap_irq API but doesn't select the required
> REGMAP_IRQ option in Kconfig. This can cause the following build error
> if regmap irq is not enabled implicitly by someone else:
> 
>     ld: drivers/mfd/max77650.o: in function `max77650_i2c_probe':
>     max77650.c:(.text+0xcb): undefined reference to `devm_regmap_add_irq_chip'
>     ld: max77650.c:(.text+0xdb): undefined reference to `regmap_irq_get_domain'
>     make: *** [Makefile:1079: vmlinux] Error 1
> 
> Fix it by adding the missing option.
> 
> Fixes: d0f60334500b ("mfd: Add new driver for MAX77650 PMIC")
> Reported-by: Paul Gazzillo <paul@pgazz.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
