Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE6A19B72E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbgDAUlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 16:41:19 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34961 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732737AbgDAUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:41:18 -0400
Received: by mail-pj1-f66.google.com with SMTP id g9so589944pjp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zFP2MmEh+fFQszCsXSQY0ldP1U7Kx8dHPHKr9P/7iew=;
        b=fPxTEVFSZHusXbeYgo0DRZTeCJp4bRLu6bZ/SGBluaqbz9og1z6nGehIiTjPxXSWC7
         7XXKEc83C13IFBptDr+ZqsLS6/yvTM0tHmg7LbQnog3GlMw5pn0R/aBIgaifX2RxWAvh
         NpqU2CLiUNC4FY2/d7FD3cmAXDu3Ck2nG0fcRyWy2LbJ5afHFwmd06gN6U581bUrthVk
         nEFVgQms+XDfcztVX8JUlOAKbHf0EvNckanMnwF17//lXE391eKTb5W52IKB1JlXevhU
         Ost7smm2vqyI9EryPdUv7MN5Kio8SpShtqi6RS1OkZ3129TVhVhdXtb4K13VAp8+50k4
         p45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFP2MmEh+fFQszCsXSQY0ldP1U7Kx8dHPHKr9P/7iew=;
        b=FMyGnEDVMadQjMmh+84lofruJ/JmlmQ+5TNX/ICdYaU3ocUFJIrWZwu/DGrI0pLgk2
         vObMIIFU7ki6vXR5ghxO9C63HO2LtF/NuwSKx9ctj28q0zZkNXbDp6yJ+BmjJmmkvFqo
         pnbtrJRJW5AXcglgSuHvw6rMZkuqA7TYRuyAxzn/KhtvC2UF8IYvzsLineHGLERjZJiC
         OZcQOK7owLIHsck7hPWKts4WaUWlS+0HU6zUu5hMmXHHaMocu+faec+HZ8+D6VtKA1GO
         uRogzelYm58Di3mdIzRAGq7ufj+7JYr8RQD/vPBCXdQ1DWo1mc7PblVLVbCORNRrrGr1
         pfXA==
X-Gm-Message-State: ANhLgQ1k+FMwLLf3yLuu2LSLdlAw2KTI8CpjMPMm9HJodP4nSVLoad1E
        TODxP0nsLDX0HVmGuO0ndpcCUw==
X-Google-Smtp-Source: ADFU+vtg2CznCLVwLCjsJxBM1gHwJDG488+MlRww+/0POpTMqwyeJXyuNMv9f4yNYHBNsJiDCllfBA==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr23691174plt.184.1585773676926;
        Wed, 01 Apr 2020 13:41:16 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id nl7sm2408552pjb.36.2020.04.01.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:41:16 -0700 (PDT)
Date:   Wed, 1 Apr 2020 13:41:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] devicetree: bindings: pci: add phy-tx0-term-offset
 to qcom,pcie
Message-ID: <20200401204113.GH254911@minitux>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-8-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-8-ansuelsmth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Mar 11:34 PDT 2020, Ansuel Smith wrote:

> Document phy-tx0-term-offset propriety to qcom pcie driver
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 6efcef040741..8c1d014f37b0 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -254,6 +254,12 @@
>  			- "perst-gpios"	PCIe endpoint reset signal line
>  			- "wake-gpios"	PCIe endpoint wake signal line
>  
> +- phy-tx0-term-offset:

If I understand your implementation correctly this difference in
hardware revision should be encoded in the compatible string.

Regards,
Bjorn

> +	Usage: optional
> +	Value type: <u32>
> +	Definition: If not defined is 0. In ipq806x is set to 7. In newer
> +				revision (v2.0) the offset is zero.
> +
>  * Example for ipq/apq8064
>  	pcie@1b500000 {
>  		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
> @@ -293,6 +299,7 @@
>  		reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
>  		pinctrl-0 = <&pcie_pins_default>;
>  		pinctrl-names = "default";
> +		phy-tx0-term-offset = <7>;
>  	};
>  
>  * Example for apq8084
> -- 
> 2.25.1
> 
