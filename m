Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AB12266A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLQIOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 03:14:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54682 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfLQIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:14:52 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ih80H-0000eO-Hv; Tue, 17 Dec 2019 09:14:49 +0100
Date:   Tue, 17 Dec 2019 09:14:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.21-rt15
Message-ID: <20191217081449.xsrfpma4frgynkmg@linutronix.de>
References: <20191216173416.2dcmfis4xza2dqf5@linutronix.de>
 <20191217044549.GB1363@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217044549.GB1363@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 20:45:49 [-0800], Richard Cochran wrote:
> On Mon, Dec 16, 2019 at 06:34:16PM +0100, Sebastian Andrzej Siewior wrote:
> > 
> >   - Since the migrate_disable() rework, with heave changing of the
> >     task's affinity mask the kernel could issue a warning in
> >     migrate_enable() and crash later.
> 
> What is "heave changing?"

Sorry. "heavy changing". You need to change the affinity mask of a task
very often and one requirement is that new affinity mask does not
contain a CPU on which the task is currently running.

> Just Curious,
> 
> Richard

Sebastian
