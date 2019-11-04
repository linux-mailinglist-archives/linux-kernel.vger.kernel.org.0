Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4AEE0B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 14:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfKDNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 08:10:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:13556 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbfKDNK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:10:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 05:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="212312059"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Nov 2019 05:10:25 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Nov 2019 15:10:24 +0200
Date:   Mon, 4 Nov 2019 15:10:24 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>,
        intel-gfx@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: snd_hda_intel 0000:00:1f.3: No response from codec, resetting
 bus: last cmd=
Message-ID: <20191104131024.GB2552@lahna.fi.intel.com>
References: <b31b8649-cb2d-890b-2d4d-881e47895ee6@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b31b8649-cb2d-890b-2d4d-881e47895ee6@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 04, 2019 at 01:57:54PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> resuming0with Dell’s Thunderbolt TB16 dock connected, Linux spews
> the errors below.

I have this machine here so can try to reproduce it as well.

> ```
> [    0.000000] Linux version 5.3.0-1-amd64 (debian-kernel@lists.debian.org) (gcc version 9.2.1 20191008 (Debian 9.2.1-9)) #1 SMP Debian 5.3.7-1 (2019-10-19)
> […]
> [    1.596619] pci 0000:00:1f.3: Adding to iommu group 12
> [   14.536274] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> [   14.544100] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [   14.760751] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
> [   14.760790] input: HDA Intel PCH HDMI as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
> [  156.614284] snd_hda_intel 0000:00:1f.3: No response from codec, disabling MSI: last cmd=0x20270503
> [  157.622232] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  158.626371] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  159.634102] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  161.678121] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> [  162.682272] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20370503
> [  163.694234] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x201f0500
> [  165.730142] snd_hda_intel 0000:00:1f.3: No response from codec, resetting bus: last cmd=0x20270503
> […]
> ```
> 
> In the bug report *[Intel Ice Lake, snd-hda-intel, HDMI] "No
> response from codec" (after display hotplug?)* [1], note it’s a
> different model, Takashi comments that this is a Thunderbolt or
> i915 issue.

0000:00:1f.3 is on PCH so not sure how it could be related to
Thunderbolt, well or i915 for that matter.

> Please tell me, how to debug this further.

Unfortunately I don't know much about the HDA driver so can't really
suggest anything.
