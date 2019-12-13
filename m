Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3E11E71F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 16:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfLMPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 10:54:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:34227 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfLMPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:54:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 07:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="246170744"
Received: from dbmoens-mobl1.amr.corp.intel.com ([10.255.228.102])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2019 07:54:15 -0800
Subject: Re: [alsa-devel] [PATCH v4 06/15] soundwire: add support for
 sdw_slave_type
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-7-pierre-louis.bossart@linux.intel.com>
 <20191213072127.GD1750354@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <41d1fcbc-47b7-bbee-5b55-759cbb5f5a7b@linux.intel.com>
Date:   Fri, 13 Dec 2019 09:05:37 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213072127.GD1750354@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 1:21 AM, Greg KH wrote:
> On Thu, Dec 12, 2019 at 11:04:00PM -0600, Pierre-Louis Bossart wrote:
>> Currently the bus does not have any explicit support for master
>> devices.
>>
>> First add explicit support for sdw_slave_type and error checks if this type
>> is not set.
>>
>> In follow-up patches we can add support for the sdw_md_type (md==Master
>> Device), following the Grey Bus example.
> 
> How are you using greybus as an example of "master devices"?  All you
> are doing here is setting the type of the existing devices, right?

I took your advice to look at GreyBus and used the 'gb host device' as 
the model to implement the 'sdw master' add/startup/remove interfaces we 
needed.

so yes in this patch we just add a type for the slave, the interesting 
part is in the next patches.
>>   static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   {
>> -	struct sdw_slave *slave = to_sdw_slave_device(dev);
>> +	struct sdw_slave *slave;
>>   	char modalias[32];
>>   
>> -	sdw_slave_modalias(slave, modalias, sizeof(modalias));
>> +	if (is_sdw_slave(dev)) {
>> +		slave = to_sdw_slave_device(dev);
>> +
>> +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
>>   
>> -	if (add_uevent_var(env, "MODALIAS=%s", modalias))
>> -		return -ENOMEM;
>> +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
>> +			return -ENOMEM;
>> +	} else {
>> +		/* only Slave device type supported */
>> +		dev_warn(dev, "uevent for unknown Soundwire type\n");
>> +		return -EINVAL;
> 
> Right now, this can not happen, right?
> 
> Not a problem, just trying to understand the sequence of patches here...

yes this cannot happen at this point, it's more of a paranoid test. In 
theory a SoundWire solution could enable a 'monitor' device as defined 
in the standard.
