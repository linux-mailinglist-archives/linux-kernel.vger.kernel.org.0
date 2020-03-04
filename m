Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F11788F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 04:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgCDDHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 22:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgCDDHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:07:48 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C9E20842;
        Wed,  4 Mar 2020 03:07:46 +0000 (UTC)
Date:   Tue, 3 Mar 2020 22:07:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luiz Capitulino <lcapitulino@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] trace-cmd record: add --cpu-list option
Message-ID: <20200303220745.527c57f2@oasis.local.home>
In-Reply-To: <20170103115406.167e508e@redhat.com>
References: <1479846052-8020-1-git-send-email-lcapitulino@redhat.com>
        <20170103113258.17e57d1a@redhat.com>
        <20170103114530.49053eaa@gandalf.local.home>
        <20170103115406.167e508e@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking through my inbox, I stumbled on this.

On Tue, 3 Jan 2017 11:54:06 -0500
Luiz Capitulino <lcapitulino@redhat.com> wrote:

> On Tue, 3 Jan 2017 11:45:30 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 3 Jan 2017 11:32:58 -0500
> > Luiz Capitulino <lcapitulino@redhat.com> wrote:
> >   
> > > On Tue, 22 Nov 2016 15:20:50 -0500
> > > Luiz Capitulino <lcapitulino@redhat.com> wrote:
> > >     
> > > > This series adds support for a --cpu-list option, which is
> > > > much more human friendly than -M:
> > > > 
> > > >   # trace-cmd record --cpu-list 1,4,10-15 [...]
> > > > 
> > > > The first patch is a small refectoring needed to
> > > > make --cpu-list support fit nicely. The second patch
> > > > adds the new option.      
> > > 
> > > ping?
> > >     
> > 
> > Thanks for the reminder ;-)
> > 
> > I'm going to try to get to this this week, but as this is my first week
> > on my new job (not to mention the new year), you may need to ping me
> > again.  
> 
> I see, no rush then.

I hope you really meant that, as I really did need another ping.

I think this is a good option to have. I've Cc'd linux-trace-devel, and
hopefully we'll get this feature added much sooner than the next 3
years!

-- Steve
