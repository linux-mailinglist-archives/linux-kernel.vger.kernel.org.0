Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A531170FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgB0FKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 00:10:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46540 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgB0FKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:10:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id i14so1355795qtv.13;
        Wed, 26 Feb 2020 21:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pivyxHSyqwryDPI9Gp60bBQcqgh4EowGAu7KJlQgz8E=;
        b=H4jCUaLfJYUfLLqA3eJUJTu4b5XveFIshSWzC8Y9ln+QPHPxLUrzmrpESy/4akroJp
         Z1nDx07X+MlLtNHzVPHE0eRY5Ki3r78WV31qoXhY51kbpvG/tDwciXC480UedUkCVCLI
         CfSE9KcQk9zWNnCwGGaiXi0+XGAOA+cUPGSLF1Kl8WM911mYZ5WBeZjtQ4p7/trNAmiG
         lee0S5ks436Q82ah/K+yp4MxHyjN4E9/4sbSeYHC8ECGGPVvAIYYtbLsEKwL6P41B1Jg
         5juA7vU9RxBBlarCdwpP1F6wZhIcVRvZZ8LOzUBwNwcutzQsS1no+Zbav7A+e8MY9XBO
         f9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pivyxHSyqwryDPI9Gp60bBQcqgh4EowGAu7KJlQgz8E=;
        b=P+rfVjrCmQdv7CjsQC6DA6IBYdcYOYo3uZ59w2bV6YXx1hggcaM2T1IoLAP8eI+kCn
         HIQ69jISmeDCan93DqUuFNILyT6dYD+01s0dz4o/RAqfkwYloje15WfrqMxrUJIGS6tZ
         E1D+ue13+F5MWC2v5BsPLTWOWmEx0fceKtrHIuiwVzYuGt55r9MnJx0c48e6AMRrdTfO
         RkVcdUdVHWqKo9KFkMuMIuvp3KzVtdZC2hOwwJgYLN6BsbKmA3l7ssc02yN2SgNcf0Sb
         sHFX0Km4weYzUTE2oquvtJqOIKmOliEdjfInPpyUpfriZtZN/hQ5aE1KefP/8pkkOh+K
         1hVA==
X-Gm-Message-State: APjAAAUaSxgH5NG8UiziUsX1uUXWzje3RxWi0/UQxwzOmGdr5E47opUF
        NxSUkdvBH1H6LFDTM31rDG4udjb3SQoZM9Q4UKk=
X-Google-Smtp-Source: APXvYqycq8WwBFtqjVUYzXazfM0rpHuJEyxghtCnM5oaWtr3OyjFzAOxbLU+lLoU9oiDrDjLlu176P4wnMzSmLHlnG0=
X-Received: by 2002:ac8:5298:: with SMTP id s24mr2831317qtn.54.1582780230751;
 Wed, 26 Feb 2020 21:10:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582770784.git.shengjiu.wang@nxp.com> <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
 <20200227034121.GA20540@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20200227034121.GA20540@Asurada-Nvidia.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 27 Feb 2020 13:10:19 +0800
Message-ID: <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_asrc: Change asrc_width to asrc_format
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:43 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> > asrc_format is more inteligent variable, which is align
> > with the alsa definition snd_pcm_format_t.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
> >  sound/soc/fsl/fsl_asrc.h     |  4 ++--
> >  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
> >  3 files changed, 14 insertions(+), 15 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > index 0dcebc24c312..2b6a1643573c 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
>
> > @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> >
> >       pair->config = &config;
> >
> > -     if (asrc_priv->asrc_width == 16)
> > -             format = SNDRV_PCM_FORMAT_S16_LE;
> > -     else
> > -             format = SNDRV_PCM_FORMAT_S24_LE;
>
> It feels better to me that we have format settings in hw_params().
>
> Why not let fsl_easrc align with this? Any reason that I'm missing?

because the asrc_width is not formal,  in the future we can direct
input the format from the dts. format involve the info about width.

best regards
wang shengjiu
