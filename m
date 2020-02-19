Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41B163913
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 02:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBSBLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 20:11:13 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44978 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgBSBLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:11:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so22132895oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 17:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xGaWAJBKAec3kwhkj9dkQ9ZINCAIKOnyRVDiG9f8fk=;
        b=FwIDj/04JR/IHzVMZB5/xQ9S8o8n2jNDqjW7qtQ9UwUU7ETx5J16nMwLS/hZTjMGJN
         HDttozOQStUrVexFsduHFiyPZq+iFwkR4NDHwJADtSRRvWVGeNg7lrhjpsnuNEddiOSB
         K44kDfz9U9+NK11sP9lrzJT8+yvrScu33H7Jgrxf8rI0rhPD85TEl5I0YQ/Cajl0TK3B
         t8XPm2EiZ9zyvL7RY9DPZmbRXERil36UDZ/sCXTb4MWBzX0YH/h5xxErMIVkSJGLrt/N
         9UhVRgrR1ewSmlwZrn3IgSeO2/4E3RNy9tHQjjvihGmG6xFJNXrnX9ssWcxkLc4PfPZJ
         NPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xGaWAJBKAec3kwhkj9dkQ9ZINCAIKOnyRVDiG9f8fk=;
        b=kqMvR/ITAD2483gcw9RIhCdsjh0kC3yDGok3Hz1hXHXB+iGF1tXr9o1zA8vtP0kxm9
         agDLPuUk4v+4vjf0ByZEXMpRvrIFNDoe2RLJgHlIIEDodq6z7mfE9cR8SoMqupWDozC8
         S6unF3IaFNM96yNLHPt4urukb+dE0kTMHSWrEVnpUPeA3t+MppUhWbS8f8nhsmu1hbzI
         Zn4tdkq8d08SCkWmf2H14dHPC9xoyi+jwA+unQHSd3c3//6jhoSvGW5sU0cyJWeZUzQq
         QbaWx0UIb8Yje81AhsjmNey6U5rvlrQCwO2qzYbm0Tl+J4S6ULuZV0Ed0xEV1xtJsdoq
         h6AQ==
X-Gm-Message-State: APjAAAUj/SfxLn0jop10D0O5cO+Dbn5w5QokC/2mAcbWvzIMhhRPFFKO
        6OhL/uhWoOsrlQG+iO5G+j9ZVm7nD89DCSS26/VScw==
X-Google-Smtp-Source: APXvYqzhuoDZ9i6YIqTSpgb4IL/NHaiNkH1/8VSm+1Ke2iHRloG51oG9IIJbDtZvYPe5e6bFQfHLhiNxJZBwAke81UM=
X-Received: by 2002:a54:4396:: with SMTP id u22mr3143967oiv.128.1582074672294;
 Tue, 18 Feb 2020 17:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <CAHp75VcPL7DYp9hjgMu+d=CE=g+V7ZxT9ZyXX-OjEW_JQ4m_nA@mail.gmail.com> <CALAqxLWtYfwCzDRVecWF8yRQSKQZh-N2g0SifageUaG0QhBGJg@mail.gmail.com>
In-Reply-To: <CALAqxLWtYfwCzDRVecWF8yRQSKQZh-N2g0SifageUaG0QhBGJg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Feb 2020 17:11:00 -0800
Message-ID: <CALAqxLW-Z=sut+A5Ezg4PkZ0HzM-np3PY_gAn0r=Ef0+FDBQDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 4:19 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Tue, Feb 18, 2020 at 4:06 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wednesday, February 19, 2020, John Stultz <john.stultz@linaro.org> wrote:
> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >> index b25bcab2a26b..9d916a7b56a6 100644
> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -237,13 +237,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
> >>
> >>  static int __driver_deferred_probe_check_state(struct device *dev)
> >>  {
> >> -       if (!initcalls_done)
> >> -               return -EPROBE_DEFER;
> >
> >
> > Why to touch this? Can't you simple add a new condition here 'if (deferred_probe_timeout > 0)'... ?
>
> I think that might work. I'll give it a spin later tonight and double check it.
>
> The main thing I wanted to do is fix the logic hole in the current
> code where after initcalls_done=true but before deferred_probe_timeout
> has expired we just fall through and return 0, which results in an
> ENODEV being returned from the calling function.


So on IRC Bjorn sort of clarified a point I think Rob was trying to
make on the earlier iteration of this patch, that it seems like
Thierry's patch here:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62a6bc3a1e4f4ee9ae0076fa295f9af1c3725ce3
*seems* to be trying to address the exact same issue, and maybe we
should just have the genpd code use that instead?

The main question though, is why do we need both?  As mentioned above,
the existing logic in __driver_deferred_probe_check_state() seems
wrong: Until late_initcall it returns EPROBE_DEFER, then after
initcalls_done==true returns 0 (in which case the caller then
translates to ENODEV), until the timeout expires which it then returns
ETIMEDOUT.

I suspect what is really wanted is EPROBE_DEFER -> (0) ENODEV (when
timeout is not set) or EPROBE_DEFER -> ETIMEOUT (when the timeout is
set), instead of the two state transitions it currently makes.

So I still think my patch is needed, but I also suspect a better fix
would be to kill driver_deferred_probe_check_state() and just replace
its usage with driver_deferred_probe_check_state_continue(). Or am I
still missing something?

thanks
-john
