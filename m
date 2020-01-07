Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23B0132754
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgAGNNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 08:13:50 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44133 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgAGNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:13:50 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so20446170qvg.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 05:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/SE5McdrTSka+bx/IZ5kkM57UgYz4XAyQjoMJHuUQs=;
        b=lp6BmAU0n6esjFwvTsD7juffeuCaGxC1bSIiRNmFr/sUC7nD5ezvlMA1x7UHlOLYXZ
         xDPoQt7suR7V6Rmb6dy09Qjh7HkEXo1/ev014cf5hflGFRxsp52Lr07pRFS+LElYp6K4
         aCUJYZuW+cZyknx5s5p8l/Kd72gHgbGO1cM5KX3ge2uJhU9b8k+L0ZfXWym+zmpB93Xc
         coCXwor7WgQCDiokAh0sCEoVPu3p6dBqfVfn8Z6jrrlp2MGxEuC+NKBDebCcPYg9hz4z
         PIrQYpG7mvATEWjsO08YCVZmyl4udH1ZEyOukIzlb/dcM6B92e1rpsUaz3fNlbPPwKs6
         eNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/SE5McdrTSka+bx/IZ5kkM57UgYz4XAyQjoMJHuUQs=;
        b=qWDChhN+o1bVeESAORDLu5tzeXdnmW7mri42eJuM0hL993Nusu7v1GM3V8pD3+RNoU
         ZJCapABSFuDigJaRNp4WoET+0dBZULQSFswnFFqoAxGGYMefpfCQOY8M8V3pAEePPoTr
         WIV5+mMosEWhrVi0Qx1U5Iry2lV5kEYqsTcg5MxOlsU5hUtsrCdktXoUXLs1L3Zq0vsZ
         SlxkNHOzePLxygrMFO5rnCJSUpp237csNWm+1us7zGwqzYJzmaPjzx2rpCBqs+olgmLF
         INbQPsx586RJF4y0uzvGGveVtunsw1GoQUOmNzg8tmHp6to7+7x/ykOW1+RKoqIs7pIU
         pcHw==
X-Gm-Message-State: APjAAAV/pCn3RY/U7c4BYLLSuuVlVg2QKDt+JKeSPY8GPVOuSXrKp44k
        04DccfTuR2lvlnT44zJYk05J6psM6iF29JTp2yih1A==
X-Google-Smtp-Source: APXvYqxD8SqL3UJjUIuFxPcR3Me6JeA87ulj3MZhtnLa0lw2HLKk/7HlGnEg2mKYujkBBWSJY2LF26CwTxc/tN5acsw=
X-Received: by 2002:a0c:cd8e:: with SMTP id v14mr83896788qvm.182.1578402829335;
 Tue, 07 Jan 2020 05:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20191210102437.19377-1-benjamin.gaignard@st.com>
In-Reply-To: <20191210102437.19377-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 7 Jan 2020 14:13:38 +0100
Message-ID: <CA+M3ks7ha2PkznLJ8JO=ZLo9eN2Q3ijiR+Zw9x2PKPH3Vwbovw@mail.gmail.com>
Subject: Re: [PATCH] drm/modes: tag unused variables to avoid warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, yakui.zhao@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 11 d=C3=A9c. 2019 =C3=A0 10:20, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Some variables are set but never used. To avoid warning when compiling
> with W=3D1 and keep the algorithm like it is tag theses variables
> with _maybe_unused macro.

Gentle ping.
Thanks,
Benjamin

>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in this version:
> - do not modify the code to remove the unused variables
>   just prefix them with __maybe_unused macro.
>
>  drivers/gpu/drm/drm_modes.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 88232698d7a0..70aed4e2990d 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -233,7 +233,7 @@ struct drm_display_mode *drm_cvt_mode(struct drm_devi=
ce *dev, int hdisplay,
>                 /* 3) Nominal HSync width (% of line period) - default 8 =
*/
>  #define CVT_HSYNC_PERCENTAGE   8
>                 unsigned int hblank_percentage;
> -               int vsyncandback_porch, vback_porch, hblank;
> +               int vsyncandback_porch, __maybe_unused vback_porch, hblan=
k;
>
>                 /* estimated the horizontal period */
>                 tmp1 =3D HV_FACTOR * 1000000  -
> @@ -386,9 +386,10 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdi=
splay, int vdisplay,
>         int top_margin, bottom_margin;
>         int interlace;
>         unsigned int hfreq_est;
> -       int vsync_plus_bp, vback_porch;
> -       unsigned int vtotal_lines, vfieldrate_est, hperiod;
> -       unsigned int vfield_rate, vframe_rate;
> +       int vsync_plus_bp, __maybe_unused vback_porch;
> +       unsigned int vtotal_lines, __maybe_unused vfieldrate_est;
> +       unsigned int __maybe_unused hperiod;
> +       unsigned int vfield_rate, __maybe_unused vframe_rate;
>         int left_margin, right_margin;
>         unsigned int total_active_pixels, ideal_duty_cycle;
>         unsigned int hblank, total_pixels, pixel_freq;
> --
> 2.15.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
