Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34919A159
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbgCaVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:55:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45386 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbgCaVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:54:59 -0400
Received: by mail-io1-f65.google.com with SMTP id y14so6349092iol.12;
        Tue, 31 Mar 2020 14:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11pFjDa/Z9YxdK11hpWSqQAE1GxHCAeolDe4bFA2Hvw=;
        b=GaeVOxzaGhJ0zKgsuW6cxVVZTO/OGFp+T9DBmQ9pNJzuUwH+W0YbzroWFwV6AxMlcJ
         fA1MGpvkWe4sZ0Al6DAs9Q858VIYBJrk2r4+s9Y40xHHh7ZTWgmEEgmYOOGY9yQ71WYO
         o4QhyuP4YHBslYoc1Z4ORsgQ+o5ciKR+TPRiLAdPaXV+JBh/9nbPkzvyUsBomm9DSLjY
         fxXtkAbPHv9j3AgNnTsKKLufSRFHybphO2jSWUcNre1NIuwTl7tRSxBQ+swxefF7HVN2
         kcE0y65TD7/88agGLx4ndsDKopJMM1pAFf1w/FocjkFusCUWnConwBf+j3KOelNbiAG5
         7NXg==
X-Gm-Message-State: ANhLgQ1e2nBd70IQLiiUJWS0C4LdjoC4WlaDTtM5Mfzi82aTQoYcHuGd
        SQSigVd48xrxtnjKiGnwxg==
X-Google-Smtp-Source: ADFU+vupLX8M6U2FZmDT40jwK+DGW65CRtTxIt40vQQvbEj5lptgfL6vlhVc89Nm4mf08y9N6gacyg==
X-Received: by 2002:a6b:580d:: with SMTP id m13mr17554237iob.59.1585691698738;
        Tue, 31 Mar 2020 14:54:58 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l14sm36289ioj.22.2020.03.31.14.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:54:58 -0700 (PDT)
Received: (nullmailer pid 7976 invoked by uid 1000);
        Tue, 31 Mar 2020 21:54:56 -0000
Date:   Tue, 31 Mar 2020 15:54:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 02/13] Documentation: mfd: Add DT bindings for i.MX
 Audiomix
Message-ID: <20200331215456.GA656@bogus>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
 <1585150731-3354-3-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585150731-3354-3-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 05:38:40PM +0200, Abel Vesa wrote:
> The i.MX Audiomix is a mix of clock gates, reset bits
> and some other i.MX audio specific functionalities.
> Add information for the MFD, its clock and reset controllers.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../devicetree/bindings/mfd/fsl,imx-audiomix.txt   | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt

Please use DT schema format.
 
> diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt b/Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt
> new file mode 100644
> index 00000000..1622818
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fsl,imx-audiomix.txt
> @@ -0,0 +1,34 @@
> +Freescale i.MX Audiomix
> +======================================
> +
> +Audiomix is a conglomerate of different functionalities.
> +
> +Required properties:
> +- compatible: Should be "fsl,<chip>-mix" for the MFD device
> +	Should be"fsl,<chip>-audiomix-clk" for the clock controller
> +	Should be"fsl,<chip>-audiomix-reset" for the reset controller
> +	Some functionalities of the audiomix will be registered as syscon.
> +- reg: should be register base and length as documented in the
> +  datasheet
> +
> +example:
> +	audiomix: audiomix@30e20000 {
> +		compatible = "fsl,imx8mp-mix";
> +		reg = <0x30e20000 0x10000>;
> +
> +		audiomix_clk: clock-controller {
> +			compatible = "fsl,imx8mp-audiomix-clk";
> +			#clock-cells = <1>;
> +			clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
> +				 <&clk IMX8MP_CLK_AUDIO_AHB>,
> +				 <&clk IMX8MP_CLK_AUDIO_AXI_DIV>;

None of these clocks are needed for the other functions in this MFD.

I'm not all that convinced that these child nodes are needed. A single 
node can be a clock and reset provider. If you have other things to add 
to the binding, do so now even if you don't have driver support.

> +			clock-names = "audio_root",
> +				      "audio_ahb",
> +				      "audio_axi_div";
> +		};
> +
> +		audiomix_reset: reset-controller {
> +			compatible = "fsl,imx8mp-audiomix-reset";
> +			#reset-cells = <1>;
> +		};
> +	};
> -- 
> 2.7.4
> 
