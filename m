Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEA028030
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfEWOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 10:48:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42004 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfEWOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:48:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id i2so5648951otr.9;
        Thu, 23 May 2019 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDQBZdIvYwIinFH3kAqUI347dxABstmtY5K29nEy8mo=;
        b=HNr+lm9qrX2w9n+0DHcc8xytZybxavfe+23JfHpNgn9pseNEgnEK0UTfApLytl3g9K
         JPfxVu6Ozzs/AWTnnt8YvUO5noCYyjb5r5fdlvOHCfygSc6lc6s1KKX2G3aaws7mPgYr
         ZODo9q5J84Pvb7LDzjMKYtcbpQ+k2785cimOMJKhSrEL/BNOkiA0DvyCiJlQd6XyUI1R
         xNge4WJLZqLPiNoaN0sHp8dNBpGSjdaULSEzM5V2FUa5iUxU0A3dZd+sWCwd1nq5pZHA
         rpR1DJxBRNF/ZBXNbinJniHhF3t9FMym1Z0QdoAn0/JDUL+MySyXAunoctX5Mb4/gG/q
         77/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDQBZdIvYwIinFH3kAqUI347dxABstmtY5K29nEy8mo=;
        b=dRYybhbEErmG0SXXtCM2+6rQPD7J5RSxG6Fn7uk6sYPA7omqVqTyMQ3wALqHmivPkD
         fal0DBw0yLX+9AMFxramoAtUP5OxYtBXTuXsBlizfNU0JcaNNb8aHgUYfRwPFWiY15YH
         5EGQaTUrlPzfjlFo4Cj/QVeAK27dAMT+nhRDrQXLqX0bmCHVQq40LGPaxRT0kr3Su9Jw
         jxq84J9Nh3awmYZO3Nezxt7nWo2dd1pP2AayIHkOiyNQ2sDM4soe8OQ1oRrUffNX8oj3
         PfwqsEoCYr4A6lGZX5TKg+HdVnILnXL/H7bj//XHA7ihOFiFqYQJWSe4swqodH3PtHd2
         bB7g==
X-Gm-Message-State: APjAAAX+Sv48a54vE+T9lyvAOf8+IFGO3oDYMjDY0z39QUrUEY4mTFwp
        qlr03cLGB9W9ekKARG0kj6Y13M4l21cCyg7XWfQ=
X-Google-Smtp-Source: APXvYqw3lXNzL20L5yiXLKv5Z3v3y22lX4Y0hQjIQiu0uAzQPUXWXHzt/EhByUGPnFRRFPnfxLaM88AV6ZYWkFV34b8=
X-Received: by 2002:a05:6830:2047:: with SMTP id f7mr29121701otp.312.1558622909158;
 Thu, 23 May 2019 07:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190523065013.2719D68B05@newverein.lst.de> <20190523065404.BB60F68B20@newverein.lst.de>
In-Reply-To: <20190523065404.BB60F68B20@newverein.lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 23 May 2019 07:48:03 -0700
Message-ID: <CA+E=qVdh-=C5zOYWYj95jLN51EaXFS6B+CQ101-f64q5QmgN3g@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a64: enable ANX6345 bridge on Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:54 PM Torsten Duwe <duwe@lst.de> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Teres-I has an anx6345 bridge connected to the RGB666 LCD output, and
> the I2C controlling signals are connected to I2C0 bus. eDP output goes
> to an Innolux N116BGE panel.
>
> Enable it in the device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts |   65 +++++++++++++++++--
>  1 file changed, 61 insertions(+), 4 deletions(-)
>
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -65,6 +65,21 @@
>                 };
>         };
>
> +       panel: panel {
> +               compatible ="innolux,n116bge", "simple-panel";

IIRC Rob wanted it to be edp-connector, not simple-panel. Also you
need to introduce edp-connector binding.

> +               status = "okay";
> +               power-supply = <&reg_dcdc1>;
> +               backlight = <&backlight>;
> +
> +               ports {
> +                       panel_in: port {
> +                               panel_in_edp: endpoint {
> +                                       remote-endpoint = <&anx6345_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
>         reg_usb1_vbus: usb1-vbus {
>                 compatible = "regulator-fixed";
>                 regulator-name = "usb1-vbus";
> @@ -81,20 +96,48 @@
>         };
>  };
>
> +&de {
> +       status = "okay";
> +};
> +
>  &ehci1 {
>         status = "okay";
>  };
>
>
> -/* The ANX6345 eDP-bridge is on i2c0. There is no linux (mainline)
> - * driver for this chip at the moment, the bootloader initializes it.
> - * However it can be accessed with the i2c-dev driver from user space.
> - */
>  &i2c0 {
>         clock-frequency = <100000>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c0_pins>;
>         status = "okay";
> +
> +       anx6345: anx6345@38 {
> +               compatible = "analogix,anx6345";
> +               reg = <0x38>;
> +               reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
> +               dvdd25-supply = <&reg_dldo2>;
> +               dvdd12-supply = <&reg_dldo3>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               anx6345_in: endpoint {
> +                                       remote-endpoint = <&tcon0_out_anx6345>;
> +                               };
> +                       };
> +                       port@1 {
> +                               anx6345_out: endpoint {
> +                                       remote-endpoint = <&panel_in_edp>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&mixer0 {
> +       status = "okay";
>  };
>
>  &mmc0 {
> @@ -279,6 +322,20 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +&tcon0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&lcd_rgb666_pins>;
> +
> +       status = "okay";
> +};
> +
> +&tcon0_out {
> +       tcon0_out_anx6345: endpoint@0 {
> +               reg = <0>;
> +               remote-endpoint = <&anx6345_in>;
> +       };
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
