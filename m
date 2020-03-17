Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A437B188663
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCQNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:54:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36466 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCQNyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:54:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id 39so6261117otu.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmJ1DX6hWX/M0tJ4tb+T+vnuuVl9PBhyVPx9KWg+TfE=;
        b=oq96GvwKE3QjPaVLIL6puTSWYMA2JZDVaTmuQkU5YS2oAf/mr3PnEKvKHJR0ZRhtIa
         co1ejwVmMjf45HEIGsFS7ucBT3DK6y8RniLfZE9atxfSrHzRC4LR7/HbpPoNhsm9Csw9
         4WgJovPpiFVSd6SpId/tkc9AFWMsO7+/Fgrhd5ZALH+GelrL93lZpFiNJkbpxOyGI9jj
         cfuiFY4wiYKRNaziZ2clJGs0DujKo7wScsDUBJMincBMB9URA1hz8xIaq7/5PVaD2a+m
         3b74LJeSYTOYbUGyuvbKRYBDDMHveVikkENWoxUtiLK++DNrQ92vG/eDVnrxruhpAR9B
         pdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmJ1DX6hWX/M0tJ4tb+T+vnuuVl9PBhyVPx9KWg+TfE=;
        b=BCgbl8SPLsjFWIagMPx0xaOURj9nMZ2T057SWWD5pr5iIgRMAKPojlaXaBCbGwEEpS
         8nWkMPX1uI2tQckIkjBjCOg5TZZjx767SZ7NM9VfFGp1qhbSBLf2AhGpkcbA/na/9yu+
         Kg/aGH3TgW6r+h35eedY9N9mzAcVPMNu8+FyQ5NwmVI0nM0XDhE+sTvsxeOGKPoHImVH
         EySi/MLOx6S2akP69d5066qIIv0tZwpoP68pl/rt95/mlrUXwEHTS1Be3Mytg9Tjcmpb
         wsyJc1jz+vTZiT6JFCCAZ/+WcSX3BN6HAIOWJ4iVWAEJoLugSN5oOBFpOuRwnmKv/771
         N7MQ==
X-Gm-Message-State: ANhLgQ3Cm+jO4V6PI4MJpEqdL54lhPE72f8sOvp99OXl7HvoGmkk8TZ3
        IVpx7uX4w/5wFoZyI0pLORDyGULHRVaFvRHCPFwkqA==
X-Google-Smtp-Source: ADFU+vthRF1CGXBIcX8eCWjLSUuv0ijsh47UzzDn/jzCwqg/7g0xalXEDtotKi4n7rENshDbZBHeysQsEaf4csLdeEE=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr3763477otm.91.1584453264637;
 Tue, 17 Mar 2020 06:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123501.18202-1-robert.foss@linaro.org>
 <20200311123501.18202-7-robert.foss@linaro.org> <20200312053544.GY264362@yoga>
In-Reply-To: <20200312053544.GY264362@yoga>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 17 Mar 2020 14:54:13 +0100
Message-ID: <CAG3jFyuEWqkWSZzVt04y4GcO=0LUwLq4bHe_=dirWePdVW+NSA@mail.gmail.com>
Subject: Re: [v1 6/6] arm64: defconfig: Enable QCOM CAMCC, CAMSS and CCI drivers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     leonard.crestez@nxp.com, dinguyen@kernel.org,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Loic Poulain <loic.poulain@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 at 06:35, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 11 Mar 05:35 PDT 2020, Robert Foss wrote:
>
> > Build camera clock, isp and controller drivers as modules.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
>
> Thanks for the series Robert!

Thanks for the quick & thorough review, I'll send out a v2 with all of
the feedback corrected.

>
> Regards,
> Bjorn
>
> > ---
> >  arch/arm64/configs/defconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 4db223dbc549..7cb6989249ab 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -376,6 +376,7 @@ CONFIG_I2C_MESON=y
> >  CONFIG_I2C_MV64XXX=y
> >  CONFIG_I2C_OWL=y
> >  CONFIG_I2C_PXA=y
> > +CONFIG_I2C_QCOM_CCI=m
> >  CONFIG_I2C_QCOM_GENI=m
> >  CONFIG_I2C_QUP=y
> >  CONFIG_I2C_RK3X=y
> > @@ -530,6 +531,7 @@ CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
> >  CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
> >  CONFIG_VIDEO_RENESAS_FCP=m
> >  CONFIG_VIDEO_RENESAS_VSP1=m
> > +CONFIG_VIDEO_QCOM_CAMSS=m
> >  CONFIG_DRM=m
> >  CONFIG_DRM_I2C_NXP_TDA998X=m
> >  CONFIG_DRM_NOUVEAU=m
> > @@ -732,6 +734,7 @@ CONFIG_MSM_GCC_8994=y
> >  CONFIG_MSM_MMCC_8996=y
> >  CONFIG_MSM_GCC_8998=y
> >  CONFIG_QCS_GCC_404=y
> > +CONFIG_SDM_CAMCC_845=m
> >  CONFIG_SDM_GCC_845=y
> >  CONFIG_SM_GCC_8150=y
> >  CONFIG_QCOM_HFPLL=y
> > @@ -762,6 +765,7 @@ CONFIG_QCOM_COMMAND_DB=y
> >  CONFIG_QCOM_GENI_SE=y
> >  CONFIG_QCOM_GLINK_SSR=m
> >  CONFIG_QCOM_RMTFS_MEM=m
> > +CONFIG_SDM_CAMCC_845=m
> >  CONFIG_QCOM_RPMH=y
> >  CONFIG_QCOM_RPMHPD=y
> >  CONFIG_QCOM_SMEM=y
> > --
> > 2.20.1
> >
