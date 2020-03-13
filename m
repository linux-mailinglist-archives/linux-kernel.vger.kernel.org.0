Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C237A184631
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCMLuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 07:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgCMLuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:50:16 -0400
Received: from localhost (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F374206EB;
        Fri, 13 Mar 2020 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584100216;
        bh=oQpLYcCV2iLWIGyUzK1FXH7X9RSgm3OKjVVgtTclyJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfmUH9T7NHqJu1yP3O4mxNpHT+zHc4jENyQyHN1l+MVdhQLOCaCswkpSqF/1yQ1Km
         Z/wIrbWmwAAzcoOBiraxUDCZVgEarc80NfhWGQVW8zM5QONxgoT+yRNf27dJVGQHmK
         +AMSF20TdJhtXzmyrCzy8dqPsxp95UNMAfRarxDA=
Date:   Fri, 13 Mar 2020 17:20:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
Message-ID: <20200313115011.GD4885@vkoul-mobl>
References: <20200303054136.GP4148@vkoul-mobl>
 <8a04eda6-cbcf-582f-c229-5d6e4557344b@linux.intel.com>
 <20200304095312.GT4148@vkoul-mobl>
 <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
 <20200305063646.GW4148@vkoul-mobl>
 <eb30ac49-788f-b856-6fcf-84ae580eb3c8@linux.intel.com>
 <20200306050115.GC4148@vkoul-mobl>
 <4fabb135-6fbb-106f-44fd-8155ea716c00@linux.intel.com>
 <20200311063645.GH4885@vkoul-mobl>
 <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 09:44, Pierre-Louis Bossart wrote:
> On 3/11/20 1:36 AM, Vinod Koul wrote:
> > On 06-03-20, 09:40, Pierre-Louis Bossart wrote:
> > > > > > Why do you need a extra driver for this. Do you have another set of
> > > > > > device object and driver for DSP code? But you do manage that, right?
> > > > > > I am proposing to simplify the device model here and have only one
> > > > > > device (SOF PCI) and driver (SOF PCI driver), which is created by actual
> > > > > > bus (PCI here) as you have in rest of the driver like HDA, DSP etc.
> > > > > > 
> > > > > > I have already recommended is to make the int-sdw a module which is
> > > > > > invoked by SOF PCI driver code (thereby all code uses SOF PCI device and
> > > > > > SOF PCI driver) directly. The DSP in my time for skl was a separate
> > > > > > module but used the parent objects.
> > > > > > 
> > > > > > The SOF sdw init (the place where sdw routines are invoked after DSP
> > > > > > load) can call sdw_probe and startup. Based on DSP sequencing you can
> > > > > > call these functions directly without waiting for extra device to be
> > > > > > probed etc.
> > > > > > 
> > > > > > I feel your flows will be greatly simplified as a result of this.
> > > > > 
> > > > > Not at all, no. This is not a simplification but an extremely invasive
> > > > > proposal.
> > > > > 
> > > > > The parent-child relationship is extremely useful for power management, and
> > > > > guarantees that the PCI device remains on while one or more of the masters
> > > > > are used, and conversely can suspend when all links are idle. I currently
> > > > > don't need to do anything, it's all taken care of by the framework.
> > > > > 
> > > > > If I have to do all the power management at the PCI device level, then I
> > > > > will need to keep track of which links are currently active. All these links
> > > > > are used independently, so it's racy as hell to keep track of the usage when
> > > > > the pm framework already does so quite elegantly. You really want to use the
> > > > > pm_runtime_get/put refcount for each master device, not manage them from the
> > > > > PCI level.
> > > > 
> > > > Not at all, you still can call pm_runtime_get/put() calls in sdw module
> > > > for PCI device. That doesn't change at all.
> > > > 
> > > > Only change is for suspend/resume you have callbacks from PCI driver
> > > > rather than pm core.
> > > There are two other related issues that you didn't mention.
> > > 
> > > the ASoC layer does require a driver with a 'name' for the components
> > > registered with the master device. So if you don't have a driver for the
> > > master device, the DAIs will be associated with the PCI device.
> > > 
> > > But the ASoC core does make pm_runtime calls on its own,
> > > 
> > > soc_pcm_open(struct snd_pcm_substream *substream)
> > > {
> > > ...
> > > 	for_each_rtd_components(rtd, i, component)
> > > 		pm_runtime_get_sync(component->dev);
> > > 
> > > and if the device that's associated with the DAI is the PCI device, then
> > > that will not result in the relevant master IP being activated, only the PCI
> > > device refcount will be increased - meaning there is no hook that would tell
> > > the PCI layer to turn on a specific link.
> > > 
> > > What you are recommending would be an all-or-nothing solution with all links
> > > on or all links off, which beats the purpose of having independent
> > > link-level power management.
> > 
> > Why can't you use dai .startup callback for this?
> > 
> > The ASoC core will do pm_runtime calls that will ensure PCI device is
> > up, DSP firmware downloaded and running.
> > 
> > You can use .startup() to turn on your link and .shutdown to turn off
> > the link.
> 
> There are multiple dais per link, and multiple Slave per link, so we would
> have to refcount and track active dais to understand when the link needs to
> be turned on/off. It's a duplication of what the pm framework can do at the
> device/link level, and will likely introduce race conditions.
> 
> Not to mention that we'd need to introduce workqueues to turn the link off
> with a delay, with pm_runtime_put_autosuspend() does for free.

Yes sure, that seems to be the cost unfortunately. While it might feel I
am blocking but the real block here is the hw design which gives you a
monolith whereas it should have been different devices. If you have a
'device' for sdw or a standalone controller we would not be debating
this..

> Linux is all about frameworks. For power management, we shall use the power
> management framework, not reinvent it.

This reminds me, please talk to Mika and Rafael, they had similar
problems with lpss etc and IIRC they were working on splices to solve
this.. Its been some time (few years now) so maybe they have a
solution..

Thanks
-- 
~Vinod
