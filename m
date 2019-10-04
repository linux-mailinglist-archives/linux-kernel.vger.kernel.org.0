Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7CDCBB3F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfJDNHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 09:07:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387916AbfJDNHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:07:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65C2EB1A3;
        Fri,  4 Oct 2019 13:07:14 +0000 (UTC)
Date:   Fri, 4 Oct 2019 15:07:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
Message-ID: <20191004130713.GK9578@dhcp22.suse.cz>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
 <20191004105824.GD9578@dhcp22.suse.cz>
 <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
 <1570193776.5576.270.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570193776.5576.270.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 08:56:16, Qian Cai wrote:
[...]
> It might be a good time to rethink if it is really a good idea to dump_page()
> at all inside has_unmovable_pages(). As it is right now, it is a a potential
> deadlock between console vs memory offline. More details are in this thread,
> 
> https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/

Huh. That would imply we cannot do any printk from that path, no?
-- 
Michal Hocko
SUSE Labs
