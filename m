Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D670A83E63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 02:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfHGAck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 20:32:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:59046 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfHGAcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:32:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 17:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="185828104"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 06 Aug 2019 17:32:37 -0700
Date:   Wed, 7 Aug 2019 08:32:14 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Balbir Singh <sblbir@amzn.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
Message-ID: <20190807003214.GC24750@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190806081123.22334-1-richardw.yang@linux.intel.com>
 <20190806105822.GA25354@dev-dsk-sblbir-2a-88e651b2.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806105822.GA25354@dev-dsk-sblbir-2a-88e651b2.us-west-2.amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:58:22AM +0000, Balbir Singh wrote:
>On Tue, Aug 06, 2019 at 04:11:23PM +0800, Wei Yang wrote:
>> When addr is out of the range of the whole rb_tree, pprev will points to
>> the biggest node. find_vma_prev gets is by going through the right most
>> node of the tree.
>> 
>> Since only the last node is the one it is looking for, it is not
>> necessary to assign pprev to those middle stage nodes. By assigning
>> pprev to the last node directly, it tries to improve the function
>> locality a little.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  mm/mmap.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 7e8c3e8ae75f..284bc7e51f9c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2271,11 +2271,10 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
>>  		*pprev = vma->vm_prev;
>>  	} else {
>>  		struct rb_node *rb_node = mm->mm_rb.rb_node;
>> -		*pprev = NULL;
>> -		while (rb_node) {
>> -			*pprev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
>> +		while (rb_node && rb_node->rb_right)
>>  			rb_node = rb_node->rb_right;
>> -		}
>> +		*pprev = rb_node ? NULL
>> +			 : rb_entry(rb_node, struct vm_area_struct, vm_rb);
>
>Can rb_node ever be NULL? assuming mm->mm_rb.rb_node is not NULL when we
>enter here
>

My bad, it should be 

	*pprev = !rb_node ? NULL
		 : rb_entry(rb_node, struct vm_area_struct, vm_rb);

Thanks

>Balbir Singh

-- 
Wei Yang
Help you, Help me
