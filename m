Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7733C27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 01:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFCXzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 19:55:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:37239 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfFCXzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:55:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 16:55:01 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2019 16:55:01 -0700
Date:   Mon, 3 Jun 2019 16:56:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <20190603235610.GB29018@iweiny-DESK2.sc.intel.com>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
 <20190603164206.GB29719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603164206.GB29719@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:42:06AM -0700, Christoph Hellwig wrote:
> > +#if defined(CONFIG_CMA)
> 
> You can just use #ifdef here.
> 
> > +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> > +	struct page **pages)
> 
> Please use two instead of one tab to indent the continuing line of
> a function declaration.
> 
> > +{
> > +	if (unlikely(gup_flags & FOLL_LONGTERM)) {
> 
> IMHO it would be a little nicer if we could move this into the caller.

FWIW we already had this discussion and thought it better to put this here.

https://lkml.org/lkml/2019/5/30/1565

Ira

[PS John for some reason your responses don't appear in that thread?]

