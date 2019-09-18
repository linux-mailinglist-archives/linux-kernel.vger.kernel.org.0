Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFC7B6A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfIRSYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 14:24:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388687AbfIRSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wyclBAhLGTUISnYVlcWzGC24WmHGZKrQOXN5phZ/Nf4=; b=QSEo2lNK2OFM0t3mHSJ+VX6Wl
        nu23w9dBQYbchoaYzWewSepOEs+S5RBbIgoC3/E6UN00rGkioOK4qvUrySXmw9BmFlJaaSnffZnHK
        LF2Hz7DjkASMtJ3hFxPYyk98yhPIt6hxZ8+ATGWRPjIaQ8vipzTwhXsHJaHSLQ91WDDQ3pA6N3uDM
        N7KFX35NKSts2qLCMUO+LTXc3emZWENCKakH19mIOpMd3BS5T3iUeRf4uqnFLbHmEL/ThXh+0x+SP
        2QUocLufhJ/V5/pCraKRcckZY+78atNbFGRNCY83N60iARiF2I10VQuIU8jDkyuSwyFN3iwrtffGX
        elqgtqT2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAece-0003ss-ER; Wed, 18 Sep 2019 18:24:12 +0000
Date:   Wed, 18 Sep 2019 11:24:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.4-rc1
Message-ID: <20190918182412.GA9924@infradead.org>
References: <20190918114754.GA1899504@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918114754.GA1899504@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a note of record:  I don't think either file system move
is a good idea.  erofs still needs a lot of work, especially in
interacting with the mm code like abusing page->mapping.

exfat is just a random old code drop from Samsung hastily picked up,
and also duplicating the fat16/32 functionality, and without
consultation of the developes of that who are trying to work through
their process of contributing the uptodate and official version of it.
