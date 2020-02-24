Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BF616A431
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 11:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBXKnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 05:43:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:10855 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXKnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:43:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 02:43:04 -0800
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; 
   d="scan'208";a="225935345"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.154.74]) ([10.249.154.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Feb 2020 02:43:02 -0800
Subject: Re: [PATCH] Intel: Skylake: Fix inconsistent IS_ERR and PTR_ERR
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joe Perches <joe@perches.com>, Xu Wang <vulab@iscas.ac.cn>,
        "Slawinski, AmadeuszX" <amadeuszx.slawinski@intel.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com
References: <20200221101112.3104-1-vulab@iscas.ac.cn>
 <1247da797bc0a860e845989241385e124e589063.camel@perches.com>
 <8e96c207-cdf8-2d1f-755e-be60555c8728@linux.intel.com>
 <a0f5a3bc-3814-4e96-f81a-b693f78d2511@intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <f05ddcba-4cd2-fb55-1829-53e7ef19943f@linux.intel.com>
Date:   Mon, 24 Feb 2020 11:42:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a0f5a3bc-3814-4e96-f81a-b693f78d2511@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2020 4:59 PM, Cezary Rojewski wrote:
> On 2020-02-21 16:40, Pierre-Louis Bossart wrote:
>> On 2/21/20 8:41 AM, Joe Perches wrote:
>>> On Fri, 2020-02-21 at 18:11 +0800, Xu Wang wrote:
>>>> PTR_ERR should access the value just tested by IS_ERR.
>>>> In skl_clk_dev_probe(),it is inconsistent.
> 
> Please include all maintainers of given driver when submitting the 
> patch, thank you.
> 
>>> []
>>>> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c 
>>>> b/sound/soc/intel/skylake/skl-ssp-clk.c
>>> []
>>>> @@ -384,7 +384,7 @@ static int skl_clk_dev_probe(struct 
>>>> platform_device *pdev)
>>>>                   &clks[i], clk_pdata, i);
>>>>           if (IS_ERR(data->clk[data->avail_clk_cnt])) {
>>>> -            ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>>>> +            ret = PTR_ERR(data->clk[data->avail_clk_cnt]);
>>>
>>> NAK.
>>>
>>> This is not inconsistent and you are removing the ++
>>> which is a post increment.  Likely that is necessary.
>>>
>>> You could write the access and the increment as two
>>> separate statements if it confuses you.
>>
>> Well to be fair the code is far from clear.
> 
> Thanks for notifying, Pierre.
> 
> Although NAK is upheld here. Proposed change is likely to introduce 
> regression.
> 
>>
>> the post-increment is likely needed because of the error handling in 
>> unregister_src_clk 1
>>          data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
>>                  &clks[i], clk_pdata, i);
>>
>>          if (IS_ERR(data->clk[data->avail_clk_cnt])) {
>>              ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>>              goto err_unreg_skl_clk;
>>          }
>>      }
>>
>>      platform_set_drvdata(pdev, data);
>>
>>      return 0;
>>
>> err_unreg_skl_clk:
>>      unregister_src_clk(data);
>>
>> static void unregister_src_clk(struct skl_clk_data *dclk)
>> {
>>      while (dclk->avail_clk_cnt--)
>>          clkdev_drop(dclk->clk[dclk->avail_clk_cnt]->lookup);
>> }
>>
>> So the post-increment is cancelled in the while().
>>
>> That said, the avail_clk_cnt field is never initialized or incremented 
>> in normal usages so the code looks quite suspicious indeed.
> 
> As basically entire old Skylake code, so no surprises here : )
> struct skl_clk_data::avail_clk_cnt field is initialized with 0 via 
> devm_kzalloc in skl_clk_dev_probe().
> 
>>
>> gitk tells me this patch is likely the culprit:
>>
>> 6ee927f2f01466 ('ASoC: Intel: Skylake: Fix NULL ptr dereference when 
>> unloading clk dev')
>>
>> -        data->clk[i] = register_skl_clk(dev, &clks[i], clk_pdata, i);
>> -        if (IS_ERR(data->clk[i])) {
>> -            ret = PTR_ERR(data->clk[i]);
>> +        data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
>> +                &clks[i], clk_pdata, i);
>> +
>> +        if (IS_ERR(data->clk[data->avail_clk_cnt])) {
>> +            ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>>               goto err_unreg_skl_clk;
>>           }
>> -
>> -        data->avail_clk_cnt++;
>>
>> That last removal is probably wrong. Cezary and Amadeusz, you may want 
>> to look at this?
> 
> Indeed, code looks wrong. Idk what are we even dropping in 
> unregister_src_clk() if register_skl_clk() fails and avail_clk_cnt gets 
> incremented anyway.
> 
> In general usage of while(ptr->counter--) (example of which is present 
> in unregister_src_clk()) is prone to errors. Decrementation happens 
> regardless of while's check outcome and caller may receive back handle 
> in invalid state.
> 
> Amadeo, your thoughts?
>

Right, there is a problem with how we do increment available clock 
counter. It should be done in success path, sent fix.

Amadeusz
