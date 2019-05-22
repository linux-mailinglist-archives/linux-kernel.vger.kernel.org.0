Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46C26343
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfEVLwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 07:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfEVLwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:52:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A8320815;
        Wed, 22 May 2019 11:52:29 +0000 (UTC)
Date:   Wed, 22 May 2019 07:52:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: silence GCC 9 array bounds warning
Message-ID: <20190522075227.52ae4720@gandalf.local.home>
In-Reply-To: <20190522095810.GA16110@gmail.com>
References: <20190522095810.GA16110@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 11:58:10 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> +/* reset all but tr, trace, and overruns */
> +static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
> +{
> +	/*
> +	 * We do not simplify the start address to &iter->seq in order to let
> +	 * GCC 9 know that we really want to overwrite more members than
> +	 * just iter->seq (-Warray-bounds).

This comment is fine for the change log, but here it is too specific.
Why does one care about GCC 9 when we are at version GCC 21? I care
more about why we are clearing the data and less about the way we are
doing it.

A comment like:

	/*
	 * Reset the state of the trace_iterator so that it can read
	 * consumed data. Normally, the trace_iterator is used for
	 * reading the data when it is not consumed, and must retain
	 * state.
	 */

That is more useful than why we have the offset hack.


> +	 */
> +	const size_t offset = offsetof(struct trace_iterator, seq);

Need a empty line between these two.

-- Steve

> +	memset((char *)(iter) + offset, 0, sizeof(struct trace_iterator) - offset);
> +
> +	iter->pos = -1;
> +}
> +
>  #endif /* _LINUX_KERNEL_TRACE_H */
