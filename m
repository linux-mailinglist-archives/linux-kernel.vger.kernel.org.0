Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23412D2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 18:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfL3Rjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 12:39:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3Rjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:39:48 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CAB520409;
        Mon, 30 Dec 2019 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577727588;
        bh=D3Q8pCZEwFu1FI0ot0RtUu0DgLxkR3MJgRisFehfLwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdzW7rH1E3OBppFIs9xpZUh7tHhJjs0ynVQR7U26zfgc5qAgWTzbqUUjPpCmPS9D6
         7FqlCOk2jz9Oz20c2QM5mt1lyaOdQAn2QBBFfuny/YkJjoQZix7U4BCe+RCX4ACAqV
         8ytOt66KaKp1XuoxTL412I/QwBb1HiWfnQi72ZaM=
Date:   Mon, 30 Dec 2019 18:39:44 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/vtime: Prevent unstable evaluation of
 WARN(vtime->state)
Message-ID: <20191230173943.GA12625@lenoir>
References: <20191230010839.GA8740@lenoir>
 <20191230090436.3749235-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230090436.3749235-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:04:36AM +0000, Chris Wilson wrote:
> As the vtime is sampled under loose seqcount protection by kcpustat, the
> vtime fields may change as the code flows. Where logic dictates a field
> has a static value, use a READ_ONCE.
> 
> Fixes: 74722bb223d0 ("sched/vtime: Bring up complete kcpustat accessor")
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>

Oh thanks for taking the time to make it a proper patch!
Looks good, I'm relaying it.
