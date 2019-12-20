Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172B8127F23
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 16:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLTPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 10:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfLTPSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:18:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E3E222C2;
        Fri, 20 Dec 2019 15:18:49 +0000 (UTC)
Date:   Fri, 20 Dec 2019 10:18:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Kirill Tkhai <tkhai@yandex.ru>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/4] sched: Force the address order of each sched
 class descriptor
Message-ID: <20191220101848.2b64b224@gandalf.local.home>
In-Reply-To: <5846dfc3-a7a8-25af-aec7-3e326cf54efd@virtuozzo.com>
References: <20191219214451.340746474@goodmis.org>
        <20191219214558.510271353@goodmis.org>
        <0a957e8d-7af8-613c-11ae-f51b9b241eb7@rasmusvillemoes.dk>
        <20191220100033.GE2844@hirez.programming.kicks-ass.net>
        <1ac359e8-fa7f-7ded-e2f2-9f7d0b23a4e1@rasmusvillemoes.dk>
        <5846dfc3-a7a8-25af-aec7-3e326cf54efd@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 13:44:05 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> My opinion is to better make some less beautiful thing in a single synchronous place,
> than to distribute the redundancy over all the code (especially, when it is asynchronous).

I very much subscribe to this notion. The TRACE_EVENT() and NMI code
does the same. Keep all other use cases simple by making it complex in
one locality.

-- Steve
