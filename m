Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A99AECAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfIJOM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:12:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:44204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfIJOMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:12:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 07:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="186862805"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2019 07:12:25 -0700
Received: from wkhong-mobl2.amr.corp.intel.com (unknown [10.255.34.248])
        by linux.intel.com (Postfix) with ESMTP id EA9DE58044E;
        Tue, 10 Sep 2019 07:12:23 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint support
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
 <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402C9EA2@PGSMSX108.gar.corp.intel.com>
 <29b9fd4e-3d78-b4a3-e61a-c066bf24995a@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402CB9AC@PGSMSX108.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <99769525-779a-59aa-96da-da96f8f09a8a@linux.intel.com>
Date:   Tue, 10 Sep 2019 09:12:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C7402CB9AC@PGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I also don't see any case where we support 4 channels in any broadwell
>> machine driver?
> It's the bdw-rt5650.c which only exists in chrome's 3.14 branch supporting Buddy
> project. They submitted the machine driver but not yet merged.
> 
> https://patchwork.kernel.org/patch/11050985/
> 
>>
>> So again can you point me to an issue or existing backport that requires the
>> patch below. Not trying to be obtuse but we should only change older
>> platforms when there is evidence that a change is needed.
> The story is Chrome has a tool called alsa_conformance_test which runs capture or
> playback against a PCM port with all possible configurations (channel, format, rate)
> then measure if the sample rate is correct. Since the channel max number reported
> is 4, it tests the 4-channel 48K capture and reports the actual sample rate is 24000
> instead of 48000. That's the reason we want to add a constraint in machine driver to
> avoid user space programs trying to do 4 channel recording since this machine does
> not support it in the beginning.

ok, that helps get context, thanks for the details.

I would have expected some error to be returned if there's a front-end 
opened with 4 channels and the back-end only supports two. Adding the 
constraint seems like a work-around to avoid dealing with the mismatch 
between FE and BE. I don't understand DPCM enough to suggest an 
alternative though. Ranjani, can you help on this one?

And even if we agree with this solution, it'd be nice to apply it for 
the Broadwell machine driver for consistency.
