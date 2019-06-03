Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F923352A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfFCQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 12:42:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfFCQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PF/DPANZU4B/91WFDIx5XMAZHVrwBhQKQlUd+pBcvEQ=; b=JaGOnQRJd1s1Tei2klsqm9Xw/
        K+z8AjG++0f7WOFL/9N6Okkg4uIaPUTec2wS0KZv9WBhCaHl/IlAg12WlNGF9X3X1ne26v6tNfcRm
        baazZKctsmnFG3aRsZx9tnHSrz9yxqhAKpKpiJ1sfbSRzxS/uDGXrmsE0lPn/YhAz4qbBZrsD3WEp
        FbTU1Uf+Wizk64U4jhZaOSb/xG1FH0WAO0PocMjrBCWoPs/TFenlK4ecED2g5xHbefvRUt0vQb5Ky
        fsv04MugJsd7+QypPkbI1we9jNwnpg22UdePuUom2zg4VPZISZ9R3lbk3EDd4sqSVYBhL1ouD3fwO
        dIMR8XMFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXq2A-0002Ps-63; Mon, 03 Jun 2019 16:42:06 +0000
Date:   Mon, 3 Jun 2019 09:42:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190603164206.GB29719@infradead.org>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#if defined(CONFIG_CMA)

You can just use #ifdef here.

> +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> +	struct page **pages)

Please use two instead of one tab to indent the continuing line of
a function declaration.

> +{
> +	if (unlikely(gup_flags & FOLL_LONGTERM)) {

IMHO it would be a little nicer if we could move this into the caller.
