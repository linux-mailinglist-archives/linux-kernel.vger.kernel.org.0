Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2726B174AF9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 05:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCAEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 23:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgCAEEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:04:45 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D5721556;
        Sun,  1 Mar 2020 04:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583035483;
        bh=v2mcxXWb+R0Vhm17A6puuY8jR6c5Oi6XU1V671GdlZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A9ePQgV6KKC2mkpgUEeBYsaX6+itQcOiQNHySSIms4bmN2iXMXtJp8zDfWu9gN+1l
         qLpc36KbDrTZG6q6a0Kl2c7YXPNDWfnXq+av5ZtkmQ3q8vLAfkCCQVmzDloJiqH+SK
         3ISuA3wgjNsV83UMHc6LmY1VdlRzPJeOi2p8XA8s=
Date:   Sat, 29 Feb 2020 20:04:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/8] mm: Split huge pages on write-notify or COW
Message-Id: <20200229200442.64bf59df288962382d46fd55@linux-foundation.org>
In-Reply-To: <20191203132239.5910-3-thomas_os@shipmail.org>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
        <20191203132239.5910-3-thomas_os@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 14:22:33 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> We currently only do COW and write-notify on the PTE level, so if the
> huge_fault() handler returns VM_FAULT_FALLBACK on wp faults,
> split the huge pages and page-table entries. Also do this for huge PUDs
> if there is no huge_fault() handler and the vma is not anonymous, similar
> to how it's done for PMDs.

There is no description here of *why* we are making this change?

> Note that fs/dax.c does the splitting in the huge_fault() handler, but as
> huge_fault() is implemented by modules we need to consider whether to
> export the splitting functions for use in the modules or whether to try
> to keep calls in the core. Opt for the latter. A follow-up patch can
> remove the dax.c split_huge_pmd() if needed.
