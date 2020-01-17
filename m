Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7971414042C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 07:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgAQG4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 01:56:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:30970 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgAQG4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 01:56:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 22:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,329,1574150400"; 
   d="scan'208";a="219948596"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2020 22:56:28 -0800
Date:   Fri, 17 Jan 2020 14:56:28 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [mm/hugetlb] c77c0a8ac4: will-it-scale.per_process_ops
 15.9% improvement
Message-ID: <20200117065628.GC86012@shbuild999.sh.intel.com>
References: <20200114085637.GA29297@shao2-debian>
 <20200114091251.GE19428@dhcp22.suse.cz>
 <bd474ca4-9f47-0ab1-f461-513789fc074d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd474ca4-9f47-0ab1-f461-513789fc074d@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman and Michal,

On Tue, Jan 14, 2020 at 09:57:14AM -0500, Waiman Long wrote:
> On 1/14/20 4:12 AM, Michal Hocko wrote:
> > On Tue 14-01-20 16:56:37, kernel test robot wrote:
> >> Greeting,
> >>
> >> FYI, we noticed a 15.9% improvement of will-it-scale.per_process_ops due to commit:
> >>
> >>
> >> commit: c77c0a8ac4c522638a8242fcb9de9496e3cdbb2d ("mm/hugetlb: defer freeing of huge pages if in non-task context")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > This is more than surprising because the patch has only changed the
> > behavior for hugetlb pages freed from the (soft)interrupt context and
> > that should be a very rare event. Does the test really generate a lot of
> > those?
> >
> Yes, I have the same question. I was not expecting to see any
> performance impact.

We have the same question and did some further check.

This is the "pagefault3" test case of will-it-scale, and is  
mmap/get_page/munmap test. The source code is: 
https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault3.c 

And its running on LKP does NOT involve any hugetlb actions, as
could be checking HugePages_* in /proc/meminfo.

We also did another check, reverted c77c0a8ac4c5 and simply added
some printk inside free_huge_page(), which can also bring 15%
improvement.

So one possible reason could be the commit changes the cache
alignment of other kernel codes in final bzImage, which happens
to hugely affect this test case.

Thanks,
Feng

> 
> Cheers,
> Longman
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
