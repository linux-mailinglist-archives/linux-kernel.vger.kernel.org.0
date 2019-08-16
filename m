Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C469022C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfHPNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:00:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfHPNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/X/Y59hfbuhTR8R0c4UgnC40L7hK5mDNJVq0+XW9gto=; b=G725rYDoFuoO8BgzUWXYW7cYc
        vauQ7kYdyqJ03f6IcxS9qhkhtTmZSRgMnnYxZeryutg+Or3A6urZMN2jJluDdlxdncHZWpUIggkNp
        FIGRFbfJPkz+UpCMvy9Aq6BmUgXZPvKWgcUX1aiSoG8VSBe/izzbR8P9ybUABxNcXUpKkrQzY2dtN
        +n7NobpBi0tHSNiaZMPAvLsENRC7iX8PH3sPVxhS8QjeNKVXzwsaHPpodXNCAoCLr9rdPPl+1o/nE
        kb+dhjHMpvC7kQbARBJEcA5Dpjxzpt+DODNBBTry1vcpyNgTzkcaIl0bYjVSln4kbmyHwy4059iKB
        xurXgSUwQ==;
Received: from [91.112.187.46] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hybq4-0006GQ-61; Fri, 16 Aug 2019 13:00:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: swiotlb-xen cleanups
Date:   Fri, 16 Aug 2019 15:00:02 +0200
Message-Id: <20190816130013.31154-1-hch@lst.de>
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
