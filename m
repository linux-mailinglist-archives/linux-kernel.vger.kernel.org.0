Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295AD7FDE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfHBP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 11:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbfHBP7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:59:02 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CC020B7C;
        Fri,  2 Aug 2019 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761542;
        bh=E21+I1H59V6MsCfH6Fg5TnD0nRNFBekeAOLaNaiXMhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i07x/1lHjnA1/3bX90ONRyLaOlC349ccqPsirmEZhaaII6jwBVQO7oOAhanUx1tD9
         dxTwA5wvpLpxSehkUn8snlb+JVRCdYIoFX/IyEOL9zUCbsyouQA1oFUgLSvhFzwixj
         VhRZboa1ONpanDiL9lANnGP9pDoNPZun7UgZzPXA=
Date:   Fri, 2 Aug 2019 21:27:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 06/40] soundwire: intel: prevent
 possible dereference in hw_params
Message-ID: <20190802155738.GR12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
 <20190802115537.GI12733@vkoul-mobl.Dlink>
 <6da5aeef-40bf-c9bb-fc18-4ac0b3961857@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da5aeef-40bf-c9bb-fc18-4ac0b3961857@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-19, 10:16, Pierre-Louis Bossart wrote:
> 
> 
> On 8/2/19 6:55 AM, Vinod Koul wrote:
> > On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> > > This should not happen in production systems but we should test for
> > > all callback arguments before invoking the config_stream callback.
> > 
> > so you are saying callback arg is mandatory, if so please document that
> > assumption
> 
> no, what this says is that if a config_stream is provided then it needs to
> have a valid argument.

well typically args are not mandatory..

> I am not sure what you mean by "document that assumption", comment in the
> code (where?) or SoundWire documentation?

The callback documentation which in this is in include/linux/soundwire/sdw_intel.h

-- 
~Vinod
