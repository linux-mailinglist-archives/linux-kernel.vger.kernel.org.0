Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DA18D6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 19:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCTSRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 14:17:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:6726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCTSRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:17:54 -0400
IronPort-SDR: O3l9wgIUd9Zr6vfkYJlvXLVveniBQTz4HmVh3IIlxh3fueL0c/vllOaXwiKdjOiIZ215yverbU
 OyLVOnvLSYaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 11:17:54 -0700
IronPort-SDR: DDP/GIIyJJ19iIoNiPikDTqzpCLiEvcn3EZasMzS26QsrLJYpGZzzToJt3N8BmP4qUssLmTSV/
 L5p+doQnNwBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="392230359"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12]) ([10.255.34.12])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:17:51 -0700
Subject: Re: [PATCH 3/7] soundwire: intel: add mutex to prevent concurrent
 access to SHIM registers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-4-pierre-louis.bossart@linux.intel.com>
 <20200320134112.GC4885@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a989368c-5a57-a726-0816-2e389d733ae0@linux.intel.com>
Date:   Fri, 20 Mar 2020 09:07:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320134112.GC4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
>> index 38b7c125fb10..568c84a80d79 100644
>> --- a/drivers/soundwire/intel.h
>> +++ b/drivers/soundwire/intel.h
>> @@ -15,6 +15,7 @@
>>    * @irq: Interrupt line
>>    * @ops: Shim callback ops
>>    * @dev: device implementing hw_params and free callbacks
>> + * @shim_lock: mutex to handle access to shared SHIM registers
>>    */
>>   struct sdw_intel_link_res {
>>   	struct platform_device *pdev;
>> @@ -25,6 +26,7 @@ struct sdw_intel_link_res {
>>   	int irq;
>>   	const struct sdw_intel_ops *ops;
>>   	struct device *dev;
>> +	struct mutex *shim_lock; /* protect shared registers */
> 
> Where is this mutex initialized? Did you test this...

Dude, we've been testing the heck out of SoundWire.

If you want to see the actual initialization it's in the intel_init.c code:

https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L231

And this was clearly stated in the cover letter:

"Reviewers might object that the code is provided without some required
initializations for mutexes and shim masks, they will be added as part
of the transition to sdw_master_device - still stuck as of 3/11."

