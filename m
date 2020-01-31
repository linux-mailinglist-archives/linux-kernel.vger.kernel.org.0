Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA6114E781
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 04:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgAaDU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 22:20:59 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8581 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgAaDU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:20:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e339d0b0000>; Thu, 30 Jan 2020 19:20:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 19:20:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 19:20:58 -0800
Received: from [10.25.73.84] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan
 2020 03:20:55 +0000
CC:     <spujar@nvidia.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5659: add S32_LE format
To:     Oder Chiou <oder_chiou@realtek.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
References: <1579501059-27936-1-git-send-email-spujar@nvidia.com>
 <74a42452-f19c-1175-9928-da12ccad621d@nvidia.com>
 <c700f22c-a053-7f39-dddf-41abe52cad77@nvidia.com>
 <67328e51035e4eb5a6a78c3156e5d11f@realtek.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <d99e7cc4-f69b-55a2-a9e9-623ad11d6312@nvidia.com>
Date:   Fri, 31 Jan 2020 08:50:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <67328e51035e4eb5a6a78c3156e5d11f@realtek.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580440843; bh=WmI/B6AsuQiNTGM7yM8QllMGfzZ7qHsDpaBdPWuw/4g=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=C3B+OFolt+pEfYtV7JECEFIFpfqBUdvQJKlv4iFaTHkDWjn1amJPzfW4U6Ln/q6W6
         jqjJc/J8JqAnFRCdL5sBWWXVtlkFGqM0f/4m22fo2t+roFd7sndrLQ6RvRxOZB2zYy
         tu+1o4+WNdoXA7qBMGWn9doOHZuuUa3vpunL1viukXUwMxBhwLSF8namDJ/1ZtyxyS
         w+fT7CTV5Yc8BPH7L1m1n9yRY26hDzjLEfjR6msgFW0RRHkhH12SAVs6VkKr53uuJj
         eA19eHOoVMioZG8f2YuBgQvQ74iUYRX+X7QuUWm5inwcXoRyYYHXjLYrgAjUrRn3d+
         pEUdMMhOk9rxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2020 10:00 AM, Oder Chiou wrote:
> External email: Use caution opening links or attachments
>
>
> Acked-by: Oder Chiou <oder_chiou@realtek.com>

Request maintainers to consider this patch for approval. Thanks in advance.

. . .
>>>> ALC5659 supports maximum data length of 24-bit. Currently driver
>>>> supports
>>>> S24_LE which is a 32-bit container with valid data in [23:0] and 0s
>>>> in MSB.
>>>> S24_3LE is not commonly used and is hard to find audio streams with this
>>>> format. Also many SoC HW do not support S24_LE and S32_LE is used in
>>>> general. The 24-bit data can be represented in S32_LE [31:8] and 0s are
>>>> padded in LSB.
>>>>
>>>> This patch adds S32_LE to ALC5659 driver and data length for this is set
>>>> to 24 as per codec's maximum data length support. This helps to play
>>>> 24-bit audio, packed in S32_LE, on HW which do not support S24_LE.
>>>>
>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> ---
>>>>    sound/soc/codecs/rt5659.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
>>>> index fc74dd63..f910ddf 100644
>>>> --- a/sound/soc/codecs/rt5659.c
>>>> +++ b/sound/soc/codecs/rt5659.c
>>>> @@ -3339,6 +3339,7 @@ static int rt5659_hw_params(struct
>>>> snd_pcm_substream *substream,
>>>>            val_len |= RT5659_I2S_DL_20;
>>>>            break;
>>>>        case 24:
>>>> +    case 32:
>>>>            val_len |= RT5659_I2S_DL_24;
>>>>            break;
>>>>        case 8:
>>>> @@ -3733,7 +3734,8 @@ static int rt5659_resume(struct
>>>> snd_soc_component *component)
>>>>      #define RT5659_STEREO_RATES SNDRV_PCM_RATE_8000_192000
>>>>    #define RT5659_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
>>>> SNDRV_PCM_FMTBIT_S20_3LE | \
>>>> -        SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
>>>> +        SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE | \
>>>> +        SNDRV_PCM_FMTBIT_S8)
>>>>      static const struct snd_soc_dai_ops rt5659_aif_dai_ops = {
>>>>        .hw_params = rt5659_hw_params,
>>
>> ------Please consider the environment before printing this e-mail.

