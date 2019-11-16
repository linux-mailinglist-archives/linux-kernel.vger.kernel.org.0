Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46AFECBA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 15:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfKPOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 09:45:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:33990 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfKPOpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 09:45:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2019 06:45:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,312,1569308400"; 
   d="scan'208";a="258009379"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2019 06:45:19 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 88F8C300FDE; Sat, 16 Nov 2019 06:45:19 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     lqqq341 <liuqi115@hisilicon.com>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry@huawei.com>,
        <zhangshaokun@hisilicon.com>, <huangdaode@hisilicon.com>,
        <linyunsheng@huawei.com>
Subject: Re: [PATCH] Perf stat: Fix the ratio comments of miss-events
References: <1573890521-56450-1-git-send-email-liuqi115@hisilicon.com>
Date:   Sat, 16 Nov 2019 06:45:19 -0800
In-Reply-To: <1573890521-56450-1-git-send-email-liuqi115@hisilicon.com>
        (lqqq's message of "Sat, 16 Nov 2019 15:48:41 +0800")
Message-ID: <87pnhrg9s0.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lqqq341 <liuqi115@hisilicon.com> writes:

> From: Qi Liu <liuqi115@hisilicon.com>
>
> Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
> iTLB cache and LL-cache. Take L1-dcache for example, its miss ratio
> is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all
> L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache
> accesses" seems better. The comments of L1-icache, dTLB cache, iTLB
> cache and LL-cache are fixed in the same way.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
