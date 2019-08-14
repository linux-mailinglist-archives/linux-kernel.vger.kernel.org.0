Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145B78C6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfHNCUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 22:20:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:4524 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbfHNCUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:20:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 19:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="181365818"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2019 19:20:13 -0700
Date:   Wed, 14 Aug 2019 10:19:50 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: rb_parent is not necessary in __vma_link_list
Message-ID: <20190814021950.GA2025@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190813032656.16625-1-richardw.yang@linux.intel.com>
 <20190813033958.GB5307@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813033958.GB5307@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 08:39:58PM -0700, Matthew Wilcox wrote:
>On Tue, Aug 13, 2019 at 11:26:56AM +0800, Wei Yang wrote:
>> Now we use rb_parent to get next, while this is not necessary.
>> 
>> When prev is NULL, this means vma should be the first element in the
>> list. Then next should be current first one (mm->mmap), no matter
>> whether we have parent or not.
>> 
>> After removing it, the code shows the beauty of symmetry.
>
>Uhh ... did you test this?
>

I have enabled DEBUG_VM_RB, system looks good with this.

-- 
Wei Yang
Help you, Help me
