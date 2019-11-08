Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1FF3DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 03:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfKHCJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 21:09:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:41066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfKHCJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:09:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFB6EAF35;
        Fri,  8 Nov 2019 02:09:08 +0000 (UTC)
Date:   Thu, 7 Nov 2019 18:04:56 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
Message-ID: <20191108020456.sulyjskhq3s5zcaa@linux-p48b>
Mail-Followup-To: Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
 <20191107195441.GF11823@bombadil.infradead.org>
 <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ed46ef09-7766-eb80-a4ad-4c72d8dba188@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Nov 2019, Mike Kravetz wrote:

>Note that huge_pmd_share now increments the page count with the semaphore
>held just in read mode.  It is OK to do increments in parallel without
>synchronization.  However, we don't want anyone else changing the count
>while that check in huge_pmd_unshare is happening.  Hence, the need for
>taking the semaphore in write mode.

This would be a nice addition to the changelog methinks.

Thanks,
Davidlohr
