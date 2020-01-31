Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38314E73D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 03:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgAaClx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 21:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgAaClx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:41:53 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D428E2082E;
        Fri, 31 Jan 2020 02:41:51 +0000 (UTC)
Date:   Thu, 30 Jan 2020 21:41:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuahkhan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Have pid filter test use instance
 flag
Message-ID: <20200130214150.57469c13@rorschach.local.home>
In-Reply-To: <CAKocOOOnFTa3-FTBFSnbaLdQbXZiH4gx4=ZyoU0pW_pQv40efg@mail.gmail.com>
References: <20200130121205.40cbb903@gandalf.local.home>
        <20200130121352.466e3300@gandalf.local.home>
        <CAKocOOOnFTa3-FTBFSnbaLdQbXZiH4gx4=ZyoU0pW_pQv40efg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 17:10:04 -0700
Shuah Khan <shuahkhan@gmail.com> wrote:

> On Thu, Jan 30, 2020 at 10:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > Shuah,
> >
> > Can you take this through your tree?
> >  
> 
> Yes. I can take this. Could you please resend it to the addresses
> listed by get_maintainers.pl
> shuah@kernel.org or skhan@linuxfoundation.org and cc linux-kselftest
> mailing list
> 

Sure, I just picked the address I had in my address book ;-)

-- Steve
