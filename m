Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C99D9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 01:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfHZXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 19:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZXAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:00:02 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDF1206BA;
        Mon, 26 Aug 2019 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566860401;
        bh=9HU752brhPDitF+fXtIax2+34bksF89mk8XaaI0hlHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI5rkvRNL0XsTCijI2EoyZ5UlQ7WhyXvi2hWlmKVaXHMu5zQGIufp1ZMQsbJSqA4K
         rYdoqGs5TfHRO0nJJsuZvQ2HyLwjIk7Kah7ZaAbUu3SuvGPEdzMulvFhdkJ5/6AegO
         ++AtuW8Zhaul63bQhEx2+OqdpgfjUV1NchzNwtfU=
Date:   Tue, 27 Aug 2019 00:59:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 35/38] posix-cpu-timers: Remove pointless comparisons
Message-ID: <20190826225958.GJ14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.548747613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.548747613@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:22PM +0200, Thomas Gleixner wrote:
> The soft RLIMIT expiry code checks whether the soft limit is greater than
> the hard limit. That's pointless because if the soft RLIMIT is greater than
> the hard RLIMIT then that code cannot be reached as the hard RLIMIT check
> is before that and already killed the process.
> 
> Remove it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
