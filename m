Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE967F63A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392453AbfHBLv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 07:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390494AbfHBLv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:51:27 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3DEC2086A;
        Fri,  2 Aug 2019 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564746686;
        bh=Eaf1th7QecnXOVIclJfzcSJ1PEFYe2Dv0L87N/NUggk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6jmVOkOpu/sA9kk1dYTZsrD0b8PmtKpmaVKfzjRtv0FCWEYyr+YoRRuN1BXhpiau
         2g3cr/Hw5eO29ej6rwgYlC89PkFNxiYLW/IC4fxkPzNvCIpDzN9BPMOvCZVwj1Lqsg
         lK+vimI2lmQvQU6cvuo14O9a+3lAAHtbbs5pL68g=
Date:   Fri, 2 Aug 2019 17:20:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 03/40] soundwire: cadence_master: align debugfs to 8
 digits
Message-ID: <20190802115013.GG12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> SQUASHME

Git trick!

commit this using:
git fixup <sha1>

where sha1 is commit where you want this to be squashed into!

then below will suuash them for you!
 
git rebase -i --autosquash 



> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 91e8bacb83e3..9f611a1fff0a 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -234,7 +234,7 @@ static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
>  			    char *buf, size_t pos, unsigned int reg)
>  {
>  	return scnprintf(buf + pos, RD_BUF - pos,
> -			 "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
> +			 "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
>  }
>  
>  static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
> -- 
> 2.20.1

-- 
~Vinod
