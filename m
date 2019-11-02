Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD922ED099
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKBUyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 16:54:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfKBUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 16:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y2BVSZGLOtYso2UmMC8FMik2nU6NLubpKQk779x8UUA=; b=qblkL1ZRBi5PEhgfR+0PdSvaM
        OoECO8pA8R/h1IGIg62xtdJFz2ETSgNR5qdCqMYzXR+Xvxka8MmYzk0GSANGIfSYkmfu27NRkljzD
        1R2mOuCwqi8h1rynk/ioaRXnDR3wJDTQaYdfmKfqrVUg8bevsJav5BuKW7k2+uyMbsDrqRvvViyg/
        Qp9MV+6++6otwJBZmppdg08qUb3DW7Tk/BQILYEOwe9ZAbE74oMhBxov42PfKiK0tuPuqUHMXbLgj
        PXKtS5gTzH/umvyTqWrnYHOIzrCu/waCZua9bVQR5eEUclIkkvhIdEwh/tIJpNzkubXHvWJ1pfCfx
        g8PEF6zTQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iR0PT-0000LU-Rz; Sat, 02 Nov 2019 20:54:11 +0000
Date:   Sat, 2 Nov 2019 13:54:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     hui yang <yanghui.def@gmail.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: There should have an unit (kB)
Message-ID: <20191102205411.GB15832@bombadil.infradead.org>
References: <1572704287-4444-1-git-send-email-yanghui.def@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572704287-4444-1-git-send-email-yanghui.def@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 10:18:07PM +0800, hui yang wrote:
> From: YangHui <yanghui.def@gmail.com>
> 
> -    printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
> +    printk(KERN_CONT " %ldkB", zone->lowmem_reserve[i]);
> Make it look more perfect

I don't think this is accounted in kilobytes though.  Isn't it the
number of pages?

