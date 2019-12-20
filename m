Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E414F127A10
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 12:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTLgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 06:36:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41828 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfLTLgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:36:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKBaCQX082593;
        Fri, 20 Dec 2019 05:36:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576841772;
        bh=d8cyfo8OyAOfShKNXXpATI8DY9tGfXH5dt3KHImZgQo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hifFTbq4sjEBmMAUIuWwMNBNnNHRQNMbU0UdtVxaAT26c7HteBIB0mpHju8nnuYH2
         0B5jqJokNyHQVqX4YugMm6/fKRXQkLBPpp25VIIU/aME5FFpBBoJjCyFGeacy8SgH5
         YYplNFnVZ3cWCkO0A5I4xo5a30BYv5O6u2/QL2m0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKBaBE3079658;
        Fri, 20 Dec 2019 05:36:11 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 05:36:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 05:36:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKBa64o011347;
        Fri, 20 Dec 2019 05:36:06 -0600
Subject: Re: [PATCH] mfd: stm32-timers: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
References: <20191217105240.25648-1-peter.ujfalusi@ti.com>
 <a9184949-94e0-97fb-5fa8-77693e71e99a@st.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <bdfba9d1-d22b-fd55-2dce-1262017f1110@ti.com>
Date:   Fri, 20 Dec 2019 13:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a9184949-94e0-97fb-5fa8-77693e71e99a@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

On 20/12/2019 10.54, Fabrice Gasnier wrote:
> On 12/17/19 11:52 AM, Peter Ujfalusi wrote:
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/mfd/stm32-timers.c | 31 ++++++++++++++++++++++---------
>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
>> index efcd4b980c94..34747e8a4a40 100644
>> --- a/drivers/mfd/stm32-timers.c
>> +++ b/drivers/mfd/stm32-timers.c
>> @@ -167,10 +167,11 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>>  	regmap_write(ddata->regmap, TIM_ARR, 0x0);
>>  }
>>  
>> -static void stm32_timers_dma_probe(struct device *dev,
>> +static int stm32_timers_dma_probe(struct device *dev,
>>  				   struct stm32_timers *ddata)
>>  {
>>  	int i;
>> +	int ret = 0;
>>  	char name[4];
>>  
>>  	init_completion(&ddata->dma.completion);
>> @@ -179,14 +180,22 @@ static void stm32_timers_dma_probe(struct device *dev,
>>  	/* Optional DMA support: get valid DMA channel(s) or NULL */
>>  	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
>>  		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
>> -		ddata->dma.chans[i] = dma_request_slave_channel(dev, name);
>> +		ddata->dma.chans[i] = dma_request_chan(dev, name);
>>  	}
>> -	ddata->dma.chans[STM32_TIMERS_DMA_UP] =
>> -		dma_request_slave_channel(dev, "up");
>> -	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] =
>> -		dma_request_slave_channel(dev, "trig");
>> -	ddata->dma.chans[STM32_TIMERS_DMA_COM] =
>> -		dma_request_slave_channel(dev, "com");
>> +	ddata->dma.chans[STM32_TIMERS_DMA_UP] = dma_request_chan(dev, "up");
>> +	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] = dma_request_chan(dev, "trig");
>> +	ddata->dma.chans[STM32_TIMERS_DMA_COM] = dma_request_chan(dev, "com");
>> +
>> +	for (i = STM32_TIMERS_DMA_CH1; i < STM32_TIMERS_MAX_DMAS; i++) {
>> +		if (IS_ERR(ddata->dma.chans[i])) {
>> +			if (PTR_ERR(ddata->dma.chans[i]) == -EPROBE_DEFER)> +				ret = -EPROBE_DEFER;
> 
> Hi Peter,
> 
> Thanks for the patch,
> 
> As the DMA is optional, I'd rather prefer to check explicitly there's no
> device, and return any other error case, basically:
> 
> 			if (PTR_ERR(ddata->dma.chans[i]) != -ENODEV)
> 				return PTR_ERR(ddata->dma.chans[i]);

My intention was to specifically pick and handle EPROBE_DEFER while not
changing how the driver handles other errors, whether it because there
is no DMA channel specified or there is a failure to get the channel.

But if you prefer to ignore only ENODEV and report other errors then I
can send v2.
It could expose otherwise ignored configuration error (from DT?) and the
change in the driver will be blamed for the regression.

Would it make sense to add the change you suggested as an iteration on
top of this patch?

> 
>> +
>> +			ddata->dma.chans[i] = NULL;
>> +		}
>> +	}
>> +
>> +	return ret;
> 
> With that, return 0 here.
> 
>>  }
>>  
>>  static void stm32_timers_dma_remove(struct device *dev,
>> @@ -230,7 +239,11 @@ static int stm32_timers_probe(struct platform_device *pdev)
>>  
>>  	stm32_timers_get_arr_size(ddata);
>>  
>> -	stm32_timers_dma_probe(dev, ddata);
>> +	ret = stm32_timers_dma_probe(dev, ddata);
>> +	if (ret) {
>> +		stm32_timers_dma_remove(dev, ddata);
> 
> With that, stm32_timers_dma_remove() likely need to be updated:
> 
> -		if (ddata->dma.chans[i])
> +		if (!IS_ERR_OR_NULL(ddata->dma.chans[i]))
> 			dma_release_channel(ddata->dma.chans[i]);
> 
> Best regards,
> Fabrice
> 
>> +		return ret;
>> +	}
>>  
>>  	platform_set_drvdata(pdev, ddata);
>>  
>>

Kind regards,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
