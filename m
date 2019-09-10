Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BDFAF088
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 19:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437091AbfIJRfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 13:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbfIJRfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:35:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72866AD17;
        Tue, 10 Sep 2019 17:35:39 +0000 (UTC)
Date:   Tue, 10 Sep 2019 19:35:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
Message-ID: <20190910173537.GB4023@dhcp22.suse.cz>
References: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com>
 <20190910140107.GD2063@dhcp22.suse.cz>
 <CAPcyv4jkZJLzEDne6W2pEDGB+q96NkkozmhKxybTu1LjnPYY9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jkZJLzEDne6W2pEDGB+q96NkkozmhKxybTu1LjnPYY9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 07:53:17, Dan Williams wrote:
> On Tue, Sep 10, 2019 at 7:01 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 06-09-19 08:09:52, Toshiki Fukasawa wrote:
> > [...]
> > > @@ -5856,8 +5855,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > >               if (!altmap)
> > >                       return;
> > >
> > > -             if (start_pfn == altmap->base_pfn)
> > > -                     start_pfn += altmap->reserve;
> > >               end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> >
> > Who is actually setting reserve? This is is something really impossible
> > to grep for in the kernle and git grep on altmap->reserve doesn't show
> > anything AFAICS.
> 
> Yes, it's difficult to grep, here is the use in the nvdimm case:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvdimm/pfn_devs.c#n600

Thanks! I am still not sure what the proper fix is but this is a useful
pointer.

-- 
Michal Hocko
SUSE Labs
