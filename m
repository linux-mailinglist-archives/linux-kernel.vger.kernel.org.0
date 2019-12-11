Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDA11B269
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbfLKPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 10:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731642AbfLKPf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:35:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA8A22B48;
        Wed, 11 Dec 2019 15:35:58 +0000 (UTC)
Date:   Wed, 11 Dec 2019 10:35:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: ftrace histogram sorting broken on BE architecures
Message-ID: <20191211103557.7bed6928@gandalf.local.home>
In-Reply-To: <20191211123316.GD12147@stackframe.org>
References: <20191211123316.GD12147@stackframe.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 13:33:16 +0100
Sven Schnelle <svens@stackframe.org> wrote:

> Hi List,

Hi Sven,

> 
> i was looking into a ftracetest failure on s390:
> 
> # ./ftracetest test.d/trigger/trigger-hist.tc
> === Ftrace unit tests ===
> [1] event trigger - test histogram trigger	[FAIL]
> [2] (instance)  event trigger - test histogram trigger	[FAIL]
> 
> from the -vvv log: ++ fail 'sort param on sched_process_fork did not work'
> 
> # cat events/sched/sched_process_fork/hist
> 
> # event histogram
> #
> # trigger info: hist:keys=parent_pid,child_pid:vals=hitcount:sort=child_pid:size=2048 [active]
> #
> 
> { parent_pid:       1406, child_pid:       1428 } hitcount:          1
> { parent_pid:       1406, child_pid:       1430 } hitcount:          1
> { parent_pid:       1406, child_pid:       1427 } hitcount:          1
> { parent_pid:       1406, child_pid:       1432 } hitcount:          1
> { parent_pid:       1406, child_pid:       1431 } hitcount:          1
> { parent_pid:       1406, child_pid:       1429 } hitcount:          1
> 
> So the test is right, the entries are not sorted. After digging into the
> ftrace code i noticed that integer values always get extended to 64 bit
> in event_hist_trigger(), but cmp_entries_key() from tracing_map.c uses the
> type of the field (which is a pid_t, and therefore 4 bytes).
> 
> On Little Endian this doesn't hurt, but on BE s390 this makes the compare
> function compare 4 zero bytes, which is the reason why sorting doesn't
> work. As a test i forced the compare function used in cmp_entries_key() to
> tracing_map_cmp_s64(), which made the ftrace tests pass.
> 
> I also tested this on 64 bit parisc with the same results, so the architecture
> doesn't seem make a difference (besides LE vs. BE)
> 
> Any thoughts on how to fix this? I'm not sure whether i fully understand the
> ftrace maps... ;-)

Your analysis makes sense. I'll take a deeper look at it.

Thanks for reporting it!

-- Steve
