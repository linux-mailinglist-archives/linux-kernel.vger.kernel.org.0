Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7851FCE859
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 17:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfJGPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 11:54:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39272 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfJGPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:54:06 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so29693444ioc.6;
        Mon, 07 Oct 2019 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOKcZv1B2M+ysN8LJmTMwi1RT7cbsvdwnRry27TboAA=;
        b=GIm5xSbRI50sJepzUbwycg7NDvMt3BT+3RYQ1Ak3PHk03MA/wlw9SqTNGY2DfIZkI3
         vzloLLiQdo1Im+2BoTX2drQ9SytWBxd+eHhHN+oxkN83GrWLEW2lR8fnp2/7fI3yPVJk
         ZxOm4F1VeDXgpPbLMuAjDt3XlVRxikDPzHve8KYJuOw5hyLbMGGgxDCmn4YkVI3ivd7q
         +qC9HjO+buQM/o2qZs44GNytFS6dr+QBe4nE9YfUXJ9tYuB3aUliVkTo2PYIw168NusB
         jYzgE62kDvg5lylYW9+xxyGY9aRNG6dfE/sjjE4tsJNb9Fkc+4mHngnT1fhm2fIWSs2U
         RT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOKcZv1B2M+ysN8LJmTMwi1RT7cbsvdwnRry27TboAA=;
        b=TT0iZBLI16XwtTexmqZsUD5xmgKK/gzd0xMCjNNoM/VB5dn7LIR8A102KgkWh3HJmf
         iYXdlqA3pr1R5OFeFHb4/6YH9gnN1uy7yWAzamyPLdGxlpTdYj2Rtly7Uwbh76BQW4dt
         JPylGWhsS0F5bVYi2fJTjKPhrfmNGBW9UoBanU3rqcyOWUifJ1jO2dPIK0NDfCo0QmS2
         WLrL2eahRMCWWkWVmlNLjhMMwFi2mrT6MOf6xk/sYUuoQvh8/u1wdAy25IcY20iDFZcJ
         xHzaHZX5U7ahJlbLEiZsAT8sZgHfo834Blgwbj60BKOksT/qeRCqZTdnfze/24bcqfdK
         Jh0Q==
X-Gm-Message-State: APjAAAWe6WD8WI9jHmDQffAgaK7+MzyQxegubfwqQETzGc6ULP/5udX4
        WjvDFKneRUinhIk+Q25EVexhTL9qbTmgi60cU/A=
X-Google-Smtp-Source: APXvYqw9T09ClSC4idvRRaaJZz/xKErgE5SB3WxVYBhzuMFYdqY2HrLZiaXgYCS9faKiSyduxgwe6sfmi9HXu2ybLSY=
X-Received: by 2002:a02:c983:: with SMTP id b3mr27831643jap.120.1570463645906;
 Mon, 07 Oct 2019 08:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-4-linux.amoon@gmail.com>
 <b73a1302-90ae-f1db-ff43-84d56ca4ba39@baylibre.com>
In-Reply-To: <b73a1302-90ae-f1db-ff43-84d56ca4ba39@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 7 Oct 2019 21:23:53 +0530
Message-ID: <CANAwSgQjKRAKV2wycZ7QFq1CS5jr_ABgvFb+pGMHWTxgFR8wPQ@mail.gmail.com>
Subject: Re: [RFCv1 3/5] arm64: dts: meson: Add missing regulator linked to
 VDDAO_3V3 regulator to FLASH_VDD
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, 7 Oct 2019 at 19:51, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 07/10/2019 15:16, Anand Moon wrote:
> > As per schematics add missing VDDAO_3V3 power supply to FLASH_VDD
> > regulator. Also add TFLASH_VDD_EN signal name to gpio pin.
> >
> > Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > index 66262a6ab3fe..6bd23a1e7e1d 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > @@ -51,9 +51,12 @@
> >               regulator-min-microvolt = <3300000>;
> >               regulator-max-microvolt = <3300000>;
> >
> > +             /* TFLASH_VDD_EN */
> >               gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
> >               enable-active-high;
> >               regulator-always-on;
> > +             /* U18 FC8731-09VF05NRR */
> > +             vin-supply = <&vddao_3v3>;
> >       };
> >
> >       tf_io: gpio-regulator-tf_io {
> >
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,

Best Regards
-Anand
