Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95255731BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfGXOet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:34:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:18868 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGXOet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:34:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 07:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="171518552"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jul 2019 07:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 39248130; Wed, 24 Jul 2019 17:34:46 +0300 (EEST)
Date:   Wed, 24 Jul 2019 17:34:46 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com, jannh@google.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/mmap.c: silence variable 'new_start' set but not used
Message-ID: <20190724143445.ezii7bwbbxxxtu2k@black.fi.intel.com>
References: <20190724140739.59532-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724140739.59532-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 02:07:39PM +0000, YueHaibing wrote:
> 'new_start' is used in is_hugepage_only_range(),
> which do nothing in some arch. gcc will warning:

Make is_hugepage_only_range() reference the variable on such archs:

#define is_hugepage_only_range(mm, addr, len)   ((void) addr, 0)

-- 
 Kirill A. Shutemov
