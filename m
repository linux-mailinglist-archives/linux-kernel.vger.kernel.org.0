Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96322149609
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 15:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgAYOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 09:19:13 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33835 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 09:19:13 -0500
Received: by mail-il1-f193.google.com with SMTP id l4so3966440ilj.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IOcKziXindsQxuZaTjh7EfVGTRkJPvoLSajMaYU4bQ=;
        b=u4rlrp5t1zdQUP2lrVYfF1zHeG2xC8st3jya0uH58+r0q/il3Fw1F8ivF1eSce9grP
         XWBVQZOejohVU+nwMb1/WpTbOrDm7ZgSOANXYEt5Akfa+uZdQnaxRKe08ZHnzaklBXoK
         m9mqix9iA+l8cSTE9jp4PiAt2nuSo0ikktCfxigc7gm6VwSe0InRjGKkfFS2ft2n2Qou
         F2b4RZoQZIlwoZz1gXNjYMsbIzLScTQ48DNjELDgV6Uf4659ulgJrcGeIxjWTClOakiK
         l/IkUPDrThalszO+O57JcxT+jOgWcH1wrz1HIbzW7QTKCZmy1t52jhcU9BrUcMtyM3kC
         HPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IOcKziXindsQxuZaTjh7EfVGTRkJPvoLSajMaYU4bQ=;
        b=Z4Bpzu5rYUar1WUWutIQ5khyiThbgiqYUVI0j3tBA+ANm4mEqTdnhRBB6aLKRQdCmr
         k7Npxb4/L13pMRFIqsmZOqaQZo794oys4y7e6sKdmUDjJeb9khu8aif+2gTN4Wx1FgAj
         zGTC7SH5lNaVQqv7mwDs1lm0SeALWVGPEWYIrLsPudVqo6CZ3yrrWJBl3Nqwx6on3OkL
         CJ4NHElcWngtkNG4qsCGMQCNzaTe+wmMchJdbwNHBtfZcVc1wiz5J5dXr3q976UITmeT
         hJeMv4VmcVOszvI7e2rlJUHg81RC2wJ/A7HovjIl/l+ujf/wsSwDRqBc5y4ilODFpPzB
         yvdw==
X-Gm-Message-State: APjAAAXbi3CiKu31pAWycWWDneetKH5tUcEFj+YgsMLGX6Wz0LUoTeEo
        4rT1OTtiE1RtsVG9dBCiuI3LrSs9qIiU+4Xu5ppvig==
X-Google-Smtp-Source: APXvYqyM+JwU8gSk9qSy3E4AogkJSqMITiwY8nohhcaRXZroA6u/BFZkaxl05hUDIryEk+6OhG1pl1qRfPJQEWplfwg=
X-Received: by 2002:a92:9c52:: with SMTP id h79mr952579ili.213.1579961952536;
 Sat, 25 Jan 2020 06:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20200124161811.105623-1-yuhsuan@chromium.org>
In-Reply-To: <20200124161811.105623-1-yuhsuan@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Sat, 25 Jan 2020 22:19:01 +0800
Message-ID: <CA+Px+wVzK=L9nUTEzhPY36Zee-ZZOgFMCNvOi+tQ2Un0as9QDA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: Support setting bclk ratio
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 12:18 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>
> Support setting bclk ratio from machine drivers.
>
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

Please at least cc to <alsa-devel@alsa-project.org> for ASoC-related patches.

> @@ -42,6 +42,8 @@ struct cros_ec_codec_priv {
>         uint64_t ap_shm_addr;
>         uint64_t ap_shm_last_alloc;
>
> +       uint32_t i2s_rx_bclk_ratio;
> +

To be consistent, move the variable after the "DMIC" part and add a /*
I2S_RX */ comment.

>         /* DMIC */
>         atomic_t dmic_probed;

>         if (params_rate(params) != 48000)
> @@ -284,15 +287,30 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
>         if (ret < 0)
>                 return ret;
>
> -       dev_dbg(component->dev, "set bclk to %u\n",
> -               snd_soc_params_to_bclk(params));
> +       /* If the blck ratio is not set, get bclk from hw_params. */

A typo, s/blck/bclk/.  I don't think the comment is very necessary.
The code block is obvious.

> +       if (priv->i2s_rx_bclk_ratio)
> +               bclk = params_rate(params) * priv->i2s_rx_bclk_ratio;
> +       else
> +               bclk = snd_soc_params_to_bclk(params);
> +
> +       dev_dbg(component->dev, "set bclk to %u\n", bclk);
