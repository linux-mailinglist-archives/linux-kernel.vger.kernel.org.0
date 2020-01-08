Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3CD134591
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgAHPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:03:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ppqb3Wp/gf4Q4tqZUSJSDae4OnfNUVnoxhAaiYKQ2ck=; b=KRs5WCbLcfiHmTUfCmKp3nlX9
        47ilezpOg0Vmt06034zz8IPdk3j+GHXExG9s9hza8nOhBlzQWa6SX4dVxbajuk5DcSZWO/iEuQa6S
        XNjBDW3n20qMRx5Bfdq5wPTs9bxH3G9UOuOPsP85bJ5ejy3g3VHsZ9oQIPQH2kumzT2hS7QTy0gy7
        dkZD6+UJk5qjnimvoEjELL5LKxecbzIiForY3HN7neVbmmvksUKGBHwI3YbNPsL6UHa8QEScL2VmQ
        OzzkoQlpyU5LIcrM4y9ReTGA6F4dFuJFEyt6wxUJIavnaHyWSTNc/76M1LyN7p2bzei4kJT1t6jY1
        mXI/bGO7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipCrZ-0003Fs-4l; Wed, 08 Jan 2020 15:03:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F8003012C3;
        Wed,  8 Jan 2020 16:01:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 726312B613C3A; Wed,  8 Jan 2020 16:03:11 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:03:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] tracing: Initialize ret in syscall_enter_define_fields()
Message-ID: <20200108150311.GA2827@hirez.programming.kicks-ass.net>
References: <20200108085755.535e7362@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108085755.535e7362@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 08:57:55AM -0500, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If syscall_enter_define_fields() is called on a system call with no
> arguments, the return code variable "ret" will never get initialized.
> Initialize it to zero.
> 
> Link: https://lore.kernel.org/r/0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw
> Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks Steve!
