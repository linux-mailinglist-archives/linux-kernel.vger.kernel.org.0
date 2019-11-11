Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036BEF8172
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 21:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKKUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 15:40:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfKKUkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:40:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45BCB2067B;
        Mon, 11 Nov 2019 20:40:24 +0000 (UTC)
Date:   Mon, 11 Nov 2019 15:40:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3] tracing: Introduce trace event injection
Message-ID: <20191111154022.700e482f@gandalf.local.home>
In-Reply-To: <20191021192146.0d651ce2@oasis.local.home>
References: <20190904211456.31204-1-xiyou.wangcong@gmail.com>
        <CAM_iQpUiOi8JDBqAtMHii5UHK3D6WQkk_G5DriJ9Y0yTYbWf3Q@mail.gmail.com>
        <CAM_iQpU3dqvUR0Qp6ZdZrAiyT_t_uFk4K79vcT2Q_-EjqBCGbw@mail.gmail.com>
        <20191021192146.0d651ce2@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 19:21:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 21 Oct 2019 13:41:51 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > On Mon, Sep 23, 2019 at 2:13 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:  
> > >
> > > Hi, Steven
> > >
> > > Any reviews for V3? I've addressed your concern about Kconfig.
> > >    
> > 
> > Ping..  
> 
> Sorry, I still haven't forgotten about you. Just trying to deal with
> other fires at the moment.

Digging through mounds of email, I still see I have to look at this.
Will try to got to it this week.

-- Steve

