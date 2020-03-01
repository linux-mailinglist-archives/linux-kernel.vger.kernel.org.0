Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD2174A5E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 01:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgCAALu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 19:11:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCAALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0tTQpY19p3YOQ7sgf8HTMtSFinGBxI5aHxd4kFj3uKU=; b=ThQ4pTJObQ4Ta4mG22/o18PGw2
        GKkN+UNRUR7Qcui9VQxaPmCxOEKwyGpmkqNeG2tvntwnOxG6wn4AADOrMBvgkPaIxRoJ/t34fGB/z
        HeyH2yl7mK1f4xcLlABRcNN3bmmiDN2qpWt5nPM42xLjeFWis/Mc1TrvrbO+fanNqxke2gaTfDeFW
        W6YmYw0aWBIFq82Dm53ocwRie//MnwqNav6E/76urUZA+WJGWujjke+R1ZXtXdkLTMGr//R0i67FN
        IpPVy4363QKd8/xGZnKKMFqdZ6uhjL+IVev8jKrb9ujiHsNd1uHws/SFD2WmxJrgDjPibPvLYC2qS
        U9HDFBPA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8CCy-0008Az-TO; Sun, 01 Mar 2020 00:11:48 +0000
Date:   Sat, 29 Feb 2020 16:11:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/vmscan.c: Clean code by removing unnecessary
 assignment
Message-ID: <20200301001148.GM29971@bombadil.infradead.org>
References: <20200229214022.11853-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229214022.11853-1-mateusznosek0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:40:22PM +0100, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously 0 was assigned to variable 'lruvec_size',
> but the variable was never read later.
> So the assignment can be removed.
> 
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

It _was_ used, until commit f87bccde6a7dd1bdb219a4045e8ac111590c9314
which removed lru_pages.  So this is just a left-over, and I agree it's
now superfluous.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
