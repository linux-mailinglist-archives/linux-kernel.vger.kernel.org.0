Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F08D2A96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbfJJNOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 09:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfJJNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:14:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07647206A1;
        Thu, 10 Oct 2019 13:14:04 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:14:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     jikos@kernel.org, Joe Lawrence <joe.lawrence@redhat.com>,
        jpoimboe@redhat.com, mingo@redhat.com,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 0/3] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191010091403.5ecf0fdb@gandalf.local.home>
In-Reply-To: <20191010085035.emsdks6xecazqc6k@pathway.suse.cz>
References: <20191007081714.20259-1-mbenes@suse.cz>
        <20191008193534.GA16675@redhat.com>
        <20191009112234.bi7lvp4pvmna26vz@pathway.suse.cz>
        <20191009102654.501ad7c3@gandalf.local.home>
        <20191010085035.emsdks6xecazqc6k@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 10:50:35 +0200
Petr Mladek <pmladek@suse.com> wrote:

> It will make the flag unusable for other ftrace users. But it
> will be already be the case when it can't be disabled.

Honestly, I hate that flag. Most people don't even know about it. It
was added in the beginning of ftrace as a way to stop function tracing
in the latency tracer. But that use case has been obsoleted by
328df4759c03e ("tracing: Add function-trace option to disable function
tracing of latency tracers"). I may just remove the damn thing and only
add it back if somebody complains about it.

-- Steve
