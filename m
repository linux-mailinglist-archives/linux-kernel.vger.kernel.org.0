Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1F193629
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 03:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCZCtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 22:49:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgCZCtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uIV1dMF8f1Bx0qqtr1nXCMlrLokE0SVaAEV1OmGtP74=; b=XBVHyY5LqgEp/M2/ztuf9zK8pB
        fW3/IgQhGLqx1X1dHycX+BGaX+wSL+jgzgzuqaJtVRv0eDJRqcsUE35sDbn5MNrwUgWf+xIOuRQ8K
        WwYuXJwIw5ixD12I2x0wWSg0Ik8LfxJkFUgIwrBIsEwtKGOa2R1DOXMBhSgkXFZW2s9YZMLmGtdJH
        s2ZyRzlQ8DPzjk2MwWhdHuHGsm6TIifU/IolnPYBaK0rA0iRzL4+OPSkNjXVTu1a0YH9pD41Lhj1i
        hK3OCplTUTSBFppLyDSLgbuK66xHzdQx2cf4E+ex1CDwHajldIEPb1kOpDoWbhbrhW6sYbGdADYQa
        4gDgzwqw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHIaY-0000PW-8h; Thu, 26 Mar 2020 02:49:46 +0000
Date:   Wed, 25 Mar 2020 19:49:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: Re: [PATCH v7 1/9] fs: Constify vma argument to vma_is_dax
Message-ID: <20200326024946.GE22483@bombadil.infradead.org>
References: <20200324201123.3118-1-thomas_os@shipmail.org>
 <20200324201123.3118-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324201123.3118-2-thomas_os@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:11:15PM +0100, Thomas Hellstr�m (VMware) wrote:
> From: "Thomas Hellstrom (VMware)" <thomas_os@shipmail.org>
> 
> The function is used by upcoming vma_is_special_huge() with which we want
> to use a const vma argument. Since for vma_is_dax() the vma argument is
> only dereferenced for reading, constify it.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "J�r�me Glisse" <jglisse@redhat.com>
> Cc: "Christian K�nig" <christian.koenig@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Thomas Hellstrom (VMware) <thomas_os@shipmail.org>
> Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> Acked-by: Christian K�nig <christian.koenig@amd.com>

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
