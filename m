Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8CC01DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 11:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfI0JKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 05:10:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50510 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfI0JKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:10:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so5738170wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j7PsqOo3VNEELHLNUHE9shovLJXO6eMA+Y/LMPEsZ8U=;
        b=TXXjl9eXRA+ejFeIO9IfkqxgAqeo1WFANLgur0I7Ihn93hfDaNeqd6r9k6n/sVoas6
         VriraTfnVgA8DY7phuKRB9pG57kLlhVheW/xSB/Ftc6EFdDQC8Yrj2m1M9Yl1zMI6aVk
         7wzOFE2LiBaql6gR9ogUOfpqRhrRAt3ggW8w5l1GaXR4lzsktDM4RJ1QV3rDpmfsL1Lf
         H8SSZR8RD7GAcBnGGd3nbsRpqsPIIEJzFo7NaJNpwHM3PwsaninDVcEaBQZj9u+T/8LR
         Rr4GGNFgd6zQrrqXpOUw9N83fEjZk+a3SzU0pnAUjRurHAFyOCmnCAxVb9P/9JL8v62k
         gFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j7PsqOo3VNEELHLNUHE9shovLJXO6eMA+Y/LMPEsZ8U=;
        b=LWSh+1nhVg7H60bJxkJ6BvAaNbsoOZiROGkkjjrPo128DNIMiKtY47HbQ5rZlw8nHz
         tOOS91wievMIrFvRPEEawHicfAUcLvtCSZ0EkFl/3MAlbV3Fs+iX8XELWKaW4FlJsXXz
         f5IO1JAWXynirgE46XeFI46aFhfgxhlc6NHzdglLWxY67fs2G9k/WVvdY7FACEC7I69O
         wlv5WAe3jtomfpmwFQGgB0yB9WW3mvBJr/u32Khqjf0i/YRNfJLOj9cGUM4KtjtdFC76
         UYGQJgfGMYE2D1qOp+MbUhfxFPbtzu04+treaF4LnrhGAWF/T3MnsmhwSe1tkvmpN6He
         1imQ==
X-Gm-Message-State: APjAAAWEHboOEjl2T7LjLA1sMOjJBe6WLV1l9R3E43OpH91s3YJUA6k2
        Ks0OhjH2rvoIdb7rNlokI96OICVJUZJG3A==
X-Google-Smtp-Source: APXvYqz4e29c2d4K1B5dIoapU06tbDMzOKvXGkPrfM7nNq0Jm4rov4dqQ+2k3Qbx7s91L8fCD/34AA==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr6211927wma.91.1569575406927;
        Fri, 27 Sep 2019 02:10:06 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id g185sm11473915wme.10.2019.09.27.02.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 02:10:06 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: clk: axg-audio: add sm1 bindings
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190924153356.24103-1-jbrunet@baylibre.com>
 <20190924153356.24103-2-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6331eea0-5f66-95d8-7a88-81d3588a21ba@baylibre.com>
Date:   Fri, 27 Sep 2019 11:10:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153356.24103-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2019 17:33, Jerome Brunet wrote:
> Add the compatible and clock ids of the sm1 audio clock controller
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/clock/amlogic,axg-audio-clkc.txt          |  3 ++-
>  include/dt-bindings/clock/axg-audio-clkc.h             | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> index b3957d10d241..3a8948c04bc9 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> @@ -7,7 +7,8 @@ devices.
>  Required Properties:
>  
>  - compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D,
> -		  "amlogic,g12a-audio-clkc" for G12A.
> +		  "amlogic,g12a-audio-clkc" for G12A,
> +		  "amlogic,sm1-audio-clkc" for S905X3.
>  - reg		: physical base address of the clock controller and length of
>  		  memory mapped region.
>  - clocks	: a list of phandle + clock-specifier pairs for the clocks listed
> diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
> index 75901c636893..f561f5c5ef8f 100644
> --- a/include/dt-bindings/clock/axg-audio-clkc.h
> +++ b/include/dt-bindings/clock/axg-audio-clkc.h
> @@ -80,5 +80,15 @@
>  #define AUD_CLKID_TDM_SCLK_PAD0		160
>  #define AUD_CLKID_TDM_SCLK_PAD1		161
>  #define AUD_CLKID_TDM_SCLK_PAD2		162
> +#define AUD_CLKID_TOP			163
> +#define AUD_CLKID_TORAM			164
> +#define AUD_CLKID_EQDRC			165
> +#define AUD_CLKID_RESAMPLE_B		166
> +#define AUD_CLKID_TOVAD			167
> +#define AUD_CLKID_LOCKER		168
> +#define AUD_CLKID_SPDIFIN_LB		169
> +#define AUD_CLKID_FRDDR_D		170
> +#define AUD_CLKID_TODDR_D		171
> +#define AUD_CLKID_LOOPBACK_B		172
>  
>  #endif /* __AXG_AUDIO_CLKC_BINDINGS_H */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
