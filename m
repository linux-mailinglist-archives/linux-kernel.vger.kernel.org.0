Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397547FF66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404576AbfHBRS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 13:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388134AbfHBRS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:18:26 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194F720880;
        Fri,  2 Aug 2019 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564766305;
        bh=8wKtHQUm2Gz9cNDDbQVdEwsNz2PS38g6O5mnwVE/NXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swDTSPaACflb7DRlZ3ErqV3xJXZxcwFl3WOcPEMV524fGa5thOSOpssbbmW4QVVxa
         XYyOVtFRb21F77cGTVoBIYXE10GKwdVtcgA5nxkYcx7DVPl6ZuVntZfIy3yo8puW8T
         tgNyss4FAL4Xsv1YqnYoVENW+dPcUYIIr8V3+ho0=
Date:   Fri, 2 Aug 2019 22:47:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 25/40] soundwire: intel: use BIOS information to set
 clock dividers
Message-ID: <20190802171711.GA12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-26-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-26-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> The BIOS provides an Intel-specific property, let's use it to avoid
> hard-coded clock dividers.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 26 ++++++++++++++++++++++----
>  drivers/soundwire/intel.c          | 26 ++++++++++++++++++++++++++
>  include/linux/soundwire/sdw.h      |  2 ++

ah, intel patch touching bunch of things!

>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index d84344e29f71..10ebcef2e84e 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -173,8 +173,6 @@
>  #define CDNS_PDI_CONFIG_PORT			GENMASK(4, 0)
>  
>  /* Driver defaults */
> -
> -#define CDNS_DEFAULT_CLK_DIVIDER		0
>  #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>  #define CDNS_TX_TIMEOUT				2000
>  
> @@ -973,7 +971,10 @@ static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
>   */
>  int sdw_cdns_init(struct sdw_cdns *cdns)
>  {
> +	struct sdw_bus *bus = &cdns->bus;
> +	struct sdw_master_prop *prop = &bus->prop;
>  	u32 val;
> +	int divider;
>  	int ret;
>  
>  	/* Exit clock stop */
> @@ -985,9 +986,17 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	}
>  
>  	/* Set clock divider */
> +	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
>  	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
> -	val |= CDNS_DEFAULT_CLK_DIVIDER;
> +	val |= divider;
>  	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
> +	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
> +
> +	pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
> +	       prop->mclk_freq,
> +	       prop->max_clk_freq,
> +	       divider,
> +	       val);

I guess you forgot to remove this!

>  
>  	/* Set the default frame shape */
>  	val = cdns_set_default_frame_shape(prop->default_row,
> @@ -1035,6 +1044,7 @@ EXPORT_SYMBOL(sdw_cdns_init);
>  
>  int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>  {
> +	struct sdw_master_prop *prop = &bus->prop;
>  	struct sdw_cdns *cdns = bus_to_cdns(bus);
>  	int mcp_clkctrl_off, mcp_clkctrl;
>  	int divider;
> @@ -1044,7 +1054,9 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>  		return -EINVAL;
>  	}
>  
> -	divider	= (params->max_dr_freq / params->curr_dr_freq) - 1;
> +	divider	= prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR /
> +		params->curr_dr_freq;
> +	divider--; /* divider is 1/(N+1) */
>  
>  	if (params->next_bank)
>  		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL1;
> @@ -1055,6 +1067,12 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>  	mcp_clkctrl |= divider;
>  	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
>  
> +	pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register %x\n",
> +	       prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
> +	       params->curr_dr_freq,
> +	       divider,
> +	       mcp_clkctrl);

here too!

> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(cdns_bus_conf);
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index c718c9c67a37..796ac2bc8cea 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -917,11 +917,37 @@ static int intel_register_dai(struct sdw_intel *sdw)
>  					  dais, num_dai);
>  }
>  
> +static int sdw_master_read_intel_prop(struct sdw_bus *bus)
> +{
> +	struct sdw_master_prop *prop = &bus->prop;
> +	struct fwnode_handle *link;
> +	char name[32];
> +	int nval, i;
> +
> +	/* Find master handle */
> +	snprintf(name, sizeof(name),
> +		 "mipi-sdw-link-%d-subproperties", bus->link_id);
> +
> +	link = device_get_named_child_node(bus->dev, name);
> +	if (!link) {
> +		dev_err(bus->dev, "Master node %s not found\n", name);
> +		return -EIO;
> +	}
> +
> +	fwnode_property_read_u32(link,
> +				 "intel-sdw-ip-clock",
> +				 &prop->mclk_freq);
> +	return 0;
> +}
> +
>  static int intel_prop_read(struct sdw_bus *bus)
>  {
>  	/* Initialize with default handler to read all DisCo properties */
>  	sdw_master_read_prop(bus);
>  
> +	/* read Intel-specific properties */
> +	sdw_master_read_intel_prop(bus);
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 31d1e8acf25b..b6acc436ac80 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -379,6 +379,7 @@ struct sdw_slave_prop {
>   * @dynamic_frame: Dynamic frame shape supported
>   * @err_threshold: Number of times that software may retry sending a single
>   * command
> + * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
>   */
>  struct sdw_master_prop {
>  	u32 revision;
> @@ -393,6 +394,7 @@ struct sdw_master_prop {
>  	u32 default_col;
>  	bool dynamic_frame;
>  	u32 err_threshold;
> +	u32 mclk_freq;

Other than debug artifacts this looks sane, but can you split up the
cadence and intel parts into different patches please

-- 
~Vinod
