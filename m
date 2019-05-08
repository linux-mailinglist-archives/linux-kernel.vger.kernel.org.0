Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E891116ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 04:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEHCKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 22:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfEHCKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:10:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF6E21019;
        Wed,  8 May 2019 02:10:08 +0000 (UTC)
Date:   Tue, 7 May 2019 22:10:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] tracing: probeevent: Fix probe argument parser
 and handler
Message-ID: <20190507221006.17126aff@oasis.local.home>
In-Reply-To: <155723732200.9149.10482668315693777743.stgit@devnote2>
References: <155723732200.9149.10482668315693777743.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 May 2019 22:55:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of series to fix several bugs in probe event
> argument parser and handler routines.
> 
> In this version I updated patch [1/3] according to Steve's comment.
> 
> 
> I got 2 issues reported by Andreas, see
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899098.html
> 
> One issue is already fixed by Andreas (Thanks!) but $comm handling
> issue still exists on uprobe event. [1/3] fixes it.
> And I found other issues around that, [2/3] is just a trivial cleanup,
> [3/3] fixes $comm type issue which occurs not only uprobe events but
> also on kprobe events. Anyway, after this series applied, $comm must
> be "string" type and not be an array.
>

Thanks Masami,

I applied these to my queue.

-- Steve
