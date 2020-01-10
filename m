Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09A4137291
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 17:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgAJQLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 11:11:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:40028 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbgAJQLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:11:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 08:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="224236636"
Received: from nehudak-mobl1.amr.corp.intel.com (HELO [10.251.145.164]) ([10.251.145.164])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 08:11:47 -0800
Subject: Re: [alsa-devel] [PATCH 4/6] soundwire: stream: do not update
 parameters during DISABLED-PREPARED transition
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-5-pierre-louis.bossart@linux.intel.com>
 <20200110065515.GZ2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b77c227a-6779-6ed7-9ce8-68b996a08caa@linux.intel.com>
Date:   Fri, 10 Jan 2020 10:11:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110065515.GZ2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +	/*
>> +	 * when the stream is DISABLED, this means sdw_prepare_stream()
>> +	 * is called as a result of an underflow or a resume operation.
>> +	 * In this case, the bus parameters shall not be recomputed, but
>> +	 * still need to be re-applied
>> +	 */
>> +	if (stream->state == SDW_STREAM_DISABLED)
>> +		update_params = false;
> 
> Should this not be handled by the caller..? I do not like to deduce this
> here as the info is already available in dai driver, so go ahead and
> propagate it and get it from caller when it is required..

No, this update_params boolean is used later on to modify the bandwidth 
computation. These values are not accessible to the caller (and should 
absolutely be kept private/opaque).

