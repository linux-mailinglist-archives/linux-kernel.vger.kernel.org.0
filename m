Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7E12226C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 04:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLQDNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 22:13:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42116 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfLQDNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:13:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so4833631pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4oCars6htsjDIivev3kVlgBR3qq7dsiX6LzpBLkVIbM=;
        b=QAX4xsq2S1BktlwSuGiJn3gL6/At0VvBmsRG5xrDdgl67CULQ6qLGGcXhU2M0ercCk
         UWKyZacN4Rs0TCDJgXak8zMhaUxYjwDe7I2+xfihzZNQllNhLwjPgf+NIciMGQZ9HByi
         eCdqXPRgd1BYqMbvZl/PVFNoydTQq+jC+GTZqbivh0UbgYr4D90zqHZxgsTbpAwzbMoc
         7Zv0A/RTcepjE58xf9kDQntZDYvraJuFqP/CTcuHVVLUgKwBS0+iIC5KMkCeV+WfX5M6
         +OcQyYUAoJj33zAfwZ7Yja0gvLlU41+YOG6M+ufTCiu/WZRNVIUmeeLC9AhAITuc6AUp
         QkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4oCars6htsjDIivev3kVlgBR3qq7dsiX6LzpBLkVIbM=;
        b=EX/rmLHhkMsdd4PxOcsR8Hvo56ZIp5FwCOYk6qC9sNb9ooQ0uzJ8mDFnNUH6lqTyZ2
         HdMDQodS5VT+01iwTG2/rb98jya53XFd6xbXGZl08zZsxYEiUxBG91QFYC+b+PFLzXF8
         ur6S6HHqZbBz9IU/u1lk1QGxfmqCx3pE/gYqGNjfzny/1XfEMpQHhOMqnwggd69eimxO
         f4Q0LWopTLCPCGuVXanmiiLAPw0vSzl0cA/0A/VZgXXNLcmbWy+FDWN0dzZovZ2qi1l2
         dPDsQUoq55JpdHxWUtnsnM09hrDeXsLtfdgyztT9dGjzBpV/sys01mWP2clzAFEM5NBZ
         QBpQ==
X-Gm-Message-State: APjAAAWA4seEtJN1Cw6e+RW+grg4bdUtVlIW5TMB0s9FPAPz3IJ2aVaT
        mT+NPiuVu1jWLFHhjYKsZBDp74wu8u4=
X-Google-Smtp-Source: APXvYqzk0TvtEU++UOwgz0cHuxD//bj50tRNV/OW2jkYEz7KglC66F5Mrzzfzh/mP/jSKBJPblcktw==
X-Received: by 2002:aa7:946a:: with SMTP id t10mr2373585pfq.165.1576552416213;
        Mon, 16 Dec 2019 19:13:36 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v16sm23894522pfn.77.2019.12.16.19.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:13:35 -0800 (PST)
Date:   Mon, 16 Dec 2019 19:13:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-cheza: Add cr50 spi node
Message-ID: <20191217031333.GU3143381@builder>
References: <20191216234204.190769-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216234204.190769-1-swboyd@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Dec 15:42 PST 2019, Stephen Boyd wrote:

> Add the cr50 device to the spi controller it is attached to. This
> enables /dev/tpm0 and some login things on Cheza.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied

Thanks,
Bjorn

> ---
> 
> Changes from v1:
> 
>  - Fixed node name to be tpm
> 
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index 9a4ff57fc877..b59cfd73616f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -651,6 +651,20 @@ &spi0 {
>  	status = "okay";
>  };
>  
> +&spi5 {
> +	status = "okay";
> +
> +	tpm@0 {
> +		compatible = "google,cr50";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&h1_ap_int_odl>;
> +		spi-max-frequency = <800000>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <129 IRQ_TYPE_EDGE_RISING>;
> +	};
> +};
> +
>  &spi10 {
>  	status = "okay";
>  
> -- 
> Sent by a computer, using git, on the internet
> 
