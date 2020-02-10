Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC21157D64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBJO3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:29:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57486 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBJO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:29:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AESiJa001066;
        Mon, 10 Feb 2020 08:28:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581344924;
        bh=+SXU0yCFEep2Yqb8rENzdcMj11Yb5cRlMdNCjpmA0es=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tS+Nt8nunkUdVl31bfPwfP8vNDiDlnQ7sdnq6pQSgi9B6T/mjCojOHCYK44JPZUSy
         nOjGBg/NIsrH8km1yEQK39ovilB2UScjHjirOu3jlkSe27wN8f0MbR9cz4Z7dcIvsW
         byETDNkHXStoueFKplsWwUlKk3KgFEixlNS64gHk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AESin6127867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 08:28:44 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 08:28:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 08:28:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AESfmZ067868;
        Mon, 10 Feb 2020 08:28:42 -0600
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Consider DMA cache caused delay in
 pointer callback
To:     Takashi Iwai <tiwai@suse.de>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <lars@metafoo.de>, <alsa-devel@alsa-project.org>,
        <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200210140423.10232-1-peter.ujfalusi@ti.com>
 <s5hmu9qfrq7.wl-tiwai@suse.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <15c7df10-cf9f-109c-3cbf-e73af7f4f66a@ti.com>
Date:   Mon, 10 Feb 2020 16:28:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <s5hmu9qfrq7.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 10/02/2020 16.21, Takashi Iwai wrote:
> On Mon, 10 Feb 2020 15:04:23 +0100,
> Peter Ujfalusi wrote:
>>
>> Some DMA engines can have big FIFOs which adds to the latency.
>> The DMAengine framework can report the FIFO utilization in bytes. Use this
>> information for the delay reporting.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> 5.6-rc1 now have support for reporting the DMA cached data.
>> With this patch we can include it to the delay calculation.
>> The first DMA driver which reports this is the TI K3 UDMA driver.
>>
>> Regards,
>> Peter
>>
>>  sound/core/pcm_dmaengine.c | 6 ++++++
>>  sound/soc/soc-pcm.c        | 2 +-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
>> index 5749a8a49784..4f1395fd0160 100644
>> --- a/sound/core/pcm_dmaengine.c
>> +++ b/sound/core/pcm_dmaengine.c
>> @@ -247,9 +247,15 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
>>  
>>  	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
>>  	if (status == DMA_IN_PROGRESS || status == DMA_PAUSED) {
>> +		struct snd_pcm_runtime *runtime = substream->runtime;
>> +		int sample_bits = snd_pcm_format_physical_width(runtime->format);
>> +
>>  		buf_size = snd_pcm_lib_buffer_bytes(substream);
>>  		if (state.residue > 0 && state.residue <= buf_size)
>>  			pos = buf_size - state.residue;
>> +
>> +		sample_bits *= runtime->channels;
>> +		runtime->delay = state.in_flight_bytes / (sample_bits / 8);
> 
> Can this be simply bytes_to_frames()?
> 
> 		runtime->delay = bytes_to_frames(runtime, state.in_flight_bytes);

Certainly it can, I looked at various helper but somehow missed the
bytes_to_frames().

I'll send v2 in about an hour.



> 
>>  	}
>>  
>>  	return bytes_to_frames(substream->runtime, pos);
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index ff1b7c7078e5..58ef508d70a3 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -1151,7 +1151,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>>  	}
>>  	delay += codec_delay;
>>  
>> -	runtime->delay = delay;
>> +	runtime->delay += delay;
> 
> Is it correct?
> delay already takes runtime->delay as its basis, so it'll result in a
> double.

The delay here is coming from the DAI and the codec.
The runtime->delay hold the PCM (DMA) caused delay.

> 
> thanks,
> 
> Takashi
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
