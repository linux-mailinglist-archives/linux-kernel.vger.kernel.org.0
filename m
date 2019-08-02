Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792A37FF86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 19:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404939AbfHBRYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 13:24:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:2162 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404689AbfHBRYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:24:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 10:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="324630980"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2019 10:24:10 -0700
Received: from cwhanson-mobl.amr.corp.intel.com (unknown [10.252.133.191])
        by linux.intel.com (Postfix) with ESMTP id 65DFC58046F;
        Fri,  2 Aug 2019 10:24:09 -0700 (PDT)
Subject: Re: [RFC PATCH 24/40] soundwire: cadence_master: use BIOS defaults
 for frame shape
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
 <20190802171014.GZ12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a7b691cc-353f-f052-b25e-edbf7fe21c4a@linux.intel.com>
Date:   Fri, 2 Aug 2019 12:24:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802171014.GZ12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 12:10 PM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
>> Remove hard-coding and use BIOS values. If they are wrong use default
> 
> BIOS :) this is cadence, am sure this can be used outside BIOS :D
> 
> It would be better to say firmware (ACPI/DT)

yes

> 
>> 48x2 frame shape.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 442f78c00f09..d84344e29f71 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -175,7 +175,6 @@
>>   /* Driver defaults */
>>   
>>   #define CDNS_DEFAULT_CLK_DIVIDER		0
>> -#define CDNS_DEFAULT_FRAME_SHAPE		0x30
>>   #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>>   #define CDNS_TX_TIMEOUT				2000
>>   
>> @@ -954,6 +953,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>>   }
>>   EXPORT_SYMBOL(sdw_cdns_pdi_init);
>>   
>> +static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
>> +{
>> +	u32 val;
>> +	int c;
>> +	int r;
> 
> This can be in single line!

one line per variable is what I prefer.

> 
>> +
>> +	r = sdw_find_row_index(n_rows);
>> +	c = sdw_find_col_index(n_cols);
>> +
>> +	val = (r << 3) | c;
> 
> Magic 3?

yes fixed already.

