Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C0145FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfFNNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:55:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:27712 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFNNz5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:55:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 06:55:56 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2019 06:55:56 -0700
Received: from [10.254.88.254] (kliang2-mobl.ccr.corp.intel.com [10.254.88.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 557FF5803E4;
        Fri, 14 Jun 2019 06:55:55 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events: Add Icelake V1.00 event file
To:     Haiyan Song <haiyanx.song@intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190614014805.30111-1-haiyanx.song@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e62a12f1-a81d-8fe2-65b2-90a43dce4497@linux.intel.com>
Date:   Fri, 14 Jun 2019 09:55:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614014805.30111-1-haiyanx.song@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2019 9:48 PM, Haiyan Song wrote:
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index d6984a3017e0..f8357a79641a 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -33,4 +33,5 @@ GenuineIntel-6-25,v2,westmereep-sp,core
>   GenuineIntel-6-2F,v2,westmereex,core
>   GenuineIntel-6-55-[01234],v1,skylakex,core
>   GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
> +GenuineIntel-6-7E,v1,icelake,core
>   AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core

Hi Haiyan,

I forgot to mention that we just added more Ice Lake model number.
You may want to add the support for Ice Lake Desktop as well.

     GenuineIntel-6-7D,v1,icelake,core

The rest looks good to me.

Thanks,
Kan
