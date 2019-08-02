Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64E47F7BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbfHBNDY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Aug 2019 09:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389446AbfHBNDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:03:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A4D20657;
        Fri,  2 Aug 2019 13:03:22 +0000 (UTC)
Date:   Fri, 2 Aug 2019 09:03:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiping Ma <Jiping.Ma2@windriver.com>
Cc:     Will Deacon <will@kernel.org>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <joel@joelfernandes.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] tracing: Function stack size and its name mismatch
 in arm64
Message-ID: <20190802090320.728f133b@gandalf.local.home>
In-Reply-To: <47e90170-e971-c2f5-b6c9-d3c6a694a4a7@windriver.com>
References: <20190801083340.57075-1-jiping.ma2@windriver.com>
        <20190801094156.emo36ekvrm74nndl@willie-the-truck>
        <47e90170-e971-c2f5-b6c9-d3c6a694a4a7@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 10:43:03 +0800
Jiping Ma <Jiping.Ma2@windriver.com> wrote:

> > *Why* does the frame appear to be off-by-one?  
> Because the PC is LR in ARM64 stack actually.  Following is ARM64 stack 
> layout. Please refer to the figure 3 in 
> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
>              LR
>              FP
>              ......
>              LR
>              FP

And the LR holds the return address, right? Which would be identical to
x86 and every other arch I know about.

-- Steve
