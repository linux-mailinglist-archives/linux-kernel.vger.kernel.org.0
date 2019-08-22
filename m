Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3749B9881D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 01:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfHUXtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 19:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbfHUXtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:49:07 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090F122CE3;
        Wed, 21 Aug 2019 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566431346;
        bh=Jsp24IYATTLgkhf3fiHLeUBHSeF3jEMGE6aXaMgelB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAgpJeac9BC5uxxuC8b62JsbqkekxjL0qAnQvs+yX3rR8xStiQw8jIsf88i3OVE8X
         LDBhdFw1OFOhrJJfF6o1jLgWtQzu3UKFkDZ9e0Sggyk+CJE2G9NMfwYgqaI87HHaUO
         h68O7j5f04P5j0tmSOLNEuAVIJuMaqOIfLHnx2p4=
Date:   Thu, 22 Aug 2019 01:49:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 03/38] posix-cpu-timers: Use common permission check
 in posix_cpu_timer_create()
Message-ID: <20190821234903.GF22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.505833418@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.505833418@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:50PM +0200, Thomas Gleixner wrote:
> Yet another copy of the same thing gone...
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
