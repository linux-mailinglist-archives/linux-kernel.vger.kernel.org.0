Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD52575B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfEUSQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 14:16:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42288 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfEUSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:16:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so9465625pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kWn23uPSMxDFn2qGTs4o2rEa3INC2eoWBUd16xA7XV8=;
        b=StpYFVZSovK25IyEPqkVrilukmqVU8wqhQsBBJXhzVWPRyObGv3Y0sE/foiPAP1dLY
         u+5cRVaM2aXyHOZbDnvo5CixYT3pDTGkwkastTAD9csANh4Kq53CAYqdt3BU542IHDWo
         GL5I6q2Z4PZP3D28tm1mOHEUFcPTPaXw5u/4PmkRk1zyWJvXlJA1+y01Eb56nO8IuZZZ
         7O7OzNNw+gXkyyEWTk9bN4QuYEOEFrAk7OSvc5rGDby3rnQqpeuTXTMHw/HMugDrt6SQ
         sJExt/iFymWshqalcGbMGMqXuAuxB6kf0qmYF9UKfVF8w5mMat09dUmFZKf+frzxamE0
         dGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWn23uPSMxDFn2qGTs4o2rEa3INC2eoWBUd16xA7XV8=;
        b=TDeuwJnvwVOStbN8EOZkb4Uxc1iRPlmQizmnFBkJFLUejNGaEPEc9R9QgpqvFJSwuA
         OqsHVkQQU3jE3iZIDn+DQ3NGJSp7WYfGMpzyXlBTzQ1q82BhgIZB3xzwuCYo+5xJNiLk
         3MAHreRAtHrRXFp36kKQBrmIUdwdYiwxKcq6tn25LTgosVoyOjHv/262fIZQQ/CiyZYY
         8pcDoUGyMxuSLuh8KfNUd1TGbB+jGq1uHJvYg9fHwJRPkGXc+KujsR7MleLn4u2YvP3Z
         x4/zQDRV6hAzJWiww/jy9Zz0SWcbz8f2in+iaY9b2qpjlDd+0relhf2G/NZh4xlriAUN
         Bmkw==
X-Gm-Message-State: APjAAAXfjoH6/+IEZiEVKtBWWV8bwfXw7rRvaI56RZ68z67+ag/GwJH0
        PIITnEQS6Dj7MQ0Ks1h6Iy20jg==
X-Google-Smtp-Source: APXvYqzNDTddr3qSb0H+nAtgW+HjSihhmwcLS/tOoKNIQOseOHwP64iiNXN2WRg9soFejjy2u6Ne/A==
X-Received: by 2002:a63:484d:: with SMTP id x13mr56974pgk.275.1558462586195;
        Tue, 21 May 2019 11:16:26 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i17sm27598969pfo.103.2019.05.21.11.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:16:25 -0700 (PDT)
Date:   Tue, 21 May 2019 11:16:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, david.brown@linaro.org, jcrouse@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: msm8998-mtp: Add pm8005_s1 regulator
Message-ID: <20190521181652.GC2085@tuxbook-pro>
References: <20190521164932.14265-1-jeffrey.l.hugo@gmail.com>
 <20190521165341.14428-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521165341.14428-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 May 09:53 PDT 2019, Jeffrey Hugo wrote:

> The pm8005_s1 is VDD_GFX, and needs to be on to enable the GPU.
> This should be hooked up to the GPU CPR, but we don't have support for that
> yet, so until then, just turn on the regulator and keep it on so that we
> can focus on basic GPU bringup.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index f09f3e03f708..108667ce4f31 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -27,6 +27,23 @@
>  	status = "okay";
>  };
>  
> +&pm8005_lsid1 {
> +	pm8005-regulators {
> +		compatible = "qcom,pm8005-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +
> +		pm8005_s1: s1 { /* VDD_GFX supply */
> +			regulator-min-microvolt = <524000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-enable-ramp-delay = <500>;
> +
> +			/* hack until we rig up the gpu consumer */
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
>  &qusb2phy {
>  	status = "okay";
>  
> -- 
> 2.17.1
> 
