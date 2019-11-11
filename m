Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4130BF713B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKJzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 04:55:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rspyj690RUkkwXzYJ611rHdR3zry7VQFe2AxDbxDS7k=; b=sPK2QtHJHCBxmWz+kVgU+81rE
        kRQ0TNnzSGrft+I/spQLqKs/b3+afVFvToUX7usehBZ/BzfkTWPQ49/JR5CKe6j2Jc13nTOKvqPHP
        IKMXqeBHKg0qLd38HKgeKVBDxMAVnImafqHuEVdDSzrbYq0yDD1oxZHBoeAZaLAw6PYAicxJakiN1
        NLqRfPFN8Gfy2v8MB3Cvis9+/u1LEbKo5tkeWcdtY4cc0rIBI7eanXy6h9sF7ZV4qoKKfaoNSk5Sn
        GDwHPORfSKu8MA5Cueqmsu6N2OmbmR4o745lTGMz11BXwu6EXz+4U4IJ67JDDHVwRBXpF5bfXjqkN
        n6NFbCDcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iU6QE-0007ZE-93; Mon, 11 Nov 2019 09:55:46 +0000
Date:   Mon, 11 Nov 2019 01:55:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org,
        hch@infradead.org
Subject: Re: [PATCH v3] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
Message-ID: <20191111095546.GA23301@infradead.org>
References: <1573203640-6173-1-git-send-email-zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573203640-6173-1-git-send-email-zong.li@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 01:00:40AM -0800, Zong Li wrote:
> The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
> defined.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
