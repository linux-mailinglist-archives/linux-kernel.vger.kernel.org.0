Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712E5241E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 22:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfETURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 16:17:01 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44067 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfETURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:17:01 -0400
Received: by mail-ua1-f66.google.com with SMTP id p13so5753487uaa.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6B2h64c7BAIXdqgTD3mb8/lcaBqFTG1vyJC0fwpx6wE=;
        b=KQMm8dHlW0EX+V6h+USfLko9QjquRn3QzW/5J7l+0b/pQy5Dvztidqe8NZWI0647aR
         L+PuY1rYGscMwG+2Fo1tk6DfjcAF7p0K4i5eFnOfAg7Bpnw5pktbNUrmUsFEF+4M1AQW
         bDUzBrJzXsa9FJ/B/992ypQfJjcTM2UtqhbRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6B2h64c7BAIXdqgTD3mb8/lcaBqFTG1vyJC0fwpx6wE=;
        b=Z8sCUS0zN6EuVI5PaGGVebmWa0NsJl1FQqNqAaGXKN6l55jZRFngU5zZcM5HO01fUY
         sjhGISRS5voSXzZmXtsHdy9NPS682MCHJ0XGUL5gryeIjwk1uVIAQ70Fvk0SmWpaOEEw
         /5fdSovVvfcOCyGbKghtsUvDYW6X7lqY2OXlcCSu8hgFF9igihcib4fL14nn9eNIClKz
         lJc+ZsILof/XSHNeFqqw8DmSGSZpWFdM29FViyt7useG171YZ3CxBDFB422rV8BLjtlG
         bMNvhbPyOJlKBI9MZciIXypf47PjnupVerE35HdlPcwnXWQ1CKPy4DMub9YhwzRU+MCH
         MFUg==
X-Gm-Message-State: APjAAAWz9U0EcAvO86ssu0ciLuwIKNY3rBVlEY+9L0M86XVY4m42KdAi
        FxKAZ4zZkLFIgACpqfR9Ndx+DyKhP0w=
X-Google-Smtp-Source: APXvYqwhlmkX0ZyTGDK311a6NsKbZNMTVbBd/FQqEhfxlRR790yYHzK+hGIBeymzWUC5tu/jOHtenw==
X-Received: by 2002:ab0:670c:: with SMTP id q12mr14702277uam.106.1558383419199;
        Mon, 20 May 2019 13:16:59 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id e62sm11078184vsc.24.2019.05.20.13.16.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:16:58 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id g187so9735416vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:16:58 -0700 (PDT)
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr31757112vsk.149.1558383417594;
 Mon, 20 May 2019 13:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190520170132.91571-1-mka@chromium.org>
In-Reply-To: <20190520170132.91571-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 13:16:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VGA_i=vM4_OrqXnv0WC__Fcdced3oOZjzcPO=i8Q+SdA@mail.gmail.com>
Message-ID: <CAD=FV=VGA_i=vM4_OrqXnv0WC__Fcdced3oOZjzcPO=i8Q+SdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: Limit GPU frequency on veyron
 mickey to 300 MHz when the CPU gets very hot
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 20, 2019 at 10:01 AM Matthias Kaehlcke <mka@chromium.org> wrote=
:
>
> On rk3288 the CPU and GPU temperatures are correlated. Limit the GPU
> frequency on veyron mickey to 300 MHz for CPU temperatures >=3D 85=C2=B0C=
.
>
> This matches the configuration of the downstream Chrome OS 3.14 kernel,
> the 'official' kernel for mickey.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
> entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
> ---
>  arch/arm/boot/dts/rk3288-veyron-mickey.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/d=
ts/rk3288-veyron-mickey.dts
> index d889ab3c8235..f118d92a49d0 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> @@ -125,6 +125,12 @@
>                                          <&cpu2 8 THERMAL_NO_LIMIT>,
>                                          <&cpu3 8 THERMAL_NO_LIMIT>;
>                 };
> +
> +               /* At very hot, don't let GPU go over 300 MHz */
> +               cpu_very_hot_limit_gpu {
> +                       trip =3D <&cpu_alert_very_hot>;
> +                       cooling-device =3D <&gpu 2 2>;
> +               };

Two things:

A) If I'm reading things properly, you're actually limiting things to
400 MHz.  This is because you don't have <https://crrev.com/c/1574579>
which deletes the 500 MHz GPU operating point.  So on upstream the
available points are:

0: 600 MHz
1: 500 MHz
2: 400 MHz
3: 300 MHz
4: 200 MHz
5: 100 MHz

...and downstream:

0: 600 MHz
1: 400 MHz
2: 300 MHz
3: 200 MHz
4: 100 MHz

Thinking about it more, I bet Heiko would actually be OK deleting the
500 MHz GPU operating point for veyron.  Technically it's not needed
upstream because upstream doesn't have our hacks to allow re-purposing
NPLL for HDMI (so they _can_ make 500 MHz) but maybe we can make the
argument that these laptops have only ever been tested with the 500
MHz operating point removed and also that eventually someonje will
probably figure out a way to re-purpose NPLL for HDMI even upstream...


B) It seems like in the same patch you'd want to introduce
"cpu_warm_limit_gpu", AKA:

cpu_warm_limit_gpu {
  trip =3D <&cpu_alert_warm>;
  cooling-device =3D
  <&gpu 1 1>;
};


-Doug
