Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D279177949
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 15:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgCCOkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 09:40:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36073 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgCCOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:40:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id j16so4669991wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zk5za+61RSxflkNdYa9I8GQAUcmgHjNBAyo6vqaH8B8=;
        b=bivt2IP6TN5/8UtW4BAX7a6vrwLGm5DwRyjkTcZtpwNjOSV78Nd4DhDrTa7mn75Mbx
         r/+NkdRKxeUUAkAtj+J8PgW8BgwGq5yzJ3ug/NghJjrGAj0skoc21kBQZGoXLltgeiR3
         R59V/43H2FQGlrk227vuYLT0R8ey3MxVln1HVze4zisQKQ1ir+tyI2I8vkY6i2stEY2X
         f+bkESExadLVniTmO5CUyKHcx85xY5aeHtsQsnlHMiUQmzn7VM+vi7xdeOhK1Bnyx+OR
         wkIjr58ZAZwrU34ePKC8LAKjjH2gDmrofRvfACu+t5vuK95az3Ve/I/1XiPgNf2CimHu
         pzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zk5za+61RSxflkNdYa9I8GQAUcmgHjNBAyo6vqaH8B8=;
        b=XMCYgg58lp0XoN5czV4v+bTiLEGPNuvZX4nD0TLR+JqP3/p89hwUYWVBAd3eWl+X4y
         Iwvu2aZU+k/xT3TPstr3KLz/pVbwbEx33q9XLY3aA1MbZ2x+d5tjPnQ6fnys0m+UWdjo
         VKj/PX7dLRPIj/RCuw5V0FaRjDZSlxXTFEwu/CmsPyv05smM17szK4inH3fiphXfzdWq
         tD0GqCwGoyVArsOHxDkjN0RLt83WWv5EH4Vkpwkl34DxkcgLQ6ynce62b84ad/9VRQCc
         /R5nRvEzmAiVqWQa+ey7M8VzcUQethHIdevxV9sznKmx3/0wiuA8W2HYgccrk2Ep4lbN
         Yk0A==
X-Gm-Message-State: ANhLgQ0bZJwyHbxXJqbPBS1U3FBghXzI9k7rlmWuHSNBOCvPcrc3frXx
        5GokhuZiYqCrK1WcZEXqLOMELBZ50bkwpg==
X-Google-Smtp-Source: ADFU+vuryMlPi3WM/bqWph2/BYtP0gM1GlUsfdmEg1UPt9Wd+CCZ8Zn0dMF1hDDYb/sHE5NmscyJ9A==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr5560505wrn.140.1583246398142;
        Tue, 03 Mar 2020 06:39:58 -0800 (PST)
Received: from [10.1.3.173] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j66sm4443642wmb.21.2020.03.03.06.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 06:39:56 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson: khadas-vim3: move model to
 g12b-khadas-vim3 dtsi
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1582868824-73870-1-git-send-email-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <1ac1ed5b-c034-e816-9211-83e07fe6f6e9@baylibre.com>
Date:   Tue, 3 Mar 2020 15:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582868824-73870-1-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2020 06:47, Christian Hewitt wrote:
> The common meson-khadas-vim3.dtsi is now shared with VIM3L so move the
> VIM3 model namne to meson-g12b-khadas-vim3.dtsi.
---------------/\ name
> 
> meson-sm1-khadas-vim3l.dts contains the VIM3L model name.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 2 ++
>  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi      | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> index 5548634..2b2d72c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> @@ -8,6 +8,8 @@
>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>  
>  / {
> +	model = "Khadas VIM3";
> +
>  	vddcpu_a: regulator-vddcpu-a {
>  		/*
>  		 * MP8756GD Regulator.
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 90815fa..0ef60c7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -9,8 +9,6 @@
>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>  
>  / {
> -	model = "Khadas VIM3";
> -
>  	aliases {
>  		serial0 = &uart_AO;
>  		ethernet0 = &ethmac;
> 

With typo fixes:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
