Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E625C102EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 23:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKSWKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 17:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfKSWKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:10:49 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104F722445;
        Tue, 19 Nov 2019 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574201448;
        bh=l79WBsC8E5Lcg7exxmqTQyn1rU0Uq4SRrjSuf8Ymrfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ox4RnNzqGdy5pbnYZy5+y/vuNQAT15V/Rs86upWAjc7FPjFFrZilAxG2mB555LJKI
         EdPAd8f2idHmjHtzFtS6I8fH2kKhep+cTQukXM5qrMYfBwF4rg9ANG06aFPMCFeHr3
         dZAogaLYxSID7JEAGJf1rjdxk/FVOjYjgroimnYw=
Date:   Tue, 19 Nov 2019 14:10:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, sparse: do not waste pre allocated memmap space
Message-Id: <20191119141047.a8e31e95b631e28f84dc0bc9@linux-foundation.org>
In-Reply-To: <def84c96-a7d0-1026-a890-a8eca2e6a458@redhat.com>
References: <20191119092642.31799-1-mhocko@kernel.org>
        <def84c96-a7d0-1026-a890-a8eca2e6a458@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 11:03:58 +0100 David Hildenbrand <david@redhat.com> wrote:

> > @@ -482,8 +481,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> >   {
> >   	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
> >   	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
> > +	/*
> > +	 * Pre-allocated buffer is mainly used by __populate_section_memmap
> > +	 * and we want it to be properly aligned to the section size - this is
> > +	 * especially the case for VMEMMAP which maps memmap to PMDs
> > +	 */
> >   	sparsemap_buf =
> > -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> > +		memblock_alloc_try_nid_raw(size, section_map_size(),
> >   						addr,
> >   						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> 
> Wow, that alignment/layout gives me nightmares  ^
> 
> None of your business, though :)

We're allowed to change it ;)

--- a/mm/sparse.c~mm-sparse-do-not-waste-pre-allocated-memmap-space-fix
+++ a/mm/sparse.c
@@ -486,10 +486,8 @@ static void __init sparse_buffer_init(un
 	 * and we want it to be properly aligned to the section size - this is
 	 * especially the case for VMEMMAP which maps memmap to PMDs
 	 */
-	sparsemap_buf =
-		memblock_alloc_try_nid_raw(size, section_map_size(),
-						addr,
-						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+	sparsemap_buf = memblock_alloc_try_nid_raw(size, section_map_size(),
+					addr, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	sparsemap_buf_end = sparsemap_buf + size;
 }
 
_

