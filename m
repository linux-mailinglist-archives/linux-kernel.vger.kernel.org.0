Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3037820
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfFFPgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 11:36:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:13501 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbfFFPgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:36:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 08:36:00 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 Jun 2019 08:36:00 -0700
Received: from kwong4-mobl.amr.corp.intel.com (unknown [10.252.203.122])
        by linux.intel.com (Postfix) with ESMTP id 11F5F580490;
        Thu,  6 Jun 2019 08:35:59 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2] soundwire: stream: fix bad unlock balance
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
 <9427a73a-e09a-4a9c-7690-271d2e2e1024@linux.intel.com>
 <f13c82d2-94a4-9517-bcf6-95aa40c6a42f@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <43a381df-13d7-eaac-a1ae-704db5659cb9@linux.intel.com>
Date:   Thu, 6 Jun 2019 10:36:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f13c82d2-94a4-9517-bcf6-95aa40c6a42f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/19 9:58 AM, Srinivas Kandagatla wrote:
> 
> 
> On 06/06/2019 15:28, Pierre-Louis Bossart wrote:
>> On 6/6/19 6:22 AM, Srinivas Kandagatla wrote:
>>> multi bank switching code takes lock on condition but releases without
>>> any check resulting in below warning.
>>> This patch fixes this.
>>
>>
>> Question to make sure we are talking about the same thing: multi-link 
>> bank switching is a capability beyond the scope of the SoundWire spec 
>> which requires hardware support to synchronize links and as Sanyog 
>> hinted at in a previous email follow a different flow for bank switches.
>>
>> You would not use the multi-link mode if you have different links that 
>> can operate independently and have no synchronization requirement. You 
>> would conversely use the multi-link mode if you have two devices on 
>> the same type on different links and want audio to be rendered at the 
>> same time.
>>
>> Can you clarify if indeed you were using the full-blown multi-link 
>> mode with hardware synchronization or a regular single-link operation? 
>> I am not asking for details of your test hardware, just trying to 
>> reconstruct the program flow leading to this problem.
>>
> 
> Am testing on a regular single link, which hits this path.
> 
>> It could also be that your commit message was meant to say:
>> "the msg lock is taken for multi-link cases only but released 
>> unconditionally, leading to an unlock balance warning for single-link 
>> usages"?
> Yes.

Thanks for the precision. the change is legit so assuming the commit 
message is reworded to mention single link usage please feel free to 
take the following tag.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks!
