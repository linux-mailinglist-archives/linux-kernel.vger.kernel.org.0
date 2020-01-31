Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAA14F1BE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgAaSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 13:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgAaSAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:00:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2F0214D8;
        Fri, 31 Jan 2020 18:00:21 +0000 (UTC)
Date:   Fri, 31 Jan 2020 13:00:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 06/12] tracing: Change trace_boot to use synth_event
 interface
Message-ID: <20200131130020.51d04203@gandalf.local.home>
In-Reply-To: <20200131125539.68ab766d@gandalf.local.home>
References: <cover.1580323897.git.zanussi@kernel.org>
        <94f1fa0e31846d0bddca916b8663404b20559e34.1580323897.git.zanussi@kernel.org>
        <1580492941.24839.5.camel@gmail.com>
        <20200131125539.68ab766d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 12:55:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 31 Jan 2020 11:49:01 -0600
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > Hi Steve,
> > 
> > It looks like you missed this patch when you pulled the other ones into
> >  for-next.
> >   
> 
> Ah, you're right! And my INBOX patchwork is informing me of it too (I
> have it read my email, and when I post the 'for-next' patches, it
> switches the status from "new" to "Under review", and this one is still
> "new").
> 
> Thanks for letting me know. I'll apply it now.

My latest has been pushed to ftrace/core.

-- Steve
