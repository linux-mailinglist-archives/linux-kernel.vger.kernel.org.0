Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF84285444
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbfHGUH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 16:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388210AbfHGUH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:07:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2979521922;
        Wed,  7 Aug 2019 20:07:27 +0000 (UTC)
Date:   Wed, 7 Aug 2019 16:07:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RT BUG] isolcpus causes sleeping function called from invalid
 context (4.19.59-rt24)
Message-ID: <20190807160725.10a554e7@gandalf.local.home>
In-Reply-To: <20190805100646.GH14724@localhost.localdomain>
References: <20190805100646.GH14724@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2019 12:06:46 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> This only happens if isolcpus are configured at boot.
> 
> AFAIU, RT is reworking workqueues and 5.x-rt shouldn't suffer from this.
> As a matter of fact, I could verify that backporting the workqueue
> rework all-in change from 5.0-rt [1] fixes this problem.

So you have backported this and it fixed the bug?

> 
> I'm thus wondering if there is any plan on backporting the rework to
> 4.19-rt stable, and if that patch has dependencies, or if any alternative
> fix might be found for this problem.

I could do it after I fix the bug with 4.19.63 merge :-/ (which may be
related. Who knows).

-- Steve
