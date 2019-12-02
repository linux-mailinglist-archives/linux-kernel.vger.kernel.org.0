Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A770710EE9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 18:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfLBRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 12:40:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:30020 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbfLBRk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:40:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 09:40:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="208164928"
Received: from svedurlx-mobl.amr.corp.intel.com (HELO [10.251.129.241]) ([10.251.129.241])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2019 09:40:26 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: sst: Add missing include
 <linux/io.h>
To:     YueHaibing <yuehaibing@huawei.com>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        gregkh@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, alexios.zavras@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191128135853.8360-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <62e5bb2c-14a9-66d0-c89e-c38b5550fb86@linux.intel.com>
Date:   Mon, 2 Dec 2019 11:32:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191128135853.8360-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/19 7:58 AM, YueHaibing wrote:
> Fix build error:
> 
> sound/soc/intel/atom/sst/sst.c: In function intel_sst_interrupt_mrfld:
> sound/soc/intel/atom/sst/sst.c:93:5: error: implicit declaration of function memcpy_fromio;
>   did you mean memcpy32_fromio? [-Werror=implicit-function-declaration]
>       memcpy_fromio(msg->mailbox_data,
>       ^~~~~~~~~~~~~
>       memcpy32_fromio
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

that looks legit, we had similar reports for SoundWire.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/atom/sst/sst.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
> index fbecbb7..68bcec5 100644
> --- a/sound/soc/intel/atom/sst/sst.c
> +++ b/sound/soc/intel/atom/sst/sst.c
> @@ -14,6 +14,7 @@
>   #include <linux/module.h>
>   #include <linux/fs.h>
>   #include <linux/interrupt.h>
> +#include <linux/io.h>
>   #include <linux/firmware.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/pm_qos.h>
> 
