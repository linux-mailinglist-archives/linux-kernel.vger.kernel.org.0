Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3629625023
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfEUN1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 09:27:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfEUN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yt1TSE+hvjdYVZh8L0V5R+F6bnTH4NU+zMd4kOaAMvQ=; b=WVQbSLh/MDT4P+lDDna9iiMLr
        RRbMOAsBBmx4mCsZkNt49bylRYvcHzTVyua8N+OHNPIuw3GOInsrr2tiwogTLqP5AK7jQXqd5vN5O
        FjMt7ysOrVATKhJxwsW8wu+IQw/7kazzkaztdjb/VdxkhrNb2+NFaafvKE6FHHNvmGdLiztCuWzq7
        Rn6o/w88n0EJknBygF+sAKOyOMzco10Xo9MPtUSM57FxRbDwkIeLozXg2s6fnIwfuhrOPFLM13NnE
        BMFnkXKcR7RVT9hjYGA8A55oRboTjDWL+0GercEMTRGgwU8IlWl4Oph/kXhf1JAplB3yExABbnpFX
        AIZzOg+Ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hT4nY-0006Jh-Ty; Tue, 21 May 2019 13:27:20 +0000
Date:   Tue, 21 May 2019 06:27:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jaewon Kim <jaewon31.kim@gmail.com>, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
Message-ID: <20190521132720.GA23361@infradead.org>
References: <20190520101206.GA9291@infradead.org>
 <Pine.LNX.4.44L0.1905201011490.1498-100000@iolanthe.rowland.org>
 <20190520142331.GA12108@infradead.org>
 <1558428877.12672.8.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558428877.12672.8.camel@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:54:37AM +0200, Oliver Neukum wrote:
> OK, but this leaves a question open. Will the GFP_NOIO actually
> hurt, if it is used after memalloc_noio_save()?

Unless we have a bug somewhere it should not make any difference,
neither positively nor negatively.
