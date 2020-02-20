Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE5166425
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgBTRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 12:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgBTRQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:16:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FD324672;
        Thu, 20 Feb 2020 17:16:42 +0000 (UTC)
Date:   Thu, 20 Feb 2020 12:16:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/8] bootconfig: Overwrite value on same key by
 default
Message-ID: <20200220121641.6c0d611a@gandalf.local.home>
In-Reply-To: <158220116248.26565.12553080867501195108.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
        <158220116248.26565.12553080867501195108.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 21:19:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Currently, bootconfig does not overwrite existing value
> on same key, but add new value to the tail of an array.
> But this looks a bit confusing because similar syntax
> configuration always overwrite the value by default.

Should we even allow this case? Or at the very least, some output
should be made that a value is being overwritten.

-- Steve


> 
> This changes the behavior to overwrite value on same key.
> 
> For example, if there are 2 entries
> 
>   key = value
>   ...
>   key = value2
> 
> Then, the key is updated as below.
> 
>   key = value2
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
