Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C18165186
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 22:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgBSVWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 16:22:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSVWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:22:42 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECAE124656;
        Wed, 19 Feb 2020 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582147360;
        bh=SMT83HTbhfyboCPhfsiX1K20ihz6gLD6srtGATEOVI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TwGo8139M7PeZk7Ov1iEDzoLrm1mJZkY3kstaz84xgWoJbRuTjVmp5aqfcHPmKG9M
         kjI4/Wm5JwTpg8UlU9udwUB24H1NaXig16E9n0t/Nki27LU2HfkQKbuzg2Jtq74Mt0
         KMSow4Ne76+p2IgcExEruN5IHkGzH2vIxV1CL3dI=
Date:   Wed, 19 Feb 2020 13:22:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Justin He <Justin.He@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] mm: Avoid data corruption on CoW fault into PFN-mapped
 VMA
Message-Id: <20200219132239.92a22479e4bff7ec73ae6bdb@linux-foundation.org>
In-Reply-To: <20200218154151.13349-1-kirill.shutemov@linux.intel.com>
References: <20200218154151.13349-1-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 18:41:51 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> Jeff Moyer has reported that one of xfstests triggers a warning when run
> on DAX-enabled filesystem:
> 
> 	WARNING: CPU: 76 PID: 51024 at mm/memory.c:2317 wp_page_copy+0xc40/0xd50
> 	...
> 	wp_page_copy+0x98c/0xd50 (unreliable)
> 	do_wp_page+0xd8/0xad0
> 	__handle_mm_fault+0x748/0x1b90
> 	handle_mm_fault+0x120/0x1f0
> 	__do_page_fault+0x240/0xd70
> 	do_page_fault+0x38/0xd0
> 	handle_page_fault+0x10/0x30
> 
> The warning happens on failed __copy_from_user_inatomic() which tries to
> copy data into a CoW page.
> 
> This happens because of race between MADV_DONTNEED and CoW page fault:
> 
> 	CPU0					CPU1
>  handle_mm_fault()
>    do_wp_page()
>      wp_page_copy()
>        do_wp_page()
> 					madvise(MADV_DONTNEED)
> 					  zap_page_range()
> 					    zap_pte_range()
> 					      ptep_get_and_clear_full()
> 					      <TLB flush>
> 	 __copy_from_user_inatomic()
> 	 sees empty PTE and fails
> 	 WARN_ON_ONCE(1)
> 	 clear_page()
> 
> The solution is to re-try __copy_from_user_inatomic() under PTL after
> checking that PTE is matches the orig_pte.
> 
> The second copy attempt can still fail, like due to non-readable PTE,
> but there's nothing reasonable we can do about, except clearing the CoW
> page.

You don't think this is worthy of a cc:stable?
