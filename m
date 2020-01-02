Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5312E937
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 18:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgABRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 12:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgABRUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:20:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C062020866;
        Thu,  2 Jan 2020 17:20:05 +0000 (UTC)
Date:   Thu, 2 Jan 2020 12:20:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] tools lib traceevent: How to do library versioning being in
 the Linux kernel source?
Message-ID: <20200102122004.216c85da@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I hope everyone had a Happy New Year!

Next, Sudip has been working to get the libtraceevent library into
Debian. As this has been happening, I've been working at how to get all
the projects that use this, to use the library installed on the system
if it does exist. I'm hoping that once it's in Debian, the other
distros will follow suit.

Currently, the home of libtraceevent lives in the Linux kernel source
tree under tools/lib/traceevent. This was because perf uses it to parse
the events, and it seemed logical (at the time) to use this location as
the main source tree for the distributions.

The problem I'm now having is that I'm looking at fixing and updating
some of the code in this library, and since library versioning is
critical for applications that depend on it, we need to have a way to
update the versions, and this does not correspond with the Linux
versions.

For example, we currently have:

 libtraceevent.so.1.1.0

If I make some bug fixes, I probably want to change it to:

 libtraceevent.so.1.1.1 or libtraceevent.so.1.2.0

But if I change the API, which I plan on doing soon, I would probably
need to update the major version.

 libtraceevent.so.2.0.0

The thing is, we shouldn't be making these changes for every update
that we send to the main kernel. I would like to have a minimum of tags
to state what the version should be, and perhaps even branches for
working on a development version.

This is a problem with living in the Linux source tree as tags and
branches in Linus's tree are for only the Linux kernel source itself.
This may work fine for perf, as it's not a library and there's not
tools depending on the version of it. But it is a problem when it comes
to shared libraries.

Should we move libtraceevent into a stand alone git repo (on
kernel.org), that can have tags and branches specifically for it? We
can keep a copy in the Linux source tree for perf to use till it
becomes something that is reliably in all distributions. It's not like
perf doesn't depend on other libraries today anyway.

Thoughts or suggestions?

Thanks!

-- Steve
