Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7F44249
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392174AbfFMQU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391802AbfFMQUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:20:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B392173C;
        Thu, 13 Jun 2019 16:20:36 +0000 (UTC)
Date:   Thu, 13 Jun 2019 12:20:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "linux-trace-users@vger.kernel.org" 
        <linux-trace-users@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Slavomir Kaslev <kaslevs@vmware.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [ANNOUNCE] trace-cmd v2.8
Message-ID: <20190613122035.7d19f318@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finally, after a long time, trace-cmd version 2.8 is released!

This will give us a path to release KernelShark 1.0 (after we fix a few
more bugs).

 http://trace-cmd.org

Enjoy!

-- Steve

Features since 2.7:

 o Restructure of the source directory layout

 o Loading of plugins from build directory (over other locations)

 o trace-cmd reset updates (restores more, and keeps tracing_on enabled)

 o trace-cmd stat shows more information about the state of ftrace

 o Better accuracy with trace-cmd record --date

 o Version of executable now saved in trace.dat file
    trace-cmd report --version, will show that version

 o trace-cmd listen has a V3 protocal (V2 is no longer used)
    This is a big step toward a virt-server implementation

 o trace-cmd record --no-filter option added to not filter out
    the trace-cmd tasks while tracing.

 o Better bash completion for trace-cmd commands

 o The "mono" clock is shown now in seconds

 o --max-graph-depth can be used by instances

 And of course a ton of fixes and clean ups. 
