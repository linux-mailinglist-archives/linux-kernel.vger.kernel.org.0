Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11E2AA197
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbfIELg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 07:36:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbfIELg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PcPa5IlnDPH8tm4OAmhfwwgRlNISzvs+UWn9umBpAfg=; b=oHktuR8r49WzS31A+UiLvH2Z1
        NOyMpC+gF++rhCh0op7LqLwwAWVUNUm2SQ9KmfLw9Pn/jUxylg5DwsGYh3+9dzQi14KQdNMBbj9oc
        doMl3phBErpwrkl1GIePI1UGZRc2kIdHNs44uBX4QikSp831ZWfdwCW4SV0WZ2Dnd43ncD/uZM+J2
        /Rw7f9H5PeR8pjZMTjToV/ZWxAE/xpX2xJSe5VGnQdi5AWvDDfwFt8fHgPIJMw1JPMcO2WHpzvs14
        eaEIYtaQygNOOsdigW27oG6DgRt17ieKZVa5HK7Ouw9qXpBM1CF3SwzHnSMOjBiYRp+Lhz2szCjNB
        xKIvE8g0w==;
Received: from 213-225-38-191.nat.highway.a1.net ([213.225.38.191] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5q3o-0001wn-Rm; Thu, 05 Sep 2019 11:36:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: swiotlb-xen cleanups v4
Date:   Thu,  5 Sep 2019 13:33:57 +0200
Message-Id: <20190905113408.3104-1-hch@lst.de>
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


Changes since v3:
 - don't use dma_direct_alloc on x86

Changes since v2:
 - further dma_cache_maint improvements
 - split the previous patch 1 into 3 patches

Changes since v1:
 - rewrite dma_cache_maint to be much simpler
 - improve various comments and commit logs
 - remove page-coherent.h entirely
