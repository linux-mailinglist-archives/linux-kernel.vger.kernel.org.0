Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3F16E9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgBYPXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 10:23:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:26408 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgBYPXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:23:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 07:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="231485289"
Received: from sabhimji-mobl3.amr.corp.intel.com (HELO [10.251.137.190]) ([10.251.137.190])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2020 07:23:34 -0800
Subject: Re: [PATCH 00/10] soundwire: bus: fix race conditions, add
 suspend-resume
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
 <20200225102734.GO2618@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e5e992cb-7e5b-081e-14ab-40bdad24b9c8@linux.intel.com>
Date:   Tue, 25 Feb 2020 09:23:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225102734.GO2618@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/20 4:27 AM, Vinod Koul wrote:
> On 14-01-20, 18:08, Pierre-Louis Bossart wrote:
>> The existing mainline code for SoundWire does not handle critical race
>> conditions, and does not have any support for pm_runtime suspend or
>> clock-stop modes needed for e.g. jack detection or external VAD.
>>
>> As suggested by Vinod, these patches for the bus are shared first -
>> with the risk that they are separated from their actual use in Intel
>> drivers, so reviewers might wonder why they are needed in the first
>> place.
>>
>> For reference, the complete set of 90+ patches required for SoundWire
>> on Intel platforms is available here:
>>
>> https://github.com/thesofproject/linux/pull/1692
>>
>> These patches are not Intel-specific and are likely required for
>> e.g. Qualcomm-based implementations.
>>
>> All the patches in this series were generated during the joint
>> Intel-Realtek validation effort on Intel reference designs and
>> form-factor devices. The support for the initialization_complete
>> signaling is already available in the Realtek codecs drivers merged in
>> the ASoC tree (rt700, rt711, rt1308, rt715)
> 
> Applied all, thanks

Thanks Vinod, I'll now prepare the update for the transition away from 
platform devices (minor update needed on the RFC already reviewed by Greg).
