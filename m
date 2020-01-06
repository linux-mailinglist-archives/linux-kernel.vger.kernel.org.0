Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9641131BA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgAFWkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 17:40:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgAFWkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:40:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03F6207FF;
        Mon,  6 Jan 2020 22:40:41 +0000 (UTC)
Date:   Mon, 6 Jan 2020 17:40:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH] libtraceevent: Add dependency on libdl
Message-ID: <20200106174040.083676bd@gandalf.local.home>
In-Reply-To: <20200106221955.GC16851@kernel.org>
References: <20191226224931.3458-1-sudipm.mukherjee@gmail.com>
        <20200106221955.GC16851@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 19:19:55 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> Em Thu, Dec 26, 2019 at 10:49:31PM +0000, Sudip Mukherjee escreveu:
> > event-plugin.c is calling dl_*() functions but it is not linked with
> > libdl. As a result when we use ldd on the generated libtraceevent.so
> > file, it does not list libdl as one of its dependencies.
> > Add -ldl explicitly as done in tools/lib/lockdep.  
> 
> Rostedt, can you ack this one? It applies just fine.

I see nothing wrong, but wanted to play with it before acking it. I'll
do that in a bit. Thanks for the reminder!

-- Steve
