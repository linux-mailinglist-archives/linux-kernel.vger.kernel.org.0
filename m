Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6128713815B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 13:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgAKMS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 07:18:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:5095 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbgAKMS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 07:18:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 04:18:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,421,1571727600"; 
   d="scan'208";a="396689983"
Received: from syamada-mobl.amr.corp.intel.com (HELO [10.255.229.5]) ([10.255.229.5])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2020 04:18:26 -0800
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: stream: update state machine
 and add state checks
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-3-pierre-louis.bossart@linux.intel.com>
 <20200110064838.GY2818@vkoul-mobl>
 <a18c668f-4628-0fb9-ffa0-b24cdad1cc8b@linux.intel.com>
Message-ID: <69ad48b0-fa3c-904a-4106-5cd9bd18de5c@linux.intel.com>
Date:   Sat, 11 Jan 2020 05:30:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a18c668f-4628-0fb9-ffa0-b24cdad1cc8b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/20 10:30 AM, Pierre-Louis Bossart wrote:
> 
>>> -  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
>>> +  int sdw_prepare_stream(struct sdw_stream_runtime * stream, bool 
>>> resume);
>>
>> so what does the additional argument of resume do..?
>>
>>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>>> index 178ae92b8cc1..6aa0b5d370c0 100644
>>> --- a/drivers/soundwire/stream.c
>>> +++ b/drivers/soundwire/stream.c
>>> @@ -1553,8 +1553,18 @@ int sdw_prepare_stream(struct 
>>> sdw_stream_runtime *stream)
>>
>> and it is not modified here, so is the doc correct or this..?
> 
> the doc is correct and the code is updated in
> 
> [PATCH 4/6] soundwire: stream: do not update parameters during 
> DISABLED-PREPARED transition

Sorry, wrong answer, my bad. The code block in the documentation is 
incorrect.

The Patch 4/6 implements the transition mentioned in the documentation, 
but the extra parameter is a left-over from an earlier version. This 
case is now handled internally. We did revert to the initial prototype 
after finding out that dealing with transitions in the caller is 
error-prone.

Will fix in v2, thanks for spotting this.
