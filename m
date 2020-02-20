Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62374165525
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 03:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBTCiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 21:38:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbgBTCiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9C4q1yiX55pfiM9NCjD/zDbj2x7HtQclnCikhie1s9w=; b=C3asFV71n6ErhE6wl1zS0sQGmt
        nYEpHJrdtFdbwGsv4hIIdrkS8TQsnvE3OttgX8UZdfcGBUZJDkf34Mg2ygoujwQZO94IAUzcAU960
        lLh0y6Uh1oKOeyNvQTRVCGrYhKS+Qd6oyZOPkrs6jHwIUsJkmChSMZKs3AT8wCjS4NHpoLs7xpbrw
        bUudegj8zUqubFQshNzrw6Zx8gryaDmsDgDWKbwPZMkMKxLdJBbV6DVBdh4k6bNVwV9fl37z6P4Ol
        PqImArEVySRJChZe6W2mvLCemtnQURXxTsGc6TVrda/2rA5Bz9am9UWLOztuipqXN4y1MhQQjo5Va
        qdIKXQlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4bjL-00033H-CI; Thu, 20 Feb 2020 02:38:23 +0000
Date:   Wed, 19 Feb 2020 18:38:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Liam Mark <lmark@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
Message-ID: <20200220023823.GA11561@infradead.org>
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
 <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
 <20200219123704.GC19400@willie-the-truck>
 <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:22:36PM -0800, Liam Mark wrote:
> I am looking into how much of our allocation pattern details I can share.

Well if you can't share the details it is by defintion completely
irrelevant.  Please don't waste our time.
