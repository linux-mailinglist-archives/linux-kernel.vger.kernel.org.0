Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3612D187
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfL3PiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 10:38:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfL3PiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 10:38:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so32937809edv.2;
        Mon, 30 Dec 2019 07:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+fvXg7v5gstlV7QHJfLUPtEMEaeWdFQQ5WmiP5N1uk=;
        b=IpW2WB6m9qxouJ5IGy4b1DkSfOQ1rR0UoptuUwpgDinShNusMrKuiwTjRvzjNT0RBz
         /Ht1m2RZ8WyunkhQOfMev8ndnEGxoCo+W2T9uY4K7gZ7yIQcN+C1BfFxHD3QqdkEgqqM
         kpAmEdwsrz9O7TbaFsnqSWiVPCTZ/zU3Zi0ncyp9EfkqKJaJHRxHfX2fx6CSCpKUhuKZ
         +zT/fXLjSYmJm8cDaw5h7G5uVDKKROq8ARGo+ffyHcuOIxz7CMw4T+/PHbu/DTiEHG8i
         1qCOUF8AYt4CL2aiWA/4i35+mcl2BcJsFc4JvoNQcbPnTbvULRIL1w4ZZIf0yzqYyGNT
         3/iQ==
X-Gm-Message-State: APjAAAXvwIiaxACY0l4ECtmf2+N2rcEu7tMSDyFO6s43ZTMv7LSAIfsX
        dwcJAsMUT+70XIfNi+bZnec=
X-Google-Smtp-Source: APXvYqy+53yBifFTLAmU8dsdQ8hL0cLkTBJ1uEgw7SYnSKdV/so5DE1tI+/hP+QWRy6KnJjmAet0wA==
X-Received: by 2002:a17:906:5448:: with SMTP id d8mr39256290ejp.254.1577720281504;
        Mon, 30 Dec 2019 07:38:01 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id s22sm2765324ejm.43.2019.12.30.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:38:00 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:37:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, m.szyprowski@samsung.com,
        amelie.delaunay@st.com
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: Remove unneeded "snps,dwc2"
 from hsotg node
Message-ID: <20191230153758.GB4918@pi3>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
 <20191219103536.25485-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219103536.25485-3-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:35:36AM +0100, Benjamin Gaignard wrote:
> Remove "snps,dwc2" from hsotg@12480000 node compatible list because
> "samsung,s3c6400-hsotg" should be enough.

The more detailed compatible is almost always "enough". Some other nodes
also have detailed+generic compatible. In this case there is a driver
matching "snps,dwc2" so why removing it?

Best regards,
Krzysztof

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index b016b0b68306..d4866269f4ee 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -362,7 +362,7 @@
>  		};
>  
>  		hsotg: hsotg@12480000 {
> -			compatible = "samsung,s3c6400-hsotg", "snps,dwc2";
> +			compatible = "samsung,s3c6400-hsotg";
>  			reg = <0x12480000 0x20000>;
>  			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&cmu CLK_USBOTG>;
> -- 
> 2.15.0
> 
