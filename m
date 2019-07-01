Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A92E00C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfE2Op4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 10:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfE2Opz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:45:55 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D9A23A78;
        Wed, 29 May 2019 14:45:54 +0000 (UTC)
Date:   Wed, 29 May 2019 10:45:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Preisner <linux@tpreisner.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190529104552.146fa97c@oasis.local.home>
In-Reply-To: <20190529093124.2872-1-linux@tpreisner.de>
References: <20190529093124.2872-1-linux@tpreisner.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 11:31:23 +0200
Thomas Preisner <linux@tpreisner.de> wrote:

> The "oneshot" tracer records every address (ip, parent_ip) exactly once.
> As a result, "oneshot" can be used to efficiently create kernel function
> coverage/usage reports such as in undertaker-tailor[0].
> 
> In order to provide this functionality, "oneshot" uses a
> configurable hashset for blacklisting already recorded addresses. This
> way, no user space application is required to parse the function
> tracer's output and to deactivate functions after they have been
> recorded once. Additionally, the tracer's output is reduced to a bare
> mininum so that it can be passed directly to undertaker-tailor.
> 
> Further information regarding this oneshot function tracer can also be
> found at [1].
> 
> [0]: https://undertaker.cs.fau.de
> [1]: https://tpreisner.de/pub/ba-thesis.pdf
> 
> Signed-off-by: Thomas Preisner <linux@tpreisner.de>
>

Hi,

If you are only interested in seeing what functions are called (and
don't care about the order), why not just make another function
profiler (see register_ftrace_profiler and friends)? Then you could
just list the hash table entries instead of having to record into the
ftrace ring buffer.

-- Steve
