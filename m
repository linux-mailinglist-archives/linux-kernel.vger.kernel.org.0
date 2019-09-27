Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEDCC050D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfI0MUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 08:20:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfI0MUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:20:03 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iDpE2-0000q1-Ij; Fri, 27 Sep 2019 14:19:54 +0200
Date:   Fri, 27 Sep 2019 14:19:54 +0200
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
Message-ID: <20190927121954.3gbzk3i3jbpugrjo@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-5-swood@redhat.com>
 <20190926163940.khzhsp3a4h7vj7lw@linutronix.de>
 <f3b31297df859eb7d1dc86637c29b271fbf87970.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3b31297df859eb7d1dc86637c29b271fbf87970.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-26 11:52:42 [-0500], Scott Wood wrote:
> Looks good, thanks!

Thanks, just released.
Moving forward. It would be nice to have some DL-dev feedback on DL
patch. For the remaining once, could please throw Steven's
stress-test-hostplug-cpu-script? If that one does not complain I don't
see a reason why not apply the patches (since they improve performance
and do not break anything while doing so).

> -Scott

Sebastian
