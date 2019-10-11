Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5253ED3DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 12:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfJKKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 06:47:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a9/2VGeLnRRi35YmZhE0rouXiWagsNk2lJpliT2cEcA=; b=JjXevuOdMXBRkOmTXcphovYpz
        D/NHu+GI/W+Aj0b1bUkoAi4m4fX8k3UKAXfTOWnx3vJFgcqsMvArBup8YNl8IApa86chDk6cI+jZ0
        D+7m+YhVkBzdeIseTE4eYacrAeMQO2BauissKc5riJHr4ibsPmIoQK8YKOwXDNGbImI215wfuFw6I
        uRnoRfxDCoFJvZ1ebYqlWirPY6nDEx483i3dN5Y3nHkTuvDEtSns9BgscDFAS7UCdI3s8v0V+6hHe
        sdaXNnl8XlVmV2666hA865sqBDI0OXmlweFvBn2GOjgLBkjPeLnGIZJ1tY262ciJMPG1acLJCw5mq
        3bbr5SVDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsS2-0000K7-CJ; Fri, 11 Oct 2019 10:47:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C4EA30025A;
        Fri, 11 Oct 2019 12:46:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37B8C201F7DBB; Fri, 11 Oct 2019 12:47:12 +0200 (CEST)
Date:   Fri, 11 Oct 2019 12:47:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191011104712.GL2359@hirez.programming.kicks-ass.net>
References: <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191010134830.72ccef3d@gandalf.local.home>
 <20191011104552.GW2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011104552.GW2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:45:52PM +0200, Peter Zijlstra wrote:
> +	if (!ops->trampoline) {
> +		ops->trampoline = create_trampoline(ops, &size, ftrace_ops_get_func(ops));

And now that I look at what I send, I see we already pass ops, so no
need to pass ftrace_ops_get_func().

Let me respin that.
