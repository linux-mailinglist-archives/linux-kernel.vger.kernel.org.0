Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B597B77058
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 19:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbfGZRft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 13:35:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:42766 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387622AbfGZRft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:35:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="198464400"
Received: from andawes-mobl.amr.corp.intel.com (HELO [10.251.145.66]) ([10.251.145.66])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2019 10:35:48 -0700
Subject: Re: [alsa-devel] [RFC PATCH 38/40] soundwire: cadence_master: make
 clock stop exit configurable on init
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-39-pierre-louis.bossart@linux.intel.com>
 <20190726160258.GN16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c6ecaa08-9fdc-d228-8016-9a22241fb689@linux.intel.com>
Date:   Fri, 26 Jul 2019 12:35:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726160258.GN16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -int sdw_cdns_init(struct sdw_cdns *cdns);
>> +int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit);
>>   int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>>   		      struct sdw_cdns_stream_config config);
>>   int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 1192d5775484..db7bf2912767 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1043,7 +1043,7 @@ static int intel_init(struct sdw_intel *sdw)
>>   	intel_link_power_up(sdw);
>>   	intel_shim_init(sdw);
>>   
>> -	return sdw_cdns_init(&sdw->cdns);
>> +	return sdw_cdns_init(&sdw->cdns, false);
> 
> This is the only caller of this function so far, so, it looks like
> the second argument ATM is always "false." I assume you foresee other
> uses with "true" in the future, otherwise maybe just fix it to false
> in the function?

Since we are at RFC level things are not set in stone, it's not fully 
clear if this test is required or not. I added it since Rander reported 
an error on one of the target platforms that I didn't see personally. 
We'll double-check if it's needed. And if indeed it's needed, yes it'll 
be set to true when we add clock stop.
