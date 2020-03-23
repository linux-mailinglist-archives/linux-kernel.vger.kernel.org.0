Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB6518F4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgCWMbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbgCWMbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:31:46 -0400
Received: from localhost (unknown [122.178.205.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35EA02072E;
        Mon, 23 Mar 2020 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584966705;
        bh=02aNWtfrpU8AgorxptidkUPx6hNK4HuNW/Fa4tvFsTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYmHx08Lp7U+MLooOOIoh4AJzRQMRwIwpBpLNUCy+reyX+OC1te5bEaKKEd484qXv
         lLlmUjKsapyJVRhQ1xF1z8qodvTL7JlXL68xHzx7xdHUVQZ5FhQVPlsXD5r0gRdW82
         kTRzp9/HjbOMNsersRvOOOHErlDTQbmnp+PRyrB0=
Date:   Mon, 23 Mar 2020 18:01:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 5/7] soundwire: intel: follow documentation sequences for
 SHIM registers
Message-ID: <20200323123140.GM72691@vkoul-mobl>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-6-pierre-louis.bossart@linux.intel.com>
 <20200320135145.GE4885@vkoul-mobl>
 <9e280e1b-178a-0ce8-be5b-03532c5507fe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e280e1b-178a-0ce8-be5b-03532c5507fe@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-20, 09:20, Pierre-Louis Bossart wrote:

> > > @@ -283,11 +284,48 @@ static int intel_link_power_up(struct sdw_intel *sdw)
> > >   {
> > >   	unsigned int link_id = sdw->instance;
> > >   	void __iomem *shim = sdw->link_res->shim;
> > > +	u32 *shim_mask = sdw->link_res->shim_mask;
> > 
> > this is a local pointer, so the one defined previously is not used.
> 
> No idea what you are saying, it's the same address so changes to *shim_mask
> will be the same as in *sdw->link_res->shim_mask.

There seems to be too many shim_masks, in global structs, then pointer
and then local ones. It is really confusing...

> > > +	struct sdw_bus *bus = &sdw->cdns.bus;
> > > +	struct sdw_master_prop *prop = &bus->prop;
> > >   	int spa_mask, cpa_mask;
> > > -	int link_control, ret;
> > > +	int link_control;
> > > +	int ret = 0;
> > > +	u32 syncprd;
> > > +	u32 sync_reg;
> > >   	mutex_lock(sdw->link_res->shim_lock);
> > > +	/*
> > > +	 * The hardware relies on an internal counter,
> > > +	 * typically 4kHz, to generate the SoundWire SSP -
> > > +	 * which defines a 'safe' synchronization point
> > > +	 * between commands and audio transport and allows for
> > > +	 * multi link synchronization. The SYNCPRD value is
> > > +	 * only dependent on the oscillator clock provided to
> > > +	 * the IP, so adjust based on _DSD properties reported
> > > +	 * in DSDT tables. The values reported are based on
> > > +	 * either 24MHz (CNL/CML) or 38.4 MHz (ICL/TGL+).
> > 
> > Sorry this looks quite bad to read, we have 80 chars, so please use
> > like below:
> > 
> > 	/*
> >           * The hardware relies on an internal counter, typically 4kHz,
> >           * to generate the SoundWire SSP - which defines a 'safe'
> >           * synchronization point between commands and audio transport
> >           * and allows for multi link synchronization. The SYNCPRD value
> >           * is only dependent on the oscillator clock provided to
> >           * the IP, so adjust based on _DSD properties reported in DSDT
> >           * tables. The values reported are based on either 24MHz
> >           * (CNL/CML) or 38.4 MHz (ICL/TGL+).
> > 	 */
> 
> Are we really going to have an emacs vs vi discussion here?

What has that got to do with editor to use, nothing imo.

All I am asking is to use 80 chars here and make it look decent to
read. And not truncate at 60 ish chars which seems above

-- 
~Vinod
