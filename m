Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC64D5EF79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfGCXFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 19:05:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfGCXFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=coQkLMKjijH/VoIpxmOMP2Tv/LPuLRus1VVk2ZdcuYw=; b=KPX2+IgE9oLBkxEZGniqI9YQMo
        mw6FFpY9KWKcv4FzevrbTQ45j68jdRQ5UGoOJwM/T1SPIIzZdFBMKTkQdsfkOogzKTgoPNmlohLad
        zKp6L+/7pNwKzUdV89O6XZPe00o0YW54GW9U4dBa7c9AzAFLYocnl4omSM+0HXVmPefqy3spN7aS6
        MVJCO+zt54oYwh9xoU2sa3klxyJ7Le7AxOl8rt9HyEidxW2pR5dza6c6Q3vVTdVNwAQAQzFS7cAnW
        cHAAF2n0qYNKkwlEhMnESD6M/avAlaHyppZRCf9y5DbJuyJoL2fIPJYo+Xqp2ScJuCjlgFne75Smi
        1vV564DQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hioJA-0001Ff-16; Wed, 03 Jul 2019 23:05:00 +0000
Date:   Wed, 3 Jul 2019 16:04:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Hugetlbfs support for riscv
Message-ID: <20190703230459.GA26830@infradead.org>
References: <20190701175900.4034-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190701175900.4034-1-alex@ghiti.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 01:58:58PM -0400, Alexandre Ghiti wrote:
>   - icache-hygiene succeeds after patch #3 of this series which lowers           
>     the base address of mmap.                                                    

I think іcache-hygiene will also need a call to riscv_flush_icache in
cacheflush().

