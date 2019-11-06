Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9D7F1C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfKFRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 12:20:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53208 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfKFRU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:20:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id c17so4543682wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nuh17+p/kI43xREuVK4a8I5e5bWCvbJIdUjydClras=;
        b=o56I/jzCa8/bEoQvRfq4lSeT8qmsNY/l0dcc2aI3FNmTf9hmwoCuWZ/vix05OTsLha
         tsR4LF1FtDIeF8UDrXExHTDXiYr1eJMCklPMfaHnw8UQU59HONBopeSAITZ0iOzQSrfF
         MIRWZ5G8cNEItuSag3Uyc3RgqJFYyV8p+5fBzAd6w+dLKzAJY3+15DIyi34CM22O2ckW
         Tk4wXpfpPOu6kRvr0iZxuarK0qxkwbQ5GCIqKoMXAk5F59pQCQRrdYiPs9250DX4geNH
         gK9mKntVVdu04sFuMHjNh6qPysr7+AubRBLJ2UIhToGvM3O9v5atbbqfdMJW3IOF1+rg
         Iwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nuh17+p/kI43xREuVK4a8I5e5bWCvbJIdUjydClras=;
        b=gCVjgbPBwbZoJiu9Vb0E4jg6xlpmI4O3xwqNEPzU0yVt1TXFvYNGUsnDMzCbCiVe19
         yWOaDED5GyxCnFvjhfq+Ct2sWZlj21SFlJwEsNrVZuVg0P/VhSEsfXxCOZsaue3jW6B8
         wrYBXh3zZ/fiWGAejXesgFoCYwFrJr16jF2IEWhhCrnrEkkUBeLXco5Gete3Uj3raPXz
         RwSHJ/LIushZqXT8h6vufbWax5Ec0IFyyGKeDaiui45hdcEAIAowY7lhjwS2biYWDL5E
         IxdR07mKm3Eph1SacOquov7OD0xnegqXqGwdqTWg4MVs1D8xh99RZPVoew1YoGO5RBJa
         FWDA==
X-Gm-Message-State: APjAAAVYgaySyduCdgjqb1Pf+o8pN6HDqSAW5d48qJRnxoixiOaOXopf
        llz1Eb8B9hzwQc2Fg050Esz/T6/ZAsAXCOt3BWw=
X-Google-Smtp-Source: APXvYqx6jOFX7fXCIJg5d/gIYJoyJfFp3ZfHehGFXu/BR8JFH7cmkd7yHm4HprgiS1eZRLbMzoLdRM8tuKAakqpk0Ec=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr3740741wme.127.1573060854806;
 Wed, 06 Nov 2019 09:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
In-Reply-To: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Nov 2019 12:20:42 -0500
Message-ID: <CADnq5_O2wgq6YDXJXZizSKKmAbLDxRkQaSwAjofTS3pbTiPc2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix struct init in renoir_print_clk_levels
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Rex Zhu <rex.zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 6:10 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> drivers/gpu/drm/amd/powerplay/renoir_ppt.c:186:2: error: missing braces
> around initializer [-Werror=missing-braces]
>   SmuMetrics_t metrics = {0};
>     ^
>
> Fixes: 8b8031703bd7 ("drm/amd/powerplay: implement sysfs for getting dpm clock")
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied.  thanks!

Alex

> ---
>
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index e62bfba51562..e5283dafc414 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -183,11 +183,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>         int i, size = 0, ret = 0;
>         uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
>         DpmClocks_t *clk_table = smu->smu_table.clocks_table;
> -       SmuMetrics_t metrics = {0};
> +       SmuMetrics_t metrics;
>
>         if (!clk_table || clk_type >= SMU_CLK_COUNT)
>                 return -EINVAL;
>
> +       memset(&metrics, 0, sizeof(metrics));
> +
>         ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
>                                (void *)&metrics, false);
>         if (ret)
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
