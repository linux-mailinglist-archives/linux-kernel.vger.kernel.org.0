Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBB1037EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfKTKuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 05:50:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:12954 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfKTKux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:50:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 02:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="215756739"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 02:50:49 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 12:50:49 +0200
Date:   Wed, 20 Nov 2019 12:50:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>, linux-kernel@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
Message-ID: <20191120105048.GY11621@lahna.fi.intel.com>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com>
 <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 05:55:43PM +0100, Paul Menzel wrote:
> Dear Mika,
> 
> 
> On 2019-11-04 17:21, Mika Westerberg wrote:
> > On Mon, Nov 04, 2019 at 05:11:10PM +0100, Paul Menzel wrote:
> 
> >> On 2019-11-04 16:49, Mario.Limonciello@dell.com wrote:
> >>
> >>>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>>> Sent: Monday, November 4, 2019 9:45 AM
> >>
> >>>> On Mon, Nov 04, 2019 at 04:44:40PM +0200, Mika Westerberg wrote:
> >>>>> On Mon, Nov 04, 2019 at 04:25:03PM +0200, Mika Westerberg wrote:
> >>
> >>>>>> On Mon, Nov 04, 2019 at 02:13:13PM +0100, Paul Menzel wrote:
> >>
> >>>>>>> On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> >>>>>>> suspending the system, and resuming with Dell’s Thunderbolt TB16
> >>>>>>> dock connected, the USB input devices, keyboard and mouse,
> >>>>>>> connected to the TB16 stop working. They work for a few seconds
> >>>>>>> (mouse cursor can be moved), but then stop working. The laptop
> >>>>>>> keyboard and touchpad still works fine. All firmware is up-to-date
> >>>>>>> according to `fwupdmgr`.
> >>>>>>
> >>>>>> What are the exact steps to reproduce? Just "echo mem >
> >>>>>> /sys/power/state" and then resume by pressing power button?
> >>
> >> GNOME Shell 3.34.1+git20191024-1 is used, and the user just closes the
> >> display. So more than `echo mem > /sys/power/state` is done. What
> >> distribution do you use?
> > 
> > I have buildroot based "distro" so there is no UI running.
> 
> Hmm, this is quite different from the “normal” use-case of the these devices.
> That way you won’t hit the bugs of the normal users. ;-)

Well, I can install some distro to that thing also :) I suppose Debian
10.2 does have this issue, no?

> >>>>> I tried v5.4-rc6 on my 9380 with TB16 dock connected and did a couple of
> >>>>> suspend/resume cycles (to s2idle) but I don't see any issues.
> >>>>>
> >>>>> I may have older/different firmware than you, though.
> >>>>
> >>>> Upgraded BIOS to 1.8.0 and TBT NVM to v44 but still can't reproduce this
> >>>> on my system :/
> >>
> >> The user reported the issue with the previous firmwares 1.x and TBT NVM v40.
> >> Updating to the recent version (I got the logs with) did not fix the issue.
> > 
> > I also tried v40 (that was originally on that system) but I was not able
> > to reproduce it.
> > 
> > Do you know if the user changed any BIOS settings?
> 
> We had to disable the Thunderbolt security settings as otherwise the USB
> devices wouldn’t work at cold boot either.

That does not sound right at all. There is the preboot ACL that allows
you to use TBT dock aready on boot. Bolt takes care of this.

Are you talking about USB devices connected to the TB16 dock?

Also are you connecting the TB16 dock to the Thunderbolt ports (left
side of the system marked with small lightning logo) or to the normal
Type-C ports (right side)?

> So, I built Linux 5.4-rc8 (`make bindeb-pkg -j8`), but unfortunately the
> error is still there. Sometimes, re-plugging the dock helped, and sometimes
> it did not.
> 
> Please find the logs attached. The strange thing is, the Linux kernel detects
> the devices and I do not see any disconnect events. But, `lsusb` does not list
> the keyboard and the mouse. Is that expected.

I'm bit confused. Can you describe the exact steps what you do (so I can
replicate them).

> Additionally, despite `CONFIG_PCI_DEBUG` I do not see more elaborate messages.

I see one strange thing in that log. The Thunderbolt driver does not
show the device at boot. You should see something like this when you
boot with the dock connected:

  thunderbolt 0-3: new device found, vendor=0xd4 device=0xb051
  thunderbolt 0-3: Dell Dell Thunderbolt Cable
  thunderbolt 0-303: new device found, vendor=0xd4 device=0xb054
  thunderbolt 0-303: Dell Dell Thunderbolt Dock

I only see those after you did suspend/resume cycle.

> Lastly, could the daemon boltd have anything to do with this?

It is the one that authorizes the PCIe tunneling so definitely has
something to do but below:

> 
> ```
> $ boltctl --version
> bolt 0.8
> $ boltctl list
>  ● Dell Thunderbolt Cable
>    ├─ type:          peripheral
>    ├─ name:          Dell Thunderbolt Cable
>    ├─ vendor:        Dell
>    ├─ uuid:          0082b09d-2f5f-d400-ffff-ffffffffffff
>    ├─ status:        authorized

looks what is expected.
