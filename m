Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E7BD4710
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfJKR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 13:59:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51062 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbfJKR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:59:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FAB26083C; Fri, 11 Oct 2019 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570816753;
        bh=dEIHNtPJMeVe0/U1DX6bBGn/UKV/780n6No7ph7w8yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ykg12PFZxT3nlVFtqTIhn/ikrDlmLyXYQarYtasJm3LbVyNw1Fz57B12hB+1YPDM9
         6LJGerahP2a6tl7FZJHSWwMkodCM0qAt/hwJxmR+DthNHoGHCAuw2tg2L5ZsqP4E/Q
         6wPXvWTDQ399qJ7dp/et0vHhzJTHV5V3MkzPxiPw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C154460AA8;
        Fri, 11 Oct 2019 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570816751;
        bh=dEIHNtPJMeVe0/U1DX6bBGn/UKV/780n6No7ph7w8yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=erwjxUldW6GlHm6A6jcnS4u/PE5qvU7lC+CFWLChnB2fTSNBAayRrlR3yr02FrHtL
         j9sbYg75buj9H5hd5WKvylgrlxFaYqV9WhnuGQok/00O3pJmTuhNuBDbeVPav3XpNk
         NLLhdJFUZEa6OwgZ9YkDGijCyM85w2BdKE5zuUVw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Oct 2019 10:59:11 -0700
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm/meson: fix max mode_config height/width
In-Reply-To: <20191009104727.GX16989@phenom.ffwll.local>
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local>
 <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
 <CAKMK7uHxiDF3z19cMBb0o2o4Ev0DFJkhMR7Ny6U2776Ry4oc=A@mail.gmail.com>
 <8e980de4-5a52-8f3d-fba2-734617e40d1b@baylibre.com>
 <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
 <5dbd6337-7e08-f3f7-6d4a-d6bcaddfd3be@baylibre.com>
 <91cd8a2aebefd4ea3e9bcee5a4ef796a@codeaurora.org>
 <20191009104727.GX16989@phenom.ffwll.local>
Message-ID: <27976f3eca6bd96dcea071db97c229b1@codeaurora.org>
X-Sender: jsanka@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-09 03:47, Daniel Vetter wrote:
> On Tue, Sep 24, 2019 at 10:28:48AM -0700, Jeykumar Sankaran wrote:
>> Reviving this thread from the context of the below conversion:
>> 
>> 
> https://lore.kernel.org/linux-arm-msm/db26145b-3f64-a334-f698-76f972332881
> @baylibre.com/T/#u
>> 
>> On 2018-10-05 01:19, Neil Armstrong wrote:
>> > On 05/10/2018 09:58, Daniel Vetter wrote:
>> > > On Fri, Oct 5, 2018 at 9:39 AM Neil Armstrong
>> > > <narmstrong@baylibre.com> wrote:
>> > > >
>> >
>> > [...]
>> >
>> > > > OK, won't this be enough ?
>> > > > --- a/include/drm/drm_mode_config.h
>> > > > +++ b/include/drm/drm_mode_config.h
>> > > > @@ -333,6 +333,8 @@ struct drm_mode_config_funcs {
>> > > >   * @min_height: minimum fb pixel height on this device
>> > > >   * @max_width: maximum fb pixel width on this device
>> > > >   * @max_height: maximum fb pixel height on this device
>> > > > + * @max_fb_width: maximum fb buffer width if differs from
> max_width
>> > > > + * @max_fb_height: maximum fb buffer height if differs from
>> > > > max_height
>> > > >   * @funcs: core driver provided mode setting functions
>> > > >   * @fb_base: base address of the framebuffer
>> > > >   * @poll_enabled: track polling support for this device
>> > > > @@ -508,6 +510,7 @@ struct drm_mode_config {
>> > > >
>> > > >         int min_width, min_height;
>> > > >         int max_width, max_height;
>> > > > +       int max_fb_width, max_fb_height;
>> > > >         const struct drm_mode_config_funcs *funcs;
>> > > >         resource_size_t fb_base;
>> > > >
>> > > > --- a/drivers/gpu/drm/drm_framebuffer.c
>> > > > +++ b/drivers/gpu/drm/drm_framebuffer.c
>> > > > @@ -283,14 +283,20 @@ drm_internal_framebuffer_create(struct
>> > > > drm_device *dev,
>> > > >                 return ERR_PTR(-EINVAL);
>> > > >         }
>> > > >
>> > > > -       if ((config->min_width > r->width) || (r->width >
>> > > > config->max_width)) {
>> > > > +       if ((config->min_width > r->width) ||
>> > > > +           (!config->max_fb_width && r->width >
>> > > > config->max_width) ||
>> > > > +           (config->max_fb_width && r->width >
>> > > > config->max_fb_width)) {
>> > > >                 DRM_DEBUG_KMS("bad framebuffer width %d, should
>> > > > be >= %d && <= %d\n",
>> > > > -                         r->width, config->min_width,
>> > > > config->max_width);
>> > > > +                         r->width, config->min_width,
>> > > > config->max_fb_width ?
>> > > > +                         config->max_fb_width :
> config->max_width);
>> > > >                 return ERR_PTR(-EINVAL);
>> > > >         }
>> > > > -       if ((config->min_height > r->height) || (r->height >
>> > > > config->max_height)) {
>> > > > +       if ((config->min_height > r->height) ||
>> > > > +           (!config->max_fb_height && r->height >
>> > > > config->max_height) ||
>> > > > +           (config->max_fb_height && r->height >
>> > > > config->max_fb_height)) {
>> > > >                 DRM_DEBUG_KMS("bad framebuffer height %d, should
>> > > > be >= %d && <= %d\n",
>> > > > -                         r->height, config->min_height,
>> > > > config->max_height);
>> > > > +                         r->height, config->min_height,
>> > > > config->max_fb_height ?
>> > > > +                         config->max_fb_height :
>> > > > config->max_height);
>> > > >                 return ERR_PTR(-EINVAL);
>> > > >         }
>> > > >
>> > > > and in the driver :
>> > > >
>> > > > +       drm->mode_config.max_width = 4096;
>> > > > +       drm->mode_config.max_height = 3840;
>> > > > +       drm->mode_config.max_fb_width = 16384;
>> > > > +       drm->mode_config.max_fb_height = 8192;
>> > > >
>> > > > With this I leave the mode filtering intact.
>> > >
>> > > Not enough. See
>> > >
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html#c.drm_connec
> tor_helper_funcs
>> > > and scroll down to mode_valid. You need to filter modes both in the
>> > > detect paths, and the atomic_check paths.
>> > >
>> > > Detect is explicitly filtered out, but atomic_check was only
>> > > implicitly filtered, through the max fb size checks. Ok, you could
>> > > light up a mode that's bigger than max fb, but in practice, no
>> > > userspace ever did that.
>> 
>> Daniel, MSM and few other vendor hardware have upscale blocks where 
>> the
>> driver can expose fb sizes smaller than
>> the mode resolution and use h/w upscaling to fill the screen. This 
>> would
>> optimize the fetch bandwidth.
>> 
>> But with your code we're missing crucial
>> > > validation now, and userspace could fall over that. What I think we
>> > > need is to add mode filter against mode_config.max_width/height in
>> > > drm_atomic_helper_check_modeset(). Probably best to stuff that into
>> > > the mode_valid() function.
>> >
>> Agreed! Since the above patch from Niel is taking care of cases where
>> max/min fb values
>> are not set, by checking against the original max/min values, can we
>> separate out this
>> core change from the driver level mode_valid changes? If Niel couldn't
> find
>> the time, I can
>> repost the above change.
> 
> Sure, I think Neil wouldn't mind if you take this over and get it ready
> for merging. Just need to make sure we're not leaving any validation 
> gaps
> in core/helper code.
> -Daniel
> 
I guess you are a bit late for the party!

I did post the patch on the forum. The latest on the thread can be found 
here: https://lkml.org/lkml/2019/10/2/369

The basic concern is if FB limits are different (especially smaller) 
than the display (mode) limits, it
will break the existing user space, who are creating unscaled FB's out 
of exposed mode limits.

Thanks and Regards,
Jeykumar S.

>> 
>> Thanks and Regards,
>> Jeykumar S.
>> 
>> > Ok I understood now, thanks for pointer, I'll try to add this.
>> >
>> > Neil
>> >
>> > >
>> > > Cheers, Daniel
>> > > >
>> > > > Neil
>> > > >
>> > > >
>> > > > > -Daniel
>> > > > >
>> > > > > >
>> > > > > > Neil
>> > > > > >
>> > > > > > >
>> > > > > > > Bunch of igt to make sure we're not missing anything
>> > > > > > > would be sweet on
>> > > > > > > top, e.g. e.g. trying to set a mode over the limit
>> > > > > > > and making sure it
>> > > > > > > fails.
>> > > > > > >
>> > > > > > > Cheers, Daniel
>> > > > > > >
>> > > > > > > > ---
>> > > > > > > >  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>> > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > > > > > > >
>> > > > > > > > diff --git a/drivers/gpu/drm/meson/meson_drv.c
>> > > > > > > > b/drivers/gpu/drm/meson/meson_drv.c
>> > > > > > > > index d344312..2e29968 100644
>> > > > > > > > --- a/drivers/gpu/drm/meson/meson_drv.c
>> > > > > > > > +++ b/drivers/gpu/drm/meson/meson_drv.c
>> > > > > > > > @@ -243,8 +243,8 @@ static int
>> > > > > > > > meson_drv_bind_master(struct device *dev, bool
>> > > > > > > > has_components)
>> > > > > > > >              goto free_drm;
>> > > > > > > >
>> > > > > > > >      drm_mode_config_init(drm);
>> > > > > > > > -    drm->mode_config.max_width = 3840;
>> > > > > > > > -    drm->mode_config.max_height = 2160;
>> > > > > > > > +    drm->mode_config.max_width = 16384;
>> > > > > > > > +    drm->mode_config.max_height = 8192;
>> > > > > > > >      drm->mode_config.funcs = &meson_mode_config_funcs;
>> > > > > > > >
>> > > > > > > >      /* Hardware Initialization */
>> > > > > > > > --
>> > > > > > > > 2.7.4
>> > > > > > > >
>> > > > > > > > _______________________________________________
>> > > > > > > > dri-devel mailing list
>> > > > > > > > dri-devel@lists.freedesktop.org
>> > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> > > > > > >
>> > > > > >
>> > > > > > _______________________________________________
>> > > > > > dri-devel mailing list
>> > > > > > dri-devel@lists.freedesktop.org
>> > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> > > > >
>> > > > >
>> > > > >
>> > > >
>> > >
>> > >
>> >
>> > _______________________________________________
>> > dri-devel mailing list
>> > dri-devel@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> 
>> --
>> Jeykumar S

-- 
Jeykumar S
