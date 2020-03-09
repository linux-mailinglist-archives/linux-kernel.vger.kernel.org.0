Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17417E814
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgCITHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbgCITHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:07:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59E120848;
        Mon,  9 Mar 2020 19:07:10 +0000 (UTC)
Date:   Mon, 9 Mar 2020 15:07:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: Instrumentation and RCU
Message-ID: <20200309150709.204bd306@gandalf.local.home>
In-Reply-To: <CAEXW_YQJ=vGxn5P=OtdkJT4NwE9+P0rAPEEQFdAUtyZ9Ck=qug@mail.gmail.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
        <20200309141546.5b574908@gandalf.local.home>
        <CAEXW_YQJ=vGxn5P=OtdkJT4NwE9+P0rAPEEQFdAUtyZ9Ck=qug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020 11:42:28 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> Just started a vacation here and will be back on January 12th. Will
> take a detailed look at Thomas's email at that time.

January 12th! Wow! Enjoy your sabbatical and see you next year! ;-)

-- Steve
