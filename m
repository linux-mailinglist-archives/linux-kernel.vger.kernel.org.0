Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4600EF0094
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 16:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbfKEPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 10:00:22 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43841 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbfKEPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:00:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so5687316oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo1azNAiQwS07x7qF6wd0zFQ9MvI4I7KJOSFlT5Z5kc=;
        b=gacG1+pzAVrtSjzVx3TyN8spFoUITbiApyyPo/W5+WgBVZXZxHbbx6jfcZX3whrV2x
         vuf+ho+OPPS9+TgbckYZY5bsYUJQhYBj/0MSxFHcLp5VwJbIN6+20Cz7zKGTQO7nZ4Kz
         SnkpRb3trI9LisSHbvOpiixcKpgJ1bAl/Tn4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo1azNAiQwS07x7qF6wd0zFQ9MvI4I7KJOSFlT5Z5kc=;
        b=ks+1ba1IqRPS5xWDSalFdtqIxPET313mowRksWPFwUpexpELUrOWTSwmzvgF3mimGH
         95JUW5tgAMF2brxPHMtMrfs9RTJg5q5U3kpyXdHYh68prAB9E22H3Ts07bRSagktUGd1
         45nmmyG6rRhvz/wdOj+5k+VA5Zos+F9lg03Fp2cH6D1OWPajyRkgEDJcd5GPTz/Sh45B
         hIei0TAy62YkMQiF7KuIDz7xiWfhimxZL/5srjYQNJq/bk2zdQ51lhstDQFr8lfZa1r3
         Jgac8Vy53QDBnXz+o+mcG91AwkccnbRS6dgcBNBMN9SjWijZ1Q+Crq0nuPoqHp5Vds5c
         F9dA==
X-Gm-Message-State: APjAAAXQlVBUopNOh8x4VcbqvwBcd9VGSCel1gqc0ybhOezKW+srSTos
        loyfF5WCtfM8/soiG8TP3+qlOT1CoFF6sP7oUob2bQ==
X-Google-Smtp-Source: APXvYqxw/CH36ll85pujgzNPpyzktbhce3Exd3NaFPZfwcUGlpbuIXrs9HDVAdtSH/BPrDFjlOi38e9sUf1Ll0AOYCY=
X-Received: by 2002:a05:6808:4cf:: with SMTP id a15mr4136868oie.132.1572966015965;
 Tue, 05 Nov 2019 07:00:15 -0800 (PST)
MIME-Version: 1.0
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local> <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
 <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
 <c8f96b46-e81e-1e41-aafc-5f6ec236d66f@amd.com> <CAKMK7uHr3aeJRqJAscDDfsuBBnVXCeN9SS36-1UGuK84NyOD5Q@mail.gmail.com>
 <CAKMK7uH6EoY9MkzjSjU+Fe=E-XB4Tf9d2VsW=Tr=tFy1J-dJgg@mail.gmail.com>
 <53bf910b-5f9c-946b-17ee-602c24c0fa96@amd.com> <20191104165457.GH10326@phenom.ffwll.local>
 <CADnq5_PxMQ_AkBCHXU_YUAMWaPcH-nkOJNGNKnUOJWSTYV6X+A@mail.gmail.com>
 <20191104172434.GJ10326@phenom.ffwll.local> <CADnq5_NUAfeWscsnj07MpReM3LNwHPSPq3pQDe0waMi4OCatUg@mail.gmail.com>
 <CAKMK7uGPuYcPf+e_AL1PrH8Croydg3JcBNORCNAFgj4E72EtZQ@mail.gmail.com>
 <75a77843-7c2d-9e74-b508-5df000a9b646@amd.com> <CAKMK7uHkARNtvjrqcjzayVGkrCTOt4tQyaZ=_g+4Ljwex8xV3A@mail.gmail.com>
 <663f25b1-cf89-c6e3-acb6-b754f59efa08@amd.com>
In-Reply-To: <663f25b1-cf89-c6e3-acb6-b754f59efa08@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 5 Nov 2019 16:00:04 +0100
Message-ID: <CAKMK7uF9-TaqSPF+Gmgbxws8rKLXAL0_oq49FHKyaFvfdXtHtw@mail.gmail.com>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 3:39 PM Harry Wentland <hwentlan@amd.com> wrote:
>
>
>
> On 2019-11-05 9:23 a.m., Daniel Vetter wrote:
> > On Tue, Nov 5, 2019 at 3:17 PM Harry Wentland <hwentlan@amd.com> wrote:
> >>
> >>
> >>
> >> On 2019-11-05 8:14 a.m., Daniel Vetter wrote:
> >>> On Tue, Nov 5, 2019 at 1:52 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>>>
> >>>> On Mon, Nov 4, 2019 at 12:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>>>>
> >>>>> On Mon, Nov 04, 2019 at 12:05:40PM -0500, Alex Deucher wrote:
> >>>>>> On Mon, Nov 4, 2019 at 11:55 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>>>>>>
> >>>>>>> On Mon, Nov 04, 2019 at 03:23:09PM +0000, Harry Wentland wrote:
> >>>>>>>> On 2019-11-04 5:53 a.m., Daniel Vetter wrote:
> >>>>>>>>> On Wed, Oct 9, 2019 at 10:58 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>>>>>>>>> On Wed, Oct 9, 2019 at 10:46 PM Lakha, Bhawanpreet
> >>>>>>>>>> <Bhawanpreet.Lakha@amd.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> I misunderstood and was talking about the ksv validation specifically
> >>>>>>>>>>> (usage of drm_hdcp_check_ksvs_revoked()).
> >>>>>>>>>>
> >>>>>>>>>> Hm for that specifically I think you want to do both, i.e. both
> >>>>>>>>>> consult your psp, but also check for revoked ksvs with the core
> >>>>>>>>>> helper. At least on some platforms only the core helper might have the
> >>>>>>>>>> updated revoke list.
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>>> I think it's an either/or. Either we use an HDCP implementation that's
> >>>>>>>> fully running in x86 kernel space (still not sure how that's compliant)
> >>>>>>>> or we fully rely on our PSP FW to do what it's designed to do. I don't
> >>>>>>>> think it makes sense to mix and match here.
> >>>>>>>
> >>>>>>> Then you need to somehow tie the revoke list that's in the psp to the
> >>>>>>> revoke list update logic we have. That's what we've done for hdcp2 (which
> >>>>>>> is similarly to yours implemented in hw). The point is that on linux we
> >>>>>>> now have a standard way to get these revoke lists updated/handled.
> >>>>>>>
> >>>>>>> I guess it wasn't clear how exactly I think you're supposed to combine
> >>>>>>> them?
> >>>>>>
> >>>>>> There's no driver sw required at all for our implementation and as far
> >>>>>> as I know, HDCP 2.x requires that all of the key revoke handling be
> >>>>>> handled in a secure processor rather than than on the host processor,
> >>>>>> so I'm not sure how we make use if it.  All the driver sw is
> >>>>>> responsible for doing is saving/restoring the potentially updated srm
> >>>>>> at suspend/resume/etc.
> >>>>>
> >>>>> Uh, you don't have a permanent store on the chip? I thought another
> >>>>> requirement is that you can't downgrade.
> >>>>
> >>>> Right.  That's why the driver has to save and restore the srm when the
> >>>> GPU is powered down.  I guess that part can be done by the host
> >>>> processor as long as the srm is signed properly.
> >>>>
> >>>>>
> >>>>> And for hw solutions all you do with the updated revoke cert is stuff it
> >>>>> into the hw, it's purely for updating it. And those updates need to come
> >>>>> from somewhere else (usually in the media you play), the kernel can't
> >>>>> fetch them over the internet itself. I thought we already had the function
> >>>>> to give you the srm directly so you can stuff it into the hw, but looks
> >>>>> like that part isn't there (yet).
> >>>>
> >>>> IIRC, the revoke stuff gets gleaned from the stream by the secure
> >>>> processor somehow when you play back secure content.  I'm not entirely
> >>>> clear on the details, but from the design, the driver doesn't have to
> >>>> do anything in our case other than saving and restoring the srm from
> >>>> the secure processor.
> >>>
> >>> Hm, is that implemented in open userspace somewhere? tbh I don't know
> >>> whether the srm is in the bitstream or somewhere else in the file
> >>> (they're all containers with lots of stuff), but the current upstream
> >>> hdcp stuff is done under the assumption that userspace still does the
> >>> decrypting (so only the lowest content protection level supported
> >>> right now). Hence the explicit step to update the kernel on the latest
> >>> srm, which the kernel can then use to either check for revokes or hand
> >>> to the hardware.
> >>> -Daniel
> >>>
> >>
> >> Not sure I follow your questions about whether this is implemented in
> >> open userspace.
> >>
> >> The SRM is provided to PSP (our secure processor) through other
> >> interfaces. I'm currently not sure whether that's directly from the
> >> bitstream or another interface from the secure userspace that's handling
> >> content protection (e.g. OEMCrypto or similar).
> >
> > Well if the full thing needs the blob (otherwise how do you get at the
> > SRM), then the blob needs to be open, or we need something else.
> >
> >> The key for HDCP SRM handling is that PSP doesn't have a permanent store
> >> on the chip and needs us to handle the save and restore at
> >> boot/shutdown/suspend/resume. Think of it as an initialization and
> >> teardown step of PSP.
> >>
> >> The idea is to provide an amdgpu device-specific sysfs that's used to
> >> save/restore the SRM without any handling in the kernel (unlike the work
> >> done by Ramalingam to do the revocation check in DRM). This sysfs will
> >> be called by a simple init script to store and read the SRM from disk.
> >
> > Uh that's what I meant, now we'll end up with 2 ways to handle the
> > SRM. We already have a drm core interface to upload the SRM from disk,
> > please use that one, not invent a new one. Yes you need to add 1 tiny
> > function to drm_hdcp.c to get at the raw srm instead of checking for a
> > revoked ksv.
>
> Can you point me to the open userspace that handles
> /lib/firmware/display_hdcp_srm.bin?

cp? This was meant re: your idea of adding a sysfs file for amd to do
srm handling, we tried that too, Greg didn't like that (like you point
out in the link below). Having different ways to upload the srm for
different drivers really doesn't sound like a good idea.

> We're dealing with two different ways of doing HDCP here. One is the
> Intel way of handling HDCP entirely in x86 kernel mode which our content
> protection guys have serious reservations about and don't think can
> comply with HDCP 2.x. The other way is the AMD way of handling the HDCP
> protocol in the kernel and handling anything security sensitive in our
> PSP firmware. No matter what you think about the merits of handling
> secure applications in kernel vs FW I think these are very different
> beasts and need to be handled differently.

This is exactly how hdcp2.2 works in i915 hw too, at least afaiui.
Somehow we didn't wire up the srm uploading to firmware, not sure
where that got stuck. Maybe it was easier, since cros wont have the hw
based srm revoke stuff, and we didn't need it anywhere else. Please
also note that for hdcp1.x we also handle most of the hdcp stuff in
hw, aside from the revoke list.
-Daniel

> On Ram's first version of the SRM interface GregKH even highlighted the
> diff. See [1] and following comments.
>
> [1]
> https://patchwork.freedesktop.org/patch/296443/?series=57233&rev=4#comment_561266
>
> Harry
>
> > -Daniel
> >
> >>
> >> Harry
> >>
> >>>> Alex
> >>>>
> >>>>> -Daniel
> >>>>>
> >>>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>>> -Daniel
> >>>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>>> For the defines I will create patches to use drm_hdcp where it is usable.
> >>>>>>>>>>
> >>>>>>>>>> Thanks a lot. Ime once we have shared definitions it's much easier to
> >>>>>>>>>> also share some helpers, where it makes sense.
> >>>>>>>>>>
> >>>>>>>>>> Aside I think the hdcp code could also use a bit of demidlayering. At
> >>>>>>>>>> least I'm not understanding why you add a 2nd abstraction layer for
> >>>>>>>>>> i2c/dpcd, dm_helper already has that. That seems like one abstraction
> >>>>>>>>>> layer too much.
> >>>>>>>>>
> >>>>>>>>> I haven't seen anything fly by or in the latest pull request ... you
> >>>>>>>>> folks still working on this or more put on the "maybe, probably never"
> >>>>>>>>> pile?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Following up with Bhawan.
> >>>>>>>>
> >>>>>>>> Harry
> >>>>>>>>
> >>>>>>>>> -Daniel
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> -Daniel
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Bhawan
> >>>>>>>>>>>
> >>>>>>>>>>> On 2019-10-09 2:43 p.m., Daniel Vetter wrote:
> >>>>>>>>>>>> On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
> >>>>>>>>>>>> <Bhawanpreet.Lakha@amd.com> wrote:
> >>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The reason we don't use drm_hdcp is because our policy is to do hdcp
> >>>>>>>>>>>>> verification using PSP/HW (onboard secure processor).
> >>>>>>>>>>>> i915 also uses hw to auth, we still use the parts from drm_hdcp ...
> >>>>>>>>>>>> Did you actually look at what's in there? It's essentially just shared
> >>>>>>>>>>>> defines and data structures from the standard, plus a few minimal
> >>>>>>>>>>>> helpers to en/decode some bits. Just from a quick read the entire
> >>>>>>>>>>>> patch very much looks like midlayer everywhere design that we
> >>>>>>>>>>>> discussed back when DC landed ...
> >>>>>>>>>>>> -Daniel
> >>>>>>>>>>>>
> >>>>>>>>>>>>> Bhawan
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> >>>>>>>>>>>>>> On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> >>>>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Static analysis with Coverity has detected a potential issue with
> >>>>>>>>>>>>>>> function validate_bksv in
> >>>>>>>>>>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> >>>>>>>>>>>>>>> commit:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> >>>>>>>>>>>>>>> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >>>>>>>>>>>>>>> Date:   Tue Aug 6 17:52:01 2019 -0400
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>       drm/amd/display: Add HDCP module
> >>>>>>>>>>>>>> I think the real question here is ... why is this not using drm_hdcp?
> >>>>>>>>>>>>>> -Daniel
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> The analysis is as follows:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>    28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> >>>>>>>>>>>>>>>    29 {
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 1. overrun-local:
> >>>>>>>>>>>>>>> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> >>>>>>>>>>>>>>> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>    30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> >>>>>>>>>>>>>>>    31        uint8_t count = 0;
> >>>>>>>>>>>>>>>    32
> >>>>>>>>>>>>>>>    33        while (n) {
> >>>>>>>>>>>>>>>    34                count++;
> >>>>>>>>>>>>>>>    35                n &= (n - 1);
> >>>>>>>>>>>>>>>    36        }
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> >>>>>>>>>>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> struct mod_hdcp_message_hdcp1 {
> >>>>>>>>>>>>>>>           uint8_t         an[8];
> >>>>>>>>>>>>>>>           uint8_t         aksv[5];
> >>>>>>>>>>>>>>>           uint8_t         ainfo;
> >>>>>>>>>>>>>>>           uint8_t         bksv[5];
> >>>>>>>>>>>>>>>           uint16_t        r0p;
> >>>>>>>>>>>>>>>           uint8_t         bcaps;
> >>>>>>>>>>>>>>>           uint16_t        bstatus;
> >>>>>>>>>>>>>>>           uint8_t         ksvlist[635];
> >>>>>>>>>>>>>>>           uint16_t        ksvlist_size;
> >>>>>>>>>>>>>>>           uint8_t         vp[20];
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>           uint16_t        binfo_dp;
> >>>>>>>>>>>>>>> };
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> variable n is going to contain the contains of r0p and bcaps. I'm not
> >>>>>>>>>>>>>>> sure if that is intentional. If not, then the count is going to be
> >>>>>>>>>>>>>>> incorrect if these are non-zero.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Colin
> >>>>>>>>>>>>> _______________________________________________
> >>>>>>>>>>>>> dri-devel mailing list
> >>>>>>>>>>>>> dri-devel@lists.freedesktop.org
> >>>>>>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> --
> >>>>>>>>>> Daniel Vetter
> >>>>>>>>>> Software Engineer, Intel Corporation
> >>>>>>>>>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> --
> >>>>>>>>> Daniel Vetter
> >>>>>>>>> Software Engineer, Intel Corporation
> >>>>>>>>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >>>>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>> Daniel Vetter
> >>>>>>> Software Engineer, Intel Corporation
> >>>>>>> http://blog.ffwll.ch
> >>>>>>> _______________________________________________
> >>>>>>> amd-gfx mailing list
> >>>>>>> amd-gfx@lists.freedesktop.org
> >>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>>>>
> >>>>> --
> >>>>> Daniel Vetter
> >>>>> Software Engineer, Intel Corporation
> >>>>> http://blog.ffwll.ch
> >>>
> >>>
> >>>
> >
> >
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
