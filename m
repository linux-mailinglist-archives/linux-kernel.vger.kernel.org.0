Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632BE50474
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfFXIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 04:23:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35768 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfFXIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:23:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id f15so2972699wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r/Gq+b3f8SdftObytJUqlEQiegHXyWR3QGcAhKeM2ME=;
        b=DkEnz2pUUwUmo09M+6MVrmbP5Quj6zD0pksFDfgb09Pi+lKinJJy9tOHot3/QdlcZK
         yqPYDaYnDkECCMJiCHHuqnFAUFcsa7I/3fKWAq5pUj1vLtwaeQnfkmskZP6Cl3NZcJYY
         TK2T7QMU92Enn0DPq9CTJpn08D6kICSHDJFHNZUAhh71vUkVabqb+YRuhXLoWYsSiDFY
         A+oGn9owrbT1DZziq6AOBCyoWW9QD8soOQPlupFK4pw6j/Gga9iFGvSN1hVp9xD9itk4
         6mLgRPOgvHLRNJH9EWKGgnvlV+/RssiQzL+8+t8kawyTBI8J+ZbYNn/MSsIkVo7wl+TP
         mXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r/Gq+b3f8SdftObytJUqlEQiegHXyWR3QGcAhKeM2ME=;
        b=G9mrb3nT6UWb1pyE91vilns0JFFAOJ2X6286GNsfBY7xYEUHTqzhAUdQvQcFbmx0Ii
         toPWvxNETHy3s/WPL0paqDy2cCrgA1n0rtqJMTHS6u5GzSNGgzsnVxB+KKSc6qgHUds7
         iSCrcO14/M3F3MUEJNDtekbMbgx/e2UGnOw8K4ouWtptay6jbCsmFQTA191G+D7t0U51
         FpauqpcH+bs4zioDto6dYZpcFUHweGGabC8XTIuWEh9X2CGsyVrbAvQe4+wnTfy/BwDa
         8QwyXbgRqP5g6VuwbOwonN4jL4wcsfIErvkQWXDac9bN1eXRrrbh1zSKKSPda4yGPiQ0
         ezDA==
X-Gm-Message-State: APjAAAXSqUIoXIqZCFZjkPb3oUToX6QfxzzePB78G0pKuzI6zJgNR9NM
        KG3Yc1GkS+Z94oE5NuhwX5IBNw==
X-Google-Smtp-Source: APXvYqx+PJXlKPyJ6o7BEWInAqF5spC2F8HGL3RFg+6VUHnHhq0tKwqLoNOiW6CtgZmwZUdoerFf4w==
X-Received: by 2002:a05:6000:100a:: with SMTP id a10mr39261789wrx.154.1561364578407;
        Mon, 24 Jun 2019 01:22:58 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l4sm7825900wmh.18.2019.06.24.01.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:22:57 -0700 (PDT)
Subject: Re: [RFC/RFT 14/14] arm64: dts: meson-g12b-odroid-n2: enable DVFS
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com
References: <20190620150013.13462-1-narmstrong@baylibre.com>
 <20190620150013.13462-15-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <789aa9dc-08d5-5d76-6efb-1365d83aad2e@baylibre.com>
Date:   Mon, 24 Jun 2019 10:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620150013.13462-15-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2019 17:00, Neil Armstrong wrote:
> Enable DVFS for the Odroid-N2 by setting the clock, OPP and supply
> for each cores of each CPU clusters.
> 
> The first cluster uses the "VDDCPU_B" power supply, and the second
> cluster uses the "VDDCPU_A" power supply.
> 
> Each power supply can achieve 0.73V to 1.01V using 2 distinct PWM
> outputs clocked at 800KHz with an inverse duty-cycle.
> 
> DVFS has been tested by running the arm64 cpuburn at [1] and cycling
> between all the possible cpufreq translations of each cluster and
> checking the final frequency using the clock-measurer, script at [2].
> 
> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> [2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> index c3e0735e6d9f..0db1547bfb5a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> @@ -114,6 +114,44 @@

[...]

I just ran a 4days long test, leading to ~4 729 015 transitions.

Here are the cpufreq trans_table content :

Cortex-A53:
   From  :    To
         :    100000    250000    500000    666666   1000000   1200000   1398000   1512000   1608000   1704000   1896000
   100000:         0     30975     20650     20649     20649     20649     20649     20649     20649     20649     20649
   250000:     20650         0     30975     20649     20649     20649     20649     20649     20649     20649     20649
   500000:     20650     20650         0     30973     20649     20648     20648     20648     20648     20648     20648
   666666:     20649     20649     20649         0     30972     20648     20648     20648     20648     20648     20648
  1000000:     20649     20649     20649     20648         0     30972     20648     20648     20648     20648     20648
  1200000:     20649     20649     20648     20648     20648         0     30972     20648     20648     20648     20648
  1398000:     20649     20649     20648     20648     20648     20648         0     30972     20648     20648     20648
  1512000:     20649     20649     20648     20648     20648     20648     20648         0     30972     20648     20648
  1608000:     20649     20649     20648     20648     20648     20648     20648     20648         0     30972     20648
  1704000:     20649     20649     20648     20648     20648     20648     20648     20648     20648         0     30972
  1896000:     30973     20649     20648     20648     20648     20648     20648     20648     20648     20648         0

Cortex-A73:
   From  :    To
         :    100000    250000    500000    666666   1000000   1200000   1398000   1512000   1704000
   100000:         0     45964     30643     30643     30643     30642     30642     30642     30642
   250000:     30643         0     45963     30642     30642     30642     30642     30642     30642
   500000:     30643     30642         0     45963     30642     30642     30642     30642     30642
   666666:     30643     30642     30642         0     45963     30642     30642     30642     30642
  1000000:     30643     30642     30642     30642         0     45963     30642     30642     30642
  1200000:     30642     30642     30642     30642     30642         0     45963     30642     30642
  1398000:     30642     30642     30642     30642     30642     30642         0     45963     30642
  1512000:     30642     30642     30642     30642     30642     30642     30642         0     45963
  1704000:     45963     30642     30642     30642     30642     30642     30642     30642         0

Neil
