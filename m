Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240F69C0B6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 00:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfHXW1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 18:27:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHXW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 18:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nurlPYQx2ItprLfZNVFEAgIWj9lAPjByXFVyqakf/bs=; b=ApdJs2NgoerPDGq+Qjl6yD3Md
        GAULGKDGkBAbH361DaCiAt7apWygm/BAIZROhFYyzzMy4bwRaulxMebUnRGt24wWjEHXE7r4N/M+1
        7K1XiSiZbchjPReLHlJUoBk8rUxdYj8WswiJJgI1k8AMf2ndViz9WFs48YpT2ny0R4jkZAGNBZY7z
        SrbzGB+qb1C1wMkNFkQXyo/QADwO9W4GP2/vGdw40zAoAIJxqymHVTyATGkDslXwQieI9sYh+BbxP
        WbaWlsz0+F+mkfsbscFFsGSRFpy++c/HluVp56qcN2/+dQLk5bMWMceetVLSPQ6dESrRMYa7edSJa
        L01aladlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i1eUp-0007Y8-25; Sat, 24 Aug 2019 22:26:55 +0000
Date:   Sat, 24 Aug 2019 15:26:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190824222654.GA28766@infradead.org>
References: <20190808154240.9384-1-hch@lst.de>
 <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
 <20190816062751.GA16169@infradead.org>
 <20190823134308.GH12847@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823134308.GH12847@mellanox.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 01:43:12PM +0000, Jason Gunthorpe wrote:
> > So what is the plan forward?  Probably a little late for 5.3,
> > so queue it up in -mm for 5.4 and deal with the conflicts in at least
> > hmm?  Queue it up in the hmm tree even if it doesn't 100% fit?
> 
> Did we make a decision on this? Due to travel & LPC I'd like to
> finalize the hmm tree next week.

I don't think we've made any decision.  I'd still love to see this
in hmm.git.  It has a minor conflict, but I can resend a rebased
version.
