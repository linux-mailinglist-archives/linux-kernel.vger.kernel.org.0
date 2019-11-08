Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D559DF3E95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 04:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfKHDxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 22:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfKHDxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:53:30 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C19B20869;
        Fri,  8 Nov 2019 03:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573185209;
        bh=slR4qIidQmC7We2wOTVqSVRCCiFEmzZiKJg8hXTu6+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fz48zrPsaivstCfk3Bajpbs66Pr9WE+lxf22D/Z2W9p3Jnc+V88OWfLd95xOP0jDA
         DXDwYq0jgcWD48TWMeKktHUK9iqUbBCXOB/M/drzvzAjgt/rIqD7+vepaMiPm4HgoF
         BRUbRHYJATIvI86WEfgk3bT30Sft/JCKAFycLvIs=
Date:   Thu, 7 Nov 2019 19:53:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v5 1/2] mm,thp: recheck each page before collapsing file
 THP
Message-Id: <20191107195328.600f302bbde69cf9c1089500@linux-foundation.org>
In-Reply-To: <20191106060930.2571389-2-songliubraving@fb.com>
References: <20191106060930.2571389-1-songliubraving@fb.com>
        <20191106060930.2571389-2-songliubraving@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 22:09:29 -0800 Song Liu <songliubraving@fb.com> wrote:

> In collapse_file(), for !is_shmem case, current check cannot guarantee
> the locked page is up-to-date.  Specifically, xas_unlock_irq() should
> not be called before lock_page() and get_page(); and it is necessary to
> recheck PageUptodate() after locking the page.
> 
> With this bug and CONFIG_READ_ONLY_THP_FOR_FS=y, madvise(HUGE)'ed .text
> may contain corrupted data.  This is because khugepaged mistakenly
> collapses some not up-to-date sub pages into a huge page, and assumes
> the huge page is up-to-date.  This will NOT corrupt data in the disk,
> because the page is read-only and never written back.  Fix this by
> properly checking PageUptodate() after locking the page.  This check
> replaces "VM_BUG_ON_PAGE(!PageUptodate(page), page);".
> 
> Also, move PageDirty() check after locking the page.  Current
> khugepaged should not try to collapse dirty file THP, because it is
> limited to read-only .text. The only case we hit a dirty page here is
> when the page hasn't been written since write. Bail out and retry when
> this happens.

Incorrect data is pretty serious.  Should we backport this into -stable
kernels?

(I suspect I already asked this in response to earier versions, sorry ;))
