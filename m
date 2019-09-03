Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929EDA6252
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfICHNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 03:13:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfICHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LfXrvAJ7nQoeTC4iaVaz4jsSr8XCOc8hcyp+iKwf00M=; b=eOf6lWVqK21zIHGXt/TWiBnTs
        +fN6KCAkxPGpd9nxtFWJ/3assrkapeFAG3RV6G3fABwRmkOq3H6vxIqGOIUQITnkGuFrZjIc1bTmk
        3ehnqfXXcmhzDv7Yw8kBQtAbEyg0MpGXuMFCWIQ2ykiCy7AlIKoDQ8N41s9WVF7P/HQioY+E/agjp
        4L3cJUF2FN2YUXDXfI9JrrapycrScQxn+ub0uduaH5wedj2Aqk/ZaDtqRbgx5YmtdvoBNtqwHxO07
        pmlE3Q+9vWr5fDwa9Mp+I2tr//6Za09Mi4KK4quscbv04fHs+GJ56v0HrHEHmG5e0NlUFYxi/W5tH
        KICr3qrOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i530L-0000jr-Cj; Tue, 03 Sep 2019 07:13:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EDE8306010;
        Tue,  3 Sep 2019 09:12:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 594B529B9FF5D; Tue,  3 Sep 2019 09:13:26 +0200 (CEST)
Date:   Tue, 3 Sep 2019 09:13:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        aarcange@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk
Subject: Re: [dm-devel] [PATCH] sched: make struct task_struct::state 32-bit
Message-ID: <20190903071326.GV2369@hirez.programming.kicks-ass.net>
References: <20190902210558.GA23013@avx2>
 <20190903065155.GA28322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903065155.GA28322@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:51:55PM -0700, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 12:05:58AM +0300, Alexey Dobriyan wrote:
> > 32-bit accesses are shorter than 64-bit accesses on x86_64.
> > Nothing uses 64-bitness of ->state.
> > 
> > Space savings are ~2KB on F30 kernel config.
> 
> I guess we'd save even more when moving from a volatile to
> WRITE_ONCE/READ_ONCE..

I doubt it; pretty much all accesses really should be using that.

Not saying we shouldn't maybe do that; but that's going to be massive
churn.
