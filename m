Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788872674C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfEVPwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729656AbfEVPwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:52:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77824AEE2;
        Wed, 22 May 2019 15:52:21 +0000 (UTC)
Date:   Wed, 22 May 2019 17:52:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] proc/meminfo: add MemKernel counter
Message-ID: <20190522155220.GB4374@dhcp22.suse.cz>
References: <155853600919.381.8172097084053782598.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155853600919.381.8172097084053782598.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-05-19 17:40:09, Konstantin Khlebnikov wrote:
> Some kinds of kernel allocations are not accounted or not show in meminfo.
> For example vmalloc allocations are tracked but overall size is not shown
> for performance reasons. There is no information about network buffers.
> 
> In most cases detailed statistics is not required. At first place we need
> information about overall kernel memory usage regardless of its structure.
> 
> This patch estimates kernel memory usage by subtracting known sizes of
> free, anonymous, hugetlb and caches from total memory size: MemKernel =
> MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Hugetlb.

Why do we need to export something that can be calculated in the
userspace trivially? Also is this really something the number really
meaningful? Say you have a driver that exports memory to the userspace
via mmap but that memory is not accounted. Is this really a kernel
memory?

-- 
Michal Hocko
SUSE Labs
