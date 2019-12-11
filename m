Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E723811AB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 13:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfLKMga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 07:36:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:3068 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfLKMga (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:36:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 04:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="220446098"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.25]) ([10.254.211.25])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2019 04:36:27 -0800
Subject: Re: [PATCH v2 1/3] perf report: Change sort order by a specified
 event in group
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191211073036.31504-1-yao.jin@linux.intel.com>
 <20191211113815.GB12087@krava>
 <6ba174a8-309e-9410-e6ea-ac7bb7187757@linux.intel.com>
 <20191211121453.GC12087@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ae8d58b9-36a4-533e-323e-0a81a6ccdd6d@linux.intel.com>
Date:   Wed, 11 Dec 2019 20:36:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191211121453.GC12087@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2019 8:14 PM, Jiri Olsa wrote:
> On Wed, Dec 11, 2019 at 08:01:44PM +0800, Jin, Yao wrote:
>>
>>
>> On 12/11/2019 7:38 PM, Jiri Olsa wrote:
>>> On Wed, Dec 11, 2019 at 03:30:34PM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>> +
>>>> +static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
>>>> +				 hpp_field_fn get_field, int idx)
>>>> +{
>>>> +	struct evsel *evsel = hists_to_evsel(a->hists);
>>>> +	u64 *fields_a, *fields_b;
>>>> +	int cmp, nr_members, ret, i;
>>>> +
>>>> +	cmp = field_cmp(get_field(a), get_field(b));
>>>> +	if (!perf_evsel__is_group_event(evsel))
>>>> +		return cmp;
>>>> +
>>>> +	nr_members = evsel->core.nr_members;
>>>> +	ret = pair_fields_alloc(a, b, get_field, nr_members,
>>>> +			      &fields_a, &fields_b);
>>>> +	if (ret) {
>>>> +		ret = cmp;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	for (i = 1; i < nr_members; i++) {
>>>> +		if (i == idx) {
>>>> +			ret = field_cmp(fields_a[i], fields_b[i]);
>>>> +			if (ret)
>>>> +				goto out;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (cmp) {
>>>> +		ret = cmp;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	for (i = 1; i < nr_members; i++) {
>>>> +		if (i != idx) {
>>>> +			ret = field_cmp(fields_a[i], fields_b[i]);
>>>> +			if (ret)
>>>> +				goto out;
>>>> +		}
>>>
>>> hi,
>>> I'm missing why we compare the fields for 2nd time in here
>>>
>>> thanks,
>>> jirka
>>>
>>
>> Hi,
>>
>> I think we may continue comparing the remaining of fields if the index field
>> is equal. :)
> 
> aah, I missed it's actualy == used in the first one ;-)
> 
> why don't you just call it directly?
> 
> 	ret = field_cmp(fields_a[idx], fields_b[idx])
> 	if (ret)
> 		goto out;
> 
> jirka
> 

Oh, yes, we can use simpler code. For example,

	if (idx >= 1 && idx < nr_members) {
		ret = field_cmp(fields_a[idx], fields_b[idx]);
		if (ret)
			goto out;
	}

Thanks
Jin Yao

