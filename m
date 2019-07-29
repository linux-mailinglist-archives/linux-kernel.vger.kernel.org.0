Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFED789B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfG2Kiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 06:38:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbfG2Kit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KAggO34scn31WY7TrlvVv9v9Jlh8D/gvQUy8nUnXkHk=; b=nBEkEzd3Pwsz4U13WP8pfhzI0
        S7e8IJB4PaJ/+Kn+2q8cRtyp1OCQNMNmnM87aiwj94/vHkqSNRq6Pjlj0+Ap6FPdbzJP51TtUd7Go
        +y1E4dh8Ac9FjHQa8YwvLXowOyTQkZXeTLxc0P+sAU8x64nOoJnGjAmNCnI7XtL6O0OfB+dCcRPuH
        IcjUw8lQwA43toWGGElJGCLShD9u2jkU4RoNOAUT9Wri7lS2khLOgvGWwWYGzLYVBWcUMb/90KTGe
        h+7yrY/G/eBtgbj6w32Gi4BIcDAwydt/KJI1TE7ENc3JgFvrTVFN2lyaoHgNPGcmwiZuwFJC1zDvz
        tr+kRNn/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs33G-0002r4-1B; Mon, 29 Jul 2019 10:38:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76B5F203BF70D; Mon, 29 Jul 2019 12:38:44 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:38:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, longman@redhat.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -tip] locking/rwsem: Check for operations on an
 uninitialized rwsem
Message-ID: <20190729103844.GA31381@hirez.programming.kicks-ass.net>
References: <20190729044735.9632-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729044735.9632-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 09:47:35PM -0700, Davidlohr Bueso wrote:
> Currently rwsems is the only locking primitive that lacks this
> debug feature. Add it under CONFIG_DEBUG_RWSEMS and do the magic
> checking in the locking fastpath (trylock) operation such that
> we cover all cases. The unlocking part is pretty straightforward.

Thanks!
