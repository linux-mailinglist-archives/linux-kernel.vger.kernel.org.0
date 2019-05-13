Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594491B8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfEMOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 10:41:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:38791 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfEMOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:41:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 07:41:35 -0700
X-ExtLoop1: 1
Received: from younghwa-mobl.amr.corp.intel.com (HELO [10.254.176.76]) ([10.254.176.76])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2019 07:41:34 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: max98090: remove 24-bit format support
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>, dgreid@chromium.org,
        cychiang@chromium.org
References: <20190510102559.76137-1-yuhsuan@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bb4f797a-9719-ec77-629c-46622c6fc2ea@linux.intel.com>
Date:   Mon, 13 May 2019 08:31:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510102559.76137-1-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/19 5:25 AM, Yu-Hsuan Hsu wrote:
> Remove 24-bit format support because it doesn't work now. We can revert
> this change after it really supports.
> (https://patchwork.kernel.org/patch/10783561/)
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

As discussed in the previous thread, the data sheet explicitly mentions 
24 bit support for the input in RJ mode. It'd be odd to remove support 
for 24 bits without clarifying in which modes it's not supported.

Also you'd need to clarify which platform you tested on, there are known 
issues with Maxim devices when using e.g. a 19.2 MHz clock and trailing 
bits (25-bit slots with 24-bit data).

> ---
>   sound/soc/codecs/max98090.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index 7619ea31ab50..b25b7efa9118 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2313,7 +2313,7 @@ int max98090_mic_detect(struct snd_soc_component *component,
>   EXPORT_SYMBOL_GPL(max98090_mic_detect);
>   
>   #define MAX98090_RATES SNDRV_PCM_RATE_8000_96000
> -#define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
> +#define MAX98090_FORMATS SNDRV_PCM_FMTBIT_S16_LE
>   
>   static const struct snd_soc_dai_ops max98090_dai_ops = {
>   	.set_sysclk = max98090_dai_set_sysclk,
> 
