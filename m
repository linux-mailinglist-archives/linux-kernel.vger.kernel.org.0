Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40C5B7EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfGAJUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 05:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbfGAJUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98C0EB02C;
        Mon,  1 Jul 2019 09:20:37 +0000 (UTC)
Date:   Mon, 1 Jul 2019 11:20:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com,
        rpenyaev@suse.de, guro@fb.com, aryabinin@virtuozzo.com,
        rppt@linux.ibm.com, mingo@kernel.org, rick.p.edgecombe@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm/vmalloc.c: improve readability and rewrite
 vmap_area
Message-ID: <20190701092037.GL6376@dhcp22.suse.cz>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630075650.8516-1-lpf.vector@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30-06-19 15:56:45, Pengfei Li wrote:
> Hi,
> 
> This series of patches is to reduce the size of struct vmap_area.
> 
> Since the members of struct vmap_area are not being used at the same time,
> it is possible to reduce its size by placing several members that are not
> used at the same time in a union.
> 
> The first 4 patches did some preparatory work for this and improved
> readability.
> 
> The fifth patch is the main patch, it did the work of rewriting vmap_area.
> 
> More details can be obtained from the commit message.

None of the commit messages talk about the motivation. Why do we want to
add quite some code to achieve this? How much do we save? This all
should be a part of the cover letter.

> Thanks,
> 
> Pengfei
> 
> Pengfei Li (5):
>   mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
>   mm/vmalloc.c: Introduce a wrapper function of
>     insert_vmap_area_augment()
>   mm/vmalloc.c: Rename function __find_vmap_area() for readability
>   mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
>   mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
> 
>  include/linux/vmalloc.h |  28 +++++---
>  mm/vmalloc.c            | 144 +++++++++++++++++++++++++++-------------
>  2 files changed, 117 insertions(+), 55 deletions(-)
> 
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
