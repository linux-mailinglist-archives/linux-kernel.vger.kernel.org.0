Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F214D54A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 03:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgA3C6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 21:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgA3C6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:58:55 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251DC2070E;
        Thu, 30 Jan 2020 02:58:54 +0000 (UTC)
Date:   Wed, 29 Jan 2020 21:58:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 04/12] tracing: Add dynamic event command creation
 interface
Message-ID: <20200129215852.53063246@rorschach.local.home>
In-Reply-To: <20200130114028.0c20b193cc3825363369794a@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
        <1f65fa44390b6f238f6036777c3784ced1dcc6a0.1580323897.git.zanussi@kernel.org>
        <20200130114028.0c20b193cc3825363369794a@kernel.org>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 11:40:28 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > +int dynevent_arg_add(struct dynevent_cmd *cmd,
> > +		     struct dynevent_arg *arg)
> > +{
> > +	int ret = 0;
> > +	int delta;
> > +	char *q;
> > +
> > +	if (arg->check_arg) {
> > +		ret = arg->check_arg(arg);  
> 
> Hmm, this seems a bit odd. The check_arg() arg object member check
> the validity of the object itself. What about moving those checker
> into dynevent_cmd instead of dynevent_arg?
> (Or, just pass the appropriate checker as the 3rd parameter of
>  this function)

Masami,

Thanks for reviewing these patches.

Tom,

Please send updates on top of this series. I've already pulled them in
my queue and there going through my test suite now. It will be easier
just to add changes on top than to send another version at this point.

You can see what I'm testing via my repo on branch ftrace/core.

-- Steve
