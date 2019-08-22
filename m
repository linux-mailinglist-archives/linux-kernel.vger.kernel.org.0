Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515AC99440
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfHVMwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 08:52:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfHVMwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:52:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 910B1AE04;
        Thu, 22 Aug 2019 12:52:32 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:52:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        pankaj.suryawanshi@einfochips.com
Subject: Re: PageBlocks and Migrate Types
Message-ID: <20190822125231.GJ12785@dhcp22.suse.cz>
References: <CACDBo57u+sgordDvFpTzJ=U4mT8uVz7ZovJ3qSZQCrhdYQTw0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo57u+sgordDvFpTzJ=U4mT8uVz7ZovJ3qSZQCrhdYQTw0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-08-19 22:23:44, Pankaj Suryawanshi wrote:
> Hello,
> 
> 1. What are Pageblocks and migrate types(MIGRATE_CMA) in Linux memory ?

Pageblocks are a simple grouping of physically contiguous pages with
common set of flags. I haven't checked closely recently so I might
misremember but my recollection is that only the migrate type is stored
there. Normally we would store that information into page flags but
there is not enough room there.

MIGRATE_CMA represent pages allocated for the CMA allocator. There are
other migrate types denoting unmovable/movable allocations or pages that
are isolated from the page allocator.

Very broadly speaking, the migrate type groups pages with similar
movability properties to reduce fragmentation that compaction cannot
do anything about because there are objects of different properties
around. Please note that pageblock might contain objects of a different
migrate type in some cases (e.g. low on memory).

Have a look at gfpflags_to_migratetype and how the gfp mask is converted
to a migratetype for the allocation. Also follow different MIGRATE_$TYPE
to see how it is used in the code.

> How many movable/unmovable pages are defined by default?

There is nothing like that. It depends on how many objects of a specific
type are allocated.

HTH
-- 
Michal Hocko
SUSE Labs
