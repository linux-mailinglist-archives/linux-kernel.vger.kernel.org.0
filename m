Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0918998C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 18:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389737AbfHVQGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 12:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389728AbfHVQGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:06:33 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3786E206B7;
        Thu, 22 Aug 2019 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566489992;
        bh=UEdjBKrSYmEI14ilij+iWsNrKB9A0BXhCRFWj0jWRCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSEo4L/m1JUdRK0HmY8458BZbdGqlVWokmPb51x99hjUSvGGzhxvdXWpAU9dqB2I1
         nmOI0R6SP0Sw+dccb3AhuDlsQqLkzxEIb4pXMi5tn/1/J2QLauWXVYQksPKtDpAl6K
         rWHQLjgIhK54MsUcuybsnf3SWYSVGy7t/TQ9rZjY=
Date:   Thu, 22 Aug 2019 18:06:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 18/38] sched: Move struct task_cputime to types.h
Message-ID: <20190822160629.GA8025@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.909530418@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.909530418@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:05PM +0200, Thomas Gleixner wrote:
> For upcoming posix-timer changes to avoid include recursion hell.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
