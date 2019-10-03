Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D745C9C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfJCK1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 06:27:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:2957 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfJCK1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:27:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 03:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="198491751"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 03 Oct 2019 03:27:18 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 03 Oct 2019 13:27:18 +0300
Date:   Thu, 3 Oct 2019 13:27:18 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] drm: add fb max width/height fields to drm_mode_config
Message-ID: <20191003102718.GC1208@intel.com>
References: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
 <1569634131-13875-2-git-send-email-jsanka@codeaurora.org>
 <20190930103931.GZ1208@intel.com>
 <f6d3c2b6ad897ce8b2fdcaab44993eed@codeaurora.org>
 <20191002134535.GU1208@intel.com>
 <CAF6AEGtETiKLggNEKm+YyH8PMzpXpp119PjV2f6jdbU4UYxiAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGtETiKLggNEKm+YyH8PMzpXpp119PjV2f6jdbU4UYxiAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:55:10PM -0400, Rob Clark wrote:
> On Wed, Oct 2, 2019 at 9:45 AM Ville Syrj�l�
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Tue, Oct 01, 2019 at 02:20:55PM -0700, Jeykumar Sankaran wrote:
> > > On 2019-09-30 03:39, Ville Syrj�l� wrote:
> > > > On Fri, Sep 27, 2019 at 06:28:51PM -0700, Jeykumar Sankaran wrote:
> > > >> The mode_config max width/height values determine the maximum
> > > >> resolution the pixel reader can handle.
> > > >
> > > > Not according to the docs I "fixed" a while ago.
> > > >
> > > >> But the same values are
> > > >> used to restrict the size of the framebuffer creation. Hardware's
> > > >> with scaling blocks can operate on framebuffers larger/smaller than
> > > >> that of the pixel reader resolutions by scaling them down/up before
> > > >> rendering.
> > > >>
> > > >> This changes adds a separate framebuffer max width/height fields
> > > >> in drm_mode_config to allow vendors to set if they are different
> > > >> than that of the default max resolution values.
> > > >
> > > > If you're going to change the meaning of the old values you need
> > > > to fix the drivers too.
> > > >
> > > > Personally I don't see too much point in this since you most likely
> > > > want to validate all the other timings as well, and so likely need
> > > > some kind of mode_valid implementation anyway. Hence to validate
> > > > modes there's not much benefit of having global min/max values.
> > > >
> > > https://patchwork.kernel.org/patch/10467155/
> > >
> > > I believe you are referring to this patch.
> > >
> > > I am primarily interested in the scaling scenario mentioned here. MSM
> > > and a few other hardware have scaling block that are used both ways:
> > >
> > > 1) Where FB limits are larger than the display limits. Scalar blocks are
> > > used to
> > >     downscale the framebuffers and render within display limits.
> > >
> > > In this scenario, with your patch, are you suggesting the drivers
> > > maintain the
> > > display limits locally and use those values in fill_modes() /
> > > mode_valid() to filter
> > > out invalid modes explicitly instead of mode_config.max_width/height?
> > >
> > > 2) Where FB limits are smaller than display limits. Enforced for
> > > performance reasons on low tier hardware.
> > > It reduces the fetch bandwidth and uses post blending scalar block to
> > > scale up the pixel stream
> > > to match the display resolution.
> >
> > As Daniel mentioned in that discussion your typical userspace
> > assumes that it can use a single unscaled framebuffer with any
> > advertised mode. Hence I believe limiting the mode list based
> > on the max framebuffer size is pretty much required unless
> > you want to break existing userspace.
> >
> > In i915 I went a bit further than that recently and now we
> > filter the mode list based on the maximum plane size [1]
> > (which can be less than the max fb size and less than the
> > maximum crtc dimensions). And again that's because userspace
> > assumes that it can just use a single unscaled fullscreen
> > plane to cover the entire crtc.
> >
> > These assumption are also carved into the legacy setcrtc uapi
> > where you can't even specify multiple framebuffers. In theory
> > a driver could internally use multiple planes to overcome some
> > of the limitations, but in i915 at least we don't.
> >
> > [1] https://cgit.freedesktop.org/drm/drm-intel/commit/?id=2d20411e25a3bf3d2914a2219f47ed48dc57aed5
> >
> > >
> > > Any suggestions on how this topology can be handled with a single set of
> > > max/min values?
> > >
> >
> > I think a safe way to relax these rules would be to either:
> > a) Add a client cap by which userspace can inform the kernel
> >    it understands there are more complicated limits at play
> >    and thus can't assume that everything will just work
> > b) Maybe we could just tie that in with the atomic cap since
> >    atomic clients are pretty much required to do the TEST_ONLY
> >    dance anyway, so one might hope they have a working fallback
> >    strategy. Though I suspect eg. the modesetting ddx wouldn't
> >    like this. But we no longer allow atomic with X anyway so
> >    that partcular argument may not hold much weight anymore.
> 
> What was the conclusion of the hack to not expose atomic to
> modesetting ddx, due to the brokenness of it's atomic use?  I guess
> that could also make the modesetting case go away..

I thought it went in? Maybe I'm mistaken.

-- 
Ville Syrj�l�
Intel
