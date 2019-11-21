Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7778105B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 22:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKUVDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 16:03:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38817 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:03:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so3773266lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNzs4jULlBYKgRUq4sXe7wSTJqBHw/l2lYwwkY2GLAU=;
        b=odaRKkuGQDfxQZVGXVZDckPRLCCSTNhrW3Hmz+nbHGvUysbMPvywmSDal3NUI3tXmX
         YxNL68DjT/wPewyXKi/zj6DDp3spqDMe30bMyWUT03E0sy4MhLmlEswGSRJ60aC5+w4r
         /nmxnoN/2iJIlbvnzkffiCpnDYAs+9hx+3b84PROJAJMHqSiu6b2MvsPkBm/k00o4dYC
         ksdArXzHBDXNgChWu7D4Wl3eTgg5ZH1dbUL3KM1QxA+H5Rj8ne69CXhFIywwx/iQrzEK
         avfIEzFacNzUVRiPHfXy1CwgJuKZmeqv1fGijqZYcZ/yYUdAkf31eyKpmCX3u59yfd1a
         YZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNzs4jULlBYKgRUq4sXe7wSTJqBHw/l2lYwwkY2GLAU=;
        b=oSJ5Xndxq2aijOFaxZXZI+y0VcK558u2wy6YyKK8WjKKvDKB7Fh+rkByxxwEuTPiDs
         oZcYGqsVaj0c55Az2n0meFcnIiN4j6cS5bkjwUj8udZtGqcRDRdsn4Afg90Pw11KrHzD
         Iv+7fYIS47icN0Ty0Zmc9ZYWm54isdszSzRbltTnIO7J+F8MThTkDNb+RpxoZTmcyLmY
         HbBK4hH2I825jnLm8ou2GEhLq3vz7diMaNFLgLzC3s/M5cmGN60Nw4ETeVvQvbLjyEj+
         +ZRSzkkRVtBHjNH2LDrT1+G931iC2taokEBBrEt9Iy0wZyRaClu9Wnsvq5H8vKTznWqh
         Ey4Q==
X-Gm-Message-State: APjAAAX/DkRZyE2kv3b3+DzA1lhcgWDHmbGIKCY/srpyE0AkTyoOsB17
        CmyqGKv6cZbQ+PQ86fL0+/HrmPbW1g1I0yYIyFJ2Ow==
X-Google-Smtp-Source: APXvYqwM5Ro4dCWMxIQabUQXYkDNuBTZ1m4bYObIKaLNV951ynrYifleFuIlwZTwmYEbPGh93jLgZndzTAqW7YSF60E=
X-Received: by 2002:ac2:5624:: with SMTP id b4mr9589817lff.75.1574370222903;
 Thu, 21 Nov 2019 13:03:42 -0800 (PST)
MIME-Version: 1.0
References: <b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com> <20191121204924.GA81030@google.com>
In-Reply-To: <20191121204924.GA81030@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 21 Nov 2019 13:03:06 -0800
Message-ID: <CACK8Z6HTiMNOHx6favzWyN6ZbVD9d2WVmf6KTxt_n0O+EpJ97A@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM link states
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wong Vee Khee <vee.khee.wong@ni.com>,
        Hui Chun Ong <hui.chun.ong@ni.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 21, 2019 at 12:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, Mika, Wong, Hui, Rajat, Keith, LKML, original patch at [5]]
>
> On Sat, Oct 05, 2019 at 02:07:56PM +0200, Heiner Kallweit wrote:
>
> > +What:                /sys/bus/pci/devices/.../link_pm/clkpm
> > +             /sys/bus/pci/devices/.../link_pm/l0s_aspm
> > +             /sys/bus/pci/devices/.../link_pm/l1_aspm
> > +             /sys/bus/pci/devices/.../link_pm/l1_1_aspm
> > +             /sys/bus/pci/devices/.../link_pm/l1_2_aspm
> > +             /sys/bus/pci/devices/.../link_pm/l1_1_pcipm
> > +             /sys/bus/pci/devices/.../link_pm/l1_2_pcipm
> > +Date:                October 2019
> > +Contact:     Heiner Kallweit <hkallweit1@gmail.com>
> > +Description: If ASPM is supported for an endpoint, then these files
> > +             can be used to disable or enable the individual
> > +             power management states. Write y/1/on to enable,
> > +             n/0/off to disable.
>
> This is queued up for the v5.5 merge window, so if we want to tweak
> anything (path names or otherwise), now is the time.
>
> I think I might be inclined to change the directory from "link_pm" to
> "link", e.g.,
>
>   - /sys/bus/pci/devices/0000:00:1c.0/link_pm/clkpm
>   + /sys/bus/pci/devices/0000:00:1c.0/link/clkpm
>
> because there are other things that haven't been merged yet that could
> go in link/ as well:
>
>   * Mika's "link disable" control [1]
>   * Dilip's link width/speed controls [2,3]
>
> The max_link_speed, max_link_width, current_link_speed,
> current_link_width files could also logically be in link/, although
> they've already been merged at the top level.
>
> Rajat's AER statistics change [4] is also coming.  Those stats aren't
> link-related, so they wouldn't go in link/.  The current strawman is
> an "aer_stats" directory, but I wonder if we should make a more
> generic directory like "errors" that could be used for both AER and
> DPC and potentially other error-related things.

Sorry, I haven't been able to find time for it for some time. I doubt
if I'll be able to make it to 5.6 timeframe. Nevertheless...

>
> For example, we could have these link-related things:
>
>   /sys/.../0000:00:1c.0/link/clkpm            # RW ASPM stuff
>   /sys/.../0000:00:1c.0/link/l0s_aspm
>   /sys/.../0000:00:1c.0/link/...
>   /sys/.../0000:00:1c.0/link/disable          # RW Mika
>   /sys/.../0000:00:1c.0/link/speed            # RW Dilip's control
>   /sys/.../0000:00:1c.0/link/width            # RW Dilip's control
>   /sys/.../0000:00:1c.0/link/max_speed        # RO possible rework
>   /sys/.../0000:00:1c.0/link/max_width        # RO possible rework
>
> With these backwards compatibility symlinks:
>
>   /sys/.../0000:00:1c.0/max_link_speed     -> link/max_speed
>   /sys/.../0000:00:1c.0/current_link_speed -> link/speed
>
> Rajat's current patch puts the AER stats here at the top level:
>
>   /sys/.../0000:00:1c.0/aer_stats/fatal_bit4_DLP
>
> But maybe we could push them down like this:
>
>   /sys/.../0000:00:1c.0/errors/aer/stats/unc_04_dlp
>   /sys/.../0000:00:1c.0/errors/aer/stats/unc_26_poison_tlb_blocked
>   /sys/.../0000:00:1c.0/errors/aer/stats/cor_00_rx_err
>   /sys/.../0000:00:1c.0/errors/aer/stats/cor_15_hdr_log_overflow

How do we create sub-sub-sub directories in sysfs (errors/aer/stats)?
My understanding is that we can only create 1 subdirectory by using a
"named" attribute group. If we want more hierarchy, the "errors" and
the "aer" will need to be backed up by a kobject. Doable, but just
mentioning.

Overall the proposal looks like a step in the right direction to me.

Thanks & Best Regards,

Rajat

>
> There are some AER-related things we don't have at all today that
> could go here:
>
>   /sys/.../0000:00:1c.0/errors/aer/ecrc_gen
>   /sys/.../0000:00:1c.0/errors/aer/ecrc_check
>   /sys/.../0000:00:1c.0/errors/aer/unc_err_status
>   /sys/.../0000:00:1c.0/errors/aer/unc_err_mask
>   /sys/.../0000:00:1c.0/errors/aer/unc_err_sev
>
> And we might someday want DPC knobs like this:
>
>   /sys/.../0000:00:1c.0/errors/dpc/status
>   /sys/.../0000:00:1c.0/errors/dpc/error_source
>
> Any thoughts?
>
> Bjorn
>
> [1] https://lore.kernel.org/r/20190529104942.74991-1-mika.westerberg@linux.intel.com
> [2] https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com
> [3] https://lore.kernel.org/r/20191030221436.GA261632@google.com/
> [4] https://lore.kernel.org/r/20190827222145.32642-2-rajatja@google.com
> [5] https://lore.kernel.org/r/b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com
