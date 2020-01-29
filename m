Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2514214D292
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 22:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgA2VeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 16:34:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38106 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2VeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:34:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so475030pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 13:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2cTq1d0/bjXHFE+8DF9uoTP4J7rQ0aQeLN//Vjb4bic=;
        b=PFMyspGV+sOlLv1HfG/X5dHc3nNXWJ50U/x+sXOJ3gQQBiJjY8xxFcf198fNf5uP0B
         a4D/YuDexTwAkMHABMPvHWoZI3qawNsepWtVZG2/c2hLOvBsRCKK/8MuORuOy+jl+381
         vhSpMbyWK9jzrPS5poZVBReuyQbgqsrWKhKnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2cTq1d0/bjXHFE+8DF9uoTP4J7rQ0aQeLN//Vjb4bic=;
        b=OxVBurNZo4SXJRhQ769FdMpqNw04iXFSFkK5sSuyZdXKr865sczq4uVQo5novxn5Tg
         6RfD57M4fwhLvjrqx5bhXb37eaAm6ap9njqnMI6SS7Dlmx9PURASi/Wq5A2BkQVJl+4f
         cRQqBPwm8FR9sls08StGvTti+3kBWBwnNq/jVlF4UKFLpnE3nPqt3a+6hzAn98dtAPBG
         9uCF01yHQQbkmUnaaT4O79ausP7U0hYXnT2HjCr9dRTl04tHtGuclsgZtAjiaJyIHEuC
         xHdK70rBcfZI1h/U5Jxa+BKJtmIYpmaMRjkYrY39brmtcin4SucGyWQ0+YxoJMMS8Dte
         JXLw==
X-Gm-Message-State: APjAAAW0LTntgr//hdo+LElt3B0D7KejKfthNuz5n+OszNzeCv5YY9Ha
        bjIAqkqaBaizjEITuFrfpV3tQg==
X-Google-Smtp-Source: APXvYqxKYW7A8o7y9AS6WSLmktLxYo1QIzsqQkH5vk8mYXdDCQMMSh/WAUpIbH3Y02oKkL15AToHdQ==
X-Received: by 2002:a63:6e04:: with SMTP id j4mr1102306pgc.175.1580333642145;
        Wed, 29 Jan 2020 13:34:02 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id r8sm3534839pjo.22.2020.01.29.13.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 13:34:01 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:34:00 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/8] arm64: dts: qcom: sc7180: Add generic QUSB2 V2
 Phy compatible
Message-ID: <20200129213400.GI71044@google.com>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-7-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580305919-30946-7-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:21:57PM +0530, Sandeep Maheswaram wrote:
> Use generic QUSB2 V2 Phy configuration for SC7180.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 8011c5f..0d6761b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1052,7 +1052,7 @@
>  		};
>  
>  		usb_1_hsphy: phy@88e3000 {
> -			compatible = "qcom,sc7180-qusb2-phy";
> +			compatible = "qcom,sc7180-qusb2-phy", "qcom,qusb2-v2-phy";
>  			reg = <0 0x088e3000 0 0x400>;
>  			status = "disabled";
>  			#phy-cells = <0>;

FWIW

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
