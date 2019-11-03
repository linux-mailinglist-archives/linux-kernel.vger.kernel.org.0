Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F01ED1D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 06:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKCFWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 01:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfKCFWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 01:22:51 -0400
Received: from localhost (unknown [106.206.115.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031EE214D8;
        Sun,  3 Nov 2019 05:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572758570;
        bh=Oqzo9tv0916Zywny7m8yNkHyuqH/rVT0IioPzWiyk2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQW3uyClIEkKDDRmnSOMh5Vy6tWu30EcjlSMXU7j+AXtC3ZLO96spvePoKnFVvNDq
         IP3RvtdtAu1ZIbtZCBBQ4lkz6bTPDAaqnSIZM6r84emnn5Ur5CMtJnPRMDB+4uKooL
         cHkJmH60CZEgTmXbCt1oBFEae7uWtAN89p/ArLfg=
Date:   Sun, 3 Nov 2019 10:52:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/4] soundwire: add enumeration_complete structure
Message-ID: <20191103052243.GF2695@vkoul-mobl.Dlink>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
 <20191023210657.32440-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023210657.32440-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 16:06, Pierre-Louis Bossart wrote:
> We need an async mechanism to prevent access to Slaves that are not
> fully-enumerated.
> 
> init_completion() will be invoked when the Slave becomes UNATTACHED,
> and complete() will be invoked when the state become ATTACHED. Any
> read/write before this status change will be delayed with a
> wait_for_completion().
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index a381a596212b..1381edfaa206 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -565,6 +565,7 @@ struct sdw_slave {
>  	u16 dev_num;
>  	bool probed;
>  	struct completion probe_complete;
> +	struct completion enumeration_complete;

Which series/patch uses this..?

Thanks
-- 
~Vinod
