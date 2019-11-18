Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F53100DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 22:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKRVc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 16:32:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39707 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:32:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so16801664oif.6;
        Mon, 18 Nov 2019 13:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gNao6bjSYC1WxI91s+ikl6/okUQ4D7/7Wn4Hq9wK5g=;
        b=IAWdKLcSzzYuSez9v0EmP9i5q7OPwG/p9fK0/iggVlLfKmuQWUqttAOiTfq27VlZyc
         WkE6tJ8/PI3+cV8uivg30e9L37vpg9BF22koQNliYKyFZPbaNCQfc9H/Yq/eNLR/5yIu
         GRRDWTn3N7vgL7cyaS0MuJFF6cCfDVOtvSUWqQNjwmOtzRMueI7MokAea6l+56x3n3+c
         BIS1ZLII1NmpfbGvsGFs89iJDu0bx84za3VjH63F3TtYXcpQuwccybjALGwE7X2S6uFi
         93evyCG+ZjNNNDUKu7reGhlwIuwKRKX8LQjVN73KgT4HexmO+KW4ZGBiO0TKoXGYHYA6
         21ow==
X-Gm-Message-State: APjAAAVatHRPohbeknaNHpA8VzoGBs9HWWYHUKr7+0psn0LCv6ujGBqj
        aAGWhwPrUAIDeKmy+E/A6g==
X-Google-Smtp-Source: APXvYqx1RtTBrYQED9QhIjvirrPV/a4JBKzhJx9hGC6wh4UxphAZLwpmJqsB1gKcOe+gKsus8SwRxw==
X-Received: by 2002:aca:d610:: with SMTP id n16mr955357oig.64.1574112778145;
        Mon, 18 Nov 2019 13:32:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b12sm6586756otl.34.2019.11.18.13.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:32:57 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:32:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bindings: sound: pcm3168a: Document optional RST gpio
Message-ID: <20191118213256.GA27262@bogus>
References: <20191113124734.27984-1-peter.ujfalusi@ti.com>
 <20191113124734.27984-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113124734.27984-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:47:33PM +0200, Peter Ujfalusi wrote:
> On boards where the RST line is not pulled up, but it is connected to a
> GPIO line this property must present in order to be able to enable the
> codec.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/sound/ti,pcm3168a.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
> index 5d9cb84c661d..f30aebc7603a 100644
> --- a/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
> +++ b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
> @@ -25,6 +25,12 @@ Required properties:
>  
>  For required properties on SPI/I2C, consult SPI/I2C device tree documentation
>  
> +Optional properties:
> +
> +  - rst-gpios : Optional RST gpio line for the codec
> +		RST = low: device power-down
> +		RST = high: device is enabled

'reset-gpios' is the standard naming for reset lines.

> +
>  Examples:
>  
>  i2c0: i2c0@0 {
> @@ -34,6 +40,7 @@ i2c0: i2c0@0 {
>  	pcm3168a: audio-codec@44 {
>  		compatible = "ti,pcm3168a";
>  		reg = <0x44>;
> +		rst-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
>  		clocks = <&clk_core CLK_AUDIO>;
>  		clock-names = "scki";
>  		VDD1-supply = <&supply3v3>;
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
