Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB91373AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgAJQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 11:30:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:20536 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgAJQac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:30:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 08:30:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="224241394"
Received: from nehudak-mobl1.amr.corp.intel.com (HELO [10.251.145.164]) ([10.251.145.164])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 08:30:30 -0800
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: stream: update state machine
 and add state checks
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-3-pierre-louis.bossart@linux.intel.com>
 <20200110064838.GY2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a18c668f-4628-0fb9-ffa0-b24cdad1cc8b@linux.intel.com>
Date:   Fri, 10 Jan 2020 10:30:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110064838.GY2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
>> +  int sdw_prepare_stream(struct sdw_stream_runtime * stream, bool resume);
> 
> so what does the additional argument of resume do..?
> 
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index 178ae92b8cc1..6aa0b5d370c0 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1553,8 +1553,18 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
> 
> and it is not modified here, so is the doc correct or this..?

the doc is correct and the code is updated in

[PATCH 4/6] soundwire: stream: do not update parameters during 
DISABLED-PREPARED transition


