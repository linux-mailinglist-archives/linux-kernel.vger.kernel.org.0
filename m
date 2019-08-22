Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D922997AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 17:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfHVPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 11:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733195AbfHVPFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:05:41 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4392133F;
        Thu, 22 Aug 2019 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566486340;
        bh=ARXMdetLL7XUe+Xhds5ZWi6OhKRudd083ZWDK3jFtHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyzYYvpmj7UbwYFOpINCRHAtCbq+gnDq5q2yb2jVEdoVB9ZGF4w6YHkDfA+kQ2btg
         0zYrtLJvj9XnLEcnZuU6ttJ55dsZwNjSh2U8HhdhRWffvtYsAMkvcU4a3Q4AtL87Hi
         NU2qQgy6L+X6ZCuwNrwYX7Y3mq4CK6rTyf5ahv/M=
Date:   Thu, 22 Aug 2019 17:05:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 16/38] posix-cpu-timers: Move prof/virt_ticks into
 caller
Message-ID: <20190822150537.GT22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.729298382@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.729298382@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:03PM +0200, Thomas Gleixner wrote:
> The functions have only one caller left. No point in having them.
> 
> Move the almost duplicated code into the caller and simplify it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
