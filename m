Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BF15FB9B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBOAn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBOAn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:43:27 -0500
Received: from localhost (unknown [38.98.37.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBE2206CC;
        Sat, 15 Feb 2020 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727406;
        bh=n6C+XIf/lyMg45xZwpa1Z0/jdjqPoKgJmPJKvllOVUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbec4k4QJ+/R5/1/51+pxAbRNaT7gXuJc2Z6YvAWwm9f/+Z8khItpYP1e09K0+7WG
         tOQ7oLR+uWzZY3zIqswcVkQU29KAvHTlAKk6ywep8desuYFROSRafpujca5Y4IfnPb
         5TNF5zZIMkU9txujwR7X+f2yRlc9+gdEBVRQzPYQ=
Date:   Fri, 14 Feb 2020 19:05:00 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 0/2] soundwire: add master_device/driver
 support
Message-ID: <20200215000500.GB5524@kroah.com>
References: <20200201042011.5781-1-pierre-louis.bossart@linux.intel.com>
 <20200214164919.GB4016987@kroah.com>
 <0ec41a5b-6132-6940-f1b3-bac1724b70a4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec41a5b-6132-6940-f1b3-bac1724b70a4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 05:34:40PM -0600, Pierre-Louis Bossart wrote:
> 
> My preference in terms of integration in drivers/soundwire would be
> 
> 1. Intel DAI cleanup (only one kfree missing, will resubmit v3 today)
> 
> 2. [PATCH 00/10] soundwire: bus: fix race conditions, add suspend-resume
> this series solves a lot of issues and should go first.
> 
> 3. ASoC/SOF integration (still with platform devices)
> I narrowed this down to 6 patches, that would help me submit the rest of the
> ASoC/SOF patches in Mark Brown's tree. That would be Intel specific. This
> step would be the first where everything SoundWire-related can be enabled in
> a build, and while we've caught a lot of cross-compilation issues it's
> likely some bots will find corner cases to keep us busy.
> 
> 4. master_device/driver transition: these updated patches removing platform
> devices + sysfs support + Qualcomm support (the last point would depend on
> the workload/support of Qualcomm/Linaro folks, I don't want to commit on
> their behalf).
> 
> 5. New SoundWire functionality for Intel platforms (clock-stop/restart and
> synchronized links). The code would be only located in drivers/soundwire and
> be easier to handle. For the synchronized links we still have a bit of
> validation work to do so it should really come last.
> 
> Would this work for everyone?

Sounds reasonable to me, but patches would show it best to see if there
are any issues :)

thanks,

greg k-h
