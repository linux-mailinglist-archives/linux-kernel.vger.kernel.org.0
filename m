Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1EF142629
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 09:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgATIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 03:54:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:54:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so28604197wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kioLvgS74f9sJjCTsbx/ZLFmZG4mkGnzw8r1w1WYA/4=;
        b=we/6y6edkk3YpKlsBXl/AgdVTKspovJ98gF9DwytZxXRdKu2lf0yHGZ9cqG+OHNl43
         1D3wAY7FLKrkB72RdPqnamX5YdLo51GRCa74KmSY6GD35joffcxpIlx05IcZqarzXOP6
         +x+WZdL8Gs45yw6pNJWCoKrxJUIpW0Icot9uVJGDAki8AJAjxn9VczF5OAkFpdczph4B
         RkCNnyR+3vU+CuNo9xNEbZOrEsQFIuCf9xPQu0wKKvvAO/Bx0ch6NjL4QHxAd+wfp2yG
         0v3gxZaqF1zpen8HTiUQZ68tg3+k1M5szuubctad3xbmDv0AW6NzZw39zcETHvk5c+cj
         kz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kioLvgS74f9sJjCTsbx/ZLFmZG4mkGnzw8r1w1WYA/4=;
        b=qfc9D0o/9Dt0EGtALz+Hkila54tQklDf83XDPeg3K/dnTklg7X013Od12HKIB2bdTF
         v//MXF//0pARME7vWBW98yFHhfeWAYfTSgSiRMV2gEOmLBSS93U6DUMaN1W21zVaDTYI
         1QQNNpHiCG7We7Tp7ZTN/1+danUGu+F+/PtPLYUAPJHp01D/ypzGNXLhKkAyZ9K4oXzz
         dCBwjM5ezocdHv3hhZvio8hZA97WPD7lVHpSAxYwWu9m4kA0x6nWkI4OHAW36gDS/P2r
         f2sbMqxtm6ClLlRf2+toMyYYxs9Yl6d3gJy64BxYLt9XPkbyLymgWblvnynqPj2USuCR
         GzMA==
X-Gm-Message-State: APjAAAU5Khw47PxQtgAALoZIUmFhYnHVogupjLL0lwdJ/eMkVPdcYzS6
        by3ioJRBC/kiuDhPJfymM4TMKw==
X-Google-Smtp-Source: APXvYqxCEa3WXWluxoJWVXwFldWEGwXwSD1xXL7D/5WNmT4sWEkYFaFe3u9dMJfoNyljA8GfrAY9CA==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr17084301wrv.426.1579510460638;
        Mon, 20 Jan 2020 00:54:20 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id b21sm11998wmd.37.2020.01.20.00.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:54:20 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:54:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v11 03/13] mfd: rohm PMICs - use platform_device_id to
 match MFD sub-devices
Message-ID: <20200120085435.GA15507@dell>
References: <cover.1579501711.git.matti.vaittinen@fi.rohmeurope.com>
 <13994480cab6d5d6376c8f5228572e55ca06e479.1579501711.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13994480cab6d5d6376c8f5228572e55ca06e479.1579501711.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, Matti Vaittinen wrote:

> Thanks to Stephen Boyd I today learned we can use platform_device_id
> to do device and module matching for MFD sub-devices!
> 
> Do device matching using the platform_device_id instead of using
> explicit module_aliases to load modules and custom parent-data field
> to do module loading and sub-device matching.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> No changes since v10
> 
>  drivers/clk/clk-bd718x7.c             | 12 ++++++++-
>  drivers/mfd/rohm-bd70528.c            |  3 +--
>  drivers/mfd/rohm-bd718x7.c            | 39 ++++++++++++++++++++++-----
>  drivers/regulator/bd718x7-regulator.c | 17 +++++++++---
>  include/linux/mfd/rohm-generic.h      |  3 +--
>  5 files changed, 58 insertions(+), 16 deletions(-)

Still needs Clk and Regulator Acks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
