Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCE17455B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgB2GKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 01:10:50 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:61132 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgB2GKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:10:50 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 01T6AfHB000449;
        Sat, 29 Feb 2020 15:10:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01T6AfHB000449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956641;
        bh=dz9GOcgjTtA6sfdBaVeug5DwkkY3/2n7C5+Ih/6zEtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yWRSOmixwjfWLtjn3x6iL5ab8PtdvUkxQT84knbAIUBlJaqlxintQsnD4/59LFGTt
         qzyMP0hfTJxZlYGp/QFMgwGAUsaXVKSrm2+kwUNs+rvCEO91BD32rK5ItK3hi8Kdoy
         uHuH2777Z3EHMnkVt69qhITG0MLklG2swUBx5olYXoqOfDgDCgWMMCtkxCOUuI1IPB
         3RSsOTYCOxk810SAVFqnBdmvy8ryyKmU+fD7KbCyPbbY/MXb73JXbxp3Hl839cKibW
         SK0HFsDDQpQgqqX/1Rt0DgtlGpUzQeJGMF80u9sicE2M0lgG1jzTqBgv3FcHHNfsux
         EaaXi9d3v4awg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id t20so1805525uao.7;
        Fri, 28 Feb 2020 22:10:41 -0800 (PST)
X-Gm-Message-State: ANhLgQ3XabD59D3dCfpHm/I6lyfz2N9SMCK3cOqHRoNSjwykq4nQxso/
        c15MREWWgWKDfry8MaoH/Mmg0bnQOcCl3R7As/I=
X-Google-Smtp-Source: ADFU+vtvCaDbHB526SMqgQeaBzfiO1W0aKK0d8VUeVEZJh1KdtKMLUpM7kuHsqh57iAV4ijET8E6PHExl9SuksLyfxg=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr3673324uar.109.1582956640386;
 Fri, 28 Feb 2020 22:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20200222064445.14903-1-yamada.masahiro@socionext.com> <20200222064445.14903-3-yamada.masahiro@socionext.com>
In-Reply-To: <20200222064445.14903-3-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:10:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtoPMckm2mgjABX0eHccR0nYM4=gGkdGRv1QVu-Ws=mw@mail.gmail.com>
Message-ID: <CAK7LNAQtoPMckm2mgjABX0eHccR0nYM4=gGkdGRv1QVu-Ws=mw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: uniphier: rename aidet node names to follow json-schema
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 3:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Follow the standard nodename pattern "^interrupt-controller(@[0-9a-f,]+)*$"
> defined in schemas/interrupt-controller.yaml of dt-schema.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-uniphier.




>  arch/arm/boot/dts/uniphier-ld4.dtsi  | 2 +-
>  arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-pro5.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-sld8.dtsi | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
> index f3a20dc0b22b..23b8fd627c00 100644
> --- a/arch/arm/boot/dts/uniphier-ld4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
> @@ -375,7 +375,7 @@
>                         interrupt-controller;
>                 };
>
> -               aidet: aidet@61830000 {
> +               aidet: interrupt-controller@61830000 {
>                         compatible = "socionext,uniphier-ld4-aidet";
>                         reg = <0x61830000 0x200>;
>                         interrupt-controller;
> diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
> index e96b5796f0f8..eb06c353970f 100644
> --- a/arch/arm/boot/dts/uniphier-pro4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
> @@ -426,7 +426,7 @@
>                         };
>                 };
>
> -               aidet: aidet@5fc20000 {
> +               aidet: interrupt-controller@5fc20000 {
>                         compatible = "socionext,uniphier-pro4-aidet";
>                         reg = <0x5fc20000 0x200>;
>                         interrupt-controller;
> diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
> index f794a0676760..c95eb44c816d 100644
> --- a/arch/arm/boot/dts/uniphier-pro5.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
> @@ -408,7 +408,7 @@
>                         };
>                 };
>
> -               aidet: aidet@5fc20000 {
> +               aidet: interrupt-controller@5fc20000 {
>                         compatible = "socionext,uniphier-pro5-aidet";
>                         reg = <0x5fc20000 0x200>;
>                         interrupt-controller;
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index 04d6bef3a00f..c054d0175df9 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -508,7 +508,7 @@
>                         };
>                 };
>
> -               aidet: aidet@5fc20000 {
> +               aidet: interrupt-controller@5fc20000 {
>                         compatible = "socionext,uniphier-pxs2-aidet";
>                         reg = <0x5fc20000 0x200>;
>                         interrupt-controller;
> diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
> index beb1eac85436..a05061038e78 100644
> --- a/arch/arm/boot/dts/uniphier-sld8.dtsi
> +++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
> @@ -379,7 +379,7 @@
>                         interrupt-controller;
>                 };
>
> -               aidet: aidet@61830000 {
> +               aidet: interrupt-controller@61830000 {
>                         compatible = "socionext,uniphier-sld8-aidet";
>                         reg = <0x61830000 0x200>;
>                         interrupt-controller;
> --
> 2.17.1
>

-- 
Best Regards
Masahiro Yamada
