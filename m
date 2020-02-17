Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE1160C14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 09:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBQIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 03:01:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBQIBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1j0IAc2wKeBPF3EDz/FuH2CGkeuAUIMTXnv9GxQihUQ=; b=laCY6zS4mQ2Zr6pPzTz9RMFkPB
        aq8u9QwyM12JK66Qndh5ysuDQT7YWdhal6HppCLdRfq3RhQqRLZxwf9Avtnn7LNvVj9bTA86gRZZs
        2pf0IzYRg3HLSEaeXkZsmqsrMm5Fs88MQKNUi96ntO0mwoONxQiBMwNwW3MoXzOkNNymMAm/dGay4
        dq1XRT3QEbhhVjP/XZbC3NpOIsOcXBTmZi5aYofeKm/4Aeax/thgKzJyKt0MS8IsakXXUfnvLsiHv
        qbf9ZH8eHtvTZnRsnlfzBxI95QKxO7++DDhYiGA4cHVMMAIeOzwUXs94ubm56ew/gL4fgrpDNAF08
        szEHi0kQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3bLW-0004e0-MJ; Mon, 17 Feb 2020 08:01:38 +0000
Date:   Mon, 17 Feb 2020 00:01:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Liam Mark <lmark@codeaurora.org>, joro@8bytes.org,
        pratikp@codeaurora.org, kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200217080138.GB10342@infradead.org>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
> From: Liam Mark <lmark@codeaurora.org>
> 
> Some devices have a memory map which contains gaps or holes.
> In order for the device to have as much IOVA space as possible,
> allow its driver to inform the DMA-IOMMU layer that it should
> not allocate addresses from these holes.

Layering violation.  dma-iommu is the translation layer between the
DMA API and the IOMMU API.  And calls into it from drivers performing
DMA mappings need to go through the DMA API (and be documented there).
