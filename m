Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4ACC196195
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 00:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgC0XAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 19:00:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35021 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgC0XAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:00:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id k5so3093299pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JqIenWZwZuZZwflrKOCXfVDSGSS9yHIiXPKhRDM0rfQ=;
        b=mb55dYBPoAEXndrnw3TFFXmQdpaONNEY0CTwf+ofOSZLOYI3t8q0fJSTRQvNHhrFPF
         VFal9j5aj/Kdk1/7t20ftZGZTGKK/RH9u5mAVruZGe3lwx+LK+unHW5qyNUkL31YMwuR
         3Pvz+SOf8BOMkjM5+JGE1CtZHVNUwroi01M/5qLddUPeyiKWNWp/DI2Dj1jdLLYisRqm
         Far7EiRWmErWyTiiPJchgvc+qJoxX+RMwYQ4q9XXpozlloKysBoK7S/Preg9Bbr4/Q+z
         uNK8Lc+EojNptOWgffWP8RxWA0SXCH27LBT50EUN6pCMyWC5RNAF+Mo8j55bm3Uc8sMz
         3IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JqIenWZwZuZZwflrKOCXfVDSGSS9yHIiXPKhRDM0rfQ=;
        b=fPiBRJq0p4iOKUvjDOE4iNEODxIn32Ieik7f4AJ0vtBbD9QnScc3+Y3AsGw8vW2GRv
         E9X5GmvhOis8nfkQuM8TI45eenyAQSA6/lWQ446+xHHmLPaSPsaN6Ivd20QuevDiXWRi
         vOFquVXbL8IPFECgIGUyh82u51ULM2WiJWvuF+w3zXbWRo8XVZ0kvCiXiJ/mvalslLkk
         O5nu/S2iVgGLt3LRbb+gEBmXgZGpBBT/3lj2DzCbGi2XMSYHPCZ9Zv5EEkwmW2RzE4GG
         lyndoxO894O7IuFn+QkTa/O0PJqSDp2T6IzTv0MNQjkR5IrCJKkgKo2o9eK5jWjJzUEm
         3k5A==
X-Gm-Message-State: ANhLgQ3F71pCZneR9otzKNVvvgTGwoTahJfUPPpr/uc0B/HFI95l7H2E
        ViNAINB7PS7O7sDog/6J+UZlMg==
X-Google-Smtp-Source: ADFU+vsHwqLL5TtFqgU4KcqOiYr0XygvoaMkIOSpnKmIG6QUfqJWOKbXb+1ATrf6wNyFpl4jFtlJ2w==
X-Received: by 2002:a62:a512:: with SMTP id v18mr1478997pfm.306.1585350028760;
        Fri, 27 Mar 2020 16:00:28 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b25sm4862093pfp.201.2020.03.27.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 16:00:27 -0700 (PDT)
Date:   Fri, 27 Mar 2020 16:00:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
Message-ID: <20200327230025.GJ5063@builder>
References: <1585219723-28323-1-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585219723-28323-1-git-send-email-pillair@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Mar 03:48 PDT 2020, Rakesh Pillai wrote:

> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> 
> Depends on https://patchwork.kernel.org/patch/11455345/
> The above patch adds the dt-bindings for wifi-firmware
> subnode
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 27 +++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 043c9b9..a6168a4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -327,6 +327,14 @@
>  	};
>  };
>  
> +&wifi {
> +	status = "okay";
> +	qcom,msa-fixed-perm;
> +	wifi-firmware {
> +		iommus = <&apps_smmu 0xc2 0x1>;

How is sc7180 different from sdm845, where the iommus property goes
directly in the &wifi node?

Regards,
Bjorn

> +	};
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
>  &qspi_clk {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 998f101..2745128 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -83,6 +83,11 @@
>  			reg = <0 0x8f600000 0 0x500000>;
>  			no-map;
>  		};
> +
> +		wlan_fw_mem: memory@94104000 {
> +			reg = <0 0x94104000 0 0x200000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> @@ -835,6 +840,28 @@
>  			};
>  		};
>  
> +		wifi: wifi@18800000 {
> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0 0x18800000 0 0x800000>;
> +			reg-names = "membase";
> +			iommus = <&apps_smmu 0xc0 0x1>;
> +			interrupts =
> +				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH /* CE0 */ >,
> +				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH /* CE1 */ >,
> +				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH /* CE2 */ >,
> +				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH /* CE3 */ >,
> +				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH /* CE4 */ >,
> +				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH /* CE5 */ >,
> +				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH /* CE6 */ >,
> +				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH /* CE7 */ >,
> +				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH /* CE8 */ >,
> +				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH /* CE9 */ >,
> +				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10 */>,
> +				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11 */>;
> +			memory-region = <&wlan_fw_mem>;
> +			status = "disabled";
> +		};
> +
>  		config_noc: interconnect@1500000 {
>  			compatible = "qcom,sc7180-config-noc";
>  			reg = <0 0x01500000 0 0x28000>;
> -- 
> 2.7.4
