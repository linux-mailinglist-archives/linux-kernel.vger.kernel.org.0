Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9850057827
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 02:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfF0AvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 20:51:23 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:60588 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfF0AvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:51:21 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 387CD2DC005B;
        Wed, 26 Jun 2019 20:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1561596680;
        bh=uXs8jdup5M6WacVJmioLChNfDgHR/3okK/USi+R0dJs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Tl3RrQYL0XioL8sGGAMZBRqWknudnM9mAtU2K09D59jGWKY1oaqG76hAVZzT4ZFsG
         CdriFls73SRvMfs8XdqBzB+aEccVYcPFLx1zHLAN2oddkR63Z1Ad/xR9obufNHYcU/
         e0BMwHNWSWq/+vuTetXa3ZqNyvoZGML0FvIadxo/SZakXjxnBqk5H8JovNOewoJJKX
         0vEznj4A1qeRVXV6uI6YXMZgEwIf2uTFpmM3VszuBa5cVS6DikxekEEtjYrghYFF9p
         2beN+y05fYBmu+H9V/jUAMIt2bOC+7NpLGwj5BM1RdPiGZF+S/xkcDYlzltyWoVRqO
         /MDvJL4Vjfi6uVAdATYbUqSQfeCVZQzj/+yGsLYLo+zCHBG2az4Od5L1qTSTnjeVox
         Pl/Li2nYdNBA751qpkGfrndceNwtSLFtv6JufV2iGBCD0Q3OBGe4AJO8UsVYcnIvTG
         KsqpxnBuIQL3dcWTj3nhWPbsHpjZgAygXmqNDAqFMt0ZJNyYjliYYAdwUFcO66T7FK
         F8IB/CGWrHaCTADGIREZ2Chrq7ht4IrTjW3TO2GYKVt6r8EkShVOuiaynIIrTt4bQm
         Kj8pEb3VMD9TbUch5JJkfC+yLnGxDOrk73z7LzcmwJhDEoQTZ6gG5WkA3vQBa6Moaw
         XVOvw/BrkBRL6P7EOVFi4FkY=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5R0owXw037609
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 10:51:13 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 27 Jun 2019 10:50:57 +1000
In-Reply-To: <20190626065751.GK17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
         <20190626061124.16013-2-alastair@au1.ibm.com>
         <20190626062113.GF17798@dhcp22.suse.cz>
         <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
         <20190626065751.GK17798@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Thu, 27 Jun 2019 10:51:15 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 08:57 +0200, Michal Hocko wrote:
> On Wed 26-06-19 16:27:30, Alastair D'Silva wrote:
> > On Wed, 2019-06-26 at 08:21 +0200, Michal Hocko wrote:
> > > On Wed 26-06-19 16:11:21, Alastair D'Silva wrote:
> > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > 
> > > > If a memory section comes in where the physical address is
> > > > greater
> > > > than
> > > > that which is managed by the kernel, this function would not
> > > > trigger the
> > > > bug and instead return a bogus section number.
> > > > 
> > > > This patch tracks whether the section was actually found, and
> > > > triggers the
> > > > bug if not.
> > > 
> > > Why do we want/need that? In other words the changelog should
> > > contina
> > > WHY and WHAT. This one contains only the later one.
> > >  
> > 
> > Thanks, I'll update the comment.
> > 
> > During driver development, I tried adding peristent memory at a
> > memory
> > address that exceeded the maximum permissable address for the
> > platform.
> > 
> > This caused __section_nr to silently return bogus section numbers,
> > rather than complaining.
> 
> OK, I see, but is an additional code worth it for the non-development
> case? I mean why should we be testing for something that shouldn't
> happen normally? Is it too easy to get things wrong or what is the
> underlying reason to change it now?
> 

It took me a while to identify what the problem was - having the BUG_ON
would have saved me a few hours.

I'm happy to just have the BUG_ON 'nd drop the new error return (I
added that in response to Mike Rapoport's comment that the original
patch would still return a bogus section number).


-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


