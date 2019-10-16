Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB1D97EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406507AbfJPQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 12:52:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32928 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfJPQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:52:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so15103480pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DWB28C23b4LvznGkG5ZeUrO8QaxjHT8svafhe7nPaII=;
        b=Fqt4lOhAUnwSxBzgtRVB2hal9xbqZxbyM6Sh7YLtYAQ9a9+L1sF3rBWAwWldX6BbAQ
         VmNZDebEzUpKD+9uXmhyU0PPgZ6oJfmecVjpa/valJuWqzb+mdfzfZ2XUaW5tb/5ENrF
         99RIBdhdicBLu2QI3kdHUbBJWeP+6N1sm+ximgH1b6AXpqq9zjtYzFMRLExakZJoTpMc
         /G9oUKnLPTI9a/+cESsKQS8dNxahHXoQfwlDF5IcgIaWK6DcWrG5b1tG+vZsV7N+L6Nv
         JtwEnkf/v8cm4HjNLyZK0UyY31vIdn4JBCyP7yMFIbLXqMyo2Zwc9yddVNtO5FnFhdOD
         J5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DWB28C23b4LvznGkG5ZeUrO8QaxjHT8svafhe7nPaII=;
        b=HWnSRsUzi5eHdOWsq5PMlbqNYtm0jjHYacCd2i/J4FTEF84sy3Fku489kGJB1Pn9s2
         7C3/atH0LG3e4SsuHBBigQqQpLz+qzBUDjJReYdcaVkJHnU/NAbvEgq1KDVa6W6cmmDJ
         3FhdClde3In76OxnP1uPpQP08dQmXY1htWDBM8dlX54iL1WgWcJKBeS+r0Nqm7FwkZNI
         ns5yzHqt6rTuvZ1GRFc/5B/KWCMOCiQI53604I+gTvk5KgTqlh7c6K0izPXROVpmSKfr
         Q/+hgZupNwIOHZe6L/XIuxvBVwYYpvnqrCeH1s08isWSi+y65+2yAK9eS3kmMMP1sRVD
         eJIw==
X-Gm-Message-State: APjAAAUICfXW35lQSE9Vd0dy6zrSRA9dxrA17f8Qz6Oa5bl3RZnFpOoH
        nSLYBAdcI0LppjMrFPXJcBxduA==
X-Google-Smtp-Source: APXvYqwEa5xX0UPGLDw3yx5YgchQI4Nl9Up2L3YAU98vchmqR+FbNObjPraFt55twMf+r/Me6ucjtQ==
X-Received: by 2002:a17:90a:3628:: with SMTP id s37mr6287710pjb.38.1571244763750;
        Wed, 16 Oct 2019 09:52:43 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id u13sm21952806pgk.88.2019.10.16.09.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:52:43 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, mark.rutland@arm.com,
        robh+dt@kernel.org, martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v2 4/4] ARM64: dts: amlogic: adds crypto hardware node
In-Reply-To: <1571031104-6880-5-git-send-email-clabbe@baylibre.com>
References: <1571031104-6880-1-git-send-email-clabbe@baylibre.com> <1571031104-6880-5-git-send-email-clabbe@baylibre.com>
Date:   Wed, 16 Oct 2019 09:52:42 -0700
Message-ID: <7hk194fx9h.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corentin Labbe <clabbe@baylibre.com> writes:

> This patch adds the GXL crypto hardware node for all GXL SoCs.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index 49ff0a7d0210..ed33d8efaf62 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -36,6 +36,16 @@
>  				phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>;
>  			};
>  		};
> +
> +		crypto: crypto@c883e000 {
> +			compatible = "amlogic,gxl-crypto";
> +			reg = <0x0 0xc883e000 0x0 0x36>;
> +			interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&clkc CLKID_BLKMV>;
> +			clock-names = "blkmv";
> +			status = "okay";
> +		};

Looks good.

I'll apply this via the amlogic tree as soon as Herbet applies the
driver part.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin

