Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8D140D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 16:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAQPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 10:01:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49546 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgAQPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Iq+2hoOfAjJVr5oEP3w7VPKwQKmqV59r0gbPlS7qwIc=; b=kpOTFK0J6C7jqIgw1bodTNTdd
        7r3b399xPJ10xAWH8zJ9MF/h5ET7fYKJehQHn+V1OxFfkQ6i24TjIFo6KW90p20DW3Q7xJ4IZvlFg
        +HY0xuI+wIKImplUvqK5v/qDnj1Y161o00u72+LVH2lNfYIBokvk17CiKl15KC19udH+8qZLfrefm
        il+nTICMtEFISE75FUxp4iqexfBC/q2UhM5LKIyn0N7rP3yIVoYdGN4gi2VntcxpsRuIl/rnavrCd
        rIvdV1AGxRj/2fCRcKBjYaDb9LE2Ji4v5IEDdZulnhCRVspxEmVCXxP0EntgVUfLVpLEDzRvbYBO5
        UKSba3bzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isT7I-0000S6-9p; Fri, 17 Jan 2020 15:00:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7ABE7304123;
        Fri, 17 Jan 2020 15:59:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC48A2025EDA1; Fri, 17 Jan 2020 16:00:54 +0100 (CET)
Date:   Fri, 17 Jan 2020 16:00:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] smp: Avoid memory allocation in on_each_cpu_cond()
Message-ID: <20200117150054.GF14879@hirez.programming.kicks-ass.net>
References: <20200117090137.1205765-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117090137.1205765-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:01:34AM +0100, Sebastian Andrzej Siewior wrote:
> x86 is using on_each_cpu_cond_mask() in native_flush_tlb_others() in a
> preempt disabled section. The memory allocation in
> on_each_cpu_cond_mask() gives me a headache on RT.
> This is an attempt to get rid of the memory allocation and potentially
> accelerating the code path :)

Looks good to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


