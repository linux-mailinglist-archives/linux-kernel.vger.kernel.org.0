Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC676B33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfGZOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfGZOL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:11:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93652218D3;
        Fri, 26 Jul 2019 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564150287;
        bh=hF4P0NSUt1UMtwss/k6Y5M453YUX4ips7z7TFzgxoWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrFGCFGe3nGdvNVEPC5e3DkB9dB6UtwpR8gwlmRgYlQ3ZWfmuMCk9mxghyq8A3IuD
         I+lFzw7xoDMMoRuMIlLkEoJKHdOqXl9EWqnvXCI7PBH46iBa1g8M8eKMio/QnVBXK+
         fz2UijrKpVM0sQUlhZmxdnZUOSIGSbQjVFO2SK/Q=
Date:   Fri, 26 Jul 2019 16:11:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 04/40] soundwire: intel: add debugfs
 register dump
Message-ID: <20190726141124.GA4253@kroah.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
 <9d5bc940-eadd-4f82-0bac-6a731369436d@intel.com>
 <d231f6b0-555a-8c45-1a9a-215c73171923@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d231f6b0-555a-8c45-1a9a-215c73171923@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:00:28AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 7/26/19 4:35 AM, Cezary Rojewski wrote:
> > On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> > > +static void intel_debugfs_init(struct sdw_intel *sdw)
> > > +{
> > > +    struct dentry *root = sdw->cdns.bus.debugfs;
> > > +
> > > +    if (!root)
> > > +        return;
> > > +
> > > +    sdw->fs = debugfs_create_dir("intel-sdw", root);
> > > +    if (IS_ERR_OR_NULL(sdw->fs)) {
> > > +        dev_err(sdw->cdns.dev, "debugfs root creation failed\n");
> > > +        sdw->fs = NULL;
> > > +        return;
> > > +    }
> > > +
> > > +    debugfs_create_file("intel-registers", 0400, sdw->fs, sdw,
> > > +                &intel_reg_fops);
> > > +
> > > +    sdw_cdns_debugfs_init(&sdw->cdns, sdw->fs);
> > > +}
> > 
> > I believe there should be dummy equivalent of _init and _exit if debugfs
> > is not enabled (if these are defined already and I've missed it, please
> > ignore).
> 
> I think the direction is just to keep going if there is an error or debufs
> is not enabled.

You should not care either way :)
