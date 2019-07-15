Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BD688E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfGOMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 08:30:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:28483 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfGOMa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:30:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 05:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="175080825"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2019 05:30:28 -0700
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id C8488580372;
        Mon, 15 Jul 2019 05:30:25 -0700 (PDT)
Subject: Re: [PATCH v1] perf session: fix loading of compressed data split
 across adjacent records
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
 <20190714154932.GC16802@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <389a8b98-1d53-6fe3-ff56-0789c0841292@linux.intel.com>
Date:   Mon, 15 Jul 2019 15:30:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714154932.GC16802@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2019 18:49, Jiri Olsa wrote:
> On Tue, Jul 09, 2019 at 05:48:14PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  	decomp->file_pos = file_offset;
>> +	decomp->mmap_len = mmap_len;
>>  	decomp->head = 0;
>>  
>> -	if (decomp_last) {
>> -		decomp_last_rem = decomp_last->size - decomp_last->head;
>> +	if (decomp_last_rem) {
>>  		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
>>  		decomp->size = decomp_last_rem;
>>  	}
>> @@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>>  	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
>>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>>  	if (!decomp_size) {
>> -		munmap(decomp, sizeof(struct decomp) + decomp_len);
>> +		munmap(decomp, mmap_len);
>>  		pr_err("Couldn't decompress data\n");
>>  		return -1;
>>  	}
>> @@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
>>  static void perf_session__release_decomp_events(struct perf_session *session)
>>  {
>>  	struct decomp *next, *decomp;
>> -	size_t decomp_len;
>> +	size_t mmap_len;
>>  	next = session->decomp;
>> -	decomp_len = session->header.env.comp_mmap_len;
>>  	do {
>>  		decomp = next;
>>  		if (decomp == NULL)
>>  			break;
>>  		next = decomp->next;
>> -		munmap(decomp, decomp_len + sizeof(struct decomp));
>> +		mmap_len = decomp->mmap_len;
>> +		munmap(decomp, mmap_len);
> 
> what's the need for extra mmap_len variable in here?
> could you just use decomp->mmap_len directly?

To avoid reference to the object being deallocated.
Plain munmap(), yes - :)

~Alexey

> 
> otherwise it lookgs good to me
> 
> thanks,
> jirka
> 
