Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA58A2C941
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1OuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 10:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfE1OuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:50:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4118E2081C;
        Tue, 28 May 2019 14:50:04 +0000 (UTC)
Date:   Tue, 28 May 2019 10:50:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190528105002.5951dbbd@gandalf.local.home>
In-Reply-To: <20190528144328.6wygc2ofk5oaggaf@treble>
References: <cover.1558569448.git.mhelsley@vmware.com>
        <20190528144328.6wygc2ofk5oaggaf@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 09:43:28 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Thanks for the patches.  This looks like a good step in the right
> direction.

Good to hear.

> 
> What's the performance difference between the old recordmcount and the
> new version which relies on elf_open()?  It would be useful to compare
> kernel build times, before and after.

I'll let Matt answer these.

> 
> Would it be feasible to eventually combine subcommands so that objtool
> could do both ORC and mcount generation in a single invocation?  I
> wonder what what the interface would look like.

That is actually the goal of this work. To eventually be able to do
single passes to accomplish multiple tasks.

-- Steve
