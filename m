Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46A1444CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 20:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgAUTFq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Jan 2020 14:05:46 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgAUTFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:05:46 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MJWgK-1jDhaK2DCy-00JqZz for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 20:05:44 +0100
Received: by mail-qk1-f179.google.com with SMTP id v195so3692498qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:05:44 -0800 (PST)
X-Gm-Message-State: APjAAAXjnlpVaOOngHd2BX/VfCuLgpkhTECWffP0s0OJbOyAy9mdKIQY
        Khr1czL8Sy1J1/l/dvMaT8baVaThS0VrPpsgQtA=
X-Google-Smtp-Source: APXvYqyaU3sy6AGbEoXLdnq29+FzpVOuAwUblCu5Mbol7hW7VGm2ZUaPtrW+mhS1VdIaACj0BnK5vyn61lQKFxY8lNk=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr6089006qka.286.1579633543424;
 Tue, 21 Jan 2020 11:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20200121114553.2667556-1-arnd@arndb.de> <20200121125546.GA71415@bogon.m.sigxcpu.org>
 <1971902c68ff805ee0b4a66f558afe06e6edf0c5.camel@pengutronix.de>
In-Reply-To: <1971902c68ff805ee0b4a66f558afe06e6edf0c5.camel@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 20:05:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2E__zHPPEL37JwK=uHb_v-=C+-+zGaL3XoW5PZ+BUN5g@mail.gmail.com>
Message-ID: <CAK8P3a2E__zHPPEL37JwK=uHb_v-=C+-+zGaL3XoW5PZ+BUN5g@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: only reject timeouts with tv_nsec >= 2 seconds
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:A7s4Lt5X0zCzndHl88Iw7InqVkh84eNdaRaOzFUIVnRgzU4tPMO
 UjFnTXDSvB7wk/J/g4RhL0QsmHhCZ8LbOZeuHIKE8m5EGVMHYVeSNhNVpl79m8Hy0/Vr1N4
 q60HMFaA5IusYnUXqGw+z6YVEvMRqZJpMM9t0eawCfqeh9a1uahlGkHwn5n3DWQxZZ3RCyF
 zZZk0Qy/OuRB9G7MLTI4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pym50AB6Nlo=:4xJilspjlsRR2I9O+dfSpE
 Cm+Z22oJDloqugpzfpIT/HdIAR8Ruyd6+FZJvtKcADfzpPniO3jwdUfmDbA2I4oHAJ3GBiyKF
 d6sK5EDNY7Wb25FrvITK7BlKm9VJrUrX3dODQP0ekY9yUE64aASaDRYK4gz4piAbLuzRZCW+O
 RLmOlZ4jHgIBhxJNucG22wA8qXzqv7NBupqOfKE7UDeXHFzX4zFiSVHFphUmFN6RWfqQ3NqkW
 hyRsd28h/2wCOv0N78VL5tTnocTQu6jg6DEuH9WCPQ9FH1x6m71rag34g5nJs5fBHJp+t8a+T
 VUI+E+dc+YqmeLCaWMtJhL3ZMypHLVpiLpYXF2UmLGeoOkQ8k2/LF+GPQZl8xT6Oan+M895fS
 E+qSyvIYjqoAYSfZZC//h4jKnja5dMaRlcAw30WPjk/vTTJJ69TgLdTdUNbhvJmy0IWAsBLgU
 1+hfzMAQ56nvPSSMbZ+PY7297jh7uz4hBzfAsNp69gX9d0y7AMcvh1rJfmy7hkbWcxD9BZGZu
 E+yKoI0dZ3TDrsYYzq0BChxrCZ4HKnLljuF8kWyp78v0kGJwH5EmT9koJ+UlgsQAvR2apffEE
 j+V/TQG53mUvmrrKVvxXHqg6cxWhZ+QLaUXHhZP3fMEqXNYf6AvpSUhfZXqMczJRByoZ4pNsJ
 rFVdWOQRPVtT3juCEsMdlt1v3G4wGs0YBNMe+7iLueE7VptHR8sJ/s7Fv477GA/EIt0iTufx7
 DAM8ixHkIkaQAxhxZBwHEx+FzVP2mG+8IGtw63Jx4LWdzH5hndD6/YYDRUG9dLT8ONN5DvIln
 6Crr6bsQshQphxwjJ+ncHZJDftZ8KUOa3f29/wxSlALfIeQiLKdNw5zVFYMxVRB3bhwJ+7Ysq
 spQZB/Br1WPcrtQadgyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 5:10 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Guido,
>
> On Di, 2020-01-21 at 13:55 +0100, Guido Günther wrote:
> > Hi,
> > On Tue, Jan 21, 2020 at 12:45:25PM +0100, Arnd Bergmann wrote:
> > > As Guido Günther reported, get_abs_timeout() in the etnaviv user space
> > > sometimes passes timeouts with nanosecond values larger than 1000000000,
> > > which gets rejected after my first patch.
> > >
> > > To avoid breaking this, while also not allowing completely arbitrary
> > > values, set the limit to 1999999999 and use set_normalized_timespec64()
> > > to get the correct format before comparing it.
> >
> > I'm seeing values up to 5 seconds so I need
> >
> >      if (args->timeout.tv_nsec > (5 * NSEC_PER_SEC))
> >
> > to unbreak rendering. Which seems to match what mesa's get_abs_timeout()
> > does and how it's invoked.
>
> I have not tested this myself yet, only looked at the code. From the
> code I quoted earlier, I don't see how we end up with 5 * NSEC_PER_SEC
> in the tv_nsec member, even if the timeout passed to get_abs_timeout()
> is 5 seconds.

I can think of two different ways you'd end up with around five seconds here:

a) you have a completely arbitrary 32-bit number through truncation,
    which is up to 4.2 seconds
b) you have the same kind of 32-bit number, but add up to another 999999999
    nanoseconds, so you get up to 5.2 seconds in the 64-bit field.

It could of course be something completely different. If this works correctly
today, we may need to allow any 64-bit input for the nanoseconds and do
an expensive 64-bit div/mod in the kernel for normalization rather than the
cheaper set_normalized_timespec64() from my patch.

        Arnd
