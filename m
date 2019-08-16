Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69528FAFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 08:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfHPG2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 02:28:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfHPG2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oU/+XLvJ/zQXeVSNiDSSlJqSG/SneSmtCzvqLBroOSY=; b=EvXHTIUxlRbzNA+RRnALDlEZ7
        V3/RDd3Mqg1DeQl7oV3ZkPJfeP0TE9G+7oHZoME5kQqbbL1z3akBM3MJsWG4ZlgbDgyd82M7oWvyA
        GIb5p2vce+b8aoyegq2NmEVZpH/sS0JOOfWgR6BdSLNS588kchnd87R9V3mNofTE+dipTfnFZbAUy
        kIWl9m2vTro537iAS/fgltZp681Tr6OPWOzXSwHDBxwmzvR2MWdqzOKcK3nE2w1IMuYRSztBQ1Z9/
        OID7tNU5sXdkolwAetL2OKma/9NdaQ6ME+emgjtNyITJ1/CQjFauz9IogkNnsfAgfMGSjsPpzY77I
        pZ1/YO/Rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyViJ-00064g-AM; Fri, 16 Aug 2019 06:27:51 +0000
Date:   Thu, 15 Aug 2019 23:27:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190816062751.GA16169@infradead.org>
References: <20190808154240.9384-1-hch@lst.de>
 <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:50:37AM -0700, Linus Torvalds wrote:
> On Thu, Aug 8, 2019 at 8:42 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > this series is based on a patch from Linus to split the callbacks
> > passed to walk_page_range and walk_page_vma into a separate structure
> > that can be marked const, with various cleanups from me on top.
> 
> The whole series looks good to me. Ack.
> 
> > Note that both Thomas and Steven have series touching this area pending,
> > and there are a couple consumer in flux too - the hmm tree already
> > conflicts with this series, and I have potential dma changes on top of
> > the consumers in Thomas and Steven's series, so we'll probably need a
> > git tree similar to the hmm one to synchronize these updates.
> 
> I'd be willing to just merge this now, if that helps. The conversion
> is mechanical, and my only slight worry would be that at least for my
> original patch I didn't build-test the (few) non-x86
> architecture-specific cases. But I did end up looking at them fairly
> closely  (basically using some grep/sed scripts to see that the
> conversions I did matched the same patterns). And your changes look
> like obvious improvements too where any mistake would have been caught
> by the compiler.
> 
> So I'm not all that worried from a functionality standpoint, and if
> this will help the next merge window, I'll happily pull now.

So what is the plan forward?  Probably a little late for 5.3,
so queue it up in -mm for 5.4 and deal with the conflicts in at least
hmm?  Queue it up in the hmm tree even if it doesn't 100% fit?
