Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428F5159AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgBKVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 16:12:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:13437 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgBKVMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:12:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 13:12:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="256603823"
Received: from lmgarret-mobl2.amr.corp.intel.com (HELO [10.251.152.253]) ([10.251.152.253])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2020 13:12:01 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
To:     "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Cc:     "Lu, Brent" <brent.lu@intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "cychiang@google.com" <cychiang@google.com>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
 <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
 <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
Date:   Tue, 11 Feb 2020 15:12:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/20 2:37 PM, Sridharan, Ranjani wrote:
> 
>      > I think the patch is for those systems which enable I2S clocks in
>     pcm_start instead
>      > of pcm_prepare. It has no effect on systems already be able to
>     turn on clocks in
>      > supply widgets or set_bias_level() function.
>      >
>      > If the trigger type in the DAI link is TRIGGER_PRE, then the
>     trigger function of FE port
>      > (component or CPU DAI) will be called before codec driver's
>     trigger function. In this
>      > case we will be able to turn on the clock in time. However, if
>     the trigger type is
>      > TRIGGER_POST, then the patch does not help because just like what
>     you said, codec
>      > driver's trigger function is called first.
> 
>     IIRC we recently did a change to deal with underflows. Ranjani, can you
>     remind us what the issue was?
> 
> Hi Pierre,
> 
> Are you talking about the change in this commit acbf27746ecfa96b
> "ASoC: pcm: update FE/BE trigger order based on the command"?
> 
> We made this change to handle xruns during pause/release particularly on 
> the Intel HDA platforms.

this change was just to mirror the behavior between start/stop, I 
thought there was a patch where we moved to TRIGGER_POST by default?

What I am trying to figure out if whether using TRIGGER_PRE is ok or not 
for the SOF firmware.

Thanks!
-Pierre
