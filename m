Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576A2150EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 18:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgBCRhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 12:37:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgBCRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:37:35 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iyffA-0005En-7p; Mon, 03 Feb 2020 18:37:32 +0100
Date:   Mon, 3 Feb 2020 18:37:32 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 1/2] sched: migrate_enable: Use per-cpu cpu_stop_work
Message-ID: <20200203173732.ldbgbpwao7xm23mm@linutronix.de>
References: <1579864307-13093-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1579864307-13093-1-git-send-email-swood@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-24 06:11:46 [-0500], Scott Wood wrote:
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
> Fixes: e6c287b1512d ("sched: migrate_enable: Use stop_one_cpu_nowait()")
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Scott Wood <swood@redhat.com>

Yes, perfect, thank you.

Sebastian
