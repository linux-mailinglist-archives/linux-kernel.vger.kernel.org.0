Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F119BD696
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 05:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411423AbfIYDNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 23:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394719AbfIYDNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:13:37 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2ED2075D;
        Wed, 25 Sep 2019 03:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569381216;
        bh=rPZsx5pEjNAHnnStBu4c+or/zobMDQhFXwTACOpn34s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RKjXFpvdXJESRv1aJo1URRbpigJFUTBZzXhxha7WON1XKhjva2wOAukBJ32g7+M8N
         mCaqJy1x1VLNMcRdN2N4D5QR4jK9Ec0B7c3Qe2FFDl8mPx+pFpujUeq9R5lGy73Rbu
         vaaWktmpV4Nh8h31yDew2LKwYhWd2nz0q2cqUzkY=
Date:   Tue, 24 Sep 2019 20:13:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
Message-Id: <20190924201335.0af280458bf68d7f57acb637@linux-foundation.org>
In-Reply-To: <f505cc64-ddff-4c1a-2659-7a3890055d73@arm.com>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
        <f505cc64-ddff-4c1a-2659-7a3890055d73@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 11:16:38 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> 
> 
> On 09/16/2019 11:17 AM, Anshuman Khandual wrote:
> > In add_memory_resource() the memory range to be hot added first gets into
> > the memblock via memblock_add() before arch_add_memory() is called on it.
> > Reverse sequence should be followed during memory hot removal which already
> > is being followed in add_memory_resource() error path. This now ensures
> > required re-order between memblock_[free|remove]() and arch_remove_memory()
> > during memory hot-remove.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Original patch https://lkml.org/lkml/2019/9/3/327
> > 
> > Memory hot remove now works on arm64 without this because a recent commit
> > 60bb462fc7ad ("drivers/base/node.c: simplify unregister_memory_block_under_nodes()").
> > 
> > David mentioned that re-ordering should still make sense for consistency
> > purpose (removing stuff in the reverse order they were added). This patch
> > is now detached from arm64 hot-remove series.
> > 
> > https://lkml.org/lkml/2019/9/3/326
>
> ...
>
> Hello Andrew,
> 
> Any feedbacks on this, does it look okay ?
> 

Well.  I'd parked this for 5.4-rc1 processing because it looked like a
cleanup.

But waaaay down below the ^---$ line I see "Memory hot remove now works
on arm64".  Am I correct in believing that 60bb462fc7ad broke arm64 mem
hot remove?  And that this patch fixes a serious regression?  If so,
that should have been right there in the patch title and changelog!


