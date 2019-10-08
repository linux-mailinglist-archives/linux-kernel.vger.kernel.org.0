Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF1D0449
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfJHXm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 19:42:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:27718 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfJHXm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:42:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 16:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="199961741"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2019 16:42:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 83A05F9; Wed,  9 Oct 2019 02:42:23 +0300 (EEST)
Date:   Wed, 9 Oct 2019 02:42:23 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
Message-ID: <20191008234223.wycjktby2t5gwz3o@black.fi.intel.com>
References: <20191008213836.19266-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008213836.19266-1-vgupta@synopsys.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:38:36PM +0000, Vineet Gupta wrote:
> Add the intermediate p4d accessors to make it 5 level compliant.
> 
> Thi sis non-functional change anyways since ARC has software page walker
     ^
     Typo.
> with 2 lookup levels (pgd -> pte)
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/include/asm/pgtable.h |  1 -
>  arch/arc/mm/fault.c            | 10 ++++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)

Have you tested it with CONFIG_HIGHMEM=y? alloc_kmap_pgtable() has to be
converted too.

-- 
 Kirill A. Shutemov
