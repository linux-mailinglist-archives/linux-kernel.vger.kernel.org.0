Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E7F5D15
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 03:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfKICrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 21:47:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:42457 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfKICrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:47:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 18:47:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="201515057"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2019 18:47:54 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 44A8A300E00; Fri,  8 Nov 2019 18:47:54 -0800 (PST)
Date:   Fri, 8 Nov 2019 18:47:54 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "liuqi (BA)" <liuqi115@hisilicon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        huangdaode <huangdaode@hisilicon.com>,
        linyunsheng <linyunsheng@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [QUESTION]perf stat: comment of miss ratio
Message-ID: <20191109024754.GA573472@tassilo.jf.intel.com>
References: <F57F094935A66448B135517D3F6EA397F35063@DGGEMA504-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F57F094935A66448B135517D3F6EA397F35063@DGGEMA504-MBS.china.huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    Relevant code is checked to make sure that the ratio is calculated by
> 
>    L1-dcache-load-misses/L1-dcache-loads, data "7.58%=30249/399189*100%" also
> 
>    proves this conclusion.
> 
>    So, I'm not sure why we use "of all L1-dcache hits" here to describe miss
>    ratio,

Yes you're right it should be "of all L1-dcache accesses"

Please send a patch to fix the string and also check if this isn't wrong with some other
ratio too.

-Andi
