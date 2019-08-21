Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8548296E95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 02:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfHUAyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 20:54:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUAyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WOLUqTOBybrWu/WmLa0SVTrR0ZYSLugUxBFyMLxbqBk=; b=Js1JfjifrXDe1lW3QE0Yt1gQR
        mUJPk4hesVY8anlPMG86AjT2E7bMJlzTIYmfRzQvg4GPxETvFoHfJyFd1r2jMVZIkrSFQTyV3tQOZ
        N5vWvQ0H5Ev3QPSClW7ql5JmjrXRUrKTkQR2y5XKQ3Wa2qA5kEqCmpGQePKVUfvDn3h7JKQrJG7Rr
        6PPyYLWeixe0Lc/05HHGE+hz9Wu27e1xsznb5nyyDY/7Y48C+hh6vV/SRWOSKTtFBXOLv1MNJUKgs
        Rbb0Vzqql47R+Y8WMZZHhIwl/4gFyCLAMCUbSB6LmAw+tVryHKTyF4wzfNZJnC1vdyYjxR0ShVS4O
        Ig8uakCow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0EtF-0004F5-It; Wed, 21 Aug 2019 00:54:17 +0000
Date:   Tue, 20 Aug 2019 17:54:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mmap.c: extract __vma_unlink_list as counter part
 for __vma_link_list
Message-ID: <20190821005417.GC18776@bombadil.infradead.org>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
 <20190814021755.1977-3-richardw.yang@linux.intel.com>
 <20190814051611.GA1958@infradead.org>
 <20190814065703.GA6433@richard>
 <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
 <20190820172629.GB4949@bombadil.infradead.org>
 <20190821005234.GA5540@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821005234.GA5540@richard>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 08:52:34AM +0800, Wei Yang wrote:
> On Tue, Aug 20, 2019 at 10:26:29AM -0700, Matthew Wilcox wrote:
> >On Wed, Aug 14, 2019 at 11:19:37AM +0200, Vlastimil Babka wrote:
> >> On 8/14/19 8:57 AM, Wei Yang wrote:
> >> > On Tue, Aug 13, 2019 at 10:16:11PM -0700, Christoph Hellwig wrote:
> >> >>Btw, is there any good reason we don't use a list_head for vma linkage?
> >> > 
> >> > Not sure, maybe there is some historical reason?
> >> 
> >> Seems it was single-linked until 2010 commit 297c5eee3724 ("mm: make the vma
> >> list be doubly linked") and I guess it was just simpler to add the vm_prev link.
> >> 
> >> Conversion to list_head might be an interesting project for some "advanced
> >> beginner" in the kernel :)
> >
> >I'm working to get rid of vm_prev and vm_next, so it would probably be
> >wasted effort.
> 
> You mean replace it with list_head?

No, replace the rbtree with a new tree.  https://lwn.net/Articles/787629/
