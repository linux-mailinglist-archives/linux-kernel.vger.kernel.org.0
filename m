Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559B59D6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfHZTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 15:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfHZTpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:45:42 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FD32070B;
        Mon, 26 Aug 2019 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566848741;
        bh=7RD5XolL/SS4b+duqXLuyVNGAaFxlEUknxNCP2rhDfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nG5B3s6F/L/TFvxmSOER1Qhv1UiZev0ARW+kJ1yUXhdfLVKPXxLRP2AiI35+baXFj
         h50uYV4gUkR2UVYNyzU2FpEkZf1NqmoQAEBpWy7kUrB6WyF2xkmPsgcvmqPLxPhWxi
         QtRtw64pBqTD2OQcSiFtEQKs/ZC7njNP0unkw3Ls=
Date:   Mon, 26 Aug 2019 21:45:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V3 28/38] posix-cpu-timers: Restructure expiry array
Message-ID: <20190826194538.GB14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.895254344@linutronix.de>
 <20190826163204.GA14309@lenoir>
 <alpine.DEB.2.21.1908262014260.1939@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908262021140.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908262021140.1939@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:22:24PM +0200, Thomas Gleixner wrote:
> Now that the abused struct task_cputime is gone, it's more natural to
> bundle the expiry cache and the list head of each clock into a struct and
> have an array of those structs.
> 
> Follow the hrtimer naming convention of 'bases' and rename the expiry cache
> to 'nextevt' and adapt all usage sites.
> 
> Generates also better code .text size shrinks by 80 bytes.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> V3: Address review feedback from Frederic

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
