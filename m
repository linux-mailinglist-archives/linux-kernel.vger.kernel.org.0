Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8172E13807
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfEDHDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 03:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfEDHDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 03:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F73B206BB;
        Sat,  4 May 2019 07:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556953429;
        bh=06o88Q/xn9ojq7khzJkjBbDh8svWhXIRLYGsoQ+OuOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2W1wzdjSC/WyY75j2/5/XcF4xTYDy7KFkG4lNjz+dD+W1OVD6XRKOqh+hTQQWWeN
         CIn2qtCmCOEaAPJzbK/hpphO2vJsIfwtidaHr5ZTcrJbQ7IKclRdskff34c3G1u3ts
         yE6NEl2TvI321zfcx7XCuJrB0q/5kfJrHMuw0GUM=
Date:   Sat, 4 May 2019 09:03:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 6/7] soundwire: cadence_master: add debugfs register
 dump
Message-ID: <20190504070346.GE9770@kroah.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504010030.29233-7-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 08:00:29PM -0500, Pierre-Louis Bossart wrote:
> Add debugfs file to dump the Cadence master registers
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
> is the use of scnprintf to avoid known issues with snprintf.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 98 ++++++++++++++++++++++++++++++
>  drivers/soundwire/cadence_master.h |  5 ++
>  2 files changed, 103 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 682789bb8ab3..e9c30f18ce25 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/debugfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> @@ -222,6 +223,103 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
>  	return -EAGAIN;
>  }
>  
> +/*
> + * debugfs
> + */
> +
> +#define RD_BUF (2 * PAGE_SIZE)
> +
> +static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
> +			    char *buf, size_t pos, unsigned int reg)
> +{
> +	return scnprintf(buf + pos, RD_BUF - pos,
> +			 "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
> +}
> +
> +static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct sdw_cdns *cdns = file->private_data;
> +	char *buf;
> +	ssize_t ret;
> +	int i, j;
> +
> +	buf = kzalloc(RD_BUF, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
> +	for (i = 0; i < 8; i++) /* 8 MCP registers */
> +		ret += cdns_sprintf(cdns, buf, ret, i * 4);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nStatus & Intr Registers\n");
> +	for (i = 0; i < 13; i++) /* 13 Status & Intr registers */
> +		ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_STAT + i * 4);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nSSP & Clk ctrl Registers\n");
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nDPn B0 Registers\n");
> +	for (i = 0; i < 7; i++) {
> +		ret += scnprintf(buf + ret, RD_BUF - ret,
> +				 "\nDP-%d\n", i);
> +		for (j = 0; j < 6; j++)
> +			ret += cdns_sprintf(cdns, buf, ret,
> +					CDNS_DPN_B0_CONFIG(i) + j * 4);
> +	}
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nDPn B1 Registers\n");
> +	for (i = 0; i < 7; i++) {
> +		ret += scnprintf(buf + ret, RD_BUF - ret,
> +				 "\nDP-%d\n", i);
> +
> +		for (j = 0; j < 6; j++)
> +			ret += cdns_sprintf(cdns, buf, ret,
> +					CDNS_DPN_B1_CONFIG(i) + j * 4);
> +	}
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nDPn Control Registers\n");
> +	for (i = 0; i < 7; i++)
> +		ret += cdns_sprintf(cdns, buf, ret,
> +				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nPDIn Config Registers\n");
> +	for (i = 0; i < 7; i++)
> +		ret += cdns_sprintf(cdns, buf, ret, CDNS_PDI_CONFIG(i));
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations cdns_reg_fops = {
> +	.open = simple_open,
> +	.read = cdns_reg_read,
> +	.llseek = default_llseek,
> +};
> +
> +/**
> + * sdw_cdns_debugfs_init() - Cadence debugfs init
> + * @cdns: Cadence instance
> + * @root: debugfs root
> + */
> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
> +{
> +	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +}
> +EXPORT_SYMBOL(sdw_cdns_debugfs_init);

Don't wrap debugfs calls with export symbol without using
EXPORT_SYMBOL_GPL() or you will get grumpy emails from me :)

thanks,

greg k-h
