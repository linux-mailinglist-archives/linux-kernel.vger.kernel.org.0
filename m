Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5653357ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0I72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 04:59:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfF0I71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UdPPM47sb/7Te8Jd7ck1t2jr+yk4nMMu5ZlyAWmGh4U=; b=pCvMyR8x4xw/hpNND5pi6MT+z
        DChsNg0OC2A6xPjQglftVfoAF4un8V3nmOVaoBXcFNKvQz3NIkKGGWGL30JD1JzLR6/9MfQTGyjh6
        xgB0rtNfvOKIappaoRDipmrdZDe8fb6xizO366dxdMjiwZeGLwourt0J4cz87Mmxbjc7yt1leiQ2t
        vEm8R0fnCpFjRVSfFK/XW3uytPtRZIntRLxyqmjzJZ3KEhgyrAU6uwx6UvjcbmgLM4sBRdorbP0cR
        17K25/odK7fVGUFkfkxN1gXaXTpiBzWX5OmNaaWZSI8SnWkpXlxn0zMQNQBGkkEtFhQyyEVqMNtX0
        y19HFkpyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgQFa-0006As-NS; Thu, 27 Jun 2019 08:59:26 +0000
Date:   Thu, 27 Jun 2019 01:59:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH] riscv: ccache: Remove unused variable
Message-ID: <20190627085926.GA15810@infradead.org>
References: <1561624486-22867-1-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561624486-22867-1-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 02:04:46PM +0530, Yash Shah wrote:
> Reading the count register clears the interrupt signal. Currently, the
> count registers are read into 'regval' variable but the variable is
> never used. Therefore remove it.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/mm/sifive_l2_cache.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Unrelated note:  that driver absolutely does not belong into
arch/riscv/mm.  arch/$(ARCH)/mm is for architecte-specific memory
management code, not for random drivers.
