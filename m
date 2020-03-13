Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214241846BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 13:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgCMMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 08:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMMWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:22:02 -0400
Received: from localhost (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2942620724;
        Fri, 13 Mar 2020 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584102122;
        bh=rDGI2YkB+1Ot7lMJwobaCUfsDpwRFEEBsurwzvYrh94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mANDAO2tC3XFzypAK7l7i3+Ay/pbKCW6EKkbRLWZFrtgCkBNIkPveguoVTsYRrQhE
         cBoBan2NSSSHy0p6kkomf1NeA6JZ+dMhxIheAN08u+2iT2ZAkbRipIyu1IcET2UK+C
         mTsv6PEdfAczPNPbZJgz7kzQBxEzXdVlrwJKJ/tk=
Date:   Fri, 13 Mar 2020 17:51:56 +0530
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
Subject: Re: [PATCH 05/16] soundwire: cadence: add clock_stop/restart routines
Message-ID: <20200313122156.GG4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-6-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311184128.4212-6-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 13:41, Pierre-Louis Bossart wrote:

> @@ -225,12 +225,30 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
>  			return 0;
>  
>  		timeout--;
> -		udelay(50);
> +		usleep_range(50, 100);

this seems okay change, but unrelated to this patch

> +int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
> +{
> +	bool slave_present = false;
> +	struct sdw_slave *slave;
> +	u32 status;
> +	int ret;
> +
> +	/* Check suspend status */
> +	status = cdns_readl(cdns, CDNS_MCP_STAT);
> +	if (status & CDNS_MCP_STAT_CLK_STOP) {
> +		dev_dbg(cdns->dev, "Clock is already stopped\n");
> +		return 1;

return of 1..? Does that indicate success/fail..?

-- 
~Vinod
