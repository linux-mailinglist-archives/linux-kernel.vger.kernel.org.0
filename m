Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A24A7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfFRQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 12:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfFRQ5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:57:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438A1206E0;
        Tue, 18 Jun 2019 16:57:54 +0000 (UTC)
Date:   Tue, 18 Jun 2019 12:57:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/4] trace: introduce trace event injection
Message-ID: <20190618125752.75668a18@gandalf.local.home>
In-Reply-To: <20190610211204.76c8ca50@oasis.local.home>
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
        <20190525183715.0778f5e5@gandalf.local.home>
        <CAM_iQpXg9PrA_T_Argxuc+SST2CqjY=qjQA_pEgBNtC6F_a2Pw@mail.gmail.com>
        <20190610211204.76c8ca50@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 21:12:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 10 Jun 2019 14:11:57 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > On Sat, May 25, 2019 at 3:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > Hi Cong,
> > >
> > > Thanks for sending these patches, but I just want to let you know that
> > > it's currently a US holiday, and then afterward I'll be doing quite a
> > > bit of traveling for the next two weeks. If you don't hear from me in
> > > after two weeks, please send me a reminder.    
> > 
> > This is a reminder after two weeks. :) Please review my patches
> > when you have a chance.
> >  
> 
> Thanks for the reminder. I'll try to get to it this week.
>

Bah, sorry I haven't gotten to this yet. It's still in my queue to do,
and I'm going to be traveling again. I have not forgotten about it.
It's now marked in my INBOX patchwork, so it will not be forgotten.

-- Steve
