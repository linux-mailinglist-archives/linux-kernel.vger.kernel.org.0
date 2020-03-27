Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44E195C09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgC0RKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 13:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgC0RKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:10:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC18C206F2;
        Fri, 27 Mar 2020 17:10:22 +0000 (UTC)
Date:   Fri, 27 Mar 2020 13:10:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC] ARC: initial ftrace support
Message-ID: <20200327131020.79e68313@gandalf.local.home>
In-Reply-To: <20200327155355.18668-1-Eugeniy.Paltsev@synopsys.com>
References: <20200327155355.18668-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 18:53:55 +0300
Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com> wrote:

> +
> +noinline void _mcount(unsigned long parent_ip)
> +{
> +	unsigned long ip = (unsigned long)__builtin_return_address(0);
> +
> +	if (unlikely(ftrace_trace_function != ftrace_stub))
> +		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
> +				      NULL, NULL);
> +}
> +EXPORT_SYMBOL(_mcount);

So, ARCv2 allows the _mcount code to be written in C? Nice!

-- Steve
