Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E1977FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHULge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 07:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfHULge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:36:34 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D956422CE3;
        Wed, 21 Aug 2019 11:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566387393;
        bh=1Yfso7kLgQK54i/hrpHRixPOrPi0vRgJS8v6dAgcoMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ilmm/8+gHjK/1kPqM0yRv/9Q5tSG8BcnU1d7yiynhqrMedI60aYpb9E4UhtDuTZIo
         K+ixG8n4FGB/egX5O/jYpo9B//ek51ygMVYvUHIWDFw3uevgmInHL0JGgnshMDPoCM
         w9rtabcmpeP15alqr49VWcyD805Fz09ByvoHfSCo=
Date:   Wed, 21 Aug 2019 13:36:31 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 06/44] posix-cpu-timers: Remove tsk argument from
 run_posix_cpu_timers()
Message-ID: <20190821113630.GC16213@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.945469967@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.945469967@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:47PM +0200, Thomas Gleixner wrote:
> It's always current. Don't give people wrong ideas.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
