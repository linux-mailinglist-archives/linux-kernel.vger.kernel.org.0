Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A16ADBE9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfIIPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 11:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfIIPNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:13:46 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9895F218DE;
        Mon,  9 Sep 2019 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568042026;
        bh=OczvaEWRZL6NBT+VidhTnFSZ337CKbE2ZtYD2wSxjbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5paWlIAqD2qaRD+OPdm/FmQISn2MvatJnaO3ZDAwL2QbxW2ecVqOFRUHcI1nEsFh
         xVL28vB3dCtkl0hwmpA+ok77bZ2UVWS3csNwd+ppDYoBO/pOAY5qpFSb3/3KsLWDTY
         X6QwNVRqe4baT7PAq0vgMfrpyQL5nd2jT35LjydU=
Date:   Mon, 9 Sep 2019 17:13:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 2/6] posix-cpu-timers: Fix permission check regression
Message-ID: <20190909151342.GA2319@lerouge>
References: <20190905120339.561100423@linutronix.de>
 <20190905120539.797994508@linutronix.de>
 <20190905173148.GE18251@lenoir>
 <alpine.DEB.2.21.1909052054200.1902@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1909052314110.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909052314110.1902@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:15:08PM +0200, Thomas Gleixner wrote:
> +	if (gettime) {
> +		/*
> +		 * For clock_gettime(PROCESS) the task does not need to be
> +		 * the actual group leader. tsk->sighand gives
> +		 * access to the group's clock.
> +		 *
> +		 * Timers need the group leader because they take a
> +		 * reference on it and store the task pointer until the
> +		 * timer is destroyed.

Well, that would work with a non group leader as well but anyway that wouldn't
be pretty.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
