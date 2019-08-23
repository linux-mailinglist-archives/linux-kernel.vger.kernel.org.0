Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225399B86A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 00:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393536AbfHWWIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 18:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390696AbfHWWIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:08:34 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D7632133F;
        Fri, 23 Aug 2019 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566598113;
        bh=G0dH8kOQk5jbwTacpJ4dBkjxVRoiZa/oibpE8Yd5mBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OX5QxC6ns/DPJeqbU8tZXjkiINGgbP0inlm0wpFYHsB0Z6xF+5+HSJwJ8VYMV4NFi
         NTA79TSYGyuOh/EaQXM/6rwQ28q12xSmtxwfSmep8H8qQ62ZvW8YTezzIWVMWAUco5
         j+ALBOepABXsEFPS2iGEkh85mv9T6m6pd3V3LqSs=
Date:   Sat, 24 Aug 2019 00:08:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 25/38] posix-cpu-timers: Provide array based sample
 functions
Message-ID: <20190823220829.GF18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.590362974@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.590362974@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:12PM +0200, Thomas Gleixner wrote:
> Instead of using task_cputime and doing the addition of utime and stime at
> all call sites, it's way simpler to have a sample array which allows
> indexed based checks against the expiry cache array.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
