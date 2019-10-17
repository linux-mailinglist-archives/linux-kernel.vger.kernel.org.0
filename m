Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96E7DB8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503562AbfJQV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 17:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390402AbfJQV20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:28:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC7621A49;
        Thu, 17 Oct 2019 21:28:24 +0000 (UTC)
Date:   Thu, 17 Oct 2019 17:28:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/2] perf: Iterate on tep event arrays directly
Message-ID: <20191017172823.15f242eb@gandalf.local.home>
In-Reply-To: <20191017212431.GF3600@kernel.org>
References: <20191017210521.465613686@goodmis.org>
        <20191017210636.061448713@goodmis.org>
        <20191017212431.GF3600@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 18:24:31 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> I'll add a:
> 
> Fixes: bb3dd7e7c4d5 ("tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file")
> Cc: stable@vger.kernel.org : v4.20+
> 
> As this is when this problem starts causing the segfault when generating
> python scripts from perf.data files with multiple tracepoint events, ok?

Sure, go ahead. I realized I forgot to add a Fixes tag when sending it.

-- Steve
