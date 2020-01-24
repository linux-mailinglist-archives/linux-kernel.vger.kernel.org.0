Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CEC148B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgAXPiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388566AbgAXPiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:38:24 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707432071E;
        Fri, 24 Jan 2020 15:38:23 +0000 (UTC)
Date:   Fri, 24 Jan 2020 10:38:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 1/2] sched: migrate_enable: Use per-cpu cpu_stop_work
Message-ID: <20200124103822.76ab320f@gandalf.local.home>
In-Reply-To: <1579864307-13093-1-git-send-email-swood@redhat.com>
References: <1579864307-13093-1-git-send-email-swood@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 06:11:46 -0500
Scott Wood <swood@redhat.com> wrote:

> Commit e6c287b1512d ("sched: migrate_enable: Use stop_one_cpu_nowait()")
> adds a busy wait to deal with an edge case where the migrated thread
> can resume running on another CPU before the stopper has consumed
> cpu_stop_work.  However, this is done with preemption disabled and can
> potentially lead to deadlock.
> 
> While it is not guaranteed that the cpu_stop_work will be consumed before
> the migrating thread resumes and exits the stack frame, it is guaranteed
> that nothing other than the stopper can run on the old cpu between the
> migrating thread scheduling out and the cpu_stop_work being consumed.
> Thus, we can store cpu_stop_work in per-cpu data without it being
> reused too early.
> 

Makes sense to me.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
