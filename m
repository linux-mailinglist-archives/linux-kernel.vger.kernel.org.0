Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBED1764A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 21:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgCBUIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 15:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBUIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:08:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B769214DB;
        Mon,  2 Mar 2020 20:08:03 +0000 (UTC)
Date:   Mon, 2 Mar 2020 15:08:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] Documentation: bootconfig: Update boot configuration
 documentation
Message-ID: <20200302150802.348b814e@gandalf.local.home>
In-Reply-To: <20200302125033.4a62e88e@lwn.net>
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
        <158313622831.3082.8237132211731864948.stgit@devnote2>
        <20200302125033.4a62e88e@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 12:50:33 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon,  2 Mar 2020 17:03:48 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Update boot configuration documentation.
> > 
> >  - Not using "config" abbreviation but configuration or description.
> >  - Rewrite descriptions of node and its maxinum number.
> >  - Add a section of use cases of boot configuration.
> >  - Move how to use bootconfig to earlier section.
> >  - Fix some typos, indents and format mistakes.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> > Changes in v3:
> >  - Specify that comments also count in size.
> >  - Fix a confusing sentence.
> >  - Add O=<builddir> to make command.
> > Changes in v2:
> >  - Fixes additional typos (Thanks Markus and Randy!)
> >  - Change a section title to "Tree Structured Key".
> > ---  
> 
> So I tried to apply this but failed - it's built on other changes to
> bootconfig.rst that went into linux-next via Steve's tree.  So Steve,
> would you like to take this one too?

All my changes in linux-next have already hit Linus's tree. I haven't
started pushing my next merge window changes yet. Are you up to date with
Linus?

-- Steve
