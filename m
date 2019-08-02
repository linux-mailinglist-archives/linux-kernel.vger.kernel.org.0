Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B77FF30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 19:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403937AbfHBREb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 13:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbfHBREb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:04:31 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC8A20644;
        Fri,  2 Aug 2019 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564765470;
        bh=VO6eqvz9WhBLXxyWQo85qGFVHXdYBUZ2uTSISiN3Ihg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQDbj8wG/ufaXEdOl+bf2Eb2Z8ZRYFMh1EdsbLiNzSrEOtoQiRSxpRzW1zUaj6AQ5
         0XT3pTOdkVez6GJ1utET8ijTVr4LLRbaINqDvgIIYFrSJKc4MJ5ncwtU/oMfuYNbs4
         2xsgFL0zNKu02J41eosP8f3ocVzu0J8H9V9TLFPU=
Date:   Fri, 2 Aug 2019 22:33:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 20/40] soundwire: prototypes for suspend/resume
Message-ID: <20190802170317.GX12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-21-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-21-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

Please do provide the changelog on why this change is needed.

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index c0bf6ff00a44..d375bbfead18 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -165,6 +165,9 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>  
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
>  
> +int sdw_cdns_suspend(struct sdw_cdns *cdns);
> +bool sdw_cdns_check_resume_status(struct sdw_cdns *cdns);
> +
>  int sdw_cdns_get_stream(struct sdw_cdns *cdns,
>  			struct sdw_cdns_streams *stream,
>  			u32 ch, u32 dir);
> -- 
> 2.20.1

-- 
~Vinod
