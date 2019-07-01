Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58BA56D51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfFZPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 11:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfFZPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:08:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299CC2080C;
        Wed, 26 Jun 2019 15:08:49 +0000 (UTC)
Date:   Wed, 26 Jun 2019 11:08:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
Message-ID: <20190626110847.2dfdf72c@gandalf.local.home>
In-Reply-To: <20190621235955.GK26519@linux.ibm.com>
References: <20190619011908.25026-1-swood@redhat.com>
        <20190619011908.25026-5-swood@redhat.com>
        <20190620211826.GX26519@linux.ibm.com>
        <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
        <20190621235955.GK26519@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 16:59:55 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> I have no objection to the outlawing of a number of these sequences in
> mainline, but am rather pointing out that until they really are outlawed
> and eliminated, rcutorture must continue to test them in mainline.
> Of course, an rcutorture running in -rt should avoid testing things that
> break -rt, including these sequences.

We should update lockdep to complain about these sequences. That would
"outlaw" them in mainline. That is, after we clean up all the current
sequences in the code. And we also need to get Linus's approval of this
as I believe he was against enforcing this in the past.

-- Steve
