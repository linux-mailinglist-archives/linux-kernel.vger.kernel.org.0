Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28B216F655
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 05:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgBZEGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 23:06:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgBZEGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qu2aPURbegdzfjSgtAkPb+TbG3uomn1JGpoqTQmr/0g=; b=FIZTPvRn3595XVQory0Jhecsta
        7XjC4muiAu+9tLTT/ALg6Wttpv6fpY+HJQLq4Y7fPKXszStHmceKhxiLlF1bAsyYbTkoxvhVa2khJ
        9fjlkcmhi2t2MCy94H98F65UBVbwCWVYf771eZCuA6YrXgSl6j4GB5amo8hdAFdl1BBwd1gHUb+yY
        u2uQJm3Rx3cxA5GHwL120ApkFqoadtRq0F6StjPiuJNO6aHI5WyUtnsP+xpSPRGBIzXbEKsHHj3Ss
        8KFa64/bKLds0lA1SsVnuQb2afuoHhuDBWIBtIBf4c5G7gGkMxWRQ1rhktcynjjdGFkqFFY5MS1Ro
        sLtvsvsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6nxc-0007Kc-S7; Wed, 26 Feb 2020 04:06:12 +0000
Date:   Tue, 25 Feb 2020 20:06:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: fix data races at kswapd_classzone_idx
Message-ID: <20200226040612.GW24185@bombadil.infradead.org>
References: <20200226035827.1285-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226035827.1285-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:58:27PM -0500, Qian Cai wrote:
> pgdat->kswapd_classzone_idx could be accessed concurrently in
> wakeup_kswapd(). Plain writes and reads without any lock protection
> result in data races. Fix them by adding a pair of READ|WRITE_ONCE() as
> well as saving a branch (compilers might well optimize the original code
> in an unintentional way anyway). While at it, also take care of
> pgdat->kswapd_order and non-kswapd threads in allow_direct_reclaim().

I don't understand why the usages of kswapd_classzone_idx in kswapd() and
kswapd_try_to_sleep() don't need changing too?  kswapd_classzone_idx()
looks safe to me, but I'm prone to missing stupid things that compilers
are allowed to do.
