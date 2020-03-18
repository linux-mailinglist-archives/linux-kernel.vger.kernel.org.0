Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEA189921
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCRKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:19:11 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:50802 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCRKTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:19:10 -0400
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
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2710F200ADE;
        Wed, 18 Mar 2020 10:19:09 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id CE43220B19; Wed, 18 Mar 2020 11:19:04 +0100 (CET)
Date:   Wed, 18 Mar 2020 11:19:04 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318101904.GA134370@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <66c719b3-a66e-6a9f-fab8-721ba48d7ad8@intel.com>
 <20200318095745.GA133849@light.dominikbrodowski.net>
 <fafed002-5f7f-dd2b-0787-265da7ec7c7a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fafed002-5f7f-dd2b-0787-265da7ec7c7a@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:05:21AM +0100, Cezary Rojewski wrote:
> On 2020-03-18 10:57, Dominik Brodowski wrote:
> > > > 
> > > > Unfortunately, I cannot bisect this issue easily -- i915 was broken for
> > > > quite some time on this system[*], prohibiting boot...
> > > 
> > > Hmm, sounds like that issue is quite old. DSP for Haswell and Broadwell is
> > > available for I2S devices only, so this relates directly to legacy HDA
> > > driver. Compared to Skylake+, HDAudio controller for older platforms is
> > > found within GPU. My advice is to notify the DRM guys about this issue.
> > > 
> > > Takashi, are you aware of problems with HDMI on HSW/ BDW or should I just
> > > loop Jani and other DRM peps here?
> > 
> > Well, it works on v5.5, so this issue is not really "quite old" (the "no
> > context buffer need to restore!" message seen there seems harmless).
> > 
> > Thanks again, and best wishes,
> > 	Dominik
> > 
> 
> Was commenting the "i915 was broken for quite some time on this system[*],
> prohibiting boot...". Unless I misunderstood you, this ain't a DSP driver
> issue but HDAudio/iDisp one. Essentially, these are two issues you mentioned
> here.

Ah, sorry for the confusion. That issue was introduced post v5.5 as well,
but fixed for v5.6-rc4 -- meaning that it works now, but that bisecting
between v5.5 and v5.6-rc4 is not working as such.

Thanks,
	Dominik
