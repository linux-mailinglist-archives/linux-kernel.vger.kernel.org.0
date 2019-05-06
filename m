Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF091451F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEFHZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 03:25:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39487 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEFHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:25:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id z128so4665496qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pO57+WHM9icAQXA84tNTYrkL98PNEsC+5xBzFAyNyVg=;
        b=Q4sRowf0YZqref5eztkLd8S7ufHGsFLRndJMSOMuqY3b4S0MmgjZiYllijIxccx3+i
         d8qqm5j/vpnQrGZwJxPwwlWKsTrjEKWY6V1DThjLxMKK0nJ3OLFoyeqykRh4uzGe/OfR
         dByViWZvEs33mHGK/JVSuWGgxQUZHf262x09TCQPzgdAysQkppKolZRuF8gPsb228h1n
         iZNxlwS9hfyLFHgtVphlUl3yYDAaS0SGzHvmBgn3v+C0jrO4dnMBQekgtaTwTwxTYNQj
         JDN9iFu/x6u/ntfRt42Z+55u5TsUjZFp48zR3MbdjmPhULajgsdi4kI1dK6BPdNnQTjK
         OxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pO57+WHM9icAQXA84tNTYrkL98PNEsC+5xBzFAyNyVg=;
        b=COMMSIoOGRXSbjLlLkAOvjYbY7Dz89Mb4GdzKNiydKnNwQCKHUOMTXdE7rFtEcxNBF
         HOUhtNFaGG+Qa3wina5F+sGRpdSlMhytEGnC/lxiQ5esYiS+S9Qg0M5ZK6dM8iAvVHfP
         0p5nrsqGj8+2f9OzeIPkBSLiGztqWOphyj6gwd2KjSzyqWOsIbZ5uu1cokjO+vq39qdV
         x8rdCdud0KJnliosvnqCQvbyhqXzB1DOxfe6ElZ5eNEh9/xpdISMgPPd4OmA4jKTd6tZ
         UO2nK2CluD0W8bxvmaTXDeXw5akd/wE7Aoa0G7rJ/KyU6su34x9NaKo5sN7R0D8MgjYS
         A5QQ==
X-Gm-Message-State: APjAAAUiNqco3be/POi/ySJt5qcAdZoy/p5ew+H3BXsZPK0pYLxkc9e/
        cMwrelH3F4qcDDnfD+wFFRi+E2ephzpTQf9OveeszA==
X-Google-Smtp-Source: APXvYqzi6kaFJ7dpE+n+VOhA31cBwTt9A6DfQSW/RJ6FOD2P+M23nMnX4FFbt/nvMku6Ns54SMrMIRxJijtROfat5M4=
X-Received: by 2002:a37:8843:: with SMTP id k64mr18569492qkd.8.1557127545107;
 Mon, 06 May 2019 00:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
 <1556114601-30936-2-git-send-email-fabien.dessenne@st.com> <c445397b-36a7-3511-603a-e94ae6ddcf12@st.com>
In-Reply-To: <c445397b-36a7-3511-603a-e94ae6ddcf12@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 6 May 2019 09:25:34 +0200
Message-ID: <CA+M3ks6M7BC3VP-4O7suVucnYySJps4CxyAyVz_ra5EVDUzrag@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/stm: ltdc: manage the get_irq probe defer case
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 26 avr. 2019 =C3=A0 14:30, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
> Hi Fabien,
> and thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
> Philippe :-)
>
> On 4/24/19 4:03 PM, Fabien Dessenne wrote:
> > Manage the -EPROBE_DEFER error case for the ltdc IRQ.
> >
> > Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Applied on drm-misc-next.
Thanks,
Benjamin

> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 566b0d8..521ba83 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1174,6 +1174,9 @@ int ltdc_load(struct drm_device *ddev)
> >
> >       for (i =3D 0; i < MAX_IRQ; i++) {
> >               irq =3D platform_get_irq(pdev, i);
> > +             if (irq =3D=3D -EPROBE_DEFER)
> > +                     goto err;
> > +
> >               if (irq < 0)
> >                       continue;
> >
> >
