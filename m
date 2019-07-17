Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00C96B585
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 06:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfGQEWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 00:22:36 -0400
Received: from verein.lst.de ([213.95.11.211]:46934 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfGQEWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:22:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DB4E68B05; Wed, 17 Jul 2019 06:22:33 +0200 (CEST)
Date:   Wed, 17 Jul 2019 06:22:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
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
Subject: Re: [PATCH 1/3] mm: document zone device struct page reserved
 fields
Message-ID: <20190717042233.GA4529@lst.de>
References: <20190717001446.12351-1-rcampbell@nvidia.com> <20190717001446.12351-2-rcampbell@nvidia.com> <26a47482-c736-22c4-c21b-eb5f82186363@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a47482-c736-22c4-c21b-eb5f82186363@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 06:20:23PM -0700, John Hubbard wrote:
> > -			unsigned long _zd_pad_1;	/* uses mapping */
> > +			/*
> > +			 * The following fields are used to hold the source
> > +			 * page anonymous mapping information while it is
> > +			 * migrated to device memory. See migrate_page().
> > +			 */
> > +			unsigned long _zd_pad_1;	/* aliases mapping */
> > +			unsigned long _zd_pad_2;	/* aliases index */
> > +			unsigned long _zd_pad_3;	/* aliases private */
> 
> Actually, I do think this helps. It's hard to document these fields, and
> the ZONE_DEVICE pages have a really complicated situation during migration
> to a device. 
> 
> Additionally, I'm not sure, but should we go even further, and do this on the 
> other side of the alias:

The _zd_pad_* field obviously are NOT used anywhere in the source tree.
So these comments are very misleading.  If we still keep
using ->mapping, ->index and ->private we really should clean up the
definition of struct page to make that obvious instead of trying to
doctor around it using comments.
