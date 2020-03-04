Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759F9178D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgCDJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 04:39:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgCDJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:39:48 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j9QVC-0008B7-PP; Wed, 04 Mar 2020 10:39:42 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EC4DE101161; Wed,  4 Mar 2020 10:39:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>, fweisbec@gmail.com, mingo@kernel.org
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tick/sched: fix data races at tick_do_timer_cpu
In-Reply-To: <20200225030808.1207-1-cai@lca.pw>
References: <20200225030808.1207-1-cai@lca.pw>
Date:   Wed, 04 Mar 2020 10:39:41 +0100
Message-ID: <87tv34laqq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian,

Qian Cai <cai@lca.pw> writes:
> tick_do_timer_cpu could be accessed concurrently where both plain writes
> and plain reads are not protected by a lock. Thus, it could result in
> data races. Fix them by adding pairs of READ|WRITE_ONCE(). The data
> races were reported by KCSAN,

They are reported, but are they actually a real problem?

This completely lacks analysis why these 8 places need the
READ/WRITE_ONCE() treatment at all and if so why the other 14 places
accessing tick_do_timer_cpu are safe without it.

I definitely appreciate the work done with KCSAN, but just making the
tool shut up does not cut it. 

Thanks,

        tglx
