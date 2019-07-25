Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 015717450E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 07:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbfGYFiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 01:38:25 -0400
Received: from verein.lst.de ([213.95.11.211]:58122 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403937AbfGYFiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:38:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B331868B20; Thu, 25 Jul 2019 07:38:21 +0200 (CEST)
Date:   Thu, 25 Jul 2019 07:38:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] mm: document zone device struct page field usage
Message-ID: <20190725053821.GA24527@lst.de>
References: <20190724232700.23327-1-rcampbell@nvidia.com> <20190724232700.23327-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724232700.23327-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:26:58PM -0700, Ralph Campbell wrote:
> Struct page for ZONE_DEVICE private pages uses the page->mapping and
> and page->index fields while the source anonymous pages are migrated to
> device private memory. This is so rmap_walk() can find the page when
> migrating the ZONE_DEVICE private page back to system memory.
> ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
> page->index fields when files are mapped into a process address space.
> 
> Add comments to struct page and remove the unused "_zd_pad_1" field
> to make this more clear.

I still think we should also fix up the layout, and I haven't seen
a reply from Matthew justifying his curses for your patch that makes
the struct page layout actually match how it is used.
