Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88B3ECA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKAVog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 17:44:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:38222 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfKAVof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:44:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 14:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="206513841"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 01 Nov 2019 14:44:31 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 01 Nov 2019 23:44:31 +0200
Date:   Fri, 1 Nov 2019 23:44:31 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 2/2] drm/atomic: clear new_state pointers at hw_done
Message-ID: <20191101214431.GJ1208@intel.com>
References: <20191101180713.5470-1-robdclark@gmail.com>
 <20191101180713.5470-2-robdclark@gmail.com>
 <20191101192458.GI1208@intel.com>
 <CAJs_Fx7u6VNDarYqUuUSMSsWK0jpS5ybse0h1X4AmtXO9Mia_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJs_Fx7u6VNDarYqUuUSMSsWK0jpS5ybse0h1X4AmtXO9Mia_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 12:49:02PM -0700, Rob Clark wrote:
> On Fri, Nov 1, 2019 at 12:25 PM Ville Syrj�l�
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Fri, Nov 01, 2019 at 11:07:13AM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > The new state should not be accessed after this point.  Clear the
> > > pointers to make that explicit.
> > >
> > > This makes the error corrected in the previous patch more obvious.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > index 732bd0ce9241..176831df8163 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> > >   */
> > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
> > >  {
> > > +     struct drm_connector *connector;
> > > +     struct drm_connector_state *old_conn_state, *new_conn_state;
> > >       struct drm_crtc *crtc;
> > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > +     struct drm_plane *plane;
> > > +     struct drm_plane_state *old_plane_state, *new_plane_state;
> > >       struct drm_crtc_commit *commit;
> > > +     struct drm_private_obj *obj;
> > > +     struct drm_private_state *old_obj_state, *new_obj_state;
> > >       int i;
> > >
> > > +     /*
> > > +      * After this point, drivers should not access the permanent modeset
> > > +      * state, so we also clear the new_state pointers to make this
> > > +      * restriction explicit.
> > > +      *
> > > +      * For the CRTC state, we do this in the same loop where we signal
> > > +      * hw_done, since we still need to new_crtc_state to fish out the
> > > +      * commit.
> > > +      */
> > > +
> > > +     for_each_oldnew_connector_in_state(old_state, connector, old_conn_state, new_conn_state, i) {
> > > +             old_state->connectors[i].new_state = NULL;
> > > +     }
> > > +
> > > +     for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
> > > +             old_state->planes[i].new_state = NULL;
> > > +     }
> > > +
> > > +     for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_state, new_obj_state, i) {
> > > +             old_state->private_objs[i].new_state = NULL;
> > > +     }
> > > +
> > >       for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> > >               old_state->crtcs[i].new_self_refresh_active = new_crtc_state->self_refresh_active;
> > > +             old_state->crtcs[i].new_state = NULL;
> >
> > That's going to be a real PITA when doing programming after the fact from
> > a vblank worker. It's already a pain that the new_crtc_state->state is
> > getting NULLed somewhere.
> >
> 
> I think you already have that problem, this just makes it explicit.

I don't yet. Except on a branch where I have my vblank workers.
And I think the only problem is having the helpers/core clobber
the pointers when it should not. I don't see why it can't just
leave them be and let me use them.

-- 
Ville Syrj�l�
Intel
