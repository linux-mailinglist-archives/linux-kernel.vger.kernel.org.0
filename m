Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7417A14A3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgA0Mbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 07:31:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:41805 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbgA0Mbf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:31:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 04:31:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="305421363"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.213.218]) ([10.254.213.218])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2020 04:31:24 -0800
Subject: Re: [PATCH v4 3/4] perf util: Flexible to set block info output
 formats
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200115192904.16798-1-yao.jin@linux.intel.com>
 <20200115192904.16798-3-yao.jin@linux.intel.com>
 <20200120094737.GF608405@krava>
 <6c35864b-e396-6865-12a9-2fd001b0f567@linux.intel.com>
Message-ID: <23bec83b-b55d-8e9f-5b74-f58f0cd4a618@linux.intel.com>
Date:   Mon, 27 Jan 2020 20:31:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6c35864b-e396-6865-12a9-2fd001b0f567@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2020 11:00 PM, Jin, Yao wrote:
> 
> 
> On 1/20/2020 5:47 PM, Jiri Olsa wrote:
>> On Thu, Jan 16, 2020 at 03:29:03AM +0800, Jin Yao wrote:
>>
>> SNIP
>>
>>> +                   block_hpps, nr_hpps);
>>> -    perf_hpp_list__register_sort_field(&bh->block_list,
>>> -        &block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
>>> +    /* Sort by the first fmt */
>>> +    perf_hpp_list__register_sort_field(&bh->block_list, 
>>> &block_fmts[0].fmt);
>>>   }
>>> -static void process_block_report(struct hists *hists,
>>> -                 struct block_report *block_report,
>>> -                 u64 total_cycles)
>>> +static int process_block_report(struct hists *hists,
>>> +                struct block_report *block_report,
>>> +                u64 total_cycles, int *block_hpps,
>>> +                int nr_hpps)
>>>   {
>>>       struct rb_node *next = rb_first_cached(&hists->entries);
>>>       struct block_hist *bh = &block_report->hist;
>>>       struct hist_entry *he;
>>> -    init_block_hist(bh, block_report->fmts);
>>> +    if (nr_hpps > PERF_HPP_REPORT__BLOCK_MAX_INDEX)
>>
>> hum, should be '>=' above.. ?
>>
>> jirka
>>
> 
> '=' should be OK.
> 
> enum {
>      PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>      PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>      PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>      PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>      PERF_HPP_REPORT__BLOCK_RANGE,
>      PERF_HPP_REPORT__BLOCK_DSO,
>      PERF_HPP_REPORT__BLOCK_MAX_INDEX
> };
> 
> PERF_HPP_REPORT__BLOCK_MAX_INDEX is 6.
> 
> If nr_hpps is 6, for example, block_hpps[] is,
> 
>          int block_hpps[6] = {
>              PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>              PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>              PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>              PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>              PERF_HPP_REPORT__BLOCK_RANGE,
>              PERF_HPP_REPORT__BLOCK_DSO,
>          };
> 
>          block_info__create_report(session->evlist,
>                        rep->total_cycles,
>                                            block_hpps, 6,
>                                            &rep->nr_block_reports);
> 
> That should be legal.
> 
> Thanks
> Jin Yao

Hi Jiri,

Does this explanation make sense?

Thanks
Jin Yao
