Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5419A83576
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfHFPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 11:39:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:53903 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfHFPjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:39:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 08:39:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="165019429"
Received: from tremilla-mobl1.amr.corp.intel.com (HELO [10.251.15.130]) ([10.251.15.130])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2019 08:39:24 -0700
Subject: Re: [PATCH 09/17] soundwire: stream: remove unnecessary variable
 initializations
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190806005522.22642-10-pierre-louis.bossart@linux.intel.com>
 <a52b4fbd-1d97-d8b8-dd2c-fac30c6add4b@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <346425e0-0001-ecbc-c79a-c1372d0b4fcc@linux.intel.com>
Date:   Tue, 6 Aug 2019 10:39:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a52b4fbd-1d97-d8b8-dd2c-fac30c6add4b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/19 10:31 AM, Cezary Rojewski wrote:
> On 2019-08-06 02:55, Pierre-Louis Bossart wrote:
>> @@ -1493,6 +1493,11 @@ static int _sdw_prepare_stream(struct 
>> sdw_stream_runtime *stream)
>>           }
>>       }
>> +    if (!bus) {
>> +        pr_err("Configuration error in %s\n", __func__);
>> +        return -EINVAL;
>> +    }
>> +
> 
> This should probably be located in separate path - not at all an 
> initialization removal.

It's a consequence of the initialization removal: because we are 
removing the default init, there is a risk that the loop just before do 
not set it, so it's required to trap the case where the variable in not 
initialized.

> 
>> @@ -1573,6 +1578,11 @@ static int _sdw_enable_stream(struct 
>> sdw_stream_runtime *stream)
>>           }
>>       }
>> +    if (!bus) {
>> +        pr_err("Configuration error in %s\n", __func__);
>> +        return -EINVAL;
>> +    }
>> +
> 
> Same here.

same reply

> 
>> @@ -1639,13 +1650,14 @@ static int _sdw_disable_stream(struct 
>> sdw_stream_runtime *stream)
>>       ret = do_bank_switch(stream);
>>       if (ret < 0) {
>> -        dev_err(bus->dev, "Bank switch failed: %d\n", ret);
>> +        pr_err("Bank switch failed: %d\n", ret);
>>           return ret;
>>       }
> 
> Here too.

no, same thing, the bus variable is initialized in loops so tools will 
report a possible path where bus->dev is an invalid dereference.

> I might have missed something though I bet you got my point.
