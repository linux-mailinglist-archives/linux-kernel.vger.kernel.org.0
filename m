Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8351050116
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 07:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfFXFnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 01:43:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFXFnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G+0O3j+cgCRbigr/X4MIfnZa4yWmCGHY98UjePy9hlI=; b=WnxrlYY91HMHTqus7NTc7TkvF
        mDPWku21XSxCKeAPWG/rATrzM+mOEukkUC/aepN9oWr4+USpYvA6rpAheJljOmRzQv4Fosq0IXzQ5
        /lR09sihl/AgaGkaKRV8KZ8qt+O/HskRSKeBwYzk/8zosnQmWPGzXDAlZlrhivb2Ac9As7JAEwRNJ
        azOD6kksRz/fZE0Xp3xOqBk9GkUgfdaz3LB3v81wBIAkvvg+0PxRQ7uMYCsFgPJv5SXT1g+IOC/KD
        cbyUJ+5yxKazc4N530ff+eGFiHIO6qnd842pID0hlRpAQzqQiX+fvlTTJg6I++Na6SvSjjsEUibBz
        zXKRYKCwQ==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHl5-00063u-7r; Mon, 24 Jun 2019 05:43:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: RISC-V nommu support v2
Date:   Mon, 24 Jun 2019 07:42:54 +0200
Message-Id: <20190624054311.30256-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

below is a series to support nommu mode on RISC-V.  For now this series
just works under qemu with the qemu-virt platform, but Damien has also
been able to get kernel based on this tree with additional driver hacks
to work on the Kendryte KD210, but that will take a while to cleanup
an upstream.

To be useful this series also require the RISC-V binfmt_flat support,
which I've sent out separately.

A branch that includes this series and the binfmt_flat support is
available here:

    git://git.infradead.org/users/hch/riscv.git riscv-nommu.2

Gitweb:

    http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.2

I've also pushed out a builtroot branch that can build a RISC-V nommu
root filesystem here:

   git://git.infradead.org/users/hch/buildroot.git riscv-nommu.2

Gitweb:

   http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu.2

Changes since v1:
 - fixes so that a kernel with this series still work on builds with an
   IOMMU
 - small clint cleanups
 - the binfmt_flat base and buildroot now don't put arguments on the stack
