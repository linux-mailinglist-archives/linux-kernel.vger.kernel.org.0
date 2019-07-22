Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34D870859
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfGVSWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:22:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfGVSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iNsLtRvyzokpSrw8DHnhZFq3t2tRaf8XpQkMcs8pCNE=; b=BmjHyI3+zfBWVcXhzxKIKuTj7
        9DHqTllgVdy/fryEP9IXLmOrXnWg6Qz7Tr6RgZ7pc4yJSaW4uKJbLTQIOuzuJv6usdmy/BUKTbQBg
        uTKfzs0Id0NwMRxQqR1pj2DCOZ7sKIxYpNRGi9JC1aWx8iZ2a2e5ZkYKYzqPMgWNsOg9KDuM/ggZG
        cYBmBGmigv/Z+BkwKaB6cmTFD3MH+L+7qrQhpNO6kxbkLjcfVasZh4kbS61sdft5BvdeNR0KbReMU
        svTETFCiv/mfkFlvwUYuiir99F3molqm3BsZ7pPRfkkVnA5gw9oinvCsrlOxSnIA7wzGJeuuJQr9V
        8x3F4D0kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpcwj-0008Fl-NN; Mon, 22 Jul 2019 18:22:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 321B9980D20; Mon, 22 Jul 2019 20:21:59 +0200 (CEST)
Date:   Mon, 22 Jul 2019 20:21:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Message-ID: <20190722182159.GB6698@worktop.programming.kicks-ass.net>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719005837.4150-2-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:58:29PM -0700, Nadav Amit wrote:
> +/*
> + * Call a function on all processors.  May be used during early boot while
> + * early_boot_irqs_disabled is set.
> + */
> +static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
> +{
> +	on_each_cpu_mask(cpu_online_mask, func, info, wait);
> +}

I'm thinking that one if buggy, nothing protects online mask here.
