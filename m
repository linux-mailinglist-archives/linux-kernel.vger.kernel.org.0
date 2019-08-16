Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA66D90998
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfHPUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 16:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfHPUtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:49:18 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC602077C;
        Fri, 16 Aug 2019 20:49:16 +0000 (UTC)
Date:   Fri, 16 Aug 2019 16:49:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190816164912.078b6e01@oasis.local.home>
In-Reply-To: <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
        <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
        <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 16:44:10 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:


> I am also more on the side of using *_ONCE. To me, by principal, I
> would be willing to convert any concurrent plain access using _ONCE,
> just so we don't have to worry about it now or in the future and also
> documents the access.
> 
> Perhaps the commit message can be reworded to mention that the _ONCE
> is an additional clean up for safe access.

The most I'll take is two separate patches. One is going to be marked
for stable as it fixes a real bug. The other is more for cosmetic or
theoretical issues, that I will state clearly "NOT FOR STABLE", such
that the autosel doesn't take them.

-- Steve
