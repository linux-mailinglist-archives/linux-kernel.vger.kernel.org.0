Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D124826
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 08:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfEUGfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 02:35:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUGfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y2HthqbKJ5tpIQEWIxiqJg+rxHqmp9am5kD1f26lsGM=; b=r+RQQXmPtMb9GvZG+TsBzrBlz
        N0EIkBZvrgxm+kw+U8wNUgd7iL9+WhQ14Qwf/evHOLeYF3ogmE39f5blqOI+LuTTyhsxWO1/rCKKv
        /UB5XtWSjObMUM60A4jsZDRyi0TVSzzrluMlCWFZ7nyWa1AGoA5FMehOkZr7b8QttqMOSTvjGQkaY
        2zFCntwYULG4h9cZIWhjqUnLmLkg5yXtmmSYJmNI3dTYdcrgUOQPnp9eqQ6TRpz4zl6vNTCyhIHDZ
        vStEx8BOOTR5uzOC/VL8MW1uwtbCQ9+qRe52n3rW3ecr9iOq2vLidiTQUamwoys16XsO6NIxFU8UP
        3jmK4qX6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSyNL-00052s-Kj; Tue, 21 May 2019 06:35:51 +0000
Date:   Mon, 20 May 2019 23:35:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH] riscv: include generic support for MSI irqdomains
Message-ID: <20190521063551.GA5959@infradead.org>
References: <20190520182528.10627-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520182528.10627-1-paul.walmsley@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:25:28AM -0700, Paul Walmsley wrote:
> Some RISC-V systems include PCIe host controllers that support PCIe
> message-signaled interrupts.  For this to work on Linux, we need to
> enable PCI_MSI_IRQ_DOMAIN and define struct msi_alloc_info.  Support
> for the latter is enabled by including the architecture-generic msi.h
> include.
> 
> Based on a patch from Wesley Terpstra <wesley@sifive.com>:
> 
> https://github.com/riscv/riscv-linux/commit/7d55f38fb79f459d2e88bcee7e147796400cafa8
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Wesley Terpstra <wesley@sifive.com>

Well, this is very much Wes' patch as-is.  It should probably be
attributed to him and you should ask for his signoff.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
