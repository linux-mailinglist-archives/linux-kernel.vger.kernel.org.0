Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECD49D9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 01:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfHZXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 19:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfHZXNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:13:54 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD85420850;
        Mon, 26 Aug 2019 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566861233;
        bh=p0G3APvT967XPqQTYxQe8KtZatxWY2D6NoPY2nad95c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mD7KJPGevzJp+h17FPIrIbyBIBZykEZ0TjRYc1q+r4CN6k8NOVagYlDbkukzxACxO
         HYgqx50HTqml8AeZBiuVD0BiT++PQ80wSwnK7vhqZOEV0odOh3dQq1KGo4Aj1XoxJa
         GCr3Qf2w6tLpmjR4x5TBMGNR9p9AYsbF5GPhBhTY=
Date:   Tue, 27 Aug 2019 01:13:51 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 36/38] posix-cpu-timers: Deduplicate rlimit handling
Message-ID: <20190826231350.GK14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.653276779@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.653276779@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:23PM +0200, Thomas Gleixner wrote:
> Both thread and process expiry functions have the same functionality for
> sending signals for soft and hard RLIMITs duplicated in 4 different
> ways.
> 
> Split it out into a common function and cleanup the callsites.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
