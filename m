Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCEAD8DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 12:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404655AbfJPKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 06:33:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfJPKdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27A56B266;
        Wed, 16 Oct 2019 10:33:17 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:33:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
Message-ID: <20191016103315.GR317@dhcp22.suse.cz>
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <20191016085839.GP317@dhcp22.suse.cz>
 <c344224c-e8ae-ccea-911b-2d08f257b6f4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c344224c-e8ae-ccea-911b-2d08f257b6f4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 15:58:32, Anshuman Khandual wrote:
> 
> 
> On 10/16/2019 02:28 PM, Michal Hocko wrote:
[...]
> > After other issues mentioned by David get resolved you can add
> 
> Just to confirm. Only the styling issues, right ? pfn_range_valid_contig(),
> pfn alignment and zone scanning all remain the same like before ?

Yes, if they need any special handling then let's do it in a separate
patch with a proper justification.
-- 
Michal Hocko
SUSE Labs
