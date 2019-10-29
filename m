Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D26E89A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 14:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbfJ2Ngl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 09:36:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:58801 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388602AbfJ2Ngl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:36:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 06:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="211751713"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.210.130]) ([10.254.210.130])
  by orsmga002.jf.intel.com with ESMTP; 29 Oct 2019 06:36:38 -0700
Subject: Re: [PATCH v4 5/7] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191028013330.18319-1-yao.jin@linux.intel.com>
 <20191028013330.18319-6-yao.jin@linux.intel.com>
 <20191029092747.GH28772@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <08921142-6e65-62e3-2a1c-9a78c7bc7d2e@linux.intel.com>
Date:   Tue, 29 Oct 2019 21:36:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029092747.GH28772@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2019 5:27 PM, Jiri Olsa wrote:
> On Mon, Oct 28, 2019 at 09:33:28AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index 0e27d6830011..7cf137b0451b 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -758,6 +758,10 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
>>   	struct hist_entry entry = {
>>   		.block_info = block_info,
>>   		.hists = hists,
>> +		.ms = {
>> +			.map = al->map,
>> +			.sym = al->sym,
>> +		},
> 
> this looks like separated fix, if thats the case
> please explain the change and move it to separate patch
> 
> thanks,
> jirka
> 

Sorry, that should be the obsolete code. Thanks so much for pointing 
this out.

Thanks
Jin Yao

