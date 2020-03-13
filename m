Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673EB184685
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 13:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgCMMJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 08:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgCMMJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:09:00 -0400
Received: from localhost (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DEA206FA;
        Fri, 13 Mar 2020 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584101339;
        bh=FRa0vUMY00wqxM+1wwiVDeYxb3H2CyA1MXAd8PoEAqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgnRt+b/NSu/QOnEyTptYZF0XcwUfNV2DiUab8515WdLxCmV2k2ngysUzM4VnGuss
         Sx3nA9NpVsvTwE9ZgxUmd9GrxLOjHC1swJyfYquNcFD6C7k4NAgksCn6+Z0tNsEqKK
         cRGFlv8E1i9oOS5ykT5JMl1J5naLGftuQDY8hTuM=
Date:   Fri, 13 Mar 2020 17:38:55 +0530
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
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 04/16] soundwire: cadence: handle error cases with
 CONFIG_UPDATE
Message-ID: <20200313120855.GF4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311184128.4212-5-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 13:41, Pierre-Louis Bossart wrote:
> config_update() may time out or cannot be use in ClockStopMode
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 71cba2585151..4089c271305a 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -239,6 +239,11 @@ static int cdns_config_update(struct sdw_cdns *cdns)
>  {
>  	int ret;
>  
> +	if (sdw_cdns_is_clock_stop(cdns)) {
> +		dev_err(cdns->dev, "Cannot program MCP_CONFIG_UPDATE in ClockStopMode\n");

This looks fine but duplicates the log, so maybe you can remove from
here or preceding patch... Or use single line as I suggested in that
patch and keep this as is.

-- 
~Vinod
