Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221FA63E98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 02:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGJA2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 20:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGJA2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 20:28:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7DC20645;
        Wed, 10 Jul 2019 00:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562718504;
        bh=pgC6c3DPV5AItfmGQQFtB/x1Xt0vg1j5Q5WBogBNnOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bcORr81NEQsz5D+zOUG6k8DlarV4FeSW19kgXYYSMd9qxtzYAp2QLxXViDAJRru6M
         dtwMY3UTEic/u5ydDJe4uucQjbfejE/8h+7uvSrHfdzgxUJFHps8dEZGqI+bVmC1qW
         p6MjkxHTx75iefkEq1M0pWmNUiKj0HVfWBXbH/Ys=
Date:   Tue, 9 Jul 2019 17:28:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?J?= =?ISO-8859-1?Q?=E9r=F4me?= Glisse 
        <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
Message-Id: <20190709172823.9413bb2333363f7e33a471a0@linux-foundation.org>
In-Reply-To: <20190709223556.28908-1-rcampbell@nvidia.com>
References: <20190709223556.28908-1-rcampbell@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 15:35:56 -0700 Ralph Campbell <rcampbell@nvidia.com> wrote:

> When migrating a ZONE device private page from device memory to system
> memory, the subpage pointer is initialized from a swap pte which computes
> an invalid page pointer. A kernel panic results such as:
> 
> BUG: unable to handle page fault for address: ffffea1fffffffc8
> 
> Initialize subpage correctly before calling page_remove_rmap().

I think this is

Fixes:  a5430dda8a3a1c ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
Cc: stable

yes?
