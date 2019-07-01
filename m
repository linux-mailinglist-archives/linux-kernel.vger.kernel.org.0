Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6B1A3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfEJULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 16:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbfEJULw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:11:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B04217F9;
        Fri, 10 May 2019 20:11:51 +0000 (UTC)
Date:   Fri, 10 May 2019 16:11:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 01/27] tools lib traceevent: Remove hard coded install
 paths from pkg-config file
Message-ID: <20190510161150.20be7f1e@gandalf.local.home>
In-Reply-To: <20190510200105.966709757@goodmis.org>
References: <20190510195606.537643615@goodmis.org>
        <20190510200105.966709757@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 15:56:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> 
> Install directories of header and library files are hard coded in
> pkg-config template file.
> 
> They must be configurable, the Makefile should set them on the
> compilation / install stage.
> 
> Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Link: http://lkml.kernel.org/r/20190418211556.5a12adc3@oasis.local.home
> Link: http://lkml.kernel.org/r/20190329144546.5819-1-tstoyanov@vmware.com
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Bah!

I based my patch series off of the wrong commit, and ended up including
this one in this series.

Arnaldo,

I believe you already applied patch 1 (otherwise I would not have your
SOB on it), please ignore. But patch 2 on are new to be applied.

Thanks!

-- Steve

> ---
>  tools/lib/traceevent/Makefile                  | 13 +++++++++----
>  tools/lib/traceevent/libtraceevent.pc.template |  4 ++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
