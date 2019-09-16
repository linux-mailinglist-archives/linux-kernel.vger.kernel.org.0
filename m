Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1BB401C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfIPSOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 14:14:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:15860 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfIPSOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:14:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 11:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="361605341"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO [10.254.104.227]) ([10.254.104.227])
  by orsmga005.jf.intel.com with ESMTP; 16 Sep 2019 11:14:12 -0700
Subject: Re: [alsa-devel] [PATCH 1/6] soundwire: fix startup sequence for
 Intel/Cadence
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-2-pierre-louis.bossart@linux.intel.com>
 <20190904071108.GI2672@vkoul-mobl>
 <dc16e4d8-1d95-542c-869e-bdefc37d059b@linux.intel.com>
Message-ID: <4734e29e-859d-745b-5cc6-ce70ca6e6c99@linux.intel.com>
Date:   Mon, 16 Sep 2019 13:14:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc16e4d8-1d95-542c-869e-bdefc37d059b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> @@ -1043,8 +1043,6 @@ static int intel_probe(struct platform_device 
>>> *pdev)
>>>       if (ret)
>>>           goto err_init;
>>> -    ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>>> -
>>>       /* Read the PDI config and initialize cadence PDI */
>>>       intel_pdi_init(sdw, &config);
>>>       ret = sdw_cdns_pdi_init(&sdw->cdns, config);
>>> @@ -1062,6 +1060,18 @@ static int intel_probe(struct platform_device 
>>> *pdev)
>>>           goto err_init;
>>>       }
>>> +    ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>>> +    if (ret < 0) {
>>> +        dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
>>> +        goto err_init;
>>> +    }
>>> +
>>> +    ret = sdw_cdns_exit_reset(&sdw->cdns);
>>> +    if (ret < 0) {
>>> +        dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
>>> +        goto err_init;
>>
>> Don't you want to disable interrupts at least... before you return
>> error? err_init does bus cleanup and not controller one
> 
> yes good point, let me look at this.

The existing code has no interrupt disable sequence.

I will add this improved error handling in a follow-up patch, after the 
capability to disable interrupts is added.
