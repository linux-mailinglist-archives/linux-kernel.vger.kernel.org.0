Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C313283D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfEWQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 12:35:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfEWQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pTqw8vVT02TTedKtNx5d/snM21V25zXZwTaJRpzHF2s=; b=NfRr1sg+JCx7yTC0Y1pf6Ia/1
        Jj1Q2JKIqRmnEF8uOXpqDpnr9jnvpqyQBNSvVaYyiHaVfePwCfQ0tbLKI4O2cMdcBLvDzvrte+2cX
        1Ly+5JK/e9hbhNJbBJND96QDqY8TGO8OwTWGUrJF1N3V3YCU6jDgEx7HfhN+62O+StZI9eZfbaiEK
        mOxv1UxoWRRwqCOo3fLHC/klxOsWZN6BIyCzN2XJsws5lMcg06NHOBzxQvEFf9idGdYnR3B3EO+AW
        M523UGnpBClzSFsxc9+IrD/MOXokNRCGk9ezwriiL9ixjGlj/s3dDot/vgK2nXpf5NgXjUxy43LCg
        HgQHp8E6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTqh3-0004Ox-JP; Thu, 23 May 2019 16:35:49 +0000
Date:   Thu, 23 May 2019 09:35:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jaewon Kim <jaewon31.kim@gmail.com>, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
Message-ID: <20190523163549.GA8692@infradead.org>
References: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
 <20190520055657.GA31866@infradead.org>
 <1558614729.3994.5.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558614729.3994.5.camel@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 02:32:09PM +0200, Oliver Neukum wrote:
> > Please switch to use memalloc_noio_save() instead.
> 
> Thinking about this again, we have a problem. We introduced
> memalloc_noio_save() in 3.10 . Hence the code should have been
> correct in v4.14. Which means that either
> 6518202970c1 "(mm/cma: remove unsupported gfp_mask
> parameter from cma_alloc()"
> is buggy, or the original issue with a delay of 2 seconds
> still exist.
> 
> Do we need to do something?

cma_alloc calls into alloc_contig_range to do the actual allocation,
which then calls current_gfp_context() to pick up the adjustments
from memalloc_noio_save and friends.  So at least in current mainline
we should be fine.
