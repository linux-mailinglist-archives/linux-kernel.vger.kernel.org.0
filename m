Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3976A68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbfGZN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:58:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:17590 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfGZN6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:58:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 06:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322045174"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 06:58:36 -0700
Subject: Re: [alsa-devel] [RFC PATCH 03/40] soundwire: cadence_master: align
 debugfs to 8 digits
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
 <500e2f21-3ec9-342c-ab4d-e222d9adb42c@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b557d2ac-2229-d24e-6d64-e426a2a96dfa@linux.intel.com>
Date:   Fri, 26 Jul 2019 08:58:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <500e2f21-3ec9-342c-ab4d-e222d9adb42c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 4:38 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
>> SQUASHME
>>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c 
>> b/drivers/soundwire/cadence_master.c
>> index 91e8bacb83e3..9f611a1fff0a 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -234,7 +234,7 @@ static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
>>                   char *buf, size_t pos, unsigned int reg)
>>   {
>>       return scnprintf(buf + pos, RD_BUF - pos,
>> -             "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
>> +             "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
>>   }
>>   static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
>>
> 
> Should just be merged together with the introducing commit. Guess it's 
> posted unintentionally.

Yep, I missed this, will squash in the updates as intended.
