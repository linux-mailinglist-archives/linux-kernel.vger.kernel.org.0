Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEAB15D628
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 11:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBNK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 05:59:54 -0500
Received: from mail-eopbgr140129.outbound.protection.outlook.com ([40.107.14.129]:1934
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbgBNK7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:59:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3abAHq1pSKAYjWavjDVNayM9uYPgA+rSg9b14MILlm/BNUnaD8ozGf29oOyjN9XYgo9pSG96Wnl1qqKFMJClAy0Vdajhh3f4/CdvC92w4t+M+YJF187xV6ihwnDiqarsZ/HYkMRqlgze67+c2a+V25I9Ud3k2X4X1/Yq5jvxN013o2FVlqxX/R5gNbPnVNQGqw0B6jUhZ66GQzYwazx65w9M0c0Yl2piVyNVf3sXNb8yv8mLj2yfpxdxViUwXuRl1+g7mlpQDH1QUOzJrfh0bJKEsA7bNqzksoX22vCkn4DXC0L+X0I63FtUDKSSHFvvNz3rV615jaq2i4EFUipxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JIxRcJLOV4GTwxs65VF4ZaxsWI0SP8eb2CKMzQgGoo=;
 b=PH/zfzUYdziXUWYp+FZDSIm7QiZjdPSMT9Ju+194b5jbiIYRRaJLVuKNXqTNXpiPQBA4/T5Avlgf/B4dBSZ2iJ7TppmSzh3Q8hDj0ejoBwDSMdGEQ9wmUf1/5cZcCV4kvO32+bS44exS6IGsnuAD6uElybi0PGt5v4zA6KB44vRW/+nW9x/mmt0Wf0YVhSMobdw5ADKQERQ5XF0gyzpZAaLAZpGOwe/A8QIRh7tG1GERmP3aqLLvl+WTZMM513x4uNu0pFeiTZblizINacVTpOZi9J/Na0K/01gWjUGYfu2dmUOfsvJus8TUt7bvXFHtsnYp3AcdHYHWDGQdEDxhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JIxRcJLOV4GTwxs65VF4ZaxsWI0SP8eb2CKMzQgGoo=;
 b=sEjTUVzv1f4VoRgqF4ZsWZ7cz004T1WUKGdrY69iDolmrvm7MxcfTIeSqDZ4Mzf3PIjR30FaBboqTuWRUBQTQFZ7cwRyiQk+LQNoNnL7FSJIrTP9wyUd7imsHENl299gZPJrg+uDGD+EOMMnOMKMs92W4K3wteJYhRxyWr8AXIM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6879.eurprd05.prod.outlook.com (20.181.33.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 10:59:12 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.024; Fri, 14 Feb 2020
 10:59:12 +0000
X-Gm-Message-State: APjAAAVdCfXusm0Bo0l6Jtguo2IYs6uP6UGQpw8OUpQt6xF3sfyp1EVP
        pAoXaahPBCtUOkK9TNGeyLvh0FZOlw2kOGzzicQ=
X-Google-Smtp-Source: APXvYqyqIvXzmkJNV53S8W5CCa5nhc9LRWNiiu3PE8U2ao+4s5DKLqyUMBqodnTnMVWcRIW+M3B67CW8KuTucpO5sYI=
X-Received: by 2002:ac8:1851:: with SMTP id n17mr2020101qtk.305.1581677946764;
 Fri, 14 Feb 2020 02:59:06 -0800 (PST)
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
 <20200204111151.3426090-7-oleksandr.suvorov@toradex.com> <20200214084356.GD25543@dragon>
In-Reply-To: <20200214084356.GD25543@dragon>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Fri, 14 Feb 2020 12:58:55 +0200
X-Gmail-Original-Message-ID: <CAGgjyvHmRPp3cOqZdonUdsa4G84T8MGkF8hEk38v5_Lrjv_XJg@mail.gmail.com>
Message-ID: <CAGgjyvHmRPp3cOqZdonUdsa4G84T8MGkF8hEk38v5_Lrjv_XJg@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: imx7-colibri: add support for Toradex Aster
 carrier board
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:207:3c::21) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
Received: from mail-qt1-f180.google.com (209.85.160.180) by BL0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:207:3c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Fri, 14 Feb 2020 10:59:11 +0000
Received: by mail-qt1-f180.google.com with SMTP id d5so6688308qto.0;        Fri, 14 Feb 2020 02:59:10 -0800 (PST)
X-Gm-Message-State: APjAAAVdCfXusm0Bo0l6Jtguo2IYs6uP6UGQpw8OUpQt6xF3sfyp1EVP
        pAoXaahPBCtUOkK9TNGeyLvh0FZOlw2kOGzzicQ=
X-Google-Smtp-Source: APXvYqyqIvXzmkJNV53S8W5CCa5nhc9LRWNiiu3PE8U2ao+4s5DKLqyUMBqodnTnMVWcRIW+M3B67CW8KuTucpO5sYI=
X-Received: by 2002:ac8:1851:: with SMTP id n17mr2020101qtk.305.1581677946764;
 Fri, 14 Feb 2020 02:59:06 -0800 (PST)
X-Gmail-Original-Message-ID: <CAGgjyvHmRPp3cOqZdonUdsa4G84T8MGkF8hEk38v5_Lrjv_XJg@mail.gmail.com>
X-Originating-IP: [209.85.160.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2deeae-18c5-4b62-f454-08d7b13cebea
X-MS-TrafficTypeDiagnostic: VI1PR05MB6879:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6879ECA8FED2D0E032F7ECCDF9150@VI1PR05MB6879.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(39840400004)(376002)(396003)(189003)(199004)(26005)(6862004)(52116002)(186003)(55446002)(55236004)(81166006)(5660300002)(42186006)(53546011)(450100002)(81156014)(44832011)(4326008)(86362001)(316002)(9686003)(8936002)(54906003)(66946007)(2906002)(6666004)(66556008)(66476007)(478600001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6879;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bwon9/CqPU/16AEpdDEPeU+PiNDjxrtEoUndgvs3f+HAcXaLkZ7NSSHirE+PDkPcymI4pvanVA2rC9s/eA+lwD4aMqVyaGzoIVhemPgqhq49f3VoYIH8lKQiGYf67c/CpgpqZtwuiIYECzf9tY7PA+8GrrL/qhk/HJ3oGKiGx7D1akVrwZ/eNHo9R2AAMPf15yf7BFev6GIinAdu1tHBIi43Zn++dLnFkFT/NeW+e+1VSoFD7FKPRVWA90sWD3t+1pWUxQ+RDodiL5dCq0SEx69rqLHy0DNNqpJynKlbyKyfB373+auTIVf3/4K8f4iVzV1wt0RQTvjwLnNZEdljdbbNMcwoQTNEwJZD6j8NhDuODxXJufxq5Cy9npm1B0dzl5jQeDch37irmoe5KL9ZkEeK6GjB1SiKM+vdmr5bpD+RxsWKDx1zm9U9lmb2a9hQ
X-MS-Exchange-AntiSpam-MessageData: 2fEKsC/1x015x6NNNwVU5rB7XbrtL2/3u+K85NWmv6RM1a6f009QrcVc/65KpS0TT1gLg/48U+O5gbRXmWppyHcEFOJT6FNmxFgOGy51pq5Y7H6bP9+mSVlCsH2sm2Zw01MNjD9okirRiGOBtoK0mQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2deeae-18c5-4b62-f454-08d7b13cebea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 10:59:11.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLamYvUlQCe4yx1eddIRdNBWWF9ZOllgELuATIZ0qDsBm8vGB6wK/ndQRAcFH3J4lmelhEiul/ATE3UhwElvVy2PQt0RMjjVmCvMHco8IGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

Thanks for your extremely helpful review. I'll fix all the issues you
noted in the next patchset version.

On Fri, Feb 14, 2020 at 10:44 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Feb 04, 2020 at 01:11:51PM +0200, Oleksandr Suvorov wrote:
> > Add support for the Toradex Aster carrier board.
> >
> > Follow the usual hierarchic include model, maintaining shared
> > configuration imx7-colibri-aster.dtsi.
> >
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > ---
> >
> >  arch/arm/boot/dts/Makefile                    |   3 +
> >  arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 191 ++++++++++++++++++
> >  arch/arm/boot/dts/imx7-colibri.dtsi           |   2 -
> >  arch/arm/boot/dts/imx7d-colibri-aster.dts     |  20 ++
> >  .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  20 ++
> >  arch/arm/boot/dts/imx7s-colibri-aster.dts     |  15 ++
> >  6 files changed, 249 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/imx7-colibri-aster.dtsi
> >  create mode 100644 arch/arm/boot/dts/imx7d-colibri-aster.dts
> >  create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
> >  create mode 100644 arch/arm/boot/dts/imx7s-colibri-aster.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index e006fef77499..6165d5d3a008 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -610,6 +610,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
> >       imx6ulz-14x14-evk.dtb
> >  dtb-$(CONFIG_SOC_IMX7D) += \
> >       imx7d-cl-som-imx7.dtb \
> > +     imx7d-colibri-aster.dtb \
> > +     imx7d-colibri-emmc-aster.dtb \
> >       imx7d-colibri-emmc-eval-v3.dtb \
> >       imx7d-colibri-eval-v3.dtb \
> >       imx7d-mba7.dtb \
> > @@ -623,6 +625,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
> >       imx7d-sdb-sht11.dtb \
> >       imx7d-zii-rmu2.dtb \
> >       imx7d-zii-rpu2.dtb \
> > +     imx7s-colibri-aster.dtb \
> >       imx7s-colibri-eval-v3.dtb \
> >       imx7s-mba7.dtb \
> >       imx7s-warp.dtb
> > diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
> > new file mode 100644
> > index 000000000000..776dacdbbe30
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
> > @@ -0,0 +1,191 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR X11)
>
> MIT
>
> > +/*
> > + * Copyright 2017-2020 Toradex AG
> > + *
> > + */
> > +
> > +
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +
> > +/ {
> > +     chosen {
> > +             stdout-path = "serial0:115200n8";
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_gpiokeys>;
> > +
> > +             power {
> > +                     label = "Wake-Up";
> > +                     gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> > +                     linux,code = <KEY_WAKEUP>;
> > +                     debounce-interval = <10>;
> > +                     wakeup-source;
> > +             };
> > +     };
> > +
> > +     panel: panel {
> > +             compatible = "edt,et057090dhu";
> > +             backlight = <&bl>;
> > +             power-supply = <&reg_3v3>;
> > +
> > +             port {
> > +                     panel_in: endpoint {
> > +                             remote-endpoint = <&lcdif_out>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     reg_3v3: regulator-3v3 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "3.3V";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +     };
> > +
> > +     reg_5v0: regulator-5v0 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "5V";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +     };
> > +
> > +     reg_usbh_vbus: regulator-usbh-vbus {
> > +             compatible = "regulator-fixed";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_usbh_reg>;
> > +             regulator-name = "VCC_USB[1-4]";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
> > +             vin-supply = <&reg_5v0>;
> > +     };
> > +};
> > +
> > +&bl {
> > +     brightness-levels = <0 4 8 16 32 64 128 255>;
> > +     default-brightness-level = <6>;
> > +     power-supply = <&reg_3v3>;
> > +
>
> Drop this newline.
>
> > +     status = "okay";
> > +};
> > +
> > +&adc1 {
>
> Sort nodes alphabetically.
>
> > +     status = "okay";
> > +};
> > +
> > +/*
> > + * ADC2 is not available on the Aster board and
> > + * conflicts with AD7879 resistive touchscreen.
> > + */
> > +&adc2 {
> > +     status = "disabled";
> > +};
> > +
> > +&ecspi3 {
> > +     cs-gpios = <
> > +             &gpio4 11 GPIO_ACTIVE_HIGH
> > +             &gpio4 23 GPIO_ACTIVE_HIGH
> > +     >;
> > +     status = "okay";
> > +
> > +     spidev0: spidev@0 {
> > +             compatible = "toradex,evalspi";
>
> Undocumented compatible?
>
> > +             reg = <0>;
> > +             spi-max-frequency = <23000000>;
> > +     };
> > +
> > +     spidev1: spidev@1 {
> > +             compatible = "toradex,evalspi";
> > +             reg = <1>;
> > +             spi-max-frequency = <23000000>;
> > +     };
> > +};
> > +
> > +&fec1 {
> > +     status = "okay";
> > +};
> > +
> > +&i2c4 {
> > +     status = "okay";
> > +
> > +     /* Microchip/Atmel maxtouch controller */
> > +     touchscreen@4a {
> > +             compatible = "atmel,maxtouch";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_gpiotouch>;
> > +             reg = <0x4a>;
> > +             interrupt-parent = <&gpio2>;
> > +             interrupts = <15 IRQ_TYPE_EDGE_FALLING>;        /* SODIMM 107 */
> > +             reset-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;     /* SODIMM 106 */
> > +             status = "okay";
>
> We use okay status to flip disabled device.  It's not really necessary
> here, right?
>
> > +     };
> > +
> > +     /* M41T0M6 real time clock on carrier board */
> > +     rtc: m41t0m6@68 {
> > +             compatible = "st,m41t0";
> > +             reg = <0x68>;
> > +     };
> > +};
> > +
> > +&lcdif {
> > +     status = "okay";
> > +
> > +     port {
> > +             lcdif_out: endpoint {
> > +                     remote-endpoint = <&panel_in>;
> > +             };
> > +     };
> > +};
> > +
> > +&pwm1 {
> > +     status = "okay";
> > +};
> > +
> > +&pwm2 {
> > +     status = "okay";
> > +};
> > +
> > +&pwm3 {
> > +     status = "okay";
> > +};
> > +
> > +&pwm4 {
> > +     status = "okay";
> > +};
> > +
> > +&uart1 {
> > +     status = "okay";
> > +};
> > +
> > +&uart2 {
> > +     status = "okay";
> > +};
> > +
> > +&uart3 {
> > +     status = "okay";
> > +};
> > +
> > +&usbotg1 {
> > +     status = "okay";
> > +};
> > +
> > +&usdhc1 {
> > +     keep-power-in-suspend;
> > +     no-1-8-v;
> > +     wakeup-source;
> > +     vmmc-supply = <&reg_3v3>;
> > +     status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl_gpiotouch: touchgpios {
> > +             fsl,pins = <
> > +                     MX7D_PAD_EPDC_DATA15__GPIO2_IO15        0x74
> > +                     MX7D_PAD_EPDC_BDR0__GPIO2_IO28          0x14
> > +             >;
> > +     };
> > +};
> > diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> > index 7b4e81412381..fc075f2465eb 100644
> > --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> > +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> > @@ -321,7 +321,6 @@ MX7D_PAD_LCD_RESET__GPIO3_IO4             0x14 /* SODIMM 93 */
> >                       MX7D_PAD_EPDC_DATA13__GPIO2_IO13        0x14 /* SODIMM 95 */
> >                       MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11    0x14 /* SODIMM 99 */
> >                       MX7D_PAD_EPDC_DATA10__GPIO2_IO10        0x74 /* SODIMM 105 */
> > -                     MX7D_PAD_EPDC_DATA15__GPIO2_IO15        0x74 /* SODIMM 107 */
> >                       MX7D_PAD_EPDC_DATA00__GPIO2_IO0         0x14 /* SODIMM 111 */
> >                       MX7D_PAD_EPDC_DATA01__GPIO2_IO1         0x14 /* SODIMM 113 */
> >                       MX7D_PAD_EPDC_DATA02__GPIO2_IO2         0x14 /* SODIMM 115 */
> > @@ -338,7 +337,6 @@ MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17 0x14 /* SODIMM 24 */
> >                       MX7D_PAD_SD2_DATA2__GPIO5_IO16          0x14 /* SODIMM 100 */
> >                       MX7D_PAD_SD2_DATA3__GPIO5_IO17          0x14 /* SODIMM 102 */
> >                       MX7D_PAD_EPDC_GDSP__GPIO2_IO27          0x14 /* SODIMM 104 */
> > -                     MX7D_PAD_EPDC_BDR0__GPIO2_IO28          0x74 /* SODIMM 106 */
> >                       MX7D_PAD_EPDC_BDR1__GPIO2_IO29          0x14 /* SODIMM 110 */
> >                       MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30       0x14 /* SODIMM 112 */
> >                       MX7D_PAD_EPDC_SDCLK__GPIO2_IO16         0x14 /* SODIMM 114 */
> > diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
> > new file mode 100644
> > index 000000000000..1e84e47a00fc
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR X11)
> > +/*
> > + * Copyright 2017-2020 Toradex AG
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx7d-colibri.dtsi"
> > +#include "imx7-colibri-aster.dtsi"
> > +
> > +/ {
> > +     model = "Toradex Colibri iMX7D on Colibri Aster Board";
> > +     compatible = "toradex,colibri-imx7d-aster", "toradex,colibri-imx7d",
>
> Any new compatible needs to be documented.
>
> Shawn
>
> > +                  "fsl,imx7d";
> > +};
> > +
> > +&usbotg2 {
> > +     vbus-supply = <&reg_usbh_vbus>;
> > +     status = "okay";
> > +};
> > diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
> > new file mode 100644
> > index 000000000000..9caaac6ecf5c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR X11
> > +/*
> > + * Copyright 2017-2020 Toradex AG
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx7d-colibri-emmc.dtsi"
> > +#include "imx7-colibri-aster.dtsi"
> > +
> > +/ {
> > +     model = "Toradex Colibri iMX7D 1GB (eMMC) on Colibri Aster Board";
> > +     compatible = "toradex,colibri-imx7d-emmc-aster",
> > +                  "toradex,colibri-imx7d-emmc", "fsl,imx7d";
> > +};
> > +
> > +&usbotg2 {
> > +     vbus-supply = <&reg_usbh_vbus>;
> > +     status = "okay";
> > +};
> > diff --git a/arch/arm/boot/dts/imx7s-colibri-aster.dts b/arch/arm/boot/dts/imx7s-colibri-aster.dts
> > new file mode 100644
> > index 000000000000..6fb981f3f801
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx7s-colibri-aster.dts
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR X11)
> > +/*
> > + * Copyright 2017-2020 Toradex AG
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx7s-colibri.dtsi"
> > +#include "imx7-colibri-aster.dtsi"
> > +
> > +/ {
> > +     model = "Toradex Colibri iMX7S on Colibri Aster Board";
> > +     compatible = "toradex,colibri-imx7s-aster", "toradex,colibri-imx7s",
> > +                  "fsl,imx7s";
> > +};
> > --
> > 2.24.1
> >



-- 
Best regards
Oleksandr Suvorov

Toradex AG
Altsagenstrasse 5 | 6048 Horw/Luzern | Switzerland | T: +41 41 500
4800 (main line)
