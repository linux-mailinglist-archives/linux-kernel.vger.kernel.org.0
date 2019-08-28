Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF59FA50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 08:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfH1GUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 02:20:12 -0400
Received: from verein.lst.de ([213.95.11.211]:34602 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1GUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:20:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 144CB68AFE; Wed, 28 Aug 2019 08:20:08 +0200 (CEST)
Date:   Wed, 28 Aug 2019 08:20:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190828062007.GA21823@lst.de>
References: <20190808154240.9384-1-hch@lst.de> <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com> <20190816062751.GA16169@infradead.org> <20190823134308.GH12847@mellanox.com> <20190824222654.GA28766@infradead.org> <20190827013408.GC31766@mellanox.com> <20190827163431.65a284b295004d1ed258fbd5@linux-foundation.org> <20190827233619.GB28814@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827233619.GB28814@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:36:26PM +0000, Jason Gunthorpe wrote:
> Okay, I'll get it on a branch and merge it toward hmm.git tomorrow

I was planning to resend it with the rebase, especially as the build
bot picked a build error in task_mmu.c where we were missing a stub
for an unusual configuration.  I wish I'd remember which one that was..
