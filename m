Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948AF17CB7B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 04:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCGDYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 22:24:44 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36703 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCGDYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:24:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id u25so4352951qkk.3;
        Fri, 06 Mar 2020 19:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xx47FJX+QZbsjpJJ8x5FoZzQPuJdzEkyLKKPH7vo5sk=;
        b=V6CTG2BcTle4ax3VW2GMHUYNQikRPHCX4W8GrQB30I7oTu+yciihautJPRVRVjQ/Fc
         4kw1eamGfYWI+0JA2+f4WTC0j66nFLcnd99j+u/JabWCi3MKzZqlGYpUGHSL2uG7mtIF
         BfhUwv1spkZ3ujZfrr3fUBm8ngmoJQzhDuiHuJu/QP0GKueGBjshtLXt46XuOmZgKx/k
         JuhzFIkghSF56z6430kkDS6XYJ9RA+oqlafgd4aUUnS5t52RLf0rttvgMrL1JBERiRYX
         RpwRRbLrCwoL2EWUcYPnjqPBEq6rHC9UTbskZJ/gSdsjmpVPKgwIbE0mfl05KL3hJagt
         G8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xx47FJX+QZbsjpJJ8x5FoZzQPuJdzEkyLKKPH7vo5sk=;
        b=ZtNJrkPrOYNUvLBuBSYru29cikjWe24CmuHm7vdRHvcqmzpb77S1/X3tEhepW2hMkP
         /nTV9rt0PJwKWaXJ59SV7tHIdkdBgJPdVedeWVQ0+ivDwc/s3JS+1Jm2u6xqMY2aF20k
         /5JEdNiQAO4dBJk/8xuwWqmcQIJRfU410oMylwR2EJvLUsOkSJM17jZBXOC9/RnnKEXW
         QIpR3ZXLTGGwkp/kLDFKiec+aZUDq56VXEKncMErOi1cl6mg6miXlhYTc9qVDTKCWkpB
         1Z15ZtIa7OrhhjihDWIem7/h/NyzQElJQLhyWKYVdxNpG+Lzr+jseaWDewDR0b8QSyYA
         cO3A==
X-Gm-Message-State: ANhLgQ2mWJQW63OGtyC95nD/emT9nKXhb900gy40S3fsakI1eAO57y4Y
        0+SIJsKOt7OoxFocaq3k/yI+JxwwcoicDHid1ug=
X-Google-Smtp-Source: ADFU+vsrgn/I7/3yq0U87aezc5EPcL/v/ioSyi8uCEcZqO8JoZIjCstooShLZGMYvgHn2vn/uc1R6Au9Gus47NWljDo=
X-Received: by 2002:a37:a50d:: with SMTP id o13mr5736750qke.37.1583551482955;
 Fri, 06 Mar 2020 19:24:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583039752.git.shengjiu.wang@nxp.com> <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
 <20200303014133.GA24596@bogus> <CAA+D8ANgECaz=tRtRwNP=jMXBD0XciAE0HUYROH8uuo03iDejg@mail.gmail.com>
 <20200303124739.GE3866@sirena.org.uk>
In-Reply-To: <20200303124739.GE3866@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sat, 7 Mar 2020 11:24:32 +0800
Message-ID: <CAA+D8AMkmHZoZ7Oa0_OGfgRAC+H-117e1bNJgzyiWGTueyxDzg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to asrc-format
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Mar 3, 2020 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 11:59:30AM +0800, Shengjiu Wang wrote:
> > On Tue, Mar 3, 2020 at 9:43 AM Rob Herring <robh@kernel.org> wrote:
>
> > > > -   - fsl,asrc-width  : Defines a mutual sample width used by DPCM Back Ends.
> > > > +   - fsl,asrc-format : Defines a mutual sample format used by DPCM Back
> > > > +                       Ends. The value is one of SNDRV_PCM_FORMAT_XX in
> > > > +                       "include/uapi/sound/asound.h"
>
> > > You can't just change properties. They are an ABI.
>
> > I have updated all the things related with this ABI in this patch series.
> > What else should I do?
>
> Like Nicolin says you should continue to support the old stuff.  The
> kernel should work with people's out of tree DTs too so simply updating
> everything in the tree isn't enough.

Thanks for review, I will update patch in next version.

best regards
wang shengjiu
