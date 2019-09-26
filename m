Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5534DBF6D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfIZQju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 12:39:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43208 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfIZQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:39:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iDWns-0003L8-Mh; Thu, 26 Sep 2019 18:39:40 +0200
Date:   Thu, 26 Sep 2019 18:39:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 4/8] sched: migrate disable: Protect cpus_ptr with lock
Message-ID: <20190926163940.khzhsp3a4h7vj7lw@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-5-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-5-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-27 00:56:34 [-0500], Scott Wood wrote:
> Various places assume that cpus_ptr is protected by rq/pi locks,
> so don't change it before grabbing those locks.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

I applied now everything until here and you can take a look at
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-5.2.y-rt-RC

If there are no objections then I would make this a -rt9 and then go
further.

Sebastian
