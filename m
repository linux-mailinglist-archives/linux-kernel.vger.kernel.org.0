Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DFBB82E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfIWPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 11:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732187AbfIWPna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:43:30 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4203D207FD;
        Mon, 23 Sep 2019 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569253409;
        bh=ttds3Shcs38MGHzlIYyXHPzBWxdCC9mn77x2AHy99sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QucP4TY8c18+RG9iGSl8HbISn3okju7W2vK+jgQmLgcYQ4c3SsPmQ/rF7nnG7hrPT
         JPG+HR2aRdsU/2nPY+82pS4POD8Qvc6RGlo3bE02sIs4rdA2GmD4+0kiLE0to+U1dL
         v9sriNDiZfgNkaOFsEX/YuKBOHnc2lqMlbusg0PI=
Date:   Mon, 23 Sep 2019 17:43:26 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 5/6] posix-cpu-timers: Return PTR_ERR() from
 lookup_task()
Message-ID: <20190923154325.GA11264@lenoir>
References: <20190923145435.507024424@linutronix.de>
 <20190923145528.856703803@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923145528.856703803@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 04:54:40PM +0200, Thomas Gleixner wrote:
> To prepare for changing the return code to -EPERM when the ptrace
> permission check fails, use PTR_ERR() to return the error information from
> lookup_task() and fixup all call sites.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
