Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3122C9F32F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfH0TSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:18:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:39331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0TSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:18:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 12:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="171296979"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.27.63]) ([10.252.27.63])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2019 12:18:38 -0700
Subject: Re: [PATCH 2/6] ASoC: Intel: Fix use of potentially uninitialized
 variable
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
 <20190827141712.21015-3-amadeuszx.slawinski@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a1ce2e69-d93a-93e8-8bbf-07c27e52124f@intel.com>
Date:   Tue, 27 Aug 2019 21:18:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827141712.21015-3-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-27 16:17, Amadeusz Sławiński wrote:
> From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
> 
> If ipc->ops.reply_msg_match is NULL, we may end up using uninitialized
> mask value.
> 
> reported by smatch:
> sound/soc/intel/common/sst-ipc.c:266 sst_ipc_reply_find_msg() error: uninitialized symbol 'mask'.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
> ---
>   sound/soc/intel/common/sst-ipc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
> index 1186a03a88d6..6068bb697e22 100644
> --- a/sound/soc/intel/common/sst-ipc.c
> +++ b/sound/soc/intel/common/sst-ipc.c
> @@ -223,6 +223,8 @@ struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
>   
>   	if (ipc->ops.reply_msg_match != NULL)
>   		header = ipc->ops.reply_msg_match(header, &mask);
> +	else
> +		mask = (u64)-1;

Please see linux/limits.h and check if this can't be replaced by an 
equivalent found there.

>   
>   	if (list_empty(&ipc->rx_list)) {
>   		dev_err(ipc->dev, "error: rx list empty but received 0x%llx\n",
> 
