Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7820C18E816
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 11:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCVKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 06:47:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43847 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 06:47:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id o10so6383124qki.10;
        Sun, 22 Mar 2020 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6yehooPiFA7WFzSiN6iRq3URFGEeFNRubLJGaTKKeg=;
        b=vfJ1KtbeLDw5rFqeb6hIPBm5Sc1u7NaY5cV22O2B6Qr5sj+BUBGQBoxgBnDyG25Uun
         XarmSsEFe+LOGy/CsGvlXp+gB1ey4rj/w4Psk1IdT1KxfgfNvtobd8eTKawz4omDaCAp
         9Q1QqhexZiCi+puZyxpV4LbWTJuBfTBAcqE1JoZWo+/JFNDLXF0lZPnVSo+5jl0996fB
         IGiNJbsb2PBmJIQOaHcEPBaA6RMSFpgUk6E0F6mA/cK5z1KzcLPQfehaIJPM83S3xcQ/
         LjQj/DgPr2S3dv9JTzva8TGWqrNMpWa3T1ybGhe65sBtgGwJoKR509wm+j/05GFrFu65
         EB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6yehooPiFA7WFzSiN6iRq3URFGEeFNRubLJGaTKKeg=;
        b=I69OROpfYK5NGlQQ0NzQeqNa/Vm5rWvE/UzHgIjJHskSXMYBlEQj5rF2KcbQaLY77C
         6d0WNKkuNhCgTTTq8eAsvOtJkaIDmHkN+04V9SxWrxfF34zCqhOKDLWGQ+gDRd3J/ONz
         vsoXmUqNKT3//rmBZW5xofcKx1JcXWZiQBzszZonyCBsG+xisZIVqwyWo+g3oIL25Xyq
         2yqeylPrLiyWJriA4REiJ5fTHDf0idIZ1wgtVrmHXvQhXETUNU3uWGBtjWWATvSXWVBy
         KUOoHgKlZnzgv2Y+UHEWdNPX+6DZ0rMgAVtPVImULvJblXbDygCVEiUMHcgAB+TVRHUd
         Na+w==
X-Gm-Message-State: ANhLgQ13+1LkZ64GtV4KGtbXDfwN1KuNd4bTTmFux0aDBc/2IhM453Kv
        RQhxzV556vU+fsC2FZBgXzY9/STTeeHxIu34qr8=
X-Google-Smtp-Source: ADFU+vtFlqm8k9nbdJLDkTWAYuVNBzwsd2eGqUIfasY6+bquWnBaxo5guuFzQCC/yubJX5XQ8gab/74PHmKPUs49zC4=
X-Received: by 2002:a37:9683:: with SMTP id y125mr16639605qkd.450.1584874041867;
 Sun, 22 Mar 2020 03:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583725533.git.shengjiu.wang@nxp.com> <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com> <20200320173213.GA9093@bogus>
In-Reply-To: <20200320173213.GA9093@bogus>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 22 Mar 2020 18:47:09 +0800
Message-ID: <CAA+D8APtW+ZRvJufzhNSw8acTdhGRQNphZcyVYnV-ZLUbtTGew@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 1:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> > On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > > In order to support new EASRC and simplify the code structure,
> > > We decide to share the common structure between them. This bring
> > > a problem that EASRC accept format directly from devicetree, but
> > > ASRC accept width from devicetree.
> > >
> > > In order to align with new ESARC, we add new property fsl,asrc-format.
> > > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > > can accept format from devicetree, don't need to convert it to
> > > format through width.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > index cb9a25165503..780455cf7f71 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > @@ -51,6 +51,11 @@ Optional properties:
> > >                       will be in use as default. Otherwise, the big endian
> > >                       mode will be in use for all the device registers.
> > >
> > > +   - fsl,asrc-format       : Defines a mutual sample format used by DPCM Back
> > > +                     Ends, which can replace the fsl,asrc-width.
> > > +                     The value is SNDRV_PCM_FORMAT_S16_LE, or
> > > +                     SNDRV_PCM_FORMAT_S24_LE
> >
> > I am still holding the concern at the DT binding of this format,
> > as it uses values from ASoC header file instead of a dt-binding
> > header file -- not sure if we can do this. Let's wait for Rob's
> > comments.
>
> I assume those are an ABI as well, so it's okay to copy them unless we
> already have some format definitions for DT. But it does need to be copy
> in a header under include/dt-bindings/.

Thanks for reviewing. seems it is not a good time to add a new header
file in include/dt-bindings/ in this patch serial. I will drop this change
this time, that still using the "fsl,asrc-width".

best regards
wang shengjiu
