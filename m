Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EA19B3B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405919AbfHWPoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 11:44:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:50812 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbfHWPob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:44:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 08:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="330763198"
Received: from sdkulkar-mobl.amr.corp.intel.com (HELO [10.254.94.219]) ([10.254.94.219])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2019 08:44:30 -0700
Subject: Re: [alsa-devel] [RESEND PATCH v4 2/4] soundwire: core: add device
 tree support for slave devices
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2f1b5e2e-4699-1d06-e28e-708d5ed99b6a@linux.intel.com>
Date:   Fri, 23 Aug 2019 10:44:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822233759.12663-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/19 6:37 PM, Srinivas Kandagatla wrote:
> This patch adds support to parsing device tree based
> SoundWire slave devices.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/bus.c   |  2 ++
>   drivers/soundwire/bus.h   |  1 +
>   drivers/soundwire/slave.c | 52 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 55 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 49f64b2115b9..c2eaeb5c38ed 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -77,6 +77,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>   	 */
>   	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
>   		ret = sdw_acpi_find_slaves(bus);
> +	else if (IS_ENABLED(CONFIG_OF) && bus->dev->of_node)
> +		ret = sdw_of_find_slaves(bus);
>   	else
>   		ret = -ENOTSUPP; /* No ACPI/DT so error out */
>   
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 3048ca153f22..ee46befedbd1 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -15,6 +15,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>   }
>   #endif
>   
> +int sdw_of_find_slaves(struct sdw_bus *bus);
>   void sdw_extract_slave_id(struct sdw_bus *bus,
>   			  u64 addr, struct sdw_slave_id *id);
>   
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a5815e25d..3ef265d2ee89 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -2,6 +2,7 @@
>   // Copyright(c) 2015-17 Intel Corporation.
>   
>   #include <linux/acpi.h>
> +#include <linux/of.h>
>   #include <linux/soundwire/sdw.h>
>   #include <linux/soundwire/sdw_type.h>
>   #include "bus.h"
> @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>   
>   	slave->dev.release = sdw_slave_release;
>   	slave->dev.bus = &sdw_bus_type;
> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));
>   	slave->bus = bus;
>   	slave->status = SDW_SLAVE_UNATTACHED;
>   	slave->dev_num = 0;
> @@ -112,3 +114,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>   }
>   
>   #endif
> +
> +/*
> + * sdw_of_find_slaves() - Find Slave devices in master device tree node
> + * @bus: SDW bus instance
> + *
> + * Scans Master DT node for SDW child Slave devices and registers it.
> + */
> +int sdw_of_find_slaves(struct sdw_bus *bus)
> +{
> +	struct device *dev = bus->dev;
> +	struct device_node *node;
> +
> +	for_each_child_of_node(bus->dev->of_node, node) {
> +		int link_id, sdw_version, ret, len;
> +		const char *compat = NULL;
> +		struct sdw_slave_id id;
> +		const __be32 *addr;
> +
> +		compat = of_get_property(node, "compatible", NULL);
> +		if (!compat)
> +			continue;
> +
> +		ret = sscanf(compat, "sdw%01x%04hx%04hx%02hhx", &sdw_version,
> +			     &id.mfg_id, &id.part_id, &id.class_id);
> +
> +		if (ret != 4) {
> +			dev_err(dev, "Invalid compatible string found %s\n",
> +				compat);
> +			continue;
> +		}
> +
> +		addr = of_get_property(node, "reg", &len);
> +		if (!addr || (len < 2 * sizeof(u32))) {
> +			dev_err(dev, "Invalid Instance and Link ID\n");
> +			continue;
> +		}
> +
> +		id.unique_id = be32_to_cpup(addr++);
> +		link_id = be32_to_cpup(addr);

So here the link ID is obviously not in the address, so you are not 
using the MIPI spec as we discussed initially?

> +		id.sdw_version = sdw_version;
> +
> +		/* Check for link_id match */
> +		if (link_id != bus->link_id)
> +			continue;
> +
> +		sdw_slave_add(bus, &id, of_fwnode_handle(node));
> +	}
> +
> +	return 0;
> +}
> 
