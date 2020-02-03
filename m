Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83118150494
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 11:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBCKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 05:52:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBCKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:52:04 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iyZKd-00082i-Px; Mon, 03 Feb 2020 11:51:55 +0100
Date:   Mon, 3 Feb 2020 11:51:55 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH -v2 0/7] locking: Percpu-rwsem rewrite
Message-ID: <20200203105155.zg2facrg344uyfzn@linutronix.de>
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200131150703.194229898@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-31 16:07:03 [+0100], Peter Zijlstra wrote:
> Hi all,
> 
> This is the long awaited report of the percpu-rwsem rework (sorry Juri).
> 
> IIRC (I really have trouble keeping up momentum on this series) I've addressed
> all previous comments by Oleg and Davidlohr and Waiman and hope we can stick
> this in tip/locking/core for inclusion in the next merge.
> 
> It has been cooked (thoroughly) in PREEMPT_RT, and not found wanting.

I did not suck it into -RT earlier since it look like work-in-progress
(based on the review). Now if you feel confident, I will suck it in.

Thank you.

> Any objections to me stuffing it in so we can all forget about it properly?

Sebastian
