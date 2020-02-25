Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E93216ED43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 18:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgBYR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 12:57:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35893 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgBYR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:57:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id j20so371568otq.3;
        Tue, 25 Feb 2020 09:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=122VamsU2CoI60mTYn2qsd+kIcsNIFVhMCViO2v3gAk=;
        b=fikrckJzIOm+2fBphtK8tDs13AaqRDplWbRlfp0ZUf9dc9pOwtDDljuE7L3B55F6dF
         GoNHVYIDc9ROQLEgAVXuFsa3XPMTfO8sIZc9PEV5gfy6XnvvDApF6mSD1p5t8p2LQO27
         XF6yEE1JEgOh44NW5ujASEpuvU5XMRmJrHQvmT6bTwKibwFAqaC2aHP3ZuXfbCFI/4et
         +EjVGwXeF6MAorJT5B1dXR1ct+SmVoEnssysMgUs+ucRKHcCGkw/nyakb8hc7/fVO9/v
         yNtvfLnPuNGqM5sqkLTFWof76QWvg5jJjGGyAimyw5I4YCIykHrzwiZ97YOfMQn+Zfp0
         550Q==
X-Gm-Message-State: APjAAAWFfEKwHhcj5mt2uFEsSCO/ChQA2lzOyGB/ozTdSBvnk0IXtHXp
        +ltvtYy+TivyPMjeF0XiQA==
X-Google-Smtp-Source: APXvYqwr8YyrYpTEaCbgBtAfIoyDJZUv/EYMnIH/R2mEqcnJjcRa6HdAJAElyOXU7kIpiPtypH3jXg==
X-Received: by 2002:a9d:6c8d:: with SMTP id c13mr46458916otr.277.1582653456886;
        Tue, 25 Feb 2020 09:57:36 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm5930770otp.14.2020.02.25.09.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:57:36 -0800 (PST)
Received: (nullmailer pid 6790 invoked by uid 1000);
        Tue, 25 Feb 2020 17:57:35 -0000
Date:   Tue, 25 Feb 2020 11:57:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        aisheng.dong@nxp.com, peng.fan@nxp.com, fugang.duan@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clk: imx8: Add SCU and LPCG clocks for I2C in CM40 SS
Message-ID: <20200225175735.GA5232@bogus>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
 <1581909561-12058-3-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581909561-12058-3-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:19:16AM +0800, Joakim Zhang wrote:
> Add SCU and LPCG clocks for I2C in CM40 SS.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  include/dt-bindings/clock/imx8-clock.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
> index 673a8c662340..84a442be700f 100644
> --- a/include/dt-bindings/clock/imx8-clock.h
> +++ b/include/dt-bindings/clock/imx8-clock.h
> @@ -131,7 +131,12 @@
>  #define IMX_ADMA_PWM_CLK				188
>  #define IMX_ADMA_LCD_CLK				189
>  
> -#define IMX_SCU_CLK_END					190
> +/* CM40 SS */
> +#define IMX_CM40_IPG_CLK				200
> +#define IMX_CM40_I2C_CLK				205
> +
> +#define IMX_SCU_CLK_END					220

Why are you skipping numbers?

> +
>  
>  /* LPCG clocks */
>  
> @@ -290,4 +295,10 @@
>  
>  #define IMX_ADMA_LPCG_CLK_END				45
>  
> +/* CM40 SS LPCG */
> +#define IMX_CM40_LPCG_I2C_IPG_CLK			0
> +#define IMX_CM40_LPCG_I2C_CLK				1
> +
> +#define IMX_CM40_LPCG_CLK_END				2
> +
>  #endif /* __DT_BINDINGS_CLOCK_IMX_H */
> -- 
> 2.17.1
> 
