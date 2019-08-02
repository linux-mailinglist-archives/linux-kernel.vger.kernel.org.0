Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868AE7FD06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfHBPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 11:08:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:10558 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfHBPIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:08:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 08:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="175607546"
Received: from vivekcha-mobl1.amr.corp.intel.com (HELO [10.251.131.115]) ([10.251.131.115])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 08:08:29 -0700
Subject: Re: [RFC PATCH 05/40] soundwire: intel: move interrupt enable after
 interrupt handler registration
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-6-pierre-louis.bossart@linux.intel.com>
 <20190802115359.GH12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c4cca5ba-0ef9-9f31-148a-5aa94baddd85@linux.intel.com>
Date:   Fri, 2 Aug 2019 10:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802115359.GH12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/19 6:53 AM, Vinod Koul wrote:
> On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
>> Not sure why the existing code would enable interrupts without the
>> ability to deal with them.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index aeadc341c0a3..68832e613b1e 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -981,8 +981,6 @@ static int intel_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_init;
>>   
>> -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>> -
>>   	/* Read the PDI config and initialize cadence PDI */
>>   	intel_pdi_init(sdw, &config);
>>   	ret = sdw_cdns_pdi_init(&sdw->cdns, config);
>> @@ -1000,6 +998,8 @@ static int intel_probe(struct platform_device *pdev)
>>   		goto err_init;
>>   	}
>>   
>> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> 
> we should also handle the return

yes, fixed already
