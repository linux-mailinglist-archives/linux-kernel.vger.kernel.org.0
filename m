Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70A683798
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbfHFRD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 13:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733011AbfHFRD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:03:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B2420717;
        Tue,  6 Aug 2019 17:03:25 +0000 (UTC)
Date:   Tue, 6 Aug 2019 13:03:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch
 in arm64
Message-ID: <20190806130323.7075c3da@gandalf.local.home>
In-Reply-To: <20190806123455.487ac02b@gandalf.local.home>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
        <20190802112259.0530a648@gandalf.local.home>
        <20190802120920.3b1f4351@gandalf.local.home>
        <20190802121124.6b41f26a@gandalf.local.home>
        <20190806154811.GB39951@google.com>
        <20190806123455.487ac02b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 12:34:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Here's the best way to explain this. The code is using the stack trace
> to figure out which function is the stack hog. Or perhaps a serious of

 Why so serious? ....  s/serious/series/

-- Steve

> stack hogs. On x86, a call stores the return address as it calls the
> next function. Then that function allocates its stack frame for its
> local variables and saving of registers.

