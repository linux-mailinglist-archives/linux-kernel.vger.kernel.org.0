Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D89E7BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfJ1VxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 17:53:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1VxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GeAyw/k5dbilam+KBQ0S7G/ClcVIzyQAhc583Ygbdc4=; b=bKY4Vbdd47Pu5x+YdddkB39FW
        0ZYBjXmNPIDzknyDlEiAiuO643h+B3ONCWQR6sEJjhBiIGqnVbgAoZCUk0lqiJwlylqdwOaZEamex
        1FA91IGTrK9wxio9ui/6XW2z/7IRjaDu6w+Zs56XptKI6UPZx6pjdz4PxwQKebtZ947OSgPDagmUJ
        6ebIsi7/T/n3wfQhrCu3laOSBaKyf6L6vAPGAMtGleStFQXjTskKN58G6nkQtH08JlbIXLRdfEO3B
        lOzpn34DPvTUwE8sLJ/nGGqq1KUejoJCdItZzEwpifQ3X16K+2IYIHNVf9CUXxo0FqHqYvI1wHI41
        wQQkCzxMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPCwe-0002Fj-LD; Mon, 28 Oct 2019 21:53:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60170980D8F; Mon, 28 Oct 2019 22:52:58 +0100 (CET)
Date:   Mon, 28 Oct 2019 22:52:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/9] Consolidate {get,put}_unaligned_[bl]e24() definitions
Message-ID: <20191028215258.GO4643@worktop.programming.kicks-ass.net>
References: <20191028200700.213753-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028200700.213753-1-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:06:51PM -0700, Bart Van Assche wrote:
> Hi Peter,
> 
> This patch series moves the existing {get,put}_unaligned_[bl]e24() definitions
> into include/linux/unaligned/generic.h. This patch series also introduces a function
> for sign-extending 24-bit into 32-bit integers and introduces users for all new
> functions and macros. Please consider this patch series for kernel version v5.5.

While I applaud the effort (and didn't see anything off in a hurry), I do
wonder why you think I should route these patches.

I don't think I've ever touched the unaligned accessors...
