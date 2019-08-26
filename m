Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F669CF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 14:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfHZMTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 08:19:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHZMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4/IYpdkvOndVBhg+7Z4eP7M352N3B3xE+qKewRDjhnY=; b=WZFSh4/ccZ/7Xv7N0LpYyfSfY
        QoXBa+wW+AMqanItAKUh/Q/Hwr8DHSEDpcm0/88LLZ8eJYdRrVW7/6ekZUafJMv3NrF4M8R3kcGxY
        BZ3Ktpt2GIggAcExF5FyBHBwaCaBKdDThv1TJ0ztKOx0pqAduaU9fTcdsbmUhWl/M1+WWrfB22Xgb
        7N7AHYPt5gLgpmenrk40yeGSYjTTtcLI7jfL+0QAGqZYTK0ZMVX3Mrtj/0AQM3fKODIN8M7t9vLw/
        fxv8CeO+a/bFiXkCVlCIz4wzwozEkr6zu4outVpdXQCDiEHJTXa9FifdrhEVyqSPiHzyhxiLf4LOD
        ZNJ2fImxQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2DyM-0002Ej-9R; Mon, 26 Aug 2019 12:19:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: swiotlb-xen cleanups v2
Date:   Mon, 26 Aug 2019 14:19:33 +0200
Message-Id: <20190826121944.515-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xen maintainers and friends,

please take a look at this series that cleans up the parts of swiotlb-xen
that deal with non-coherent caches.

Changes since v1:
 - rewrite dma_cache_maint to be much simpler
 - improve various comments and commit logs
 - remove page-coherent.h entirely
