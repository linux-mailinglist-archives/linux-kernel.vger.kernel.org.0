Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F0345E99
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 15:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfFNNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:42:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfFNNmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p3fdSrD6/f8+J2jfdFQoF6CbHZtdUBeGJFTtmYRKwYs=; b=C/ulpoOj8tF0DMXgykNNOW20X
        4Mzm4QmvDAn+j9P8nuhJeRygIqeHOjSWDJY+0+OzKZ1QOxCd16AZBN9sn99xoafwCYsf0SxCAHd1A
        5kjiC6LnXF8NWX9MRaaHLXEQtSc9mwQ2izH24oV42RKxLUWNbRkwBv0evHaMj4mAHfsOJWq/plo5j
        c0YcPHAbAKviEhOul5kKUn8wvhSx2e1cRWynTF38u8QKSf61Y8QRiK3tgX92QtBeOrAr6sXrG97P6
        l+62k64V9qA6RAM5SGJaJWO6SQnHIs6xo4GyoGp4XiUwjTllRucUNGOQaV5yoLXL9aV1vtwrDFKFh
        1iC6nF3Lw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbmTE-0000Vp-AX; Fri, 14 Jun 2019 13:42:20 +0000
Date:   Fri, 14 Jun 2019 06:42:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/vmalloc: Check absolute error return from
 vmap_[p4d|pud|pmd|pte]_range()
Message-ID: <20190614134220.GL32656@bombadil.infradead.org>
References: <1560413551-17460-1-git-send-email-anshuman.khandual@arm.com>
 <7cc6a46c50c2008bfb968c5e48af5a49@suse.de>
 <406afc57-5a77-a77c-7f71-df1e6837dae1@arm.com>
 <20190613153141.GJ32656@bombadil.infradead.org>
 <4b5c0b18-c670-3631-f47f-3f80bae8fe4b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5c0b18-c670-3631-f47f-3f80bae8fe4b@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:57:42AM +0530, Anshuman Khandual wrote:
> 
> 
> On 06/13/2019 09:01 PM, Matthew Wilcox wrote:
> > On Thu, Jun 13, 2019 at 08:51:17PM +0530, Anshuman Khandual wrote:
> >> acceptable ? What we have currently is wrong where vmap_pmd_range() could
> >> just wrap EBUSY as ENOMEM and send up the call chain.
> > 
> > It's not wrong.  We do it in lots of places.  Unless there's a caller
> > which really needs to know the difference, it's often better than
> > returning the "real error".
> 
> I can understand the fact that because there are no active users of this
> return code, the current situation has been alright. But then I fail to
> understand how can EBUSY be made ENOMEM and let the caller to think that
> vmap_page_rage() failed because of lack of memory when it is clearly not
> the case. It is really surprising how it can be acceptable inside kernel
> (init_mm) page table functions which need to be thorough enough.

It's a corollary of Steinbach's Guideline for Systems Programming.
There is no possible way to handle this error because this error is
never supposed to happen.  So we may as well return a different error
that will still lead to the caller doing the right thing.
