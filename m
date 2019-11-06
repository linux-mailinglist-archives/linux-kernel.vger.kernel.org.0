Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD6F1D25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 19:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfKFSJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 13:09:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44988 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:09:15 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSPk0-00010x-66; Wed, 06 Nov 2019 19:09:12 +0100
Date:   Wed, 6 Nov 2019 19:09:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eric Dumazet <edumazet@google.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] hrtimer: Annotate lockless access to timer->state
In-Reply-To: <20191106174804.74723-1-edumazet@google.com>
Message-ID: <alpine.DEB.2.21.1911061908070.1869@nanos.tec.linutronix.de>
References: <20191106174804.74723-1-edumazet@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019, Eric Dumazet wrote:
> @@ -1013,8 +1013,9 @@ static void __remove_hrtimer(struct hrtimer *timer,
>  static inline int
>  remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
>  {
> -	if (hrtimer_is_queued(timer)) {
> -		u8 state = timer->state;
> +	u8 state = timer->state;

Shouldn't that be a read once then at least for consistency sake?

> +
> +	if (state & HRTIMER_STATE_ENQUEUED) {
>  		int reprogram;

Thanks,

	tglx
