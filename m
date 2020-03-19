Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82B18BDDE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 18:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgCSRVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 13:21:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:42321 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgCSRVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:21:49 -0400
IronPort-SDR: 1/KrzT0QTyEvjKRTQFuw2mO8rtUFckSCjhLVuxaO5HuxQde5qA2/e2RKJqGvdc67LtKAQdw7Xw
 z5/FC4rHldeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 10:21:49 -0700
IronPort-SDR: uhvihpBxhcKPDcFU+cU4PT8LMnYRGNXufez+qTl2y/miMWDn7R+AHq2l/iLIuFqEwYpy4+CCCh
 A5VqQaktpONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="444650210"
Received: from tvanlang-mobl.ger.corp.intel.com (HELO [10.255.34.72]) ([10.255.34.72])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2020 10:21:48 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, kuninori.morimoto.gx@renesas.com,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
References: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eef45d20-3bce-184a-842c-216c15252014@linux.intel.com>
Date:   Thu, 19 Mar 2020 12:21:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319165157.GA2254@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/20 11:51 AM, Dominik Brodowski wrote:
> On Thu, Mar 19, 2020 at 04:48:03PM +0100, Cezary Rojewski wrote:
>> On 2020-03-19 14:41, Mark Brown wrote:
>>> On Thu, Mar 19, 2020 at 02:00:49PM +0100, Dominik Brodowski wrote:
>>>
>>>> Have some good news now, namely that a bisect is complete: That pointed to
>>>> 1272063a7ee4 ("ASoC: soc-core: care .ignore_suspend for Component suspend");
>>>> therefore I've added Kuninori Morimoto to this e-mail thread.
>>>
>>> If that's an issue it feels more like a driver bug in that if the driver
>>> asked for ignore_suspend then it should expect not to have the suspend
>>> callback called.
>>>
>>
>> Requested for tests with following diff applied:
>>
>> diff --git a/sound/soc/intel/boards/broadwell.c
>> b/sound/soc/intel/boards/broadwell.c
>> index db7e1e87156d..6ed4c1b0a515 100644
>> --- a/sound/soc/intel/boards/broadwell.c
>> +++ b/sound/soc/intel/boards/broadwell.c
>> @@ -212,7 +212,6 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] =
>> {
>>                  .init = broadwell_rt286_codec_init,
>>                  .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>>                          SND_SOC_DAIFMT_CBS_CFS,
>> -               .ignore_suspend = 1,
>>                  .ignore_pmdown_time = 1,
>>                  .be_hw_params_fixup = broadwell_ssp0_fixup,
>>                  .ops = &broadwell_rt286_ops,
> 
> That patch fixes the issue(s). I didn't even need to revert 64df6afa0dab
> ("ASoC: Intel: broadwell: change cpu_dai and platform components for SOF")
> on top of that. But you can assess better whether that patch needs care for
> other reasons; for me, this one-liner you have suggested is perfect.

.ignore_suspend is set for bdw-rt5677.c and bdw-rt5650.c as well. I 
don't know if that was intentional.
