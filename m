Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB683E81
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 02:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfHGAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 20:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfHGAk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:40:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9346021738;
        Wed,  7 Aug 2019 00:40:56 +0000 (UTC)
Date:   Tue, 6 Aug 2019 20:40:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 02/14] rcu/nocb: Add bypass callback
 queueing
Message-ID: <20190806204055.088ba246@gandalf.local.home>
In-Reply-To: <20190807003501.GX28441@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
        <20190802151501.13069-2-paulmck@linux.ibm.com>
        <20190807000313.GA161170@google.com>
        <20190807003501.GX28441@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 17:35:01 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> > > +	// Don't use ->nocb_bypass during early boot.  
> > 
> > Very minor nit: comment style should be /* */  
> 
> I thought that Linus said that "//" was now OK.  Am I confused?

Have a link?

-- Steve
