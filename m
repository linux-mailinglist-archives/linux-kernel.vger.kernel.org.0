Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8903F3EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 05:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfKHEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 23:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHEFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:05:54 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEA720679;
        Fri,  8 Nov 2019 04:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573185954;
        bh=Dj8emM86/tTjC9nxzViGKG+zu6tt69/S9bXVf+wafks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5Jtz+oizAUYd8Xbrc2MlJpnEQMHErcQCdfDsbKO4HBsSkO5kfaE0BFoHB+NfzQ7V
         zkCW0cltflX8DquLsUFU8xJykb68acgfwBMoI5GGbMOxKZkSgrrPzdZqFr0IHcl43b
         zLDLreAjFYPH3R0YuWaG+2tMh+IjUBUIfqTz76do=
Date:   Fri, 8 Nov 2019 09:35:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 10/14] soundwire: intel: add prepare support in sdw dai
 driver
Message-ID: <20191108040550.GU952516@vkoul-mobl>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-11-pierre-louis.bossart@linux.intel.com>
 <7a49fcce-5b36-81c1-6041-dda263ebb200@intel.com>
 <02ef59ba-66da-3ba9-1fe7-0b7e256e3ac1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ef59ba-66da-3ba9-1fe7-0b7e256e3ac1@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-19, 15:31, Pierre-Louis Bossart wrote:
> 
> 
> On 11/4/19 1:45 PM, Cezary Rojewski wrote:
> > On 2019-10-23 23:28, Pierre-Louis Bossart wrote:
> > > From: Rander Wang <rander.wang@linux.intel.com>
> > > 
> > > It gets sdw runtime information from dai to prepare stream.
> > > 
> > > Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> > > Signed-off-by: Pierre-Louis Bossart
> > > <pierre-louis.bossart@linux.intel.com>
> > 
> > While the patch looks good, the commit message is questionable. You may
> > simply state why it is added only just now. Judging from the commit
> > title, it has been added to make the sdw dai driver interface complete.
> 
> The commit message is not great but it's not wrong either...

And it doesn't harm to elaborate and explain things rather than have
reviewer play detective!

-- 
~Vinod
