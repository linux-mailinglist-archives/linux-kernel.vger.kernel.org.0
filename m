Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDB18A067
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 17:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgCRQWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 12:22:52 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:45488 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:22:52 -0400
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
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 65537200B32;
        Wed, 18 Mar 2020 16:22:50 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 4EC3B20B1B; Wed, 18 Mar 2020 17:20:29 +0100 (CET)
Date:   Wed, 18 Mar 2020 17:20:29 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Keyon Jie <yang.jie@linux.intel.com>, cezary.rojewski@intel.com,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318162029.GA3999@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:13:54AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> > > > While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
> > > > some sound-related trouble: after boot, the sound works fine -- but once I
> > > > suspend and resume my broadwell-based XPS13, I need to switch to headphone
> > > > and back to speaker to hear something. But what I hear isn't music but
> > > > garbled output.
> 
> It's my understanding that the use of the haswell driver is opt-in for Dell
> XPS13 9343. When we run the SOF driver on this device, we have to explicitly
> bypass an ACPI quirk that forces HDAudio to be used:
> 
> https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd
> 
> Have you tried to run in plain vanilla HDAudio mode?

I had (see 18d78b64fddc), but not any more in years (and I'd like to keep
using I2S, which has worked flawlessly in these years).

Thanks,
	Dominik
