Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165ECB891E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394686AbfITCPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 22:15:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40689 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393877AbfITCPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:15:54 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so12599520iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 19:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCOoZbEWKtr4nWo019PWhOoBv9r1gayiQ81xDLWsuSA=;
        b=nl1zEzsTUHhY6oblxscPvt5FsMX9d2aOz63yU4JY4HTxnINusvrNMlUi1Ne9yUwH8G
         bKRvr4caKaUH8eIew0x0yUeooD+u9iDUfmDj5GnGFm1ItR59VbJVzTfgzNUnzTcONTdo
         2dIhbeSNWtUBmi2w3PYgApV034BtNBSmZ0oXSUnd7ihoRuTzF8pU4O+77X82CUnPAv0T
         drgFu1SGTubLMU8EV78J8mImaGlPrv5Rnhh8IDjiArVLGV+V++r2x2YeH7BSiPf5n6SE
         qAh6VecSoYAEj1Tn714+tUazrFSXDf2bm3JYdF9+msbDgVfSA4hjY2/LUJrkAPvXOgyA
         noGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCOoZbEWKtr4nWo019PWhOoBv9r1gayiQ81xDLWsuSA=;
        b=o5INy3hBRVfVcnCnyQOU+7xPrdFjRPUl4ZteoDgwkfvVYsUcuGhQYLdp2mxAcMD2AJ
         dzHyqlrs+pwQGKerTLDMwqj0zphbjalXlQ3qQDBnAoZ8JmNLuisD7j+rTIw2PVE6NysE
         pybKnL1Np7byPQyu45b3VCsslKYkgj+iY0GBhe8QY3SFlbFm1Wx8/sLbo3SHpcPv69AM
         TKLLPHwhVceN6lbFE8sKkHY8NQqcObka/YXpHXsXwincbGCNQjhwgODfZgtZWIb00aMS
         4GDi9FSgrUwyFPGxfXuLdOTGEk2pM114gk9LFDmUWC55KzpeCkSDT7mZfbPmOIS9Wx3Q
         qS2w==
X-Gm-Message-State: APjAAAXQlGOgKaOmXnsSombaxi4fAil+KE83ZpALyA1WuSfi9ccQCUM9
        IqAyXgix5QqkGuTJocwc0Luq/YFaQ22WshPb7oU=
X-Google-Smtp-Source: APXvYqwtgfO3iRhsXm5IaNQKn/JY1x9+u1j59h6R4OKPyLmNYaLU0SzpGpH+aGBGvRXZ81bEjstc0XYe08v2v/Lu0AA=
X-Received: by 2002:a02:b782:: with SMTP id f2mr16512267jam.48.1568945752953;
 Thu, 19 Sep 2019 19:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
 <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
 <20190624093233.73f3tcshewlbogli@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uG02qAqH8MMpE6kzRO99HTjnadTFDrY1vVr9RmAiFPvJA@mail.gmail.com>
 <20190624112301.dmczf2vofxnpzqqi@DESKTOP-E1NTVVP.localdomain> <CAKMK7uEotYyRaa4WqNKRGc0nfwcyGccRpX2YzZmETrPdgXkAKA@mail.gmail.com>
In-Reply-To: <CAKMK7uEotYyRaa4WqNKRGc0nfwcyGccRpX2YzZmETrPdgXkAKA@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Fri, 20 Sep 2019 10:15:41 +0800
Message-ID: <CAKGbVbvLv6MDYapr5Oo5ZvJh+GV3-LU_ok2a8tpYGWOpw8hBBA@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        Raymond Smith <Raymond.Smith@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I'd like to know the status of this patch? I expect a v2 adding some
comments/macros about the high bit plan would be enough?

@Raymond & @Brian do you still need another long process to send out a
v2 patch? If so, I can help to prepare a v2 patch according to your
previous mail.

Thanks,
Qiang

On Thu, Jun 27, 2019 at 3:30 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Jun 24, 2019 at 1:23 PM Brian Starkey <Brian.Starkey@arm.com> wrote:
> >
> > On Mon, Jun 24, 2019 at 11:58:59AM +0200, Daniel Vetter wrote:
> > > On Mon, Jun 24, 2019 at 11:32 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> > > >
> > > > Hi Daniel,
> > > >
> > > > On Fri, Jun 21, 2019 at 05:27:00PM +0200, Daniel Vetter wrote:
> > > > > On Fri, Jun 21, 2019 at 12:21 PM Raymond Smith <Raymond.Smith@arm.com> wrote:
> > > > > >
> > > > > > Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> > > > > > denote the 16x16 block u-interleaved format used in Arm Utgard and
> > > > > > Midgard GPUs.
> > > > > >
> > > > > > Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> > > > > > ---
> > > > > >  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > >
> > > > > > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > > > > > index 3feeaa3..8ed7ecf 100644
> > > > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > > > @@ -743,6 +743,16 @@ extern "C" {
> > > > > >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> > > > > >
> > > > > >  /*
> > > > > > + * Arm 16x16 Block U-Interleaved modifier
> > > > > > + *
> > > > > > + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the image
> > > > > > + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pixels
> > > > > > + * in the block are reordered.
> > > > > > + */
> > > > > > +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> > > > > > +       fourcc_mod_code(ARM, ((1ULL << 55) | 1))
> > > > >
> > > > > This seems to be an extremely random pick for a new number. What's the
> > > > > thinking here? Aside from "doesnt match any of the afbc combos" ofc.
> > > > > If you're already up to having thrown away 55bits, then it's not going
> > > > > to last long really :-)
> > > > >
> > > > > I think a good idea would be to reserve a bunch of the high bits as
> > > > > some form of index (afbc would get index 0 for backwards compat). And
> > > > > then the lower bits would be for free use for a given index/mode. And
> > > > > the first mode is probably an enumeration, where possible modes simple
> > > > > get enumerated without further flags or anything.
> > > >
> > > > Yup, that's the plan:
> > > >
> > > >         (0 << 55): AFBC
> > > >         (1 << 55): This "non-category" for U-Interleaved
> > > >         (1 << 54): Whatever the next category is
> > > >         (3 << 54): Whatever comes after that
> > > >         (1 << 53): Maybe we'll get here someday
> > >
> > > Uh, so the index would be encoded with least-significant bit first,
> > > starting from bit55 downwards?
> >
> > Yeah.
> >
> > > Clever idea, but I think this needs a
> > > macro (or at least a comment). Not sure there's a ready-made bitmask
> > > mirror function for this stuff, works case we can hand-code it and
> > > extend every time we need one more bit encoded. Something like:
> > >
> > > MIRROR_U32((u & (BIT(0)) << 31 | (u & BIT(1) << 30 | ...)
> > >
> >
> > Is it really worth it? People can just use the definitions as written
> > in drm_fourcc.h. I agree that we should have the high bits described
> > in a comment though.
> >
> > > And then shift that to the correct place. Probably want an
> > >
> > > ARM_MODIFIER_ENCODE(space_idx, flags) macro which assembles everything.
> > >
> > > >         ...
> > > >
> > > > I didn't want to explicitly reserve some high bits, because we've no
> > > > idea how many to reserve. This way, we can assign exactly as many
> > > > high bits as we need, when we need them. If any of the "modes" start
> > > > encroaching towards the high bits, we'll have to make a decision at
> > > > that point.
> > > >
> > > > Also, this is the only U-Interleaved format (that I know of), so it's
> > > > not worth calling bit 55 "The U-Interleaved bit" because that would be
> > > > a waste of space. It's more like the "misc" bit, but that's not a
> > > > useful name to enshrine in UAPI.
> > >
> > > Yeah that's what I meant. Also better to explicitly reserve this, i.e.
> > >
> > > #define ARM_FBC_MODIFIER_SPACE 0
> > > #define ARM_MISC_MODIFIER_SPACE 1
> > >
> > > and then encode with the mirror trickery.
> > >
> >
> > I don't really see the value in that either, it's just giving
> > userspace the opportunity to depend on more stuff: more future
> > headaches. So long as the 64-bit values are stable, that should be
> > enough.
>
> If you think you need to save the few bits this potentially saves you
> over just encoding 8bit enum like in Qiang's original patch I think
> you get to type a few macros and comments ...
>
> > > > Note that isn't the same as the "not-AFBC bit", because we may well
> > > > have something in the future which is neither AFBC nor "misc".
> > > >
> > > > We've been very careful in our code to enforce all
> > > > undefined/unrecognised bits to be zero, to ensure that this works.
> > > >
> > > > >
> > > > > The other bit: Would be real good to define the format a bit more
> > > > > precisely, including the layout within the tile.
> > > >
> > > > It's U-Interleaved, obviously ;-)
> > >
> > > :-) I mean full code exists in panfrost/lima, so this won't change
> > > anything really ...
> >
> > Yeah, so for us to provide a more detailed description would require
> > another lengthy loop through our legal approval process, and I'm not
> > sure we can make a strong business case (which is what we need) for
> > why this is needed.
> >
> > Of course, if someone happens to know the layout and wants to
> > contribute to this file... Then I don't know how ack/r-b would work in
> > that case, but I imagine the subsystem maintainer(s) might take issue
> > with us attempting to block that contribution.
>
> Well can't really take a modifier without knowing what it's for, I
> guess this is up to lima/panfrost folks then to figure out :-P
> -Daniel
>
> >
> > Thanks,
> > -Brian
> >
> > >
> > > Cheers, Daniel
> > >
> > > >
> > > > -Brian
> > > >
> > > > >
> > > > > Also ofc needs acks from lima/panfrost people since I assume they'll
> > > > > be using this, too.
> > > > >
> > > > > Thanks, Daniel
> > > > >
> > > > > > +
> > > > > > +/*
> > > > > >   * Allwinner tiled modifier
> > > > > >   *
> > > > > >   * This tiling mode is implemented by the VPU found on all Allwinner platforms,
> > > > > > --
> > > > > > 2.7.4
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
