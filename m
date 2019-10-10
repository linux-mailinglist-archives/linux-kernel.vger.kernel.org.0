Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD4D1F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 05:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfJJDxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 23:53:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:16106 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfJJDxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:53:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 20:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="184280680"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2019 20:53:31 -0700
Date:   Thu, 10 Oct 2019 11:53:14 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] userfaultfd: remove set but not used variable 'h'
Message-ID: <20191010035314.GA6917@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191009122740.70517-1-yuehaibing@huawei.com>
 <a28da32b-5c26-21e9-4a08-722abf9fbeba@oracle.com>
 <20191010012322.GB2167@richard>
 <ba62cc8f-da4d-a316-c968-80871551c863@oracle.com>
 <20191010033045.GA5927@richard>
 <01601a94-5c52-7ef6-ce08-7a86ac70fab2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01601a94-5c52-7ef6-ce08-7a86ac70fab2@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 08:42:46PM -0700, Mike Kravetz wrote:
>On 10/9/19 8:30 PM, Wei Yang wrote:
>> On Wed, Oct 09, 2019 at 07:25:18PM -0700, Mike Kravetz wrote:
>>> On 10/9/19 6:23 PM, Wei Yang wrote:
>>>> On Wed, Oct 09, 2019 at 05:45:57PM -0700, Mike Kravetz wrote:
>>>>> On 10/9/19 5:27 AM, YueHaibing wrote:
>>>>>> Fixes gcc '-Wunused-but-set-variable' warning:
>>>>>>
>>>>>> mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
>>>>>> mm/userfaultfd.c:217:17: warning:
>>>>>>  variable 'h' set but not used [-Wunused-but-set-variable]
>>>>>>
>>>>>> It is not used since commit 78911d0e18ac ("userfaultfd: use vma_pagesize
>>>>>> for all huge page size calculation")
>>>>>>
>>>>>
>>>>> Thanks!  That should have been removed with the recent cleanups.
>>>>>
>>>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>>
>>>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>
>>>> If I am correct, this is removed in a recent patch.
>>>
>>> I'm having a hard time figuring out what is actually in the latest mmotm
>>> tree.  Andrew added a build fixup patch ab169389eb5 in linux-next which
>>> adds the reference to h.  Is there a patch after that to remove the reference?
>>>
>> 
>> I checked linux-next tree, this commit removes the reference.
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=add4eaeef3766b7491d70d473c48c0b6d6ca5cb7
>> 
>
>Yes, but unless I am mistaken this adds it back,
>
>https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ab169389eb5ff9da7113a21737574edc6d22c072
>

Oops, we may leave this to Andrew.

>-- 
>Mike Kravetz

-- 
Wei Yang
Help you, Help me
