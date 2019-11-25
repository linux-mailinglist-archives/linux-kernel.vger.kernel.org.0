Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE4108CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfKYLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:13:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:46010 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfKYLNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:13:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 03:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="239494659"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 25 Nov 2019 03:13:24 -0800
Received: from [10.125.252.215] (abudanko-mobl.ccr.corp.intel.com [10.125.252.215])
        by linux.intel.com (Postfix) with ESMTP id 132935802E4;
        Mon, 25 Nov 2019 03:13:21 -0800 (PST)
Subject: Re: [PATCH v2 3/3] perf record: adapt affinity to machines with #CPUs
 > 1K
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
 <69bd0062-0f9e-889b-b7ef-0d97d257569b@linux.intel.com>
 <20191125094220.GC4675@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9b9209ce-ba61-824f-9443-3909991ff222@linux.intel.com>
Date:   Mon, 25 Nov 2019 14:13:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191125094220.GC4675@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.2019 12:42, Jiri Olsa wrote:
> On Mon, Nov 25, 2019 at 09:08:57AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>>  {
>> -	CPU_ZERO(&map->affinity_mask);
>> +	map->affinity_mask.nbits = cpu__max_cpu();
>> +	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
>> +	if (!map->affinity_mask.bits)
>> +		return -1;
>> +
>>  	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
>>  		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
>>  	else if (mp->affinity == PERF_AFFINITY_CPU)
>> -		CPU_SET(map->core.cpu, &map->affinity_mask);
>> +		set_bit(map->core.cpu, map->affinity_mask.bits);
>> +
>> +	return 0;
>>  }
>>  
>> +#define MASK_SIZE 1023
>>  int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>>  {
>> +	char mask[MASK_SIZE + 1] = {0};
> 
> does this need to be initialized?

This is to make sure the message is zero terminated for vfprintf call()

> 
>> +
>>  	if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
>>  		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
>>  			  errno);
>>  		return -1;
>>  	}
>>  
>> -	perf_mmap__setup_affinity_mask(map, mp);
>> +	if (perf_mmap__setup_affinity_mask(map, mp)) {
>> +		pr_debug2("failed to alloc mmap affinity mask, error %d\n",
>> +			  errno);
>> +		return -1;
>> +	}
>> +	bitmap_scnprintf(map->affinity_mask.bits, map->affinity_mask.nbits, mask, MASK_SIZE);
>> +	pr_debug2("%p: mmap mask[%ld]: %s\n", map, map->affinity_mask.nbits, mask);
> 
> the bitmap_scnprintf could be called only for debug case, right?

Right. It is required to prepare debug message.

> 
> 	if (version >= 2) {
> 		bitmap_scnprintf(map->affinity_mask.bits, map->affinity_mask.nbits, mask, MASK_SIZE);
> 		pr_debug2("%p: mmap mask[%ld]: %s\n", map, map->affinity_mask.nbits, mask);
> 	}
> 
> ditto int the record__adjust_affinity function
> 
> jirka
> 
> 

~Alexey

