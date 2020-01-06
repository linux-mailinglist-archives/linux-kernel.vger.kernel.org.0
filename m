Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A52C1316F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAFRlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 12:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFRlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:41:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6B7207FF;
        Mon,  6 Jan 2020 17:41:42 +0000 (UTC)
Date:   Mon, 6 Jan 2020 12:41:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org, nachukannan@gmail.com
Subject: Re: [PATCH] tracing: Resets the trace buffer after a snapshot
Message-ID: <20200106124141.1fc400a1@gandalf.local.home>
In-Reply-To: <20200105103113.flhx26366zoqcgak@frank-laptop>
References: <20191231085822.yxhph6wcguejb7al@frank-laptop>
        <20200103114001.2c118ab1@gandalf.local.home>
        <20200103223711.GC189259@google.com>
        <20200105103113.flhx26366zoqcgak@frank-laptop>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jan 2020 05:31:13 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> 
> Thank you both for your answers. I'm wondering what would be the reason
> for not resetting the trace buffer after it gets swapped with the snapshot
> buffer. Given that resetting it's not expensive, I would say that is not
> performance, so I'm intrigued ;)

Is it not expensive? It calls synchronize_rcu()! which is very
expensive.

When I have used the snapshot buffer, It was usually to capture things
that happen at various times, but still look for the next trace. By
alternating, I do get to see where the last snapshot happened. It
basically doubles the size of the buffer.

> 
> If it's OK, I will send two patches then, one documenting explicitly
> that the trace buffer it will not be reset after be swapped and the
> implications of this, and the second one changing the documentation of
> the field trace_array->max_buffer that I now realized that say:
> 
> "
> /*
> ...
> * The buffers for the max_buffer are set up the same as the trace_buffer
> * When a snapshot is taken, the buffer of the max_buffer is swapped
> * with the buffer of the trace_buffer and the buffers are reset for
> * the trace_buffer so the tracing can continue.

It is reset partially by the latency tracers, and this is where it gets
confusing. Instead of a full reset, as the latency tracer only cares
about a specific start and end, it records where the start and end is,
and only modifies that. Look at the time_start of the trace_buffer.

Hmm, it may be possible to have an option just update that, which
should give the same effect.

-- Steve
