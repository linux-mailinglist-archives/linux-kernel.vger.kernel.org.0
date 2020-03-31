Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F519A266
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgCaXVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 19:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgCaXVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:21:33 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9A4920787;
        Tue, 31 Mar 2020 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585696893;
        bh=WsfCUnixUcuW/Hxxf0cDgSU2hILcghynbB0/ocxWSWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BSUjiGPdigzSvDZ4tnofPNAagDsoCyjzK8WO8VypFo7BVQKLeb4MLtGK3iPKrLUPR
         GgnXsa6mIIMc6O+ZbIVKGdmokbqi1x1a5NNOkk0Hx1vjJB8QtCAhiM0wztg8SGQFMT
         h+fhYRJLiqdNUP+02qSloeg/C6wipkNF1IgHeDNQ=
Received: by mail-ed1-f54.google.com with SMTP id z65so27482135ede.0;
        Tue, 31 Mar 2020 16:21:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3n0s94W80UiJTqnNSWB5cePlnLiVDznKWj03LHWVyDLb3bjio9
        sDHpE3zQFlSzsNdiQjU1Wi2lOd6KQVbc/W5d2w==
X-Google-Smtp-Source: ADFU+vv3TGW/kwb5HMH/cRaDee3j5i5z0vjv/4XsV67d1Idq9Hu6wbNbfu8nd0HzCER7YmS8mN6zlRD2dLxeiQPcfX4=
X-Received: by 2002:a17:906:124f:: with SMTP id u15mr17040650eja.360.1585696891114;
 Tue, 31 Mar 2020 16:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214609.1742152-1-enric.balletbo@collabora.com>
In-Reply-To: <20200331214609.1742152-1-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 1 Apr 2020 07:21:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-=y+t1tDnV_muYs9KS_-mQK9UtRzHe_O1AnStB1XqrLg@mail.gmail.com>
Message-ID: <CAAOTY_-=y+t1tDnV_muYs9KS_-mQK9UtRzHe_O1AnStB1XqrLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc: mediatek: Enable mmsys driver by default if
 Mediatek arch is selected
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, CK Hu <ck.hu@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        ulrich.hecht+renesas@gmail.com,
        Matthias Brugger <mbrugger@suse.com>, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org,
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
=B44=E6=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:46=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> The mmsys driver supports only MT8173 device for now, but like other syst=
em
> controllers is an important piece for other Mediatek devices. Actually
> it depends on the mt8173 clock specific driver but that dependency is
> not real as it can build without the clock driver. Instead of depends on
> a specific model, make the driver depends on the generic ARCH_MEDIATEK an=
d
> enable by default so other Mediatek devices can start using it without
> flood the Kconfig.

I've no idea about 'enable by default'. For some product which has no
display, it does not need mmsys partition (include drm and mdp). But
the code size of mmsys is not large, so it seems enable it by default
has no harm. Just provide some information for you.

Regards,
Chun-Kuang.

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/soc/mediatek/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index e84513318725..59a56cd790ec 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -46,8 +46,7 @@ config MTK_SCPSYS
>
>  config MTK_MMSYS
>         bool "MediaTek MMSYS Support"
> -       depends on COMMON_CLK_MT8173_MMSYS
> -       default COMMON_CLK_MT8173_MMSYS
> +       default ARCH_MEDIATEK
>         help
>           Say yes here to add support for the MediaTek Multimedia
>           Subsystem (MMSYS).
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
