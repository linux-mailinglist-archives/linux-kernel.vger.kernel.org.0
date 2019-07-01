Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5C2F8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE3JEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 05:04:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfE3JEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=49xeno4V9mLcXP70a+Sa/AkFzuIPrG2MU15kIdS1nJ8=; b=oThcn6rn+teoSzUhrD1ivlyEm
        NLcVzG/BInSURdKJwXjMVmB0tKRq2g286EMQ0Vbdus1/jzEsGjN6XnhdBK3nYR5GYNC7wN7ReinQB
        3n5NIOsvffPiVfhvRiW3EvTICSdbwKBv/i/9afRwg2p5SAX5l8O3lVdxogQFdTLhCSjgbqIyBovaq
        HdvlU7le3E69hkHYFKiywpDmUF0xxF4nsGjN26NKcvet2nTpoHnlbHuqKRHq64tnGNicYRZx5ZOtn
        IZa8k14vODzW8d1RWcI83yW8p6ez+NLE4lGppYOGQriUa8uMMd6jfDcUHc7s0wdXA34vb0HOKm+He
        0LenWjfaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWGyn-000806-HQ; Thu, 30 May 2019 09:04:09 +0000
Date:   Thu, 30 May 2019 02:04:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 3/3] xen/swiotlb: remember having called
 xen_create_contiguous_region()
Message-ID: <20190530090409.GB30428@infradead.org>
References: <20190529090407.1225-1-jgross@suse.com>
 <20190529090407.1225-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529090407.1225-4-jgross@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't add your private flag to page-flags.h.  The whole point of
the private flag is that you can use it in any way you want withou
touching the common code.
