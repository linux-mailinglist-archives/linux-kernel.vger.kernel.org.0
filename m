Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE43386408
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403915AbfHHOK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 10:10:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50466 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfHHOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:10:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so2582054wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6m6gxn9LKSOYIOC2UD+jJL1y8rpnk5zVAEhh5s4nAFQ=;
        b=bbMMDKltdkMddpB7ydaPuad3hSghabEIOlx/v1qAcXV70ngjxy16ZQkEkvLXiT39n7
         wKYWuU+t8/gj0JNpUlZdoAtk6fOvur0TPrgmRY0zwB8WjzZ5q8E3T/f87z0B6DZJwj2N
         Z7WGCb48mP352I8GvNi2cphG0BHWtVhpCDXOsXkRNzWTFj8iwITbfhp4LvhNjmfHfL3R
         GLRRaZQbtBFB0OfkI6nScUoLJxBpWE1wia99gm1IgGRCN4ZXMB8nuEyf0CCvLU2pEXAa
         gp2i2hYq/2t8Q0vKgAjSM8UABP3TtajVVifwRDFZDicJke1ipHVEPiWcibzH5QZTwcKh
         8+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6m6gxn9LKSOYIOC2UD+jJL1y8rpnk5zVAEhh5s4nAFQ=;
        b=ti7rP5kdmKakqGtriqUXf1qB/V34f45zjTUZyWkXLiKN00YF8AhC8VM3mVKknwLg4O
         Sx5no8Px1qZyZofQwYHmGFKGDsnJC4Quga8I/5lgZFXAJXtuC8VlVg1jB61XQXQuqDw0
         +DAMm31Clf+9h/9uVO5a1Vd4aZJS4P1pEP+XgJ4YCXhl8VY4kUiKHeqjQvIaUNU7pLT1
         wB07+ZsA35V8xhD41cYpQZ763N35Ce2XE45LxjSf9lFThIbhy6As9knZIcGUhtejBzoc
         ba7Q3bmBk7a7TONlZ5yYwdp8lDweKyId9MwPFKUuduLcAIMxtx54gWAwG8+nqjgp0aIh
         E7hA==
X-Gm-Message-State: APjAAAWuJ4PozQJ3SYeMnJn+nws109hwpYtktCwB29RX/I+T0Vlvxcm6
        x3N/tyglFBd7uB9Mw8CG0Axvig==
X-Google-Smtp-Source: APXvYqxLmc+sO7xMowb+RJSTyP1ooEMxclBETMdjl+uhSXebVMMNRcyl52c80GhEl3LNchoUK+Iomg==
X-Received: by 2002:a1c:407:: with SMTP id 7mr4952733wme.113.1565273450023;
        Thu, 08 Aug 2019 07:10:50 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a19sm9860294wra.2.2019.08.08.07.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:10:49 -0700 (PDT)
Subject: Re: [PATCH 8/9] drm: meson: add macro used to enable HDMI PLL
To:     Kevin Hilman <khilman@baylibre.com>, 86zhm782g5.fsf@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
References: <86zhm782g5.fsf@baylibre.com> <86o92n82e1.fsf@baylibre.com>
 <7hwohawoxu.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <33b9572f-59cc-a72b-c517-e85df70e3f96@baylibre.com>
Date:   Thu, 8 Aug 2019 16:10:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7hwohawoxu.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2019 01:20, Kevin Hilman wrote:
> Julien Masson <jmasson@baylibre.com> writes:
> 
>> This patch add new macro HHI_HDMI_PLL_CNTL_EN which is used to enable
>> HDMI PLL.
>>
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_vclk.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
>> index e7c2b439d0f7..be6e152fc75a 100644
>> --- a/drivers/gpu/drm/meson/meson_vclk.c
>> +++ b/drivers/gpu/drm/meson/meson_vclk.c
>> @@ -96,6 +96,7 @@
>>  #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
>>  
>>  #define HHI_HDMI_PLL_CNTL	0x320 /* 0xc8 offset in data sheet */
>> +#define HHI_HDMI_PLL_CNTL_EN	BIT(30)
>>  #define HHI_HDMI_PLL_CNTL2	0x324 /* 0xc9 offset in data sheet */
>>  #define HHI_HDMI_PLL_CNTL3	0x328 /* 0xca offset in data sheet */
>>  #define HHI_HDMI_PLL_CNTL4	0x32C /* 0xcb offset in data sheet */
>> @@ -468,7 +469,7 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>>  
>>  		/* Enable and unreset */
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>> -				   0x7 << 28, 0x4 << 28);
>> +				   0x7 << 28, HHI_HDMI_PLL_CNTL_EN);

I'll do a pass on the PLL part since it needs much more work than a cleanup,
it's ok for me.

Neil

> 
> still using a magic const for the mask.  Can use GENMASK() for this?
> 
> Kevin
> 

