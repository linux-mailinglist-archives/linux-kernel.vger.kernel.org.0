Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E31379B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 23:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgAJWb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 17:31:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:64454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbgAJWb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:31:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 14:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="212400494"
Received: from ewronsha-mobl1.amr.corp.intel.com (HELO [10.255.66.226]) ([10.255.66.226])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2020 14:31:24 -0800
Subject: Re: [alsa-devel] [PATCH] soundwire: intel: report slave_ids for each
 link to SOF driver
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200110220016.30887-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a70c54c0-c691-d8eb-4f99-da1bb9306c2f@linux.intel.com>
Date:   Fri, 10 Jan 2020 16:31:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110220016.30887-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/20 4:00 PM, Pierre-Louis Bossart wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> The existing link_mask flag is no longer sufficient to detect the
> hardware and identify which topology file and a machine driver to load.
> 
> By reporting the slave_ids exposed in ACPI tables, the parent SOF
> driver will be able to compare against a set of static configurations.
> 
> This patch only adds the interface change, the functionality is added
> in future patches.

Vinod, this patch would need to be shared as an immutable tag for Mark, 
once this is done I can share the SOF parts that make use of the 
information (cf. https://github.com/thesofproject/linux/pull/1692 for 
reference)

Sorry we missed this in the earlier interface changes, we didn't think 
we would have so many hardware variations so quickly.

Thanks!

> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   include/linux/soundwire/sdw_intel.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
> index 93b83bdf8035..979b41b5dcb4 100644
> --- a/include/linux/soundwire/sdw_intel.h
> +++ b/include/linux/soundwire/sdw_intel.h
> @@ -5,6 +5,7 @@
>   #define __SDW_INTEL_H
>   
>   #include <linux/irqreturn.h>
> +#include <linux/soundwire/sdw.h>
>   
>   /**
>    * struct sdw_intel_stream_params_data: configuration passed during
> @@ -93,6 +94,11 @@ struct sdw_intel_link_res;
>    */
>   #define SDW_INTEL_CLK_STOP_BUS_RESET		BIT(3)
>   
> +struct sdw_intel_slave_id {
> +	int link_id;
> +	struct sdw_slave_id id;
> +};
> +
>   /**
>    * struct sdw_intel_ctx - context allocated by the controller
>    * driver probe
> @@ -101,9 +107,12 @@ struct sdw_intel_link_res;
>    * hardware capabilities after all power dependencies are settled.
>    * @link_mask: bit-wise mask listing SoundWire links reported by the
>    * Controller
> + * @num_slaves: total number of devices exposed across all enabled links
>    * @handle: ACPI parent handle
>    * @links: information for each link (controller-specific and kept
>    * opaque here)
> + * @ids: array of slave_id, representing Slaves exposed across all enabled
> + * links
>    * @link_list: list to handle interrupts across all links
>    * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
>    */
> @@ -111,8 +120,10 @@ struct sdw_intel_ctx {
>   	int count;
>   	void __iomem *mmio_base;
>   	u32 link_mask;
> +	int num_slaves;
>   	acpi_handle handle;
>   	struct sdw_intel_link_res *links;
> +	struct sdw_intel_slave_id *ids;
>   	struct list_head link_list;
>   	struct mutex shim_lock; /* lock for access to shared SHIM registers */
>   };
> 
