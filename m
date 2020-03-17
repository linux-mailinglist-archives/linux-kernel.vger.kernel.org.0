Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13DC188751
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCQOUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgCQOUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:20:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F219F20663;
        Tue, 17 Mar 2020 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584454807;
        bh=81eiJdXGSeSdSUTJSi4UoZ5QzsjMfTcyTsc3DFzadK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K4Yit6psvLhwuHtCblEDEcWMPg5sMuNwLnsZbdgVWnAYX1g5XKKhClYQSEqgaX5iD
         7nemAjZdM0fDTDi939z2nu7z4AvI/jFmKuFjv8VOTEOpMj9KxuiKbVPHOzkSzWzwWu
         M8hJmKz7VORW9mI6kD3xSPtaTxYc7G1GB8NbL0I4=
Date:   Tue, 17 Mar 2020 23:20:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Message-Id: <20200317232003.b24aa5575ad9d5fd02978a92@kernel.org>
In-Reply-To: <87h7yncox2.fsf@nanos.tec.linutronix.de>
References: <20200312134107.700205216@infradead.org>
        <20200312162337.GU12561@hirez.programming.kicks-ass.net>
        <20200317095628.4f3690afe24e059a146a4b6f@kernel.org>
        <87h7yncox2.fsf@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 10:26:49 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Masami Hiramatsu <mhiramat@kernel.org> writes:
> > BTW, out of curiously, if BUG*() or WARN*() cases happens in the noinstr
> > section, do we also need to move them (register dump, stack unwinding,
> > printk, console output, etc.) all into noinstr section?
> 
> The current plan is to declare BUG()/WARN() "safe". On x86 it is kinda
> safe as it uses UD2. That raises an exception which handles the bug/warn
> after establishing the correct state.

OK, so at least the entry of BUG()/WARN() is in noinstr, but the
register/stack dump routines are out of noinstr.

> 
> Of course it's debatable, but moving all of this into the noinstr
> section might be just a too wide scope.

Agreed.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
