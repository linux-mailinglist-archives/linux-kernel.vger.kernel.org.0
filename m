Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0909F7B3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 22:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfG3UCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 16:02:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfG3UCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:02:19 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2C13333F;
        Tue, 30 Jul 2019 20:02:16 +0000 (UTC)
Date:   Tue, 30 Jul 2019 13:02:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-Id: <20190730130215.919b31c19df935cc5f1483e6@linux-foundation.org>
In-Reply-To: <20190727132334.9184-1-catalin.marinas@arm.com>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Add mempool allocations for struct kmemleak_object and
> kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> under memory pressure. Additionally, mask out all the gfp flags passed
> to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> 
> A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> different minimum pool size (defaulting to NR_CPUS * 4).

btw, the checkpatch warnings are valid:

WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
#70: FILE: mm/kmemleak.c:197:
+static int min_object_pool = NR_CPUS * 4;

WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
#71: FILE: mm/kmemleak.c:198:
+static int min_scan_area_pool = NR_CPUS * 1;

There can be situations where NR_CPUS is much larger than
num_possible_cpus().  Can we initialize these tunables within
kmemleak_init()?
