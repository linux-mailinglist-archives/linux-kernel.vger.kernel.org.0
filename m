Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 420C999794
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbfHVPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 11:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732031AbfHVPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:00:42 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039EE21848;
        Thu, 22 Aug 2019 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566486041;
        bh=pSglNgp5cMD7g3PFXVDMsB9Xsg0Uivd7RDShHA0TPvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1n/hMstLjBDXP2pDAebnnyEtAB4s4lKNWpwmG0zuRAmx19j3V4KO2x7fkjtyQ5rY
         adj25eWq/DZIY9ASwLsdsKx5ZnsFTFTbMYdvH+/rNYBfRQk7FhoQdKTuawyCJAi4Aa
         GnpKMgxZJ8AcZCB9/8FaHyaGhtJnfRfOessx8PLk=
Date:   Thu, 22 Aug 2019 17:00:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 15/38] posix-cpu-timers: Sample task times once in
 expiry check
Message-ID: <20190822150038.GS22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.639878168@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.639878168@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:02PM +0200, Thomas Gleixner wrote:
> Sampling the task times twice does not make sense. Do it once.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>



