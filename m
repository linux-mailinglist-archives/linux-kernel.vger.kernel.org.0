Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD35EA5706
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfIBND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:03:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfIBND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jw8Fv6wzy49CF5verrxJIhR/l1Jc+1IWvfjOczPJBbw=; b=PL+e1Zdr2JEzZT9ECWOEgUXIj
        PfofQ/VUSphe5QCeOTp7hVitRbcBwO5EdK72d/pVGE9Al05kGGKjA898+8hdtXjKoTctl7h0PdacC
        P898B+D6oQf8leL3R7qFDVwMz+UTwtptX7bm10xVhrcwZFPzA+WwvblcZokJJ9MWLL1CHVEC403k3
        yZR22p/2zlSZ1dNzHE7/iT4XKcaRwmRLAmZsdsnwPPxjAOymEaUy3HVEN2o0LkkOho7mSpD7DrDA1
        euVeuEZhe/LdLZ399jjWMaBG0TjH+3bM748sWpek8QJ+H81MukrKwHHfkFd0rETi4hEgJqJJIkx8x
        QMq+VUvQQ==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lzi-00018q-Rg; Mon, 02 Sep 2019 13:03:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: swiotlb-xen cleanups v3
Date:   Mon,  2 Sep 2019 15:03:26 +0200
Message-Id: <20190902130339.23163-1-hch@lst.de>
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

Boris and Juergen, can you take a look at patch 8, which touches x86
a as well?

Changes since v2:
 - further dma_cache_maint improvements
 - split the previous patch 1 into 3 patches

Changes since v1:
 - rewrite dma_cache_maint to be much simpler
 - improve various comments and commit logs
 - remove page-coherent.h entirely
