Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C127E183808
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 18:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLRzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 13:55:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:63361 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLRy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:54:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 10:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="442138934"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2020 10:54:56 -0700
Received: from [10.255.182.54] (abudanko-mobl.ccr.corp.intel.com [10.255.182.54])
        by linux.intel.com (Postfix) with ESMTP id ACCEF58010D;
        Thu, 12 Mar 2020 10:54:51 -0700 (PDT)
Subject: Re: [PATCH v1] perf record: fix binding of AIO user space buffers to
 nodes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
 <20200312143152.GA28601@kernel.org>
 <2e01e17a-962d-571b-4407-70aa270cec6a@linux.intel.com>
 <20200312171214.GD12036@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b2f46add-51d3-0cf0-3acf-985e9fbcde47@linux.intel.com>
Date:   Thu, 12 Mar 2020 20:54:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312171214.GD12036@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.03.2020 20:12, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 12, 2020 at 07:09:56PM +0300, Alexey Budankov escreveu:
>>
>> On 12.03.2020 17:31, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Mar 12, 2020 at 03:21:45PM +0300, Alexey Budankov escreveu:
>>>>
>>>> Correct maxnode parameter value passed to mbind() syscall to be
>>>> the amount of node mask bits to analyze plus 1. Dynamically allocate
>>>> node mask memory depending on the index of node of cpu being profiled.
>>>> Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>>>  tools/perf/util/mmap.c | 21 +++++++++++++++------
>>>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>>>> index 3b664fa673a6..6d604cd67a95 100644
>>>> --- a/tools/perf/util/mmap.c
>>>> +++ b/tools/perf/util/mmap.c
>>>> @@ -98,20 +98,29 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
>>>>  {
>>>>  	void *data;
>>>>  	size_t mmap_len;
>>>> -	unsigned long node_mask;
>>>> +	unsigned long *node_mask;
>>>> +	unsigned long node_index;
>>>> +	int err = 0;
>>>>  
>>>>  	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
>>>>  		data = map->aio.data[idx];
>>>>  		mmap_len = mmap__mmap_len(map);
>>>> -		node_mask = 1UL << cpu__get_node(cpu);
>>>> -		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
>>>> -			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
>>>> -				data, data + mmap_len, cpu__get_node(cpu));
>>>> +		node_index = cpu__get_node(cpu);
>>>> +		node_mask = bitmap_alloc(node_index + 1);
>>>> +		if (!node_mask) {
>>>> +			pr_err("Failed to allocate node mask for mbind: error %m\n");
>>>>  			return -1;
>>>>  		}
>>>> +		set_bit(node_index, node_mask);
>>>> +		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1/*nr_bits + 1*/, 0)) {
>>>
>>>                                                                                   ^^^^^^^^^^^^^^
>>> 										  Leftover?
>>
>> Intentionally put it here to document kernel behavior for mbind() syscall
>> because currently it is different from the man page [1] documented:
>>
>> "nodemask points to a bit mask of nodes containing up to maxnode bits.
>>  The bit mask size is rounded to the next multiple of sizeof(unsigned
>>  long), but the kernel will use bits only up to maxnode.  A NULL value
>>  of nodemask or a maxnode value of zero specifies the empty set of
>>  nodes.  If the value of maxnode is zero, the nodemask argument is
>>  ignored.  Where a nodemask is required, it must contain at least one
>>  node that is on-line, allowed by the thread's current cpuset context
>>  (unless the MPOL_F_STATIC_NODES mode flag is specified), and contains
>>  memory."
> 
> Ok, will add the above as a comment above the line with that comment.

Thanks!
~Alexey
