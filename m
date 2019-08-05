Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249DF818EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfHEMNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 08:13:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727349AbfHEMNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:13:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86CCFB63C;
        Mon,  5 Aug 2019 12:13:17 +0000 (UTC)
Date:   Mon, 5 Aug 2019 14:13:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is it safe to kmalloc a large size of memory in interrupt
 handler?
Message-ID: <20190805121314.GN7597@dhcp22.suse.cz>
References: <CABXRUiSuZc+W7884ek9YifKdx1eiJ_pmyRM42KK0ZhSK9xTkFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXRUiSuZc+W7884ek9YifKdx1eiJ_pmyRM42KK0ZhSK9xTkFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 19:57:54, Fuqian Huang wrote:
> In the implementation of kmalloc.
> when the allocated size is larger than KMALLOC_MAX_CACHE_SIZE,
> it will call kmalloc_large to allocate the memory.
> kmalloc_large ->
> kmalloc_order_trace->kmalloc_order->alloc_pages->alloc_pages_current->alloc_pages_nodemask->get_page_from_freelist->node_reclaim->__node_reclaim->shrink_node->shrink_node_memcg->get_scan_count

You shouldn't really get there when using GFP_NOWAIT/GFP_ATOMIC.

> get_scan_count will call spin_unlock_irq which enables local interrupt.
> As the local interrupt should be disabled in the interrupt handler.
> It is safe to use kmalloc to allocate a large size of memory in
> interrupt handler?

It will work very unreliably because larger physically contiguous memory
is not generally available without doing compaction after a longer
runtime. In general I would recommend to use pre allocated buffers or
defer the actual handling to a less restricted context if possible.

-- 
Michal Hocko
SUSE Labs
