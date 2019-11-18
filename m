Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F85FFF44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 08:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKRHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 02:04:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfKRHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=S5SJMQSrl08VJMJjYFzoGqDV3
        30jVobNTl9dUYCycICm/1mmfg1fvf1IMgR78at3v4stXeLUEWfeO0OyAJ2eZtD8OuRCnMzamRDjWJ
        BhVPq2nv/WraPZNm9NgAEV4jssHxmJWWlUu5FXAiqoKRj8d62NaubXTx8ZKM0aB0q0QjRk8Q5IdvY
        2hKmbyjnIpSPe4qPQUwMhYfHmQpX7Kjdc3Kk1h2Jm+72R7hym/yb+m/tQF2oJmzRODv76bcK0JMG4
        yK1+ZcHv+H4IDPBeLkUSKj95z5WynKSkAqfK8S2F5kwzqblaTsMEZeZQsCpgpFxGvOIXtzYxn4TiL
        iKzcPhnNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWb4r-0000sk-Gp; Mon, 18 Nov 2019 07:04:01 +0000
Date:   Sun, 17 Nov 2019 23:04:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: Cleanup __put_devmap_managed_page() vs
 ->page_free()
Message-ID: <20191118070401.GA3099@infradead.org>
References: <20191115001134.2489505-1-jhubbard@nvidia.com>
 <20191115001134.2489505-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115001134.2489505-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
