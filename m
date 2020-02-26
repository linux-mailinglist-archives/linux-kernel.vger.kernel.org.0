Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023F116F502
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 02:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgBZBaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 20:30:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgBZBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f0M9pTXksi/4gAdPbOMhWiXGju+Jg2ed8su13b9OEus=; b=G2lnM6jJj1akbMJAyGC37MnXzJ
        O6MCG2g4Myrkqv+/4A5AdEgf3m6KJPl4eeI62mVAGs/AXIo3l37SrV6qZ/aB9nSNPtpz2/FjVa29l
        A3EWCc+3b0q++puV9gruRmIZTtb4yudjw/NgTbo6WUU5r+K/lfECbtKswv319+mTC5AXKFCEoR6Le
        7zHyLP3lJpdQZqOV49IykmyDLwsWIEdLE8XME8gmlydvnw9EG/xQAPfSyGrr8Bkyys97fPKmw4Ojb
        CQ8sZ7ePfd1et9+ZNVI/FGBsH7LQneHNo++MSf4OmQLfv6BdMyWQrsonz5NFl+YCW54YIWu3Sjr8D
        At5rGWNw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6lWK-0004C5-HK; Wed, 26 Feb 2020 01:29:52 +0000
Date:   Tue, 25 Feb 2020 17:29:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: fix data races at kswapd_classzone_idx
Message-ID: <20200226012952.GV24185@bombadil.infradead.org>
References: <1582649726-15474-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582649726-15474-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:55:26AM -0500, Qian Cai wrote:
> -	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
> -		pgdat->kswapd_classzone_idx = classzone_idx;
> -	else
> -		pgdat->kswapd_classzone_idx = max(pgdat->kswapd_classzone_idx,
> -						  classzone_idx);
> +	if (READ_ONCE(pgdat->kswapd_classzone_idx) == MAX_NR_ZONES ||
> +	    READ_ONCE(pgdat->kswapd_classzone_idx) < classzone_idx)
> +		WRITE_ONCE(pgdat->kswapd_classzone_idx, classzone_idx);
> +
>  	pgdat->kswapd_order = max(pgdat->kswapd_order, order);

Doesn't this line have the exact same problem you're "solving" above?

Also, why would you do this crazy "f(READ_ONCE(x)) || g(READ_ONCE(x))?
Surely you should be stashing READ_ONCE(x) into a local variable?

And there are a _lot_ of places which access kswapd_classzone_idx
without a lock.  Are you sure this patch is sufficient?
