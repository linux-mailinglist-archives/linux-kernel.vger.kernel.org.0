Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9158130B50
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfEaJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 05:21:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50829 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfEaJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:21:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so1586574wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U/n5yvTTgMVY/dBqeERBYEBY0lf3nQpFXZXAfVx/PD0=;
        b=GI3IIAX8QupWN7q1bpcUDK9Fve8uCJGAb1lfIXKIZ+dXY9BavIz5UXP4452BpKBWKE
         iYvrJ0Cp3xPVpO5cQzEE0FezjM27trvzaOlg3ElB4YODGmhGf5D8zJbv88TNWxGJM/SH
         MclaMz6RJXg2lV/w+/yyVqBtNSKd6EvstwRGJiTn1Ck9iqBunpCqrq9oUAoFec31m56H
         UQPTXnwPs1r08zkRYc+/JO9fhx9KhucK9dkgP7eGL98M4sfh8RODL06hhs1uRNiWcQp7
         YBNNJ75s23V2VILvMRpAVZOR+8+wWLD1hNv6YRuAuznZK331DrNOrsE/VQvxTFgx8Siz
         tOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U/n5yvTTgMVY/dBqeERBYEBY0lf3nQpFXZXAfVx/PD0=;
        b=Hdn8UmoI6Ib7nWNg+yIeE1XHV3YvfvRg4R82J399uaua0PZNWWGhyUmZMtu0uDLQX4
         XyPBLYaww4YuWaFIFTIVeoMGwN5lYZC4KXdckoQHSxHcIvl48wDjN/MmfVaTfHVKiOuZ
         8TjLY4+rp9eg2VcgqbEeekQI4sMy1LMiXA26Vi2ptD9UsrK+owKDl2d+yCmiT5Fi8fk8
         UPK8vb9IIBjunKFEJWwH9nWKr4J1195C3ZdnZoLHdPxHo4gMrD8qOJ9Z57zRPg2bvi6O
         XRDmYvFeQfLKykh9k0Itw11+XxGbqsRGJ6BKzxquLPU1y2Be5rJCaZOwX2fFvZIbz1xD
         la0w==
X-Gm-Message-State: APjAAAX+wXnXjuSktvZyI90iN1i/U9vtPf/aqtvDiphfY8pV6VR4UzkU
        og6Uxrmy3UHKph9XKCvxKtRkDQ==
X-Google-Smtp-Source: APXvYqwFKEjiRryumLbg3Rtim092mG+VHNajl5Ok0iARbC1EDvrN2XO+w0hmyjlc+LdKBvmFen3oaA==
X-Received: by 2002:a1c:3b41:: with SMTP id i62mr4987068wma.155.1559294500661;
        Fri, 31 May 2019 02:21:40 -0700 (PDT)
Received: from [192.168.1.24] (amarseille-652-1-291-131.w109-208.abo.wanadoo.fr. [109.208.94.131])
        by smtp.gmail.com with ESMTPSA id 34sm8235916wre.32.2019.05.31.02.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 02:21:39 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] arm64: dts: meson: Add minimal support for
 Odroid-N2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190527140206.30392-1-narmstrong@baylibre.com>
 <20190527140206.30392-4-narmstrong@baylibre.com>
 <7da1c182-db68-c813-1f3c-b936137deeb2@baylibre.com>
 <CAFBinCBjBRXMsvwiN0Hi4RHZ1VpU=2T3KnoN800N7FSy3_uBNQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <82ecf714-92ed-8d2a-94a6-9957dd214ae7@baylibre.com>
Date:   Fri, 31 May 2019 11:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBjBRXMsvwiN0Hi4RHZ1VpU=2T3KnoN800N7FSy3_uBNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 20:13, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Wed, May 29, 2019 at 12:09 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 27/05/2019 16:02, Neil Armstrong wrote:
>>> This patch adds basic support for :
>>> - Amlogic G12B, which is very similar to G12A
>>> - The HardKernel Odroid-N2 based on the S922X SoC
>>>
>>> The Amlogic G12B SoC is very similar with the G12A SoC, sharing
>>> most of the features and architecture, but with these differences :
>>> - The first CPU cluster only has 2xCortex-A53 instead of 4
>>> - G12B has a second cluster of 4xCortex-A73
>>> - Both cluster can achieve 2GHz instead of 1,8GHz for G12A
>>> - CPU Clock architecture is difference, thus needing a different
>>>   compatible to handle this slight difference
>>> - Supports a MIPI CSI input
>>> - Embeds a Mali-G52 instead of a Mali-G31, but integration is the same
>>>
>>> Actual support is done in the same way as for the GXM support, including
>>> the G12A dtsi and redefining the CPU clusters.
>>> Unlike GXM, the first cluster is different, thus needing to remove
>>> the last 2 cpu nodes of the first cluster.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>>>  .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 288 ++++++++++++++++++
>>>  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 +++++
>>>  3 files changed, 371 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index e129c03ced14..07b861fe5fa5 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
>>> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>> new file mode 100644
>>> index 000000000000..48783ead8dfb
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>> @@ -0,0 +1,288 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2019 BayLibre, SAS
>>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>
>> [...]
>>
>>> +
>>> +     hub_5v: regulator-hub_5v {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "HUB_5V";
>>> +             regulator-min-microvolt = <5000000>;
>>> +             regulator-max-microvolt = <5000000>;
>>> +             vin-supply = <&vcc_5v>;
>>> +
>>> +             /* Connected to the Hub CHIPENABLE, LOW sets low power state */
>>> +             gpio = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
>>> +             enable-active-high;
>>> +     };
>>> +
>>> +     usb_pwr_en: regulator-usb_pwr_en {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "USB_PWR_EN";
>>> +             regulator-min-microvolt = <5000000>;
>>> +             regulator-max-microvolt = <5000000>;
>>> +             vin-supply = <&hub_5v>;
>>> +
>>> +             /* Connected to the microUSB port power enable */
>>> +             gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
>>> +             enable-active-high;
>>> +     };
>>> +
>>
>> [...]
>>
>>> +
>>> +&usb {
>>> +     status = "okay";
>>> +     vbus-supply = <&usb_pwr_en>;
>>> +};
>>> +
>>> +&usb2_phy0 {
>>> +     phy-supply = <&vcc_5v>;
>>> +};
>>> +
>>> +&usb2_phy1 {
>>> +     phy-supply = <&vcc_5v>;
>>> +};
>>
>> In fact, I need to fixup here :
>>
>> usb2_phy1 needs &hub_5v and regulator-usb_pwr_en depends on &vcc_5v instead...
> sounds fine for me because I don't see a better way for now
> 
>> @Martin, can I still keep your reviewed-by for v5 ?
> yes, you can keep it
> 
> when you re-send it: can you please add a comment to the phy-supply in
> usb2_phy1?
> I have this in mind: "enable the hub which is connected to this port"
> (imho this is a valuable hint together with the "CHIPENABLE" comment
> that you already have inside &hub_5v and it helps to make it easier to
> understand without having to test it on physical hardware)

Sure, thanks !

Neil

> 
> 
> Martin
> 

