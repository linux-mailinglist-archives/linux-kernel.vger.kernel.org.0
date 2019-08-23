Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379729B641
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 20:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405450AbfHWSgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 14:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390289AbfHWSgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:36:42 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CC220850;
        Fri, 23 Aug 2019 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566585401;
        bh=F1cX7V8F3P2cdsrxbcA9NIsN4oXVD5aJKCyFgtfrslk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knAwhTX5reSc0V3fyNMeOdokgqVkk5y6PlBt1is7RkE5Y3OibmjvEACgvG9zV/Kqv
         sH1YlH7m2AJ/w47qm7SsFcvjutNTFKP/n7rv5bZGxN3l5dSysVT+yr4y8kOKhCEJdk
         e++CSQMwavzxP2YRoF0r7fnH57SPychFP6FIkcsg=
Date:   Fri, 23 Aug 2019 20:36:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 24/38] posix-cpu-timers: Remove the odd field rename
 defines
Message-ID: <20190823183638.GE18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.499058279@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.499058279@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:11PM +0200, Thomas Gleixner wrote:
> The last users of the odd define based renaming of struct task_cputime
> members are gone. Good riddance.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
