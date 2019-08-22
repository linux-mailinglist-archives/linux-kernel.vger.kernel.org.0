Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D58699711
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfHVOlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfHVOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:41:47 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FE7233A1;
        Thu, 22 Aug 2019 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566484906;
        bh=xbTF8AseRu01mR/EJfz3wstTj03rAj+32ynAtGi6ytQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrYUTaHAc5uY99i0UbHQP96oyVsZ4v2UeRGZw+LFJwAvyEML0OT4YU2iosLEsWwzp
         AyYMZspul2AXS3ZOQngqo8H414ASKbM4qJ0d8UwmGmjh8UeYCRbwpr8JY7Egzad0k2
         spguzpf5p1q+yZ6cMWVRmd0cGcB/iZRqqKySqb4s=
Date:   Thu, 22 Aug 2019 16:41:44 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 14/38] posix-cpu-timers: Get rid of pointer indirection
Message-ID: <20190822144143.GR22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.535079278@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.535079278@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:01PM +0200, Thomas Gleixner wrote:
> Now that the sample functions have no return value anymore, the result can
> simply be returned instead of using pointer indirection.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
