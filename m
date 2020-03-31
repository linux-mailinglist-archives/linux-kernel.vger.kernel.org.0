Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6A19A248
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 01:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgCaXNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 19:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgCaXNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:13:34 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93B921707;
        Tue, 31 Mar 2020 23:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585696413;
        bh=9XnDVeLNtXBo+7A+ymbQWmYaZXP1cYS2bkQlhtc03pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J7zqVWd/5lRSv44OmqCPe15cyMfA4cypk3PPuwEoI45tJ1YAoTl5Ju1ma924UCJl6
         Z6ky4U99dLrxKDMwa+PTXGoIyPPfnsUb6LRM8u/KABhxK6I52Zyo/oUkrVgFeiVNOT
         ND0IQRvtzFnmuXNaM15v5te9g0dWSmNYMudOjc6w=
Received: by mail-ed1-f53.google.com with SMTP id de14so27406240edb.4;
        Tue, 31 Mar 2020 16:13:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0kEpjM6joDgA2tDHZQgypbnov2wqaCqiv5reWf1k0HTQvvf9Os
        8SRsWVi7LObTtjSgEosbmgfE9h8PRF51tu0wsg==
X-Google-Smtp-Source: ADFU+vsI2at//4iAqFj3XbOPyjbjd8Ju2JHJo+yfvuPMtXyncAneKqKuJ3LsmHFRegjrJGdHpUpM711na8maETHC9Bs=
X-Received: by 2002:a50:ce01:: with SMTP id y1mr18621985edi.47.1585696411284;
 Tue, 31 Mar 2020 16:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214609.1742152-1-enric.balletbo@collabora.com> <20200331214609.1742152-4-enric.balletbo@collabora.com>
In-Reply-To: <20200331214609.1742152-4-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 1 Apr 2020 07:13:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY__9rrC3o9sTYKgSZi8n0xHdtSFoNMHOqLfQF6B_4BAGww@mail.gmail.com>
Message-ID: <CAAOTY__9rrC3o9sTYKgSZi8n0xHdtSFoNMHOqLfQF6B_4BAGww@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: mt8173: Fix mmsys node name
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, CK Hu <ck.hu@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        ulrich.hecht+renesas@gmail.com, devicetree@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-mediatek@lists.infradead.org, matthias.bgg@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B44=E6=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:47=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Node names are supposed to match the class of the device, mmsys is a
> system controller (syscon) not a clock controller, so change the node
> name accordingly.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8173.dtsi
> index 8b4e806d5119..a55e8c177832 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -908,7 +908,7 @@ u2port1: usb-phy@11291000 {
>                         };
>                 };
>
> -               mmsys: clock-controller@14000000 {
> +               mmsys: syscon@14000000 {
>                         compatible =3D "mediatek,mt8173-mmsys", "syscon";
>                         reg =3D <0 0x14000000 0 0x1000>;
>                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM=
>;
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
