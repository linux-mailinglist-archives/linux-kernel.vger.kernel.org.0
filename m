Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49A91DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 09:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfHSHcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 03:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfHSHcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:32:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358142086C;
        Mon, 19 Aug 2019 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566199973;
        bh=2lDcf3QQwVsKtMhMZhdAAuqPtLzNgs151JSGDBAUuzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6tRAlCEy9T9B1f/Fr8dqhepWZ75Fhl8VQaANcZGYdzMgTqJwFcqVlTLJy909tybu
         RPrW2ST42+f3cgF7RF1ZGbkSknGDDVoqX/qyb5n7MDo/L7aDS8rJjVyvjCsgexBYmi
         MajDi6YVzh9HEPWR+mvVck/OTqThG4PCoWxxK8k4=
Date:   Mon, 19 Aug 2019 08:32:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] arm64: use asm-generic/dma-mapping.h
Message-ID: <20190819073248.wtmnnl3mkjososvc@willie-the-truck>
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816130013.31154-12-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 03:00:13PM +0200, Christoph Hellwig wrote:
> Now that the Xen special cases are gone nothing worth mentioning is
> left in the arm64 <asm/dma-mapping.h> file, so switch to use the
> asm-generic version instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/Kbuild        |  1 +
>  arch/arm64/include/asm/dma-mapping.h | 22 ----------------------
>  arch/arm64/mm/dma-mapping.c          |  1 +
>  3 files changed, 2 insertions(+), 22 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/dma-mapping.h

Acked-by: Will Deacon <will@kernel.org>

Thanks for cleaning this up.

Will
