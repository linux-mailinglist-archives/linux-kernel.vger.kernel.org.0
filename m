Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20F3DEDCC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfJUNiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfJUNiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:38:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9394520873;
        Mon, 21 Oct 2019 13:38:13 +0000 (UTC)
Date:   Mon, 21 Oct 2019 09:38:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 00/16] Rewrite x86/ftrace to use text_poke (and more)
Message-ID: <20191021093812.72b071c4@gandalf.local.home>
In-Reply-To: <20191021090922.GA41231@gmail.com>
References: <20191018073525.768931536@infradead.org>
        <20191021090922.GA41231@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 11:09:22 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> Steve, any objections to this series? If not I'll stick it into 
> tip:core/kprobes with a tentative v5.5 upstream merge target.

I'm going to be doing work this merge window that is going to be
directly conflicting with a lot of changes in this series. If one of us
can simply have a separate branch with just this series based off of
v5.4-rc3, it would work better.

I could add it to mine, or for you. But I would still need to test this
in my code first. Peter's last series failed my test suite.

-- Steve
