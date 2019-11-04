Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D459CEE2F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfKDO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:58:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:21717 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfKDO63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:58:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 06:58:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="212329826"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Nov 2019 06:58:26 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Nov 2019 16:58:25 +0200
Date:   Mon, 4 Nov 2019 16:58:25 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>,
        intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: snd_hda_intel 0000:00:1f.3: No response from codec, resetting
 bus: last cmd=
Message-ID: <20191104145825.GE2552@lahna.fi.intel.com>
References: <b31b8649-cb2d-890b-2d4d-881e47895ee6@molgen.mpg.de>
 <20191104131024.GB2552@lahna.fi.intel.com>
 <s5heeynwzhi.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5heeynwzhi.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 02:19:21PM +0100, Takashi Iwai wrote:
> On Mon, 04 Nov 2019 14:10:24 +0100,
> Mika Westerberg wrote:
> > 
> > Hi,
> > 
> > On Mon, Nov 04, 2019 at 01:57:54PM +0100, Paul Menzel wrote:
> > > Dear Linux folks,
> > > 
> > > 
> > > On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> > > resuming0with Dell’s Thunderbolt TB16 dock connected, Linux spews
> > > the errors below.
> > 
> > I have this machine here so can try to reproduce it as well.
> > 
> > > ```
> > > [    0.000000] Linux version 5.3.0-1-amd64 (debian-kernel@lists.debian.org) (gcc version 9.2.1 20191008 (Debian 9.2.1-9)) #1 SMP Debian 5.3.7-1 (2019-10-19)
> > > […]
> > > [    1.596619] pci 0000:00:1f.3: Adding to iommu group 12
> > > [   14.536274] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> > > [   14.544100] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> > > [   14.760751] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
> > > [   14.760790] input: HDA Intel PCH HDMI as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
> > > [  156.614284] snd_hda_intel 0000:00:1f.3: No response from codec, disabling MSI: last cmd=0x20270503
> > > [  157.622232] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> > > [  158.626371] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> > > [  159.634102] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> > > [  161.678121] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> > > [  162.682272] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> > > [  163.694234] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> > > [  165.730142] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> > > […]
> > > ```
> > > 
> > > In the bug report *[Intel Ice Lake, snd-hda-intel, HDMI] "No
> > > response from codec" (after display hotplug?)* [1], note it’s a
> > > different model, Takashi comments that this is a Thunderbolt or
> > > i915 issue.
> > 
> > 0000:00:1f.3 is on PCH so not sure how it could be related to
> > Thunderbolt, well or i915 for that matter.
> 
> It's the HD-audio controller PCI device and both HDMI and onboard
> codecs are on that bus.  HDMI codec a shadow device of GPU, so it has
> a strong dependency on i915 GPU driver.  The power of HD-audio bus and
> codec is controlled over DRM audio component ops, so the power-on must
> have been notified to GPU side, but still something seems missing.
> ANd, with the dock, the other parties come to play into the game, so
> it becomes more complex...

OK, thanks for explaining. Then I guess i915 may be related. However,
that traffic for sure does not go over Thunderbolt fabric (PCIe and DP
does).
