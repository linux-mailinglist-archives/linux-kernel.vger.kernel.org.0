Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60305166CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 03:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBUCXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 21:23:16 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43116 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgBUCXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:23:16 -0500
Received: by mail-il1-f194.google.com with SMTP id p78so407497ilb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1r4Guz/pyXp2FmGJuccB7640iKmbat2fCQTpns04iQA=;
        b=Lkna8bgrY1wIa2D6YpzLy0LrWfgzvaUEsUsl3en59bAJAaA2vZ9VPIKQlDXtm+3+2+
         9pdBEzbHik3jHDJbH4uFvxBtmgF8H1fX2vh7XTfL3CQHeRV+r5yUeRR6SesXPJidAZxW
         qE20XApR58nXLCYXwc7cWM3YGLzFqizc+vgPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1r4Guz/pyXp2FmGJuccB7640iKmbat2fCQTpns04iQA=;
        b=fTfiaL90qS3c/I2i/UnCKd/nS5hurgOpFsARDH5kkV8YQxPPLV9zOE6YaFE/saWLE4
         xwqhMSnZi8aSutD7o4NE+MmMDLqg8DHgCjHa9UKnkEzIPKuwEucxOx3eiT6w0XS+WipI
         +6rO0lvCQMr0TBfi9i+xWC5BcKsIYu3VgxZE9pfqhW/AZL7C4F4GDUDax70oEVp884em
         vKrQ9mzKoa8ezWJZQss4awQmCInoRf/EczvsSjKqgzPXiiLkR0BnESHLBXabH9AYepOO
         2vbSvWjZuonqQZBrSEAh/+TlbsG9PZ/TqYI0ZRcBB7bvMpQhmeezCrvd/mHIYygpUV2p
         lOdA==
X-Gm-Message-State: APjAAAVnuolmAdtLwHfxlds2rvWHTasN2KmA56HXIpyuLKPYzMda9lQX
        8PHDMVJW/2a7Q/r5ZtSl+k/xGsTLT+QJKUgRxp9W+A==
X-Google-Smtp-Source: APXvYqyrSLErmbSrh9z11lK8TdqiabptjiOsG76i8R6M6oB7VpHn99tIgFQZTTtENubg4nsK88nil5eScTiP60KPOrA=
X-Received: by 2002:a92:af8e:: with SMTP id v14mr32001179ill.150.1582251795343;
 Thu, 20 Feb 2020 18:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20200210063523.133333-1-hsinyi@chromium.org> <20200210063523.133333-4-hsinyi@chromium.org>
 <bbc75f19-0581-c902-a455-13157d66d72f@gmail.com>
In-Reply-To: <bbc75f19-0581-c902-a455-13157d66d72f@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 21 Feb 2020 10:22:49 +0800
Message-ID: <CAJMQK-iR4YHdgKfXGiM-gLVo7535KMaZobk=j4whF2g-xJ11DA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] arm64: dts: mt8173: fix unit name warnings
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 6:17 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 10/02/2020 07:35, Hsin-Yi Wang wrote:
> > Fixing several unit name warnings:
> >
> > Warning (unit_address_vs_reg): /oscillator@0: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /oscillator@1: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /oscillator@2: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/trip-point@0: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/trip-point@1: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/cpu_crit@0: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/cooling-maps/map@0: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/cooling-maps/map@1: node has a unit name, but no reg property
> > Warning (unit_address_vs_reg): /reserved-memory/vpu_dma_mem_region: node has a reg or ranges property, but no unit name
> > Warning (simple_bus_reg): /soc/pinctrl@10005000: simple-bus unit address format error, expected "1000b000"
> > Warning (simple_bus_reg): /soc/interrupt-controller@10220000: simple-bus unit address format error, expected "10221000"
> > Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 38 ++++++++++++------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 790cd64aa447..2b7f566fb407 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -42,14 +42,14 @@ aliases {
> >               dpi0 = &dpi0;
> >               dsi0 = &dsi0;
> >               dsi1 = &dsi1;
> > -             mdp_rdma0 = &mdp_rdma0;
> > -             mdp_rdma1 = &mdp_rdma1;
> > -             mdp_rsz0 = &mdp_rsz0;
> > -             mdp_rsz1 = &mdp_rsz1;
> > -             mdp_rsz2 = &mdp_rsz2;
> > -             mdp_wdma0 = &mdp_wdma0;
> > -             mdp_wrot0 = &mdp_wrot0;
> > -             mdp_wrot1 = &mdp_wrot1;
> > +             mdp-rdma0 = &mdp_rdma0;
> > +             mdp-rdma1 = &mdp_rdma1;
> > +             mdp-rsz0 = &mdp_rsz0;
> > +             mdp-rsz1 = &mdp_rsz1;
> > +             mdp-rsz2 = &mdp_rsz2;
> > +             mdp-wdma0 = &mdp_wdma0;
> > +             mdp-wrot0 = &mdp_wrot0;
> > +             mdp-wrot1 = &mdp_wrot1;
>
> Won't we need to update the mdp driver as well, as it uses of_alias_get_id()?
>
It's fixed in the fifth patch
https://patchwork.kernel.org/patch/11372623/

> >               serial0 = &uart0;
> >               serial1 = &uart1;
> >               serial2 = &uart2;
> > @@ -246,21 +246,21 @@ psci {
> >               cpu_on        = <0x84000003>;
> >       };
> >
> > -     clk26m: oscillator@0 {
> > +     clk26m: oscillator0 {
> >               compatible = "fixed-clock";
> >               #clock-cells = <0>;
> >               clock-frequency = <26000000>;
> >               clock-output-names = "clk26m";
> >       };
> >
> > -     clk32k: oscillator@1 {
> > +     clk32k: oscillator1 {
> >               compatible = "fixed-clock";
> >               #clock-cells = <0>;
> >               clock-frequency = <32000>;
> >               clock-output-names = "clk32k";
> >       };
> >
> > -     cpum_ck: oscillator@2 {
> > +     cpum_ck: oscillator2 {
> >               compatible = "fixed-clock";
> >               #clock-cells = <0>;
> >               clock-frequency = <0>;
> > @@ -276,19 +276,19 @@ cpu_thermal: cpu_thermal {
> >                       sustainable-power = <1500>; /* milliwatts */
> >
> >                       trips {
> > -                             threshold: trip-point@0 {
> > +                             threshold: trip-point0 {
> >                                       temperature = <68000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> >
> > -                             target: trip-point@1 {
> > +                             target: trip-point1 {
> >                                       temperature = <85000>;
> >                                       hysteresis = <2000>;
> >                                       type = "passive";
> >                               };
> >
> > -                             cpu_crit: cpu_crit@0 {
> > +                             cpu_crit: cpu_crit0 {
> >                                       temperature = <115000>;
> >                                       hysteresis = <2000>;
> >                                       type = "critical";
> > @@ -296,13 +296,13 @@ cpu_crit: cpu_crit@0 {
> >                       };
> >
> >                       cooling-maps {
> > -                             map@0 {
> > +                             map0 {
> >                                       trip = <&target>;
> >                                       cooling-device = <&cpu0 0 0>,
> >                                                        <&cpu1 0 0>;
> >                                       contribution = <3072>;
> >                               };
> > -                             map@1 {
> > +                             map1 {
> >                                       trip = <&target>;
> >                                       cooling-device = <&cpu2 0 0>,
> >                                                        <&cpu3 0 0>;
> > @@ -316,7 +316,7 @@ reserved-memory {
> >               #address-cells = <2>;
> >               #size-cells = <2>;
> >               ranges;
> > -             vpu_dma_reserved: vpu_dma_mem_region {
> > +             vpu_dma_reserved: vpu_dma_mem_region@b7000000 {
> >                       compatible = "shared-dma-pool";
> >                       reg = <0 0xb7000000 0 0x500000>;
> >                       alignment = <0x1000>;
> > @@ -368,7 +368,7 @@ syscfg_pctl_a: syscfg_pctl_a@10005000 {
> >                       reg = <0 0x10005000 0 0x1000>;
> >               };
> >
> > -             pio: pinctrl@10005000 {
> > +             pio: pinctrl@1000b000 {
> >                       compatible = "mediatek,mt8173-pinctrl";
> >                       reg = <0 0x1000b000 0 0x1000>;
> >                       mediatek,pctl-regmap = <&syscfg_pctl_a>;
> > @@ -575,7 +575,7 @@ mipi_tx1: mipi-dphy@10216000 {
> >                       status = "disabled";
> >               };
> >
> > -             gic: interrupt-controller@10220000 {
> > +             gic: interrupt-controller@10221000 {
> >                       compatible = "arm,gic-400";
> >                       #interrupt-cells = <3>;
> >                       interrupt-parent = <&gic>;
> >
