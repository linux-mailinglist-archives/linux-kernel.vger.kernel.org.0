Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8364FD72BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfJOKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 06:04:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfJOKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KeSiQTLT5+yUYgIlTjDJIYnfdPX9XyC/fQqAdAFrXwA=; b=p8gST8Pmdk8tN5w1R3L7qghN0
        wvgF183kCQmYV1dcdqLrMf0q+n25gOlLCWOJJX4Icj4VB/IXiGYE4/acROOU0l6Axq85KfjPoVKos
        D1lMywlCB/rrSFvteE5GmN/0tm7LPO/jc9Mm1e3FJYm8xhBtV+bn1TswBFJQGE+flh/fLJo5GccyW
        jM4j2hGgiRtbyzpgWl8+XdqJbp2diK/jRAhGmBTvmxh8kyDu+W1Od/73ux0av5o42qUwQxGo4VgoY
        pDIUBPQlCz/VO+5sIuBwGqUhdtHq+xVmzjWw3FCG3P6seqzLgX2WmNHAZ+AGgz/Uflww0PCYeoUUw
        tbckxSJWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKJgs-0003gF-EB; Tue, 15 Oct 2019 10:04:30 +0000
Date:   Tue, 15 Oct 2019 03:04:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, mbrugger@suse.com, f.fainelli@gmail.com,
        wahrenst@gmx.net, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 2/5] ARM: introduce arm_dma_direct
Message-ID: <20191015100430.GA13893@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
 <20191014183108.24804-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014183108.24804-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we just need to byte the bullet and move over arm to dma-direct
entirely.  This needs a careful audit of what differs, but the biggest
item is that we need to ensure dmabounce keeps working (or is replaced
with swiotlb in a suitable way, but that might be a lot more work).
