Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55119146E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgCXP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:29:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgCXP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GEjRdfenMkp63VsokJpuSg83pLCvxbzC2FSqWHEQYfw=; b=OFGVUo5vk4dxUpApdVZkU8BtaQ
        SbDb4U6h4H8vwFCpBn0PUrNHWxpN2fsX3UasbiraFLSez4i3h4GGz4JxJA/7MJxTDTECX2ZPeQVoH
        jz7VnRWd6YKNJ8jHWNKOTJrOw1sgctncU3s5nYKrMNv6uyPvLPJHY24NSXSQxJ0++79MJKkYw5uA0
        p62F6zJ76k2Gncl+vao/z3heX66E/axz1gEnUkW3WrU0JZb/oTFYevV6WNnUOg5VQ+XekCiY7ORZK
        Ziq2cBiJ9doK25+WQxYl+tC5jwNh8GcI0Ef4xXBgruJG9aVMzvljAEeJ8uxN3Wk0fUrJdZ2PbPky+
        H8wRMSTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGlUK-0005MB-BP; Tue, 24 Mar 2020 15:29:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADD1D300235;
        Tue, 24 Mar 2020 16:29:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E93029A490F3; Tue, 24 Mar 2020 16:29:05 +0100 (CET)
Date:   Tue, 24 Mar 2020 16:29:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v2] lib/refcount: Document interaction with PID_MAX_LIMIT
Message-ID: <20200324152905.GR20696@hirez.programming.kicks-ass.net>
References: <20200303105427.260620-1-jannh@google.com>
 <20200317222717.GF20788@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317222717.GF20788@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:27:18PM +0000, Will Deacon wrote:

> Acked-by: Will Deacon <will@kernel.org>
> 
> Peter -- would you be able to take this through -tip, please?

Got it, I'll stick it in locking/core.

Thanks!
