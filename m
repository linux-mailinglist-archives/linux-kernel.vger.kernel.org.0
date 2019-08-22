Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A9995A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfHVN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbfHVN6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:58:15 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC2622CE3;
        Thu, 22 Aug 2019 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566482294;
        bh=eO1RVb17fEUiR+/b8yPXYWTrWOV14P33qgvAIAz0UB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2phn2JO8/tiKMudS000bH4cV20LOQHcemjJ6MrcrVGNBdKWsv9RZvcp4kz9zpa6k
         DlgoK+aqzbNdRDrDxtksvnuj5j5SyeW7T4rHn6H5/moBTaBscoM1cZGKPQIxfYFNUb
         oYyw3xHk0VC+GQUKD7QehZCb+6y/xmhhPF57QDCs=
Date:   Thu, 22 Aug 2019 15:58:12 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 09/38] posix-cpu-timers: Use clock ID in
 posix_cpu_timer_set()
Message-ID: <20190822135811.GM22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.050770464@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.050770464@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:56PM +0200, Thomas Gleixner wrote:
> Extract the clock ID (PROF/VIRT/SCHED) from the clock selector and use it
> as argument to the sample functions. That allows to simplify them once all
> callers are fixed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
