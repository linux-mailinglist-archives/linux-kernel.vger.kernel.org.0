Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFE9960A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfHVOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732967AbfHVOMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:12:46 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200EA22CE3;
        Thu, 22 Aug 2019 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566483165;
        bh=nWP/2ULFH3A6Daof8G9OmYmBCjhYFdyyfa04PSEqodM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zuy6snB559DB/IM7RYY0dJDxbCb4qLnPheCrmZXZF/aUBZ9mG58NFzCGlYyJ+8o37
         3cVg9HVBJPuTkHrQfigDfDcaL+a6Eu2Csc3Nlr7E2aW1cEOK7vQcP7grjfZ7IHoaG/
         TPPD+XH4AscWBCaJO9RiWZFLs0n3txBlNxc+YKDs=
Date:   Thu, 22 Aug 2019 16:12:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 11/38] posix-cpu-timers: Use clock ID in
 posix_cpu_timer_rearm()
Message-ID: <20190822141242.GO22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.245357769@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.245357769@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:58PM +0200, Thomas Gleixner wrote:
> Extract the clock ID (PROF/VIRT/SCHED) from the clock selector and use it
> as argument to the sample functions. That allows to simplify them once all
> callers are fixed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
