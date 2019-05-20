Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65622B80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 07:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfETF5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 01:57:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfETF5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n/yIzKd81+TM+3UvGV1Qf2W8qzlZxmI5yFYDnHihTSo=; b=urnzw8VmiMP9TugzAfLgp6yc7
        dfmBhTiVp1UyVNGQyqHS1Nnn4tFxpWfNDOjlhG3NMqQ3E4wFTCes/z0TWLH1SfqsWpD5/akz+DBX/
        oHbWkpIrbZP24i2cUziddSM5kBml+LER0VrkrORsAxP71POf02NXO+DhU5vbIZJFNG9kbJ5aV7TEL
        YCG9fYcgSfdhXvp1Wj2JL25KemMRrINp4Rmms//Dv1Iw5ebeBX5Tsc/k2CzUtT0G+iCSf9LYn1qfl
        jXOt5kQpf7Iwn84rir0nFGULr6aU1NNTbqKi+ZA0YY3lh0okwoFeQ6Ngq+VbJVUoWRVYvs0RWtiut
        g1CGMTSvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbI9-0005Xy-GO; Mon, 20 May 2019 05:56:57 +0000
Date:   Sun, 19 May 2019 22:56:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon31.kim@samsung.com>, ytk.lee@samsung.com
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
Message-ID: <20190520055657.GA31866@infradead.org>
References: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, you can't just pass arbitary GFP_ flags to dma allocation
routines, beause very often they are not just wrappers around
the page allocator.

So no, you can't just fine grained control the flags, but the
existing code is just as buggy.

Please switch to use memalloc_noio_save() instead.
