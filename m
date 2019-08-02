Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9B17FFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406230AbfHBRrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 13:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403848AbfHBRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:47:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F97A217F5;
        Fri,  2 Aug 2019 17:47:14 +0000 (UTC)
Date:   Fri, 2 Aug 2019 13:47:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/8] recordmcount cleanups
Message-ID: <20190802134712.2d8cc63f@gandalf.local.home>
In-Reply-To: <cover.1564596289.git.mhelsley@vmware.com>
References: <cover.1564596289.git.mhelsley@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 11:24:08 -0700
Matt Helsley <mhelsley@vmware.com> wrote:

> recordmcount presents unnecessary challenges to reviewers:
> 
> 	It pretends to wrap access to the ELF file in
> 	uread/uwrite/ulseek functions which aren't related
> 	the way you might think (i.e. not the way read, write,
> 	and lseek are releated to each other).
> 
> 	It uses setjmp/longjmp to handle errors (and success)
> 	during processing of the object files. This makes it
> 	hard to review what functions are doing, how globals
> 	change over time, etc.
> 
> 	There are some kernel style nits.
> 
> This series addresses all of those by removing un-helper functions,
> unused parameters, and rewriting the error/success handling to
> better resemble regular kernel C code.
> 

I applied these patches to my queue.

I pushed them to my repo on branch ftrace/core

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

But note, that this branch will rebase, probably on top of v5.3-rc3
when it comes out.

-- Steve
