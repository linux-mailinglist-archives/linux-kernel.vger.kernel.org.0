Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F697901A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfHPMdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 08:33:03 -0400
Received: from verein.lst.de ([213.95.11.211]:55163 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfHPMdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:33:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87FE068B05; Fri, 16 Aug 2019 14:32:58 +0200 (CEST)
Date:   Fri, 16 Aug 2019 14:32:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190816123258.GA22140@lst.de>
References: <20190808154240.9384-1-hch@lst.de> <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com> <20190816062751.GA16169@infradead.org> <20190816115735.GB5412@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816115735.GB5412@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:57:40AM +0000, Jason Gunthorpe wrote:
> Are there conflicts with trees other than hmm?
> 
> We can put it on a topic branch and merge to hmm to resolve. If hmm
> has problems then send the topic on its own?

I see two new walk_page_range user in linux-next related to MADV_COLD
support (which probably really should use walk_range_vma), and then
there is the series from Steven, which hasn't been merged yet.
