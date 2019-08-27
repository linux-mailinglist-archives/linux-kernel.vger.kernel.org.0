Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816139F609
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 00:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfH0WXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 18:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfH0WXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:23:44 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B57572064A;
        Tue, 27 Aug 2019 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566944624;
        bh=wrgMxRiEbbnMISiCbMW2B+ejrqY+Fb98MyvM7i0IXmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5hN8/38Xlvw/G3uK0XxyZ8ky5rlMQzOoM8N61AUmx0hCGPOeD0ASn0wHmNMqX0u/
         kV1gf7ll4mbFko/cGD0bG/RvIM2dzsuyc6wDvFZ2AxJvHc43hDURbTehREpw9LoRZ9
         WQ6gLJXHSAHGWbVRIguCl1ebG8/EyJikr5EzugJc=
Date:   Wed, 28 Aug 2019 00:23:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V3 38/38] posix-cpu-timers: Utilize timerqueue for storage
Message-ID: <20190827222340.GB25843@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.835676817@linutronix.de>
 <20190827004846.GM14309@lenoir>
 <alpine.DEB.2.21.1908270807080.1939@nanos.tec.linutronix.de>
 <20190827131727.GA25843@lenoir>
 <alpine.DEB.2.21.1908271545070.1939@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908272129220.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908272129220.1939@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:31:02PM +0200, Thomas Gleixner wrote:
> Using a linear O(N) search for timer insertion affects execution time and
> D-cache footprint badly with a larger number of timers.
> 
> Switch the storage to a timerqueue which is already used for hrtimers and
> alarmtimers. It does not affect the size of struct k_itimer as it.alarm is
> still larger.
> 
> The extra list head for the expiry list will go away later once the expiry
> is moved into task work context.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Adopt to the per clock base struct
> V3: Fixup memset() and clear cputtimer::head in cleanup_timerqueue()

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
