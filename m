Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37F166B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 01:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgBUAVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 19:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbgBUAVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:21:06 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90E2208E4;
        Fri, 21 Feb 2020 00:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582244465;
        bh=aFmWnc6nSROALS7C6rt+JEj+3cf4DjrPCVOqPO53blU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s6L8Trq6c8I5s8U8G/4Uut8ZJLFIcpHjZBs7sSoNWxZBW9PWWn2fgtIVny/jKoXJZ
         +7WdxB8LKOb6zxUm3aj/mQpg7go7U4GPbY30Yvh28qYYsB+66eN67VTmC2e5LL6zrw
         YMU/Nl9pDVXpu4SoFBDyZ219ezAFuqnwc8D2EW4E=
Date:   Fri, 21 Feb 2020 09:21:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/8] bootconfig: Overwrite value on same key by
 default
Message-Id: <20200221092101.f4a25d56de794db29ed5ed6f@kernel.org>
In-Reply-To: <20200220121641.6c0d611a@gandalf.local.home>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
        <158220116248.26565.12553080867501195108.stgit@devnote2>
        <20200220121641.6c0d611a@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 12:16:41 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 20 Feb 2020 21:19:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Currently, bootconfig does not overwrite existing value
> > on same key, but add new value to the tail of an array.
> > But this looks a bit confusing because similar syntax
> > configuration always overwrite the value by default.
> 
> Should we even allow this case? Or at the very least, some output
> should be made that a value is being overwritten.

Both are OK, but I like just making it error. At this moment,
the bootconfig tool writes user-given bootconfig file to
initrd (not reformat it). This means if user ignores the warning
from bootconfig tool, they will see same warning on dmesg again.

Thank you,


> 
> -- Steve
> 
> 
> > 
> > This changes the behavior to overwrite value on same key.
> > 
> > For example, if there are 2 entries
> > 
> >   key = value
> >   ...
> >   key = value2
> > 
> > Then, the key is updated as below.
> > 
> >   key = value2
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
