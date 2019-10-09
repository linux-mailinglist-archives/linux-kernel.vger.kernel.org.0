Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6333AD09F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfJIIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 04:32:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35885 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:32:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so1494662wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxJNRe0Hszsg2U+Mp+z1v4R0II23QRMT5ghWEEi5RWE=;
        b=NhZ3NqWVqaig7QVQN06AhJ9BzVpRIStl4PO90WhabZkYR4TZahH1FZFVa8AuhAbYOQ
         mr+y43IuW+Gz2TUSN3DRidWkigXShaqiFNEe5CZ6+KRlHt3+1ZwCmVc3UF1NBIJ5RYgd
         QcYM/Mk3PAJmjItLNhySrm+th3lCHLvsMBYAZgw0JlFyEfKyatS7ULxI8HuZzirdcHgQ
         m1hYLIHicmZKXs26cm/Zj0ixcud7v4a9MU7G7cH7QMoulEEmtNoQaAbApLxrLKuy5xHV
         tb/8Skr5Hm4WCRtpABjq1M3h1U53H+OEJDU3ALp15Ck91Zqv7iiwohtLzjX1PVGLLSQc
         PoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxJNRe0Hszsg2U+Mp+z1v4R0II23QRMT5ghWEEi5RWE=;
        b=pQZ38PsBjXRiy8x5/bZKD3cAXF0cikW2sj598Hcbo3JTgUM7y1WstvjlL92eq75fxJ
         VgjaM/NnzdnkGQ+UcSCdqsuk3WUa7GLddBbxBQPyF/tzVEtmQwWeVW/TENE0twbR3Yxb
         yKSSsHkXn235GpQA+eJFiVrZbH2jYgMk4hF5IV9n3GWyn8gr46ziMsv0cpIoMZYfDako
         sxWUlD/R92OZEPHiXZBLYarmucElOevhwkheGcQPOYdnFY2LyvWrNueJX+u70bf46yJD
         bR6aaO5mv5eDrdTx4TYURJe+jarP7o/7FUfLd297kvd6yCtHlfaUDhvHr4bP5+SAWl3F
         9t2g==
X-Gm-Message-State: APjAAAXiO2vBKYzHCQYIaJBz//8QfMaHpVOK+sRFy2hPSRoyOYG+3WfT
        C9/Sc9O5fzWjv3V1yEk3dXgmbQ==
X-Google-Smtp-Source: APXvYqywaXIHFEarJCg72s40634GXF/8q5QIy4svArSx2M3KgbShup6P+88T7XbSi5C97I9i5mw2Kw==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr1647617wmk.30.1570609973203;
        Wed, 09 Oct 2019 01:32:53 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x5sm1478910wrt.75.2019.10.09.01.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:32:52 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
Date:   Wed, 9 Oct 2019 09:32:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 14/08/2019 15:09, Pierre-Louis Bossart wrote:
> 
> 
> On 8/13/19 11:11 PM, Vinod Koul wrote:
>> On 13-08-19, 20:58, Mark Brown wrote:
>>> On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart wrote:
>>>
>>>> Indeed. I don't have a full understanding of that part to be honest, 
>>>> nor why
>>>> we need something SoundWire-specific. We already abused the 
>>>> set_tdm_slot API
>>>> to store an HDaudio stream, now we have a rather confusing stream
>>>> information for SoundWire and I have about 3 other 'stream' contexts in
>>>> SOF... I am still doing basic cleanups but this has been on my radar 
>>>> for a
>>>> while.
>>>
>>> There is something to be said for not abusing the TDM slot API if it can
>>> make things clearer by using bus-idiomatic mechanisms, but it does mean
>>> everything needs to know about each individual bus :/ .
>>
>> Here ASoC doesn't need to know about sdw bus. As Srini explained, this
>> helps in the case for him to get the stream context and set the stream
>> context from the machine driver.
>>
>> Nothing else is expected to be done from this API. We already do a set
>> using snd_soc_dai_set_sdw_stream(). Here we add the 
>> snd_soc_dai_get_sdw_stream() to query
> 
> I didn't see a call to snd_soc_dai_set_sdw_stream() in Srini's code?


There is a snd_soc_dai_get_sdw_stream() to get stream context and we add 
slave streams(amplifier in this case) to that context using 
sdw_stream_add_slave() in machine driver[1].

Without this helper there is no way to link slave streams to stream 
context in non dai based setup like smart speaker amplifiers.

Currently this driver is blocked on this patch, If you think there are 
other ways to do this, am happy to try them out.

Thanks,
srini

[1] 
https://git.linaro.org/people/srinivas.kandagatla/linux.git/tree/sound/soc/qcom/db845c.c?h=release/db845c/qcomlt-5.2
