Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A524B46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfEUJOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 05:14:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33863 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:14:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so11286674wrt.1;
        Tue, 21 May 2019 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dHnNpGK7Ry3WUk+2InXBSUl6ONPHIproU8hHdaNasKo=;
        b=Q2m/FlkNWuKDyP2gARiowAg8kMU//6LrSF07lVW1DJNFDNB0p84vnH9Gt6ZZggHoWJ
         gcF0xLka+JJXToOfZZ4f+WmYWW3bcvBibFQmed1/e308zlRlMrAdT4HlZ/7zou6PPTcg
         RkUakt4bdVfrgHEeWvi5XcQCp+NJ+z8h105zmyEMaCUALsGfBISzvZABblP39VgV7Rw2
         pCNL4RJuwtEdUXL4WaT2TWOQ/61WqQDCWZ8Kh3YuBCi2EvzLzuwxwFK0qfg1aurQvXFo
         kkjtHJBaJfWM0tBGAg3lBjM22v9L+INZUnhl6evGrnafxaBu9SVO/YeTiUEEa568jrXu
         0h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dHnNpGK7Ry3WUk+2InXBSUl6ONPHIproU8hHdaNasKo=;
        b=MYPyt51DfYxwqsP8hcd9IaXysnKhJAPJtMQFj1GkFFf9+IkKiennjmA9tTUcIfjSet
         rlvu7/9D3LbvY9WQglMzrOdMhi545M1KYRDC/LzDTdNUSBKruIL6Q4fB6X7+3npFej9P
         mlzTLFS/LdoSDiNV1eYChzE+SnZwJ84WrhrLzpHaE5Fkeo/+Xk/K2NzYi/KDTwYQDDIz
         Dw2ko39P8sjc7jPQbFBnIbr5iczUKYLeYHoKXwnufvj1/CJGH/vf4hwR6ahO3bKqT59i
         ShBBXsV0za5ti/ysHQtm9vdFYanOFIu6EmXJoJWUIB/18cGiapqnsyk6DOo6iYTVi3EP
         NeKw==
X-Gm-Message-State: APjAAAVjPVczcll/N2q4DjVgInNGtyjwryoi9rGEAOvLJgXlawJxkqIV
        pJcbee+M8WQ3Ks1A0c46uIdLN6q90gMvUS70wDk=
X-Google-Smtp-Source: APXvYqx88jP9IyFfMcKGgzJqBvm934G4O2HXpF13+8xKLPawnsoQAMOoMsv6tBLbm+Ob7gC0B0Szwr7OA5UOIAd23OI=
X-Received: by 2002:adf:fc44:: with SMTP id e4mr16954254wrs.243.1558430040079;
 Tue, 21 May 2019 02:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190520092856.26307-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190520092856.26307-1-yamada.masahiro@socionext.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 21 May 2019 17:13:48 +0800
Message-ID: <CAKgpwJXEHjww0aV4x033qugw75NUtkMg3vvgtCDNgWaWbps29A@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: move core validatation after clock enable and
 reset deassert
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already one identical patch for this:
https://patchwork.kernel.org/patch/10934937/
either one is okay.

Li Jun

Masahiro Yamada <yamada.masahiro@socionext.com> =E4=BA=8E2019=E5=B9=B45=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:45=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Since commit b873e2d0ea1e ("usb: dwc3: Do core validation early on
> probe"), the DWC3 USB3 does not work for Socionext UniPhier platform.
>
> It moved dwc3_core_is_valid() really early, where no clock is enabled,
> no reset is deasserted. Any attempt to register access causes the
> system stall on my platform.
>
> Move it after clk_bulk_enable(), and still before dwc3_get_dr_mode().
>
> Fixes: b873e2d0ea1e ("usb: dwc3: Do core validation early on probe")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/usb/dwc3/core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 4aff1d8dbc4f..93b96e6abddb 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1423,11 +1423,6 @@ static int dwc3_probe(struct platform_device *pdev=
)
>         dwc->regs       =3D regs;
>         dwc->regs_size  =3D resource_size(&dwc_res);
>
> -       if (!dwc3_core_is_valid(dwc)) {
> -               dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core=
\n");
> -               return -ENODEV;
> -       }
> -
>         dwc3_get_properties(dwc);
>
>         dwc->reset =3D devm_reset_control_get_optional_shared(dev, NULL);
> @@ -1460,6 +1455,12 @@ static int dwc3_probe(struct platform_device *pdev=
)
>         if (ret)
>                 goto unprepare_clks;
>
> +       if (!dwc3_core_is_valid(dwc)) {
> +               dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core=
\n");
> +               ret =3D -ENODEV;
> +               goto disable_clks;
> +       }
> +
>         platform_set_drvdata(pdev, dwc);
>         dwc3_cache_hwparams(dwc);
>
> @@ -1524,7 +1525,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  err1:
>         pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> -
> +disable_clks:
>         clk_bulk_disable(dwc->num_clks, dwc->clks);
>  unprepare_clks:
>         clk_bulk_unprepare(dwc->num_clks, dwc->clks);
> --
> 2.17.1
>
