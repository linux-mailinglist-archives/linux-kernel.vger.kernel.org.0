Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75027B460
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfG3Ujm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Jul 2019 16:39:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfG3Ujl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:39:41 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB48A311D;
        Tue, 30 Jul 2019 20:39:40 +0000 (UTC)
Date:   Tue, 30 Jul 2019 13:39:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-Id: <20190730133939.2840b742408336e2a0a9f573@linux-foundation.org>
In-Reply-To: <1564518157.11067.34.camel@lca.pw>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
        <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
        <1564518157.11067.34.camel@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 16:22:37 -0400 Qian Cai <cai@lca.pw> wrote:

> On Tue, 2019-07-30 at 12:57 -0700, Andrew Morton wrote:
> > On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com>
> > wrote:
> > 
> > > Add mempool allocations for struct kmemleak_object and
> > > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > > under memory pressure. Additionally, mask out all the gfp flags passed
> > > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > > 
> > > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > > different minimum pool size (defaulting to NR_CPUS * 4).
> > 
> > Why would anyone ever want to alter this?  Is there some particular
> > misbehaviour which this will improve?  If so, what is it?
> 
> So it can tolerant different systems and workloads. For example, there are some
> machines with slow disk and fast CPUs. When they are under memory pressure, it
> could take a long time to swap before the OOM kicks in to free up some memory.
> As the results, it needs a large mempool for kmemleak or suffering from higher
> chance of a kmemleak metadata allocation failure.

This sort of thing should be in the changelog and in the user-facing
documentation please.  Also, we should document the user-visible
effects of this failure so that users can determine whether this tunable
will help them.

