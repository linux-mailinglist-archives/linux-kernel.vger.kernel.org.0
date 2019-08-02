Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E07F6BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbfHBMVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 08:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729422AbfHBMVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:21:17 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BC32184B;
        Fri,  2 Aug 2019 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564748476;
        bh=SQAMv/GjRtBugvtxOJvDkEzBbx5en47q4GkvzPSXWfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BekoZ6qtwpJXcE8GkxJd8wDRfQ56P5nTr4BJmBMzke7A8zAcU5VhQjNje/C4YtZ6c
         Fkcd3MFuAxUnTC0pfqp6TjQ3WD8OA8jNLs1JIOu33/eY4KnoJhxejAPG0HgtNXJ0v4
         +/l2hUDYGTOsVbLu6Tkc2xyL43SxP8dbIT6kKs6k=
Date:   Fri, 2 Aug 2019 17:50:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 15/40] soundwire: cadence_master: handle multiple
 status reports per Slave
Message-ID: <20190802122003.GQ12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> When a Slave reports multiple status in the sticky bits, find the
> latest configuration from the mirror of the PING frame status and
> update the status directly.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 34 ++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 889fa2cd49ae..25d5c7267c15 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -643,13 +643,35 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
>  
>  		/* first check if Slave reported multiple status */
>  		if (set_status > 1) {
> +			u32 val;
> +
>  			dev_warn_ratelimited(cdns->dev,
> -					     "Slave reported multiple Status: %d\n",
> -					     mask);
> -			/*
> -			 * TODO: we need to reread the status here by
> -			 * issuing a PING cmd
> -			 */
> +					     "Slave %d reported multiple Status: %d\n",
> +					     i, mask);
> +
> +			/* re-check latest status extracted from PING commands */
> +			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
> +			val >>= (i * 2);
> +
> +			switch (val & 0x3) {
> +			case 0:

why not case CDNS_MCP_SLAVE_INTSTAT_NPRESENT:

> +				status[i] = SDW_SLAVE_UNATTACHED;
> +				break;
> +			case 1:
> +				status[i] = SDW_SLAVE_ATTACHED;
> +				break;
> +			case 2:
> +				status[i] = SDW_SLAVE_ALERT;
> +				break;
> +			default:
> +				status[i] = SDW_SLAVE_RESERVED;
> +				break;
> +			}

we have same logic in the code block preceding this, maybe good idea to
write a helper and use for both

Also IIRC we can have multiple status set right?

-- 
~Vinod
