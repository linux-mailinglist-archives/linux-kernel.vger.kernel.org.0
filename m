Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1639633F10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 08:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfFDGl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 02:41:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFDGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vjr/lmR6UJzzcnF6AXERDVYqsON61Ko2MaI3KpSTt5c=; b=XZ6u6YnPtLoNWs9ZeAtKQum0G
        k+/MlF1yNO7EFFL+CtlKMftrX7z3fzu0NgNgDX46NPDqNj6W6pfoQLe9WenZ8D/6h56L/bXfajvfD
        g7WkpYuQX9su8Wb+9IOWUa2WHzXQyNMjakFCzb8B/4Bpx0Zca+3WyxD1EWSvSNYfhrTcBepdyFvnV
        wt5Ik9at1h3vH62p+nlMh5wW8smJzdnGOLBDROHxyrTIJPtXYb4V+RvJTToHI8VVXKwnunS5d5Bnu
        6gqF5LVA4AbVAF7T1HnzH5FAMJjPOWRrnljPajuDhW4d6hu6n5BJ18CvzppL66PXrTD4AqpgXIOHf
        eSbMm7o4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY38t-0005fV-57; Tue, 04 Jun 2019 06:41:55 +0000
Date:   Mon, 3 Jun 2019 23:41:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup.Patel@wdc.com, aou@eecs.berkeley.edu, schwab@suse.de,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, anup@brainfault.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
Message-ID: <20190604064155.GA21667@infradead.org>
References: <mhng-faba08ec-69a7-43b1-b2d7-c2e996751506@palmer-si-x1c4>
 <alpine.DEB.2.21.9999.1906030944170.9338@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1906030944170.9338@viisi.sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:44:44AM -0700, Paul Walmsley wrote:
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> 
> Thanks, queued for v5.3.

Where do you apply these patches to?  Is there a chance we could just
set up a multi commiter riscv tree insted of growing the number of
trees?
