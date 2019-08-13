Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE18B995
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 15:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfHMNJp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Aug 2019 09:09:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34816 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHMNJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:09:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxWYR-0006ba-4q; Tue, 13 Aug 2019 15:09:35 +0200
Date:   Tue, 13 Aug 2019 15:09:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com
Subject: Re: [RT PATCH] sched/deadline: Make inactive timer run in hardirq
 context
Message-ID: <20190813130934.g37ob6wr4br4rkwg@linutronix.de>
References: <20190731103715.4047-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190731103715.4047-1-juri.lelli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-31 12:37:15 [+0200], Juri Lelli wrote:
> Hi,
Hi,

> Both v4.19-rt and v5.2-rt need this.
> 
> Mainline "sched: Mark hrtimers to expire in hard interrupt context"
> series needs this as well (20190726185753.077004842@linutronix.de in
> particular). Do I need to send out a separate patch for it?

time will show. I applied it now to my tree and will ping tglx later…

> Best,
> 
> Juri

Sebastian
