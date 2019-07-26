Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00235762A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfGZJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 05:38:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:27786 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfGZJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:38:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 02:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="175546381"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.89.116]) ([10.251.89.116])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2019 02:38:20 -0700
Subject: Re: [RFC PATCH 03/40] soundwire: cadence_master: align debugfs to 8
 digits
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <500e2f21-3ec9-342c-ab4d-e222d9adb42c@intel.com>
Date:   Fri, 26 Jul 2019 11:38:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> SQUASHME
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/soundwire/cadence_master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 91e8bacb83e3..9f611a1fff0a 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -234,7 +234,7 @@ static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
>   			    char *buf, size_t pos, unsigned int reg)
>   {
>   	return scnprintf(buf + pos, RD_BUF - pos,
> -			 "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
> +			 "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
>   }
>   
>   static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
> 

Should just be merged together with the introducing commit. Guess it's 
posted unintentionally.
