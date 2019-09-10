Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C0AE38D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 08:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390888AbfIJGOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 02:14:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732405AbfIJGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7TXIIMwoeNOGkBus96rW/ILkUUIZ1n6lcY8LITl7CcM=; b=SM5KyUjIobocnpvNTYqJRjUhn
        xXKkELvmEHNpEWuksikJ1mTbDu98MgepMUOUMvBSYCfXNC72NvFwMM+rEBe4lhtqPFz9yOhuHyQKS
        scUTK4i+6czGYe4o5Asn6F1bQCRp6KHCVMpNNp5RrGypz1hcdglaXbF5JPqTYUHwIT32t+B83jGCJ
        KKQd/paSm8T8SXB2/rHZ96UjZhaHVmX5Y3qXudGRVC9u5U/U2pbDmYnPtFWhv6jRkx5bS6b0Zqn9z
        Eiwu/DZVrHTviHID/8PA/iE02iOTdYTqIKcJUsCpelB0BNeWXXmAEjT8DmFo27qEev3hSssJabdvY
        ph2pvuvoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ZQP-0005wJ-51; Tue, 10 Sep 2019 06:14:49 +0000
Date:   Mon, 9 Sep 2019 23:14:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: dts: sifive: Add ethernet0 to the aliases node
Message-ID: <20190910061449.GC10968@infradead.org>
References: <1567687574-22436-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567687574-22436-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 05:46:14AM -0700, Bin Meng wrote:
> U-Boot expects this alias to be in place in order to fix up the mac
> address of the ethernet node.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
