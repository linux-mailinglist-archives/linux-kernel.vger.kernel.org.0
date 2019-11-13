Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0AFBBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 23:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKMWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 17:31:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39297 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:31:05 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iV1AB-0007co-HT; Wed, 13 Nov 2019 23:30:59 +0100
Date:   Wed, 13 Nov 2019 23:30:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     y2038@lists.linaro.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 22/23] [RFC] y2038: itimer: use ktime_t internally
In-Reply-To: <20191108211323.1806194-13-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1911132329330.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-13-arnd@arndb.de>
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

On Fri, 8 Nov 2019, Arnd Bergmann wrote:
> Avoid the intermediate step going from timeval to timespec64 to
> ktime_t and back by using ktime_t throughout the code.
> 
> I was going back and forth between the two implementations.
> This patch is optional: if we want it, it could be folded into
> the patch converting to itimerspec64.
> 
> On an arm32 build, this version actually produces 10% larger
> code than the timespec64 version, while on x86-64 it's the
> same as before, and the number of source lines stays the
> same as well.

Right. For 32bit without a native 64/32 division this is going to be more
text and I'm not really convinvced that this buys us anything.

Thanks,

	tglx
