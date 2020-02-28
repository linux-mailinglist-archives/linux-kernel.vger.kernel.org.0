Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B717370F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1MQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 07:16:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34816 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgB1MQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:16:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id 145so2719363qkl.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jW+oim1VKB75nwiyeU54QJMiA6ZEtr8g9KMSvdI3vz8=;
        b=AykcLh89sWZynHDKkElwfoxjaLKCsJqV1sXME/jD+lPWIn8yQMaVrd05+dRnpy/5is
         PWMq8k5d21GsrzfFNDTWMd9WSK8HXFxKMKCqBe225VEszplUAHOHtC610oFzYAAOrtFl
         hYAHWYGSYsSaGwXKcG9RoBvrDxPfxtXjSUFzz99vzNfuqj6edbpVE9QRu4L8VQPTpzY9
         cXrmtkZrzjcfkrtwHPrJz2J4Ix8KePzJwQ1CpVxrEvYfUR2x5fFrKoUIYNbK+dzAT4Ap
         o7H73mEf8SamKPsHa0GUGbIUfoZUWPrsHcXJCqU72QWv1zhHkizkYuzNfG+BYlymI8dS
         lk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jW+oim1VKB75nwiyeU54QJMiA6ZEtr8g9KMSvdI3vz8=;
        b=Lzg3eMC4EP+BYnuS6YoIQPecgw+QpkrBX+QatakfzYChcOaQBS2V9/NYOqz55JyNVu
         zKcFDGkkVnd99eppvoKz2YftKhCstHKNpkJoG/VRX2eSGvyLgsWDBKb4SJKzHRap9DVn
         KAJEF7N8fUaUCsLw/8vm+apfEAI482PcgD1McjfG4q7J/95OEaUuQu9eX8PiLUss5yO3
         MUJptfhQSQk2eMKWxhPkkocO8a2iSBRs/h61uocGu1f4oMNB8eHJHN3K39VCWCbjzWQN
         QpPvXv+AzPFHe1wplcrYLFDyzr2LcyoTVtgpAry0Z8/qCsRByPYjnJnYKcgK7h1QhBtR
         jSNQ==
X-Gm-Message-State: APjAAAXEA39ghJDXcPQEOXFawRwAoXukjamLIN9suFC1XYhCnLa8lN3q
        g1Mrct+SZGdlpA5SfjhVKHt8lqAt/6JL7iJv2WHJAg==
X-Google-Smtp-Source: APXvYqzMcs4xH83OCydBwkkGvs4VqYu/TjyplsOfHV6hLy/Tvr7wP9fzKzFY0pvTGD1FfhZesOpdLTJ6PMJPcvrLRwE=
X-Received: by 2002:a37:84c6:: with SMTP id g189mr3611903qkd.427.1582892191000;
 Fri, 28 Feb 2020 04:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20200203121620.9002-1-benjamin.gaignard@st.com> <75b302aa739511b3cc2abf4360d5780a08e7c17a.camel@redhat.com>
In-Reply-To: <75b302aa739511b3cc2abf4360d5780a08e7c17a.camel@redhat.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 28 Feb 2020 13:16:20 +0100
Message-ID: <CA+M3ks6xifM2xwx6PR_xuLRYV2GEprtgcM7+_26Z3WbZMRrVeg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Check crc4 value while building sideband message
To:     Lyude Paul <lyude@redhat.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 4 f=C3=A9vr. 2020 =C3=A0 20:00, Lyude Paul <lyude@redhat.com> a =C3=
=A9crit :
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>

Applied on drm-misc-next
Thanks,
Benjamin

> On Mon, 2020-02-03 at 13:16 +0100, Benjamin Gaignard wrote:
> > Check that computed crc value is matching the one encoded in the messag=
e.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > ---
> > CC: lyude@redhat.com
> > CC: airlied@linux.ie
> > CC: jani.nikula@linux.intel.com
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 822d2f177f90..eee899d6742b 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -736,6 +736,10 @@ static bool drm_dp_sideband_msg_build(struct
> > drm_dp_sideband_msg_rx *msg,
> >       if (msg->curchunk_idx >=3D msg->curchunk_len) {
> >               /* do CRC */
> >               crc4 =3D drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_l=
en -
> > 1);
> > +             if (crc4 !=3D msg->chunk[msg->curchunk_len - 1])
> > +                     print_hex_dump(KERN_DEBUG, "wrong crc",
> > +                                    DUMP_PREFIX_NONE, 16, 1,
> > +                                    msg->chunk,  msg->curchunk_len, fa=
lse);
> >               /* copy chunk into bigger msg */
> >               memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_=
len -
> > 1);
> >               msg->curlen +=3D msg->curchunk_len - 1;
> --
> Cheers,
>         Lyude Paul
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
