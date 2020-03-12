Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96421827F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 05:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbgCLEuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 00:50:17 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53824 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgCLEuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:50:17 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so2021625pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 21:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Huysc9k69DOetuyPT37xPzZ+YLOLRqnJ/FtV19WEDc=;
        b=u05buOnhB2ZaHjx7I2VFVZdDS3meih0mc6WZaP2ubEFIX5IRV5PakdbMoocuP1aMet
         136201rU4y6u8Z/BRJWEayhmgq6izg7StoG+xiBHPWeICaxzekOrFwczJDFN37vhaqhG
         1kw58XU/mfyf4/4oZnJjk92aE03UU/a077dE71+PFVLVGLx6/iA3tlkGQl5FIdnhviBh
         3XsuPkEDF8xtLyCuU6ZrY2qrQhM265xHA2AbYFz8FY43oNPUUHgB4+ccFwqE47xUd2S6
         W4eYzRJufanpih+BqCLI38xka2OLJnMdlWxDNUS1RZnkjiP6U9kMQyeitCgIeZxffQ0S
         Klvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Huysc9k69DOetuyPT37xPzZ+YLOLRqnJ/FtV19WEDc=;
        b=JZANxgXoIF7Y7eu6tQkr9XSo1NAMGPzGbH/E80ThO+M6cZxrGJihVTsf9WulSE3eg4
         JC1YF+Ubn7PqjhFISGAB68cmVgSdGpPmkoUUQiyCI0ZUD9lpP3c9HtwQ26mLLmZhs1Mi
         szV377N7k3Pg9fIqn3f6pmb9B4FI5CGXemKWppHeeb/XYicW9XAR/Vr7UGMBtLYeP6UY
         MDqIEF/6jDm0yLcMMPgVMhEnGdRHdKSGrY2V3yOTwAePcnFz5y+blTzRoIyWDRmxmBNZ
         HdVbQdfGAxABgcE5sn/r8m2eG4mF425v1kJykCN5Kwit9ldwiTqqCJ1LnBxfGyHSXvDd
         tb/A==
X-Gm-Message-State: ANhLgQ2czBTkQtSM3tAnOSfeXV40R7M1y2PO/f8+NCXPnMaaoS3xGzXH
        ETsaXuPrtUM+wZDLQqmh28kpnw==
X-Google-Smtp-Source: ADFU+vtQv6XCgFYw5CWT4cXp6fyTARSMSkMReQUHbK2N7f/ufSK/IBPreQ4I9vHrUgXhd7/6d78Hww==
X-Received: by 2002:a17:902:7c0d:: with SMTP id x13mr6162264pll.93.1583988615935;
        Wed, 11 Mar 2020 21:50:15 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q12sm52827529pfh.158.2020.03.11.21.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 21:50:15 -0700 (PDT)
Date:   Wed, 11 Mar 2020 21:50:12 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        olof@lixom.net, Anson.Huang@nxp.com, maxime@cerno.tech,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [v1 1/6] arm64: dts: msm8916: Add i2c-qcom-cci node
Message-ID: <20200312045012.GT264362@yoga>
References: <20200311123501.18202-1-robert.foss@linaro.org>
 <20200311123501.18202-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123501.18202-2-robert.foss@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 Mar 05:34 PDT 2020, Robert Foss wrote:

> From: Loic Poulain <loic.poulain@linaro.org>
> 
> The msm8916 CCI controller provides one CCI/I2C bus.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 9f31064f2374..afe1d73e5cd3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1503,6 +1503,33 @@
>  			};
>  		};
>  
> +		cci@1b0c000 {

This deserves a label, so that it's possible to reference it and alter
the status in the board dts.

> +			compatible = "qcom,msm8916-cci";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x1b0c000 0x1000>;

Please sort nodes my address (and then by name).

Apart from these two nits, this looks good.

Regards,
Bjorn

> +			interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
> +				<&gcc GCC_CAMSS_CCI_AHB_CLK>,
> +				<&gcc GCC_CAMSS_CCI_CLK>,
> +				<&gcc GCC_CAMSS_AHB_CLK>;
> +			clock-names = "camss_top_ahb", "cci_ahb",
> +				      "cci", "camss_ahb";
> +			assigned-clocks = <&gcc GCC_CAMSS_CCI_AHB_CLK>,
> +					  <&gcc GCC_CAMSS_CCI_CLK>;
> +			assigned-clock-rates = <80000000>, <19200000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&cci0_default>;
> +			status = "disabled";
> +
> +			cci0: i2c-bus@0 {
> +				reg = <0>;
> +				clock-frequency = <400000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		camss: camss@1b00000 {
>  			compatible = "qcom,msm8916-camss";
>  			reg = <0x1b0ac00 0x200>,
> -- 
> 2.20.1
> 
