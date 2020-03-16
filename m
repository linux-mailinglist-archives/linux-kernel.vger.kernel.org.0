Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8518730B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbgCPTJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 15:09:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52730 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPTJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:09:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jDv7U-0003wu-8y; Mon, 16 Mar 2020 20:09:48 +0100
Date:   Mon, 16 Mar 2020 20:09:48 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [RFC PATCH 0/3] Fix quiet console in pre-panic scenarios
Message-ID: <20200316190948.7peesqnx6yhpzdpl@linutronix.de>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
 <20200316143517.651abbeb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316143517.651abbeb@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-16 14:35:17 [-0400], Steven Rostedt wrote:
> I don't see any issues with this patch set. What do others think?
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> [ Note, I only acked, and did not give a deep review of it ]

What is the state of the other larger printk rework? If this does not
solve any -stable related issues then it will be replaced?

Sebastian
