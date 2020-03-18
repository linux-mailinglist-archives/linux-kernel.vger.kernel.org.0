Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D5B189C11
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 13:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCRMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 08:39:36 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59104 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgCRMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:39:36 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 6FD86200ADE;
        Wed, 18 Mar 2020 12:39:34 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 4585A20B1B; Wed, 18 Mar 2020 13:39:30 +0100 (CET)
Date:   Wed, 18 Mar 2020 13:39:30 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Keyon Jie <yang.jie@linux.intel.com>
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, curtis@malainey.com
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318123930.GA2433@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 06:49:56PM +0800, Keyon Jie wrote:
> On 3/18/20 2:30 PM, Dominik Brodowski wrote:
> > Hi!
> > 
> > While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
> > some sound-related trouble: after boot, the sound works fine -- but once I
> > suspend and resume my broadwell-based XPS13, I need to switch to headphone
> > and back to speaker to hear something. But what I hear isn't music but
> > garbled output.
> > 
> > A few dmesg snippets from v5.6-rc6-9-gac309e7744be which might be of
> > interest. I've highlighted the lines differing from v.5.5.x which might be
> > of special interest:
> > 
> > 	...
> > 	snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002)
> > 	usbcore: registered new interface driver snd-usb-audio
> > 	snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
> > 	input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
> > 	input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
> > 	input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
> > 	input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input16
> > 	input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input17
> > 	Console: switching to colour frame buffer device 240x67
> > !!!	sst-acpi INT3438:00: WARN: Device release is not defined so it is not safe to unbind this driver while in use
> > 	i915 0000:00:02.0: fb0: i915drmfb frame buffer device
> > 	sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
> > 	psmouse serio1: synaptics: Unable to query device: -5
> > 	haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/IntcPP01.bin failed with error -2
> > 	haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not available(-2)
> > 	haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
> > 	rt286 i2c-INT343A:00: ASoC: sink widget DMIC1 overwritten
> > 	rt286 i2c-INT343A:00: ASoC: source widget DMIC1 overwritten
> > 	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
> > 	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
> > 	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
> > 	broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
> > 	broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
> > 	input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input18
> > 	...
> > 	ALSA device list:
> > 	  #0: HDA Intel HDMI at 0xf7218000 irq 48
> > 	  #1: DellInc.-XPS139343--0TM99H
> > 	...
> > !!!	haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no stream to reset, ignore it.
> > !!!	haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no stream to free, ignore it.
> > 
> > (these last two messages already are printed a couple of time after boot, and then
> > again during a suspend/resume cycle. On v.5.5.y, there are similar messages
> > "no context buffer need to restore!"). Everything is built-in, no modules
> > are loaded.
> > 
> > Unfortunately, I cannot bisect this issue easily -- i915 was broken for
> > quite some time on this system[*], prohibiting boot...
> > 
> > Thanks for taking a look at this issue!
> > 
> > 	Dominik
> > 
> > 
> > [*] https://gitlab.freedesktop.org/drm/intel/issues/1151
> > 
> 
> Hi Dominik,
> 
> Thanks for reporting, yes, this is Keyon(Yang Jie) here, we do have several
> other Broadwell comercial platforms in the market, adding Curtis from Google
> in case they may hit similar issue once upgrading to the latest kernel.

Thanks!

> From your description above, it looks the ucm and pulseaudio is involved,
> can you help do a quick try if using aplay directly will hit the same issue?

$ cat nice-music.wav | aplay -f S16_LE -r 44100 -c 2 --device="sysdefault:CARD=broadwellrt286"

runs nicely until I suspend. Upon resume, I hear nothing, with a number of

	haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no stream to reset, ignore it.

messages appearing in dmesg. Strangely, pavucontrol then (after resume)
cannot find any suitable audio device any more.

Hope this helps,
	Dominik
