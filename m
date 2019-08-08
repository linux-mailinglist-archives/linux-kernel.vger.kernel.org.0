Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867AD86733
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbfHHQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 12:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:36:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E61AE214C6;
        Thu,  8 Aug 2019 16:36:33 +0000 (UTC)
Date:   Thu, 8 Aug 2019 12:36:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiping Ma <jiping.ma2@windriver.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] tracing/arm64: Have max stack tracer handle the
 case of return address after data
Message-ID: <20190808123632.0dd1a58c@gandalf.local.home>
In-Reply-To: <20190808162825.7klpu3ffza5zxwrt@willie-the-truck>
References: <20190807172826.352574408@goodmis.org>
        <20190807172907.155165959@goodmis.org>
        <20190808162825.7klpu3ffza5zxwrt@willie-the-truck>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 17:28:26 +0100
Will Deacon <will@kernel.org> wrote:

> > + * Note, this may change in the future, and we will need to deal with that
> > + * if it were to happen.
> > + */
> > +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1  
> 
> I know it's long already, but prefixing this with FTRACE_ would be good so
> that other code doesn't use it for anything. It's not the end of the world
> if the ftrace stack usage statistics are wonky, but if people tried to use
> this for crazy things like livepatching then we'd be in trouble.
> 
> Maybe FTRACE_ARCH_FRAME_AFTER_LOCALS, which is the same length as what
> you currently have?

Note, it would still need to be prefixed with "ARCH_" as that's the way
of showing arch specific defines.

We could make it more descriptive of what it will do and not the reason
for why it is done...


  ARCH_FTRACE_SHIFT_STACK_TRACER

?

-- Steve
