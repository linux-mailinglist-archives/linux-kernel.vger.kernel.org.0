Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39B67CC106
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJDQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 12:45:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37384 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:45:44 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iGQi4-0007mf-0j; Fri, 04 Oct 2019 18:45:40 +0200
Date:   Fri, 4 Oct 2019 18:45:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
Message-ID: <20191004164539.bwxbpmsgqs4o4ysr@linutronix.de>
References: <20190917075943.qsaakyent4dxjkq4@linutronix.de>
 <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
 <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
 <20190923175233.yub32stn3xcwkaml@linutronix.de>
 <20190924112155.rxeyksetgqmer3pg@linutronix.de>
 <55dc19fcc44b2e658b71f68206306c8310335564.camel@redhat.com>
 <20190924152514.enzeuoo5a6o3mgqu@linutronix.de>
 <1a2234884e55e5ee6df5f32f828a99c1b248933f.camel@redhat.com>
 <20190924160554.5esplbmnzm4q4tew@linutronix.de>
 <b05494c96c039c348c0d3cb93d92fc1b77fe1dab.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b05494c96c039c348c0d3cb93d92fc1b77fe1dab.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-24 11:35:16 [-0500], Scott Wood wrote:
> 
> OK, sounds like stop_one_cpu_nowait() is the way to go then.

so I applied the last three patches from the migrate-disable() series
and it looks good. Nothing blew up in my testing.
There were no objects to the stop_one_cpu_nowait() suggestion and I
think that it is important not to lose the state at end.
Could you please repost the patches?

> -Scott

Sebastian
