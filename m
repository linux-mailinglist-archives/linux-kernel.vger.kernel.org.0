Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08318D8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTUFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 16:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTUFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:05:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF2920409;
        Fri, 20 Mar 2020 20:05:46 +0000 (UTC)
Date:   Fri, 20 Mar 2020 16:05:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com,
        bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: 4.19.106-rt44 -- boot problems with irqwork: push most work
 into softirq context
Message-ID: <20200320160545.26a65de3@gandalf.local.home>
In-Reply-To: <20200320195432.GA12666@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
        <20200319214835.GA29781@duo.ucw.cz>
        <20200319232225.GA7878@duo.ucw.cz>
        <20200319204859.5011a488@gandalf.local.home>
        <20200320195432.GA12666@duo.ucw.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 20:54:32 +0100
Pavel Machek <pavel@denx.de> wrote:

> > Does this patch help?  
> 
> I don't think so. It also failed, and the failure seems to be
> identical to me.
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-cip
> https://lava.ciplatform.org/scheduler/job/13110
> 

Can you send me a patch that shows the difference between the revert that
you say works, and the upstream v4.19-rt tree (let me know which version
of v4.19-rt you are basing it on).

Thanks!

-- Steve
