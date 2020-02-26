Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B437A16F8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBZIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgBZIDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:03:32 -0500
Received: from localhost (unknown [171.76.87.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA92721556;
        Wed, 26 Feb 2020 08:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582704212;
        bh=/8t0g2cxqXTJyaSIWZzEhRM2DXny7j7hDf1vOZK9bSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiIPJH7s2e5kx9X+3AsYHSq7Gp7jbchemi90DNr/a0jDz2Ri5gxPNfYgfYe8Gk7VK
         Upx82x+THPhCVcP9cGtrlvkarYuU6Yd/FkKr0sq+RWeShX72+stYtuEQd95T2acb4u
         72v+jwV1rgAv5NUs98rgBzfI4KKBB986M6Mfaimc=
Date:   Wed, 26 Feb 2020 13:33:26 +0530
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
Subject: Re: [PATCH] soundwire: bus: provide correct return value on error
Message-ID: <20200226080326.GU2618@vkoul-mobl>
References: <20200225164907.23358-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225164907.23358-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-20, 10:49, Pierre-Louis Bossart wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> It seems to be a typo. It makes more sense to return the return value
> of sdw_update() instead of the value we want to update.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 13887713f311..b8a7a84aca1c 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1070,7 +1070,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  	if (ret < 0) {
>  		dev_err(slave->bus->dev,
>  			"SDW_DP0_INTMASK read failed:%d\n", ret);
> -		return val;
> +		return ret;

good catch. But can we optimize it to:
>  	}
>  
>  	return 0;

make this as below and remove the return above.

        return ret;
> -- 
> 2.20.1

-- 
~Vinod
