Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C122A178956
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 05:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCDEAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 23:00:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCDEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6/6c+4Ziln2SU67GLquqkGhtyon3m67WJ0bPB86NfHA=; b=I6mcHjisMiRDqK11Gwk1JD1J0F
        S3XOn8t+X3Fodr6hziGsiNQve3+OwbyipWlDGpFR51AEV/RNM115YeKajck5yVnCu7kaBkwLDn/Fi
        vOQOZ10grbNFuI1W58NjOJU4J0LKlM8yjkxqpHuNRUlB7Nx9PUPdyGljBcueA6y96qfy5dAnz5Hcu
        5Rhz29XabtvwTKP9eKqa4oNq9yBHja9YEvB0CEMS4pLK8omtqUlNxOioT6Z9jeMD/+M/Q4ae2rupT
        tsrVeDWpQOlkiEclICHEO3cTbUbGvluky91MSUQzXoNIM786sCn/KgLesZQdXKj/F87VR5//vp9T9
        1i87verg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9LDH-0005CN-C7; Wed, 04 Mar 2020 04:00:51 +0000
Date:   Tue, 3 Mar 2020 20:00:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     paulmck@kernel.org, elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200304040051.GB29971@bombadil.infradead.org>
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <409B9444-73B7-4686-B0ED-892ECDECE462@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <409B9444-73B7-4686-B0ED-892ECDECE462@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:55:02PM -0500, Qian Cai wrote:
> 
> 
> > On Mar 3, 2020, at 10:33 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> >> Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> >> could happen concurrently result in data races, but those operate only
> >> on a single bit that are pretty much harmless. For example,
> > 
> > Those aren't data races.  The writes are protected by a spinlock and the
> > reads by the RCU read lock.  If the tool can't handle RCU protection,
> > it's not going to be much use.
> > 
> 
> Maybe the commit log is a bit confusing if you did not look at the example closely
> enough. It is actually one read and one write result in data races where one spin_lock()
> and one rcu_read_lock()  can’t prevent that from happening. We also have,

Yes.  All these examples have the reader protected by the RCU read lock
and the writer protected by the spinlock.  Does the tool need some kind
of extra annotation here?

> [19522.548668][T39646] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked 
> [19522.583776][T39646]  
> [19522.593816][T39646] write to 0xffff9ffb56c5c238 of 8 bytes by interrupt on cpu 16: 
> [19522.628560][T39646]  xas_clear_mark+0x8e/0x1a0 
> [19522.648993][T39646]  __xa_clear_mark+0xe7/0x110 
> [19522.669367][T39646]  test_clear_page_writeback+0x3e9/0x712 [19522.694638][T39646]  end_page_writeback+0xaa/0x2b0 

Spinlock taken here ^^^

> [19523.533125][T39646] read to 0xffff9ffb56c5c238 of 8 bytes by task 39646 on cpu 16: 
> [19523.570758][T39646]  xas_find_marked+0xe9/0x750 
> [19523.594276][T39646]  find_get_pages_range_tag+0x1bf/0xa90 

RCU read lock taken here ^^^

