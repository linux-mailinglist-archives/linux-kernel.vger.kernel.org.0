Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3BA14CCED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgA2PCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 10:02:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgA2PCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:02:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54772070E;
        Wed, 29 Jan 2020 15:02:50 +0000 (UTC)
Date:   Wed, 29 Jan 2020 10:02:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tracing: Add new testcases for hist trigger
 parsing errors
Message-ID: <20200129100249.7b4e2acc@gandalf.local.home>
In-Reply-To: <20200129095350.7f385d6a@gandalf.local.home>
References: <cover.1561743018.git.zanussi@kernel.org>
        <62ec58d9aca661cde46ba678e32a938427945e9e.1561743018.git.zanussi@kernel.org>
        <20200129092200.2200db5e@gandalf.local.home>
        <1580309067.2312.1.camel@kernel.org>
        <20200129095350.7f385d6a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 09:53:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 Jan 2020 08:44:27 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > All the trigger testcases are passing for me, including this one:
> > 
> >   # ./ftracetest test.d/trigger/trigger-hist-syntax-errors.tc 
> > === Ftrace unit tests ===
> > [1] event trigger - test histogram parser errors	[PASS]
> > 
> > 
> > # of passed:  1
> > # of failed:  0
> > # of unresolved:  0
> > # of untested:  0
> > # of unsupported:  0
> > # of xfailed:  0
> > # of undefined(test bug):  0  
> 
> Strange, can you try with the attached config?
> 

Never mind. After checking out one branch and then back to this one, it
appears to work!

-- Steve
