Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CEAF0D58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 04:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfKFDvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 22:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfKFDvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:51:16 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B1B2087E;
        Wed,  6 Nov 2019 03:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573012275;
        bh=Ch2qZ4hrZWMCG0BfzRa/bcgEyOD2CW9P0h6uzzt78BU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lkZ5AKd0if3lcumlQA2ZsO0HM8ctchvN67RfVm0fze0k1k06BCszdsXCClXwDJVr6
         v/zCv+t/X+B7YQirkazLBgZYED9mQ6MFrjuFcGhJ+xMOA9U5ssrUJM2iKhrsY+p6hW
         dVuGaKOkDg02iDxaFzOvE0IXkiSWGJzEG3VgB4qM=
Date:   Tue, 5 Nov 2019 19:51:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v6 4/8] mm: Add write-protect and clean utilities for
 address space ranges
Message-Id: <20191105195114.f75be5e76763da5546121b41@linux-foundation.org>
In-Reply-To: <20191014132204.7721-5-thomas_os@shipmail.org>
References: <20191014132204.7721-1-thomas_os@shipmail.org>
        <20191014132204.7721-5-thomas_os@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 15:22:00 +0200 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> Add two utilities to 1) write-protect and 2) clean all ptes pointing into
> a range of an address space.
> The utilities are intended to aid in tracking dirty pages (either
> driver-allocated system memory or pci device memory).
> The write-protect utility should be used in conjunction with
> page_mkwrite() and pfn_mkwrite() to trigger write page-faults on page
> accesses. Typically one would want to use this on sparse accesses into
> large memory regions. The clean utility should be used to utilize
> hardware dirtying functionality and avoid the overhead of page-faults,
> typically on large accesses into small memory regions.

Not fully comfortable reviewing this one.

> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -736,4 +736,7 @@ config ARCH_HAS_PTE_SPECIAL
>  config ARCH_HAS_HUGEPD
>  	bool
> =20
> +config MAPPING_DIRTY_HELPERS
> +        bool
> +

But given this, it's your problem ;)  So

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Yes, please proceed with merging [1-4] via a drm tree.
