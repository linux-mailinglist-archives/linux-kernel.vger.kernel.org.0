Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C90F6BCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 14:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGQM5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 08:57:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:55947 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQM5L (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:57:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 05:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="178890559"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.214.202]) ([10.254.214.202])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2019 05:57:08 -0700
Subject: Re: [PATCH] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190712075355.16019-1-yao.jin@linux.intel.com>
 <20190716085112.GC22317@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <68639364-53d3-6221-ec57-c338a485b40c@linux.intel.com>
Date:   Wed, 17 Jul 2019 20:57:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716085112.GC22317@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2019 4:51 PM, Jiri Olsa wrote:
> On Fri, Jul 12, 2019 at 03:53:55PM +0800, Jin Yao wrote:
>> This patch prints the stddev and hist for the cycles diff of
>> program block. It can help us to understand if the cycles diff
>> is noisy or not.
> 
> I'm getting compile error:
> 
>    CC       builtin-diff.o
> builtin-diff.c: In function ‘compute_cycles_diff’:
> builtin-diff.c:712:10: error: taking the absolute value of unsigned type ‘u64’ {aka ‘long unsigned int’} has no effect [-Werror=absolute-value]
>    712 |          labs(pair->block_info->cycles_spark[i] -
>        |          ^~~~
> cc1: all warnings being treated as errors
> mv: cannot stat './.builtin-diff.o.tmp': No such file or directory
> 
> 

Oh, sorry about that. My gcc (gcc version 7.4.0 (Ubuntu 
7.4.0-1ubuntu1~18.04.1)) didn't report this error. :(

u64 - u64 is u64. I should define it as s64.

Thanks for reminding me.

Thanks
Jin Yao

> jirka
> 
