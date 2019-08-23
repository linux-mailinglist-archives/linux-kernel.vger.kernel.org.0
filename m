Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96369B5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404673AbfHWRvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 13:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404606AbfHWRvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:51:35 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4002921019;
        Fri, 23 Aug 2019 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566582694;
        bh=T0dcBlfkPBG8nwJLrEVrM53L3v1scjP0OhY9kYzoxwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eN6f2Mja1HQFjUGr+KcjvocgTIU55qS1hJCqoIriWj0l5RKlxZyNjBzFArwYN8RW9
         r5KgjkCfz2ZSzIo0WLFP/5iBH5qLwUxQVe5JO0/gkxQ7kNGlztog9tbY7rqbxIkzfo
         cSYD3Ny5PN1oZPuGvVElU3xg9oOh13gmX9F/p91Q=
Date:   Fri, 23 Aug 2019 19:51:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 21/38] posix-cpu-timers: Simplify timer queueing
Message-ID: <20190823175131.GB18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.212129449@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.212129449@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:08PM +0200, Thomas Gleixner wrote:
> Now that the expiry cache can be accessed as an array, the per clock
> checking can be reduced to just comparing the corresponding array elements.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
