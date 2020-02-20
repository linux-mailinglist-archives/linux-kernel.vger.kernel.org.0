Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF316580A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 07:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgBTGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 01:55:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46122 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgBTGzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:55:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so1414239pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dfCavHORv9nxyMUnzmpfmBH+qNw/Yz+syQLxguqNEWk=;
        b=Vo94m2wFSMFwaKo+uQfZtwPn2eYMXAwrcWvJX/zBByU8AvvJONZ/ElVxkKIuYObNxg
         nvG9NOYw0+xuJ6A8+wWKHI5lmn2pY3Uwy25iNLxlm+SQ+TDCokoiELHT4mXy+BsPAuL8
         XeU/9PA8/n7bkq4aPYMvQI2dG8mDdaV0CeLts1aIoPav+8MRX+hPhn1fZ8d71/6KRuCR
         iqKHTxSKRg6R6qZcCXseuS14uxxQpZY54jBDjApC0U29kO4MHcMg4YH9PeuWOWXHMiJk
         hXk4lZNM1Us8m/L+xQTDsG0Uo9m20yQxZd5Jts6LbwRlnn5tkWkuL/xmGi58v7B3FuOV
         EYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dfCavHORv9nxyMUnzmpfmBH+qNw/Yz+syQLxguqNEWk=;
        b=qdgyc6SF/uYMttzpODvlxTthYc3N282Z8uYyP8nUVBmfaMhMyZQcMAfJ3cnwT+zjYi
         SQcpZSZ7oVHvYlXfcUaJUzp2ibmxBRLzmp2CU2JKhTXN4CdVLD4f0ZTJPxshG6bvYFQk
         hIrEpoMCp27Gt07CMcxCoi4aAT3mJNKpDH/U5sjusvwPWw+0mFwoOGYGnNFPtOVYuY60
         u/2xavJ9Kmq3/00MP8Dx9q0GH2VtpCy8764YpPgja9VfOx/tEYAzOfcjzcHGg+mokygj
         Fb1JzvFilX4N+8Qhwu/yjHai1DPwpvQYMSt/q2uHBClHuQV+Qa4M6yiY4ttvVPi7Cexa
         WnIQ==
X-Gm-Message-State: APjAAAVPAAIU9Mjq0uABq3KxQHCO0pMiCli6suIsB4AFas656fiblPYV
        mfJ5ubWg1z1MzhbejMxPNWS0KcpIma4=
X-Google-Smtp-Source: APXvYqw6y5QOFOuMBROKf2cSymcCX9t2c38YsEtsPCMT0minzDhLKSAmemXr9BMWaCVU5Gk0G8CrYQ==
X-Received: by 2002:a63:c903:: with SMTP id o3mr6638717pgg.109.1582181702745;
        Wed, 19 Feb 2020 22:55:02 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w18sm1871896pfq.167.2020.02.19.22.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:55:02 -0800 (PST)
Date:   Wed, 19 Feb 2020 22:54:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ram Chandra Jangir <rjangir@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipq8064: pinctrl: Fixed missing RGMII pincontrol
 definitions
Message-ID: <20200220065459.GE99370@yoga>
References: <20200219175940.744-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219175940.744-1-ansuelsmth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Feb 09:59 PST 2020, Ansuel Smith wrote:

> Add missing gpio definition for mdio and rgmii2.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Ram Chandra Jangir <rjangir@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-ipq8064.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq8064.c b/drivers/pinctrl/qcom/pinctrl-ipq8064.c
> index c2fb1ddf2f22..ac717ee38416 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ipq8064.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq8064.c
> @@ -299,7 +299,7 @@ static const char * const gpio_groups[] = {
>  };
>  
>  static const char * const mdio_groups[] = {
> -	"gpio0", "gpio1", "gpio10", "gpio11",
> +	"gpio0", "gpio1", "gpio2", "gpio10", "gpio11", "gpio66",
>  };
>  
>  static const char * const mi2s_groups[] = {
> @@ -403,8 +403,8 @@ static const char * const usb2_hsic_groups[] = {
>  };
>  
>  static const char * const rgmii2_groups[] = {
> -	"gpio27", "gpio28", "gpio29", "gpio30", "gpio31", "gpio32",
> -	"gpio51", "gpio52", "gpio59", "gpio60", "gpio61", "gpio62",
> +	"gpio2", "gpio27", "gpio28", "gpio29", "gpio30", "gpio31", "gpio32",
> +	"gpio51", "gpio52", "gpio59", "gpio60", "gpio61", "gpio62", "gpio66",
>  };
>  
>  static const char * const sata_groups[] = {
> @@ -539,7 +539,7 @@ static const struct msm_function ipq8064_functions[] = {
>  static const struct msm_pingroup ipq8064_groups[] = {
>  	PINGROUP(0, mdio, NA, NA, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(1, mdio, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> -	PINGROUP(2, gsbi5_spi_cs3, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(2, gsbi5_spi_cs3, rgmii2, mdio, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(3, pcie1_rst, pcie1_prsnt, pdm, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(4, pcie1_pwren_n, pcie1_pwren, NA, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(5, pcie1_clk_req, pcie1_pwrflt, NA, NA, NA, NA, NA, NA, NA, NA),
> @@ -603,7 +603,7 @@ static const struct msm_pingroup ipq8064_groups[] = {
>  	PINGROUP(63, pcie3_rst, NA, NA, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(64, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(65, pcie3_clk_req, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> -	PINGROUP(66, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(66, rgmii2, mdio, NA, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(67, usb2_hsic, NA, NA, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(68, usb2_hsic, NA, NA, NA, NA, NA, NA, NA, NA, NA),
>  	SDC_PINGROUP(sdc3_clk, 0x204a, 14, 6),
> -- 
> 2.25.0
> 
