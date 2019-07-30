Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509F079E05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfG3BnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 21:43:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:52810 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730584AbfG3BnE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:43:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 18:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,325,1559545200"; 
   d="scan'208";a="371358430"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.86]) ([10.239.196.86])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2019 18:43:02 -0700
Subject: Re: [PATCH] perf pmu-events: Fix the missing "cpu_clk_unhalted.core"
To:     Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20190729072755.2166-1-yao.jin@linux.intel.com>
 <20190729181658.GH25319@tassilo.jf.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0100c287-21b0-4754-a0a7-aee2318fdf0d@linux.intel.com>
Date:   Tue, 30 Jul 2019 09:43:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729181658.GH25319@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2019 2:16 AM, Andi Kleen wrote:
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index 1a91a197cafb..d413761621b0 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -453,6 +453,7 @@ static struct fixed {
>>   	{ "inst_retired.any_p", "event=0xc0" },
>>   	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
>>   	{ "cpu_clk_unhalted.thread", "event=0x3c" },
>> +	{ "cpu_clk_unhalted.core", "event=0x3c" },
> 
> Not sure this is correct for non Atom.
> 
> On Atom thread==core, but that is not true with SMT/HyperThreading.
> 
> The big cores currently don't have this event, so it would
> match incorrectly.
> 
> This has to be handled on the event list level, perhaps with
> some enhancements.
> 
> -Andi
> 

Hi Andi,

It is used to handle the fixed counter encodings between JSON and perf. 
If big cores don't have this event, nothing will be generated in perf list.

In big cores pipeline.json, there is only "CPU_CLK_UNHALTED.THREAD", and 
there is no "CPU_CLK_UNHALTED.CORE" defined. So at least for now, 
CPU_CLK_UNHALTED.CORE will not be generated for big core.

Thanks
Jin Yao
