Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A73A5A46
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfIBPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 11:13:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:26786 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbfIBPNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:13:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 08:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="183328724"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2019 08:13:22 -0700
Received: from [10.252.30.226] (abudanko-mobl.ccr.corp.intel.com [10.252.30.226])
        by linux.intel.com (Postfix) with ESMTP id DB4CF58043A;
        Mon,  2 Sep 2019 08:13:18 -0700 (PDT)
Subject: Re: [PATCH 3/3] perf stat: Add --per-numa agregation support
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20190902121255.536-1-jolsa@kernel.org>
 <20190902121255.536-4-jolsa@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <bdf81661-4c70-797f-51f2-726f4458d812@linux.intel.com>
Date:   Mon, 2 Sep 2019 18:13:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902121255.536-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.09.2019 15:12, Jiri Olsa wrote:
> Adding new --per-numa option to aggregate counts per NUMA
> nodes for system-wide mode measurements.
> 
> You can specify --per-numa in live mode:
> 
>   # perf stat  -a -I 1000 -e cycles --per-numa
>   #           time numa   cpus             counts unit events

It might probably better have 'node' instead of 'numa' as in the 
option name '--per-node' as in the table header, like this:

    #           time node     cpus             counts unit events
         1.000542550 0        20          6,202,097      cycles
         1.000542550 1        20            639,559      cycles
         2.002040063 0        20          7,412,495      cycles
         2.002040063 1        20          2,185,577      cycles
         3.003451699 0        20          6,508,917      cycles
         3.003451699 1        20            765,607      cycles
   ...

BR,
Alexey
