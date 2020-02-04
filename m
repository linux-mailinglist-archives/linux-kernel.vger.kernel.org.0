Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CFB151C42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBDOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 09:33:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbgBDOdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:33:11 -0500
Received: from oasis.local.home (unknown [212.187.182.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC0A20730;
        Tue,  4 Feb 2020 14:33:08 +0000 (UTC)
Date:   Tue, 4 Feb 2020 09:33:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] bootconfig: Only load bootconfig if
 "config=bootconfig" is on the kernel cmdline (was: bootconfig: Add
 "disable_bootconfig" cmdline option to  disable bootconfig)
Message-ID: <20200204093302.593cb82e@oasis.local.home>
In-Reply-To: <20200204092528.2dc8fba4@oasis.local.home>
References: <20200204053155.127c3f1e@oasis.local.home>
        <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
        <20200204072856.0da60613@oasis.local.home>
        <CAHk-=wg2Wk9ZgVBDCBHa3-b0fSfByiRJnGA_F8snMy=3HHg_gw@mail.gmail.com>
        <20200204084642.450b6ebd@oasis.local.home>
        <20200204092528.2dc8fba4@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 09:25:28 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> As bootconfig is silently added (if the admin does not know where to look
> they may not know it's being loaded). It should be explicitly added to the
> kernel cmdline. The loading of the bootconfig is only done if
> "config=bootconfig" is on the kernel command line. This will let admins know
> that the kernel command line is extended.

I wonder if we need the "config=" part. Would "bootconfig" be
sufficient, or is it better to keep it for documentation purposes.

-- Steve
