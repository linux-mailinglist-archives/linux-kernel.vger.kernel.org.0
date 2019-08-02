Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637AC7FFD0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 19:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405756AbfHBRoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 13:44:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:49591 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404609AbfHBRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:44:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 10:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="181076889"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2019 10:44:06 -0700
Received: from cwhanson-mobl.amr.corp.intel.com (unknown [10.252.133.191])
        by linux.intel.com (Postfix) with ESMTP id 107F05800BD;
        Fri,  2 Aug 2019 10:44:04 -0700 (PDT)
Subject: Re: [RFC PATCH 34/40] soundwire: intel: ignore disabled links for
 suspend/resume
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-35-pierre-louis.bossart@linux.intel.com>
 <20190802173047.GD12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c3c15a22-3738-1e04-4b58-6c6bba4c27de@linux.intel.com>
Date:   Fri, 2 Aug 2019 12:44:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802173047.GD12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 12:30 PM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> 
> Please add explanation why..

yes missed this

> 
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 1477c35f616f..a976480d6f36 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1161,6 +1161,12 @@ static int intel_suspend(struct device *dev)
>>   
>>   	sdw = dev_get_drvdata(dev);
>>   
>> +	if (sdw->cdns.bus.prop.hw_disabled) {
>> +		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
>> +			sdw->cdns.bus.link_id);
>> +		return 0;
>> +	}
>> +
>>   	ret = intel_link_power_down(sdw);
>>   	if (ret) {
>>   		dev_err(dev, "Link power down failed: %d", ret);
>> @@ -1179,6 +1185,12 @@ static int intel_resume(struct device *dev)
>>   
>>   	sdw = dev_get_drvdata(dev);
>>   
>> +	if (sdw->cdns.bus.prop.hw_disabled) {
>> +		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
>> +			sdw->cdns.bus.link_id);
>> +		return 0;
>> +	}
>> +
>>   	ret = intel_init(sdw);
>>   	if (ret) {
>>   		dev_err(dev, "%s failed: %d", __func__, ret);
>> -- 
>> 2.20.1
> 

