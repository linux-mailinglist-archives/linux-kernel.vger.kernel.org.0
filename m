Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605226F902
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfGVFql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 01:46:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfGVFql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:46:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7EC6AD12;
        Mon, 22 Jul 2019 05:46:38 +0000 (UTC)
Date:   Mon, 22 Jul 2019 07:46:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, toshi.kani@hpe.com,
        rppt@linux.ibm.com, richardw.yang@linux.intel.com,
        pasha.tatashin@soleen.com, osalvador@suse.de, logang@deltatee.com,
        jmoyer@redhat.com, Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, jane.chu@oracle.com,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Qian Cai <cai@lca.pw>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mm-commits@vger.kernel.org
Subject: Re: [patch 23/38] mm/sparsemem: introduce struct mem_section_usage
Message-ID: <20190722054637.GW30461@dhcp22.suse.cz>
References: <20190718225757.ndUBg%akpm@linux-foundation.org>
 <20190719061313.GI30461@dhcp22.suse.cz>
 <CAHk-=wgtcNxV8ueTk5r9aXZFSpXjb22dMUxfDojPA=O4QtMFFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtcNxV8ueTk5r9aXZFSpXjb22dMUxfDojPA=O4QtMFFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-07-19 09:42:18, Linus Torvalds wrote:
> On Thu, Jul 18, 2019 at 11:13 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > Has this been properly reviewed after the last rebase and is this
> > actually ready for merging? I have seen some follow up fixes
> > http://lkml.kernel.org/r/20190715081549.32577-1-osalvador@suse.de
> > and do not see those patches being in the pipe line. Or have they been
> > merged?
> 
> It looks to me from the patches that Andrew updated them with
> 
>   https://lore.kernel.org/linux-mm/20190715081549.32577-2-osalvador@suse.de/
> 
> and
> 
>   https://lore.kernel.org/linux-mm/20190718120543.GA8500@linux/
> 
> so it looks good to me.
> 
> But that's just from reading the patches, I might have missed
> something and I don't see the history.

Thanks for double checking! It's good that follow up fixes didn't fall
through cracks. Anyway I have to say that I find merging shortly after a
non-trivial rebase as risky and rushed through. I am not really
convinced this is so urgent to warrant such a step.

I hoped to get to it eventually and give it a deeper review because this
is a non trivial stuff. I am sorry but I couldn't have done that yet
(busy with other stuff and being OOO for quite some time).
-- 
Michal Hocko
SUSE Labs
