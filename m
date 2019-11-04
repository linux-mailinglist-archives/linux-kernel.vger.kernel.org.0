Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62376EE635
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfKDRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 12:39:03 -0500
Received: from ackle.nomi.cz ([81.31.33.35]:53802 "EHLO ackle.nomi.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbfKDRjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:39:03 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 12:39:03 EST
Received: from localhost (unknown [IPv6:2a02:8308:a03d:b400:3f23:631f:7f50:8a55])
        by ackle.nomi.cz (Postfix) with ESMTPSA id 91C9BA160B;
        Mon,  4 Nov 2019 18:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nomi.cz; s=201904;
        t=1572888661; bh=yZ8QHx6Jn7mHWh6no66HGyTrTgzeSBLiEMHqWT7L0Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyKb+bxbPX+wibnMqLCBAvymI7w9BLIwunyOqShLQgTklVxXhO0gjocl9E/iuXL5/
         GQjmRdu18bRqW4ZeGnHBUnqpXhFDoo4ksEaCWUpHLBBlAilKy5vnX923T2ATHzgl5c
         +Yb6ivx/DoPD4X/ix7AtrCnvlvQtxLr/LgRzu8KDZXN/Iea9ol5TeJMcYpnEkjpJID
         P/h72jv8t5asJUMqq5HWLz7RHJzgUerzYexfYdt9MYndMQ+HPYzv72H/BiJ4YM7BQA
         Us0TuJMgPk8LqPL+FBzsacOi9So9+6q+GDpUTUI+H0p5DE9Jr6cDdR38xV0BTwtJdx
         qWuvSrVd+L0aQ==
Date:   Mon, 4 Nov 2019 18:31:01 +0100
From:   Tomas Janousek <tomi@nomi.cz>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>,
        intel-gfx@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: snd_hda_intel 0000:00:1f.3: No response from codec, resetting
 bus: last cmd=
Message-ID: <20191104173101.ugg77cwr4rdguzx6@notes.lisk.in>
References: <b31b8649-cb2d-890b-2d4d-881e47895ee6@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b31b8649-cb2d-890b-2d4d-881e47895ee6@molgen.mpg.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Nov 04, 2019 at 01:57:54PM +0100, Paul Menzel wrote:
> On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> resuming0with Dell’s Thunderbolt TB16 dock connected, Linux spews
> the errors below.
> 
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

Debian's 5.3.0-1-amd64 has a corrupted signature on the snd-hda-codec-hdmi
module which prevents the module from loading and causes these errors. Further
details here: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=942881

Workaround: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=942881#20

-- 
Tomáš Janoušek, a.k.a. Pivník, a.k.a. Liskni_si, http://work.lisk.in/
