Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9313D9964D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbfHVOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730741AbfHVOUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:20:49 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361F621743;
        Thu, 22 Aug 2019 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566483648;
        bh=8MqlUatSctkbqp+1Hg7nVyv4KXdjvXtOXlS6Wst43Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujbU2O2jnyREorVwJ+WmmJw/KnqRSX/+CKahp8nRonFsSCWsbN8ZQxNNGJ9zFX8Rk
         rDb8oMraS0tKyXs5GgPLd3RY9Sqw3lHgFxNOBW4GkIx1EPdvAcCKm1a9EBHu5OHMWo
         7vmq5hzDsGAk7rWybUhVvM1EncJ5q/vZTx6nnmcE=
Date:   Thu, 22 Aug 2019 16:20:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 13/38] posix-cpu-timers: Simplify sample functions
Message-ID: <20190822142045.GQ22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.430475832@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.430475832@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:00PM +0200, Thomas Gleixner wrote:
> All callers hand in a valdiated clock id. Remove the return value which was
> unchecked in most places anyway.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
