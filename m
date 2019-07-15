Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED3468536
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfGOI3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 04:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfGOI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:29:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BD3214C6;
        Mon, 15 Jul 2019 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563179375;
        bh=ayBD0Y5sJDpKf1w1/YXOS05x9dQwEx5X2dm1cMdrgQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFsCo5FmFQ/XW4yNKLK+yYFUVFJ6yeqU2p5lkUuyAzYVD4ZHdej4O8rwdcWywwP99
         8H2G9rLMnYjZ05Wr6oXyOlvOrbSmTaXdMverFo5ceeb8J/arfaBzcQ+EqgQttO5esB
         so4ncBpx/M/Wh1wVM0k00MQjs0oA8obOWWm1OJqA=
Date:   Mon, 15 Jul 2019 09:29:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, corbet@lwn.net,
        linux@armlinux.org.uk, catalin.marinas@arm.com, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing/fgraph: support recording function return values
Message-ID: <20190715082930.uyxn2kklgw4yri5l@willie-the-truck>
References: <20190713121026.11030-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713121026.11030-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 08:10:26PM +0800, Changbin Du wrote:
> This patch adds a new trace option 'funcgraph-retval' and is disabled by
> default. When this option is enabled, fgraph tracer will show the return
> value of each function. This is useful to find/analyze a original error
> source in a call graph.
> 
> One limitation is that the kernel doesn't know the prototype of functions.
> So fgraph assumes all functions have a retvalue of type int. You must ignore
> the value of *void* function. And if the retvalue looks like an error code
> then both hexadecimal and decimal number are displayed.

This seems like quite a significant drawback and I think it could be pretty
confusing if you have to filter out bogus return values from the trace.

For example, in your snippet:

>  3)               |  kvm_vm_ioctl() {
>  3)               |    mutex_lock() {
>  3)               |      _cond_resched() {
>  3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
>  3)   0.704 us    |      } /* ret=0x0 */
>  3)   1.226 us    |    } /* ret=0x0 */
>  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */

mutex_unlock() is wrongly listed as returning something.

How much of this could be achieved from userspace by placing kretprobes on
non-void functions instead?

Will
