Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C291076B03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfGZOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:05:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:42665 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfGZOFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:05:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322048440"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:05:03 -0700
Subject: Re: [alsa-devel] [RFC PATCH 09/40] soundwire: cadence_master: fix
 usage of CONFIG_UPDATE
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
 <20190725222302.GB16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b1458200-c28b-91be-8dca-acd641816676@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:05:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725222302.GB16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>   
>>   	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>>   
>> -	return 0;
>> +	/* commit changes */
>> +	ret = cdns_update_config(cdns);
>> +
>> +	return ret;
> 
> +	return cdns_update_config(cdns);

yes, will fix. thanks!
