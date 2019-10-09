Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64FCD12D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfJIPdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 11:33:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a2E8wQcqj4G8crXfa0YqPMgIZwfuWHtwLVN/e+vZ4HE=; b=XAwyJP+LqYlbn6MjxvAf7Q1IR
        kTcINXVPquFWBaZ2KXNXiUZIvaejMGapAYR0NBh754itkLMBNDJMsZHMaD7XJKyZPKZRESbHohfGj
        c2UiJ1ZeVU/5soxZ5L8iBVp3K7NaU7XQGM94m9poiX2hFdCZkiW9k5QCpfZbnKUOBsGjhB7breygk
        YWCzcle/NVjkzOnO/a62brnETRmGECqovnAqfavLO0hwsHMvjrUjDZ+L+akS2ZlxLvAJAEKoVvaLN
        22qq34XKxeRt2iom75zv3fe0gTWL1B+MHRODF5Zl3Wxcl1hIWn2qQEf+18/cONJSTnce5/FoMarr/
        0e/bYqDJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIDxk-0006fF-L7; Wed, 09 Oct 2019 15:33:16 +0000
Date:   Wed, 9 Oct 2019 08:33:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: add kernel/fork.c function definitions
Message-ID: <20191009153316.GA25186@infradead.org>
References: <20191009140637.12443-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009140637.12443-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:06:37PM +0100, Ben Dooks wrote:
> Add the definitions of arch_release_task_struct,
> arch_task_cache_init and arch_dup_task_struct which
> are used in kernel/fork.c but defined in various
> architecture's <asm/thread_info.h>.

So please lift them into a common header.  In fact I'm pretty sure
I had that comment before when people did the same blind sparse
cleanups for riscv..
