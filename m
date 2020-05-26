Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892EE1992BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgCaJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 05:55:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46323 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbgCaJzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:55:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so10079133pff.13;
        Tue, 31 Mar 2020 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OhHn08M8/D8HCM9gjXRbI/j0PhmAwA3tYAp3gRgxrKk=;
        b=veoTVgVRtYQTK+5zN3HYDh+HdtUTeX2nPPRVzQPABdleK9zHQb4Qfl3r/T33195phu
         DUMvCdDjmJ78SwW3P5o7zoX0gQW9ZZDwSrxEVbpixY5yShzky96M6m66YJKWwWc/MH7V
         DTMF5UWOC4YbOb73eYMwZR65xCARdm0J/queSu86YPQrB0FH77ohZOcmu/5KUeQVQ6I4
         nQFqCHefw2XGkVEG/L6uSEWsxvl3sjAAL6Ir2zECJfvkWLoJdbK4tzNXLmcUYsGJ/sBq
         CPnwAaW2kHAUq3VyOfa33eKhAyvQVC0DX4/21UX9tD/bRIhnr7KrIZxDHyWY1o/jw5ul
         +t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhHn08M8/D8HCM9gjXRbI/j0PhmAwA3tYAp3gRgxrKk=;
        b=qfBNUbcbHxNKTH3tp86gb0/BWysLF7QEpcAm6XHTs+C5M462q2VxeS8OpKkVJ3bA1h
         h0LRQ5zXQzmRvs5Sh9Dc6GIPZ+hCoArIsafUg+gIQYZz7wVRV8l76BhJNJrqw6VEEDiY
         ktnRRZmBEZJku9HMxm45xOtBlnpKwXornjOnlFhz60WzrSEyx/I8bF9NUflaBWq79eOG
         NsENh2s09QliQiGO91BLSnKJLO/f3Two2w0a97Sjh8MmOPr7ABNhCxu2tLdO8IT/Yxs2
         m6pJNaSBt9S4+QPu6nI3dCcp7myluDUy4LJ8En0t7YkzMjLL5vJtq+z+fwNarlk5V8Nk
         5/IQ==
X-Gm-Message-State: AGi0PuZ9SaC+lbGKRngEJwuv8WZGhy8Mxn+x31QC4XAQaGTCZ0AmTwJB
        8b8hUA02LYveYrPxrvWBADE=
X-Google-Smtp-Source: APiQypKviN8/GNUryvnwnsY+oU28GHx/wV6pyb4CAI4uheoqqx5DsQb2OaoNtRTW26FnN4BK6da7gA==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr4395435pgd.277.1585648552952;
        Tue, 31 Mar 2020 02:55:52 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id mq6sm1626110pjb.38.2020.03.31.02.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 02:55:52 -0700 (PDT)
Date:   Tue, 31 Mar 2020 02:55:34 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200331095534.GA2976@Asurada>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
 <20200320173213.GA9093@bogus>
 <20200323212038.GA7527@Asurada-Nvidia.nvidia.com>
 <CAA+D8APu0JYqnUvY+fCYTcZ9U1BCv-zU8J4Zt-5doZcNkgaXFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8APu0JYqnUvY+fCYTcZ9U1BCv-zU8J4Zt-5doZcNkgaXFQ@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:28:25AM +0800, Shengjiu Wang wrote:
> Hi
> 
> On Tue, Mar 24, 2020 at 5:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Fri, Mar 20, 2020 at 11:32:13AM -0600, Rob Herring wrote:
> > > On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> > > > On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > > > > In order to support new EASRC and simplify the code structure,
> > > > > We decide to share the common structure between them. This bring
> > > > > a problem that EASRC accept format directly from devicetree, but
> > > > > ASRC accept width from devicetree.
> > > > >
> > > > > In order to align with new ESARC, we add new property fsl,asrc-format.
> > > > > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > > > > can accept format from devicetree, don't need to convert it to
> > > > > format through width.
> > > > >
> > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > > > index cb9a25165503..780455cf7f71 100644
> > > > > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > > > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > > > @@ -51,6 +51,11 @@ Optional properties:
> > > > >                     will be in use as default. Otherwise, the big endian
> > > > >                     mode will be in use for all the device registers.
> > > > >
> > > > > +   - fsl,asrc-format     : Defines a mutual sample format used by DPCM Back
> > > > > +                   Ends, which can replace the fsl,asrc-width.
> > > > > +                   The value is SNDRV_PCM_FORMAT_S16_LE, or
> > > > > +                   SNDRV_PCM_FORMAT_S24_LE
> > > >
> > > > I am still holding the concern at the DT binding of this format,
> > > > as it uses values from ASoC header file instead of a dt-binding
> > > > header file -- not sure if we can do this. Let's wait for Rob's
> > > > comments.
> > >
> > > I assume those are an ABI as well, so it's okay to copy them unless we
> >
> > They are defined under include/uapi. So I think we can use them?
> >
> > > already have some format definitions for DT. But it does need to be copy
> > > in a header under include/dt-bindings/.
> >
> > Shengjiu is actually quoting those integral values, rather than
> > those macros, so actually no need copy to include/dt-bindings,
> > yet whoever adds this format property to a new DT would need to
> > look up the value in a header file under include/uapi. I's just
> > wondering if that's okay.
> >
> > Thanks
> Shall I keep this change or drop this change?

This version of patch defines the format using those two marcos.
So what Rob suggested is to copy those defines from uapi header
file to dt-bindings folder. But you don't intend to do that?

My follow-up mail is to find if using integral values is doable.
Yet, not seeing any reply further. I think you can make a choice
to send it -- We will see how Rob acks eventually, or not.
