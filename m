Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FDDCFCA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJHOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 10:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJHOni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:43:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E998520659;
        Tue,  8 Oct 2019 14:43:36 +0000 (UTC)
Date:   Tue, 8 Oct 2019 10:43:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191008104335.6fcd78c9@gandalf.local.home>
In-Reply-To: <20191007081945.10951536.8@infradead.org>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.10951536.8@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019 10:17:21 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Move ftrace over to using the generic x86 text_poke functions; this
> avoids having a second/different copy of that code around.
> 
> This also avoids ftrace violating the (new) W^X rule and avoids
> fragmenting the kernel text page-tables, due to no longer having to
> toggle them RW.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---


BTW, I'd really like to take this patch series through my tree. That
way I can really hammer it, as well as I have code that will be built
on top of it.

I'll review the other series in this thread, but I'm assuming they
don't rely on this series? Or do they?

-- Steve
