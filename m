Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6655BADA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392272AbfIWGAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 02:00:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:43150 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfIWGAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:00:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Sep 2019 23:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="363524324"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 22 Sep 2019 23:00:23 -0700
Date:   Mon, 23 Sep 2019 14:00:05 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: fix return value of p[um]dp_set_access_flags
Message-ID: <20190923060005.GB7750@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190919082549.3895-1-richardw.yang@linux.intel.com>
 <307c9866-c037-5d87-709f-840bdb577283@intel.com>
 <20190920021821.GA8472@richard>
 <2fde036a-f64e-ce58-65bf-a089e7c673aa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fde036a-f64e-ce58-65bf-a089e7c673aa@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 09:16:12AM -0700, Dave Hansen wrote:
>On 9/19/19 7:18 PM, Wei Yang wrote:
>> Last but not least, since update_mmu_cache_pmd is empty, even return
>> value is not correct, it doesn't break anything.
>
>In other words, this patch has no functional effect and does not provide
>a "fix".  What's the point of patching this stuff if it has no effect?

It correct the function semantics. The return value of these function doesn't
meet the requirement, which will be misleading and we still need to dig in the
history to find out the correct answer.

In case we would have a valid cache update mechanism, this would introduce a
problem.

So I suggest to fix the return value to reflect the true meaning.

-- 
Wei Yang
Help you, Help me
