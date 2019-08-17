Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7590D66
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 08:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfHQGnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 02:43:06 -0400
Received: from verein.lst.de ([213.95.11.211]:60610 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfHQGnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:43:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADCC568B05; Sat, 17 Aug 2019 08:43:01 +0200 (CEST)
Date:   Sat, 17 Aug 2019 08:43:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190817064301.GA18544@lst.de>
References: <20190808154240.9384-1-hch@lst.de> <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com> <20190816062751.GA16169@infradead.org> <20190816115735.GB5412@mellanox.com> <20190816123258.GA22140@lst.de> <20190816140623.4e3a5f04ea1c08925ac4581f@linux-foundation.org> <20190817164124.683d67ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817164124.683d67ff@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 04:41:24PM +1000, Stephen Rothwell wrote:
> I certainly prefer that method of API change :-)
> (see the current "keys: Replace uid/gid/perm permissions checking with
> an ACL" in linux-next and the (currently) three merge fixup patches I
> am carrying.  Its not bad when people provide the fixes, but I am no
> expert in most areas of the kernel ...)

It would mean pretty much duplicating all the code.  And then never
finish the migration because new users of the old interfaces keep
popping up.  Compared to that I'd much much prefer either Linus
taking it now or a branch.
