Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223AFA61CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfICGv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 02:51:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfICGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=on1uS5ivzDuDh9bGgt6qOTnzv59PRDx52jliN2T4+Mo=; b=D0b65z2+nz0bUijDBcAL7blia
        KGLhVDc4Bdpo5lTzExmOhVr6xcJ2Q+FEcYmgis7Z+mT3YXjEKHrdOE6xtmUosvth6cQmx351LlTdX
        Oie7o3eEP0PPc3WI2mZgGxxG+SIeSAg4YcnUPvAbSEaU3tM2CKCOt3mPf//OU3S/2b4EyCcExd5iE
        MVatl0Xr+stxlGWhhU1eIa3vDxYN2DMNOU/2dDuWoopMnSmuO6xBYiS8tGW/ui5HecpjB3+/EYHJJ
        7mBAXGBk124z43eTlwevOFs8Xwhu/p8WDiozAB2gIVMbf6UFZKqvb2b33/tNQ3haEPeGPhb8ip4VS
        l59g+y2lA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i52fT-0007ew-Ft; Tue, 03 Sep 2019 06:51:55 +0000
Date:   Mon, 2 Sep 2019 23:51:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, aarcange@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk
Subject: Re: [dm-devel] [PATCH] sched: make struct task_struct::state 32-bit
Message-ID: <20190903065155.GA28322@infradead.org>
References: <20190902210558.GA23013@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902210558.GA23013@avx2>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:05:58AM +0300, Alexey Dobriyan wrote:
> 32-bit accesses are shorter than 64-bit accesses on x86_64.
> Nothing uses 64-bitness of ->state.
> 
> Space savings are ~2KB on F30 kernel config.

I guess we'd save even more when moving from a volatile to
WRITE_ONCE/READ_ONCE..
