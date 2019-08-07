Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20878513A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 18:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfHGQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 12:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfHGQkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:40:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638A72229C;
        Wed,  7 Aug 2019 16:40:15 +0000 (UTC)
Date:   Wed, 7 Aug 2019 12:40:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] tracing: Document the stack trace algorithm in the
 comments
Message-ID: <20190807124013.4ced2f81@gandalf.local.home>
In-Reply-To: <20190807163454.392141426@goodmis.org>
References: <20190807163401.570339297@goodmis.org>
        <20190807163454.392141426@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Aug 2019 12:34:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

> + * To fix this, if the architecture sets ARCH_RET_ADDR_AFTER_LOCAL_VARS the
> + * values in stack_trace_index[] are shifted by one to and the number of
> + * stack trace entries is decremented by one.
> + *
> + *        stack_dump_trace[]        |   stack_trace_index[]
> + *        ------------------        +   -------------------
> + *  return addr to kernel_func_bar  |          20

That should have been 29, not 20. I'll update it.

-- Steve


> + *  return addr to sys_foo          |          19
> + *
> + * Although the entry function is not displayed, the first function (sys_foo)
> + * will still include the stack size of it.
> + */
>  static void check_stack(unsigned long ip, unsigned long *stack)
>  {
>  	unsigned long this_size, flags; unsigned long *p, *top, *start;

