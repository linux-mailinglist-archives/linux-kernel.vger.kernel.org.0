Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEF7E05B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfHAQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbfHAQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:40:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7BA20838;
        Thu,  1 Aug 2019 16:40:39 +0000 (UTC)
Date:   Thu, 1 Aug 2019 12:40:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
Message-ID: <20190801124037.11dcac71@gandalf.local.home>
In-Reply-To: <917395fc42633b66abe3f713a9eef8edfdf7ee44.camel@perches.com>
References: <20190729151505.9660-1-hslester96@gmail.com>
        <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
        <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
        <917395fc42633b66abe3f713a9eef8edfdf7ee44.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Aug 2019 09:19:04 -0700
Joe Perches <joe@perches.com> wrote:

> > I find that checkpatch.pl forbids assignment in if condition.
> > So this seems to be infeasible...  
> 
> checkpatch is a stupid script and doesn't forbid
> anything.  It's just a suggestion guide.
> 
> Ignore checkpatch when you know better.

And this is coming from the checkpatch.pl maintainer ;-)

-- Steve
