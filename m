Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77499391
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 14:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfHVMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 08:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbfHVMaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:30:39 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0B9206BB;
        Thu, 22 Aug 2019 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566477039;
        bh=ahKZi1+AXtwqX3cogI5vAgJtQWrq4XQrFQxDGnNh/LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D27xi+3WiAAQUUNWj3tLyjnhXKZynfZFELokQqdltMU5dS68ZXsznN8y6R4mVL05G
         jHXF/NlM+Q0QWiOOTD9IJqArghiKfXPxy6dDA9EeKAg0a2YASsazkswhMazmY5yj1/
         Y4+uzcox6tuFqrSzeOtpFtjREWO7jUUlXIs6CjMw=
Date:   Thu, 22 Aug 2019 14:30:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 06/38] posix-cpu-timers: Sample directly in timer check
Message-ID: <20190822123036.GJ22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.780348088@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.780348088@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:53PM +0200, Thomas Gleixner wrote:
> The thread group accounting is active, otherwise the expiry function would
> not be running. Sample the thread group time directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
