Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2555118264C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 01:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgCLAlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 20:41:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:51049 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbgCLAlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:41:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 17:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="289557039"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2020 17:41:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 49C6616D; Thu, 12 Mar 2020 02:41:19 +0200 (EET)
Date:   Thu, 12 Mar 2020 03:41:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: remove unnecessary memory fetch in
 PageHeadHuge()
Message-ID: <20200312004119.b7uew2jriwx2mks5@black.fi.intel.com>
References: <20200311172440.6988-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311172440.6988-1-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 06:24:40PM +0100, Vlastimil Babka wrote:
> Commit f1e61557f023 ("mm: pack compound_dtor and compound_order into one word
> in struct page") changed compound_dtor from a pointer to an array index in
> order to pack it. To check if page has the hugeltbfs compound_dtor, we can
> just compare the index directly without fetching the function pointer.
> Said commit did that with PageHuge() and we can do the same with PageHeadHuge()
> to make the code a bit smaller and faster.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

We use literaly the same check in the function next to this one --
PageHuge().


-- 
 Kirill A. Shutemov
