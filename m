Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6A169BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 02:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBXB3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 20:29:10 -0500
Received: from gentwo.org ([3.19.106.255]:58838 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXB3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:29:10 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id D49103F070; Mon, 24 Feb 2020 01:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D3A8B3E951;
        Mon, 24 Feb 2020 01:29:09 +0000 (UTC)
Date:   Mon, 24 Feb 2020 01:29:09 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Wen Yang <wenyang@linux.alibaba.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: improve count_partial() for
 CONFIG_SLUB_CPU_PARTIAL
In-Reply-To: <20200222092428.99488-1-wenyang@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2002240126190.13486@www.lameter.com>
References: <20200222092428.99488-1-wenyang@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020, Wen Yang wrote:

> We also observed that in this scenario, CONFIG_SLUB_CPU_PARTIAL is turned
> on by default, and count_partial() is useless because the returned number
> is far from the reality.

Well its not useless. Its just not counting the partial objects in per cpu
partial slabs. Those are counted by a different counter it.

> Therefore, we can simply return 0, then nr_free is also 0, and eventually
> active_objects == total_objects. We do not introduce any regression, and
> it's preferable to show the unrealistic uniform 100% slab utilization
> rather than some very high but incorrect value.

I suggest that you simply use the number of partial slabs and multiply
them by the number of objects in a slab and use that as a value. Both
values are readily available via /sys/kernel/slab/<...>/

You dont need a patch to do that.

