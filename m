Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD2611D9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 23:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfLLWtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 17:49:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:38150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730707AbfLLWtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C129AB71;
        Thu, 12 Dec 2019 22:49:11 +0000 (UTC)
Date:   Thu, 12 Dec 2019 14:42:44 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2] hugetlbfs: Disable softIRQ when taking hugetlb_lock
Message-ID: <20191212224244.ohfcrvnuc7euzmzw@linux-p48b>
Mail-Followup-To: Andi Kleen <ak@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <871rt99qmg.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <871rt99qmg.fsf@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019, Andi Kleen wrote:

>Davidlohr Bueso <dave@stgolabs.net> writes:
>> +void free_huge_page(struct page *page)
>> +{
>> +	struct hugetlb_free_page_work work;
>> +
>> +	work.page = page;
>> +	INIT_WORK_ONSTACK(&work.work, free_huge_page_workfn);
>> +	queue_work(hugetlb_free_page_wq, &work.work);
>> +
>> +	/*
>> +	 * Wait until free_huge_page is done.
>> +	 */
>> +	flush_work(&work.work);
>> +	destroy_work_on_stack(&work.work);
>
>Does flushing really work in softirq context?
>
>Anyways, waiting seems inefficient over fire'n'forget

Yep. I was only thinking about the workerfn not blocking
and therefore we could wait safely, but flush_work has no
such guarantees.

Thanks,
Davidlohr
