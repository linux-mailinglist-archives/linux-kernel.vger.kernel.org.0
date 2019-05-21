Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0364E2525B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfEUOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfEUOmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:42:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2E02173E;
        Tue, 21 May 2019 14:42:06 +0000 (UTC)
Date:   Tue, 21 May 2019 10:42:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Johannes Erdfelt <johannes@erdfelt.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@redhat.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Oops caused by race between livepatch and ftrace
Message-ID: <20190521104204.47d4e175@gandalf.local.home>
In-Reply-To: <20190521141629.bmk5onsaab26qoaw@treble>
References: <20190520194915.GB1646@sventech.com>
        <90f78070-95ec-ce49-1641-19d061abecf4@redhat.com>
        <20190520210905.GC1646@sventech.com>
        <20190520211931.vokbqxkx5kb6k2bz@treble>
        <20190520173910.6da9ddaf@gandalf.local.home>
        <20190521141629.bmk5onsaab26qoaw@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 09:16:29 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > Hmm, this may blow up with lockdep, as I believe we already have a
> > locking dependency of:
> > 
> >  text_mutex -> ftrace_lock
> > 
> > And this will reverses it. (kprobes appears to take the locks in this
> > order).
> > 
> > Perhaps have live kernel patching grab ftrace_lock?  
> 
> Where does kprobes call into ftrace with the text_mutex?  I couldn't
> find it.

Hmm, maybe it doesn't. I was looking at the arm_kprobe_ftrace() but
it doesn't call it with text_mutex().

Maybe it is fine, but we had better perform a lot of testing with
lockdep on to make sure.

-- Steve
