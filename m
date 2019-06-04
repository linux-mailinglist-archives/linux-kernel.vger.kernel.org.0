Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348C433FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFDHRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:17:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFDHRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FJORX3JeCyruZ/L/acO0maUXTCoUb/nO5fa3SUQgrYQ=; b=jfoi2joh/mzGfEk7oqOjRTOHD
        fQCUDoMITayn+YGHm/kNmN0VOvtseeK+mDfRflr4iSKEQ6OZcKPm9BHvlzT65KuEY6P2+H/2WP2zi
        eManJCcPModmnqLCoKEncNg3xHeP5udk7eKFYhOJIKBqs7cegzYTm2NKbXZAwbCfdzaTMaqjgNeGf
        ly5O2TI3dwqi0Y8+m24YCrvDGhzgflwRsnWv1hWG1GbMsgITczeW3h/ssQi3KaXvpxxfNkA0YGQxq
        gqtSvh8l0Mh/2Wbv2KLz03K3vU/Ch8YHaYZV7Vora+ti2qQBTwoyr1cQBQMEinLmojBDOeuxThWE/
        vlpPMpsQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3hL-0004Jf-RP; Tue, 04 Jun 2019 07:17:31 +0000
Date:   Tue, 4 Jun 2019 00:17:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190604071731.GA10044@infradead.org>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
 <20190603164206.GB29719@infradead.org>
 <CAFgQCTtUdeq=M=SrVwvggR15Yk+i=ndLkhkw1dxJa7miuDp_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTtUdeq=M=SrVwvggR15Yk+i=ndLkhkw1dxJa7miuDp_AA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 03:13:21PM +0800, Pingfan Liu wrote:
> Is it a convention? scripts/checkpatch.pl can not detect it. Could you
> show me some light so later I can avoid it?

If you look at most kernel code you can see two conventions:

 - double tabe indent
 - indent to the start of the first agument line

Everything else is rather unusual.
