Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3911C8986B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfHLIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 04:05:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfHLIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vPcRhQE2VhNEisGBmPchCu428bpzG9Y5RQW+EqTjpc0=; b=bSwOae8WgasH+6oQcL2IKiSHzT
        fg6xKAnMJsP0K/r8/rosIfvN27k8hgmQAt9xpVRpiVhGaCowg3C9ZVaQiUDfIwt/E4n01od1wE9t/
        RZgd5HPY5SODvgO4LAoq5LPFr2cdz4FgkWNO1fGk7zZS3/KtXqBPH+3H7f1ycK9zWRLM3fYwV0rpI
        Di4Q/JkRK3QJMxiRiuvKtQHy1MM/aNDh+v4lhnCjRLp3gz86XQBJ47DHknE7pImWJZoRDjeo9G4c2
        jlbE+BUX1SbbH483oxyxgWddLXmPxtVyibXQ7RRUGfoeu5dzUg+o1Gsnd28LyIKLaf/EUYtN2TPyZ
        o7SvHCrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hx5KR-00029s-CA; Mon, 12 Aug 2019 08:05:19 +0000
Date:   Mon, 12 Aug 2019 01:05:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: status of drivers/misc/sgi-gru?
Message-ID: <20190812080518.GA29629@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dear ex-SGI folks,

do you know if the GRU driver is still maintained and in use?

Both Bharath and Jason have been posting changes to it that need
review, and I've just been discussing even more extensive mmu_notifier
changes with Jason that will require some very careful review.  If the
driver is still need I'd really like to hear your feedback.
