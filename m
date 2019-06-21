Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB884E460
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfFUJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 05:42:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34825 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFUJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:42:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so6282913qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=voXOjCDKaWVYdLTWFMcEZUkDxmgR0CxuF6yexARSuUY=;
        b=EHtwzXV9ag4SceJsJSACSOeeNk35bKg24uObths0QcZgvsQNeZwiX9MbzsoIrzqHB8
         PmDx+jEaygonb3ZbpcvywsCMlWAh2LIdKxbzgI3ENIjF4e+hQ4AJ96WjNosw0LDZcEqD
         d27h/VFLj7CkGf0/NikIaE/fU+5kGhdnC/Bjdmp7SDNj8ComKdAaSoAGY0CcPOCvZ5Jf
         MHn/Z2lRNuJ1u7/onIxivRkSI3wf0jDjVCak9YjwHs8YG0njxbsT+5EB2VyRl9cnIUJk
         612Oji/k97NlbeZrhIsT3TMfGzEjQKBwsSTDG880f7cBovak8rhAqAelO5n1VBfcGD3A
         645A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=voXOjCDKaWVYdLTWFMcEZUkDxmgR0CxuF6yexARSuUY=;
        b=q80B8gJpV7S33LJINsdpX2M9kS2Qq53XVXG3QxOEn6fi8DRmcBuz6yKyydoTrvlz/4
         Z+JYbjpPAnGmm5LoFuoS21oArUOogEttlHCSmjYQzUd7Z5iPNheEV33OWD6EArIMB7Gs
         ILPtOz/jjYJ1UEA25TwSX5Ygvdh9vLvg+y99ViMloV86b4SYILtQ6OcOkZB5tKblnZEC
         8CADnRXP0lRMwqL69aRM1V2dyJBO/XWkCNvq5CCa51yY3I1pn/ekPKsVjFTkhGryeboN
         1KmgSrfwHGy9MN7lqUaGGWtkzRrS44fyyhxORYd2lH6dFkOygNbErIPZ4KfVgZt1Qyzj
         OP0Q==
X-Gm-Message-State: APjAAAUuMOMWzC4IpguQf0XE5z6PkEE2NrrIhO4KejuBDViWPVduMUlS
        fQLAwj0cqA99/8hZIS4Svhl5tig5NEM9dg+IoMuiYQ==
X-Google-Smtp-Source: APXvYqxG/ETQk1E8/TUYPfflkh7ZrDwEi3NeU1BW/bV+XNteZsnNKMWTbT4FgYaJzDfH6YCpg7S38j2Dzf3ZtixqdyQ=
X-Received: by 2002:a0c:99d5:: with SMTP id y21mr43534451qve.106.1561110165510;
 Fri, 21 Jun 2019 02:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150306.124839-1-yuehaibing@huawei.com>
In-Reply-To: <20190620150306.124839-1-yuehaibing@huawei.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 21 Jun 2019 11:42:34 +0200
Message-ID: <CA+M3ks69T+Eh0Hd_OgCfT_VP=S_ouUwU+dawueJw9fzWO=LzmA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/sti: Remove duplicated include from sti_drv.c
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 20 juin 2019 =C3=A0 16:56, YueHaibing <yuehaibing@huawei.com> a =C3=
=A9crit :
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied on drm-misc-next,
Thanks for the patch.

Benjamin

> ---
>  drivers/gpu/drm/sti/sti_drv.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.=
c
> index bb6ae6dd66c9..2edd666fb44a 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -23,7 +23,6 @@
>
>  #include "sti_crtc.h"
>  #include "sti_drv.h"
> -#include "sti_drv.h"
>  #include "sti_plane.h"
>
>  #define DRIVER_NAME    "sti"
>
>
>
