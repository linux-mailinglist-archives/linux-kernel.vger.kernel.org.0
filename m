Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC99D7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfHZVMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 17:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfHZVMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:12:09 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DFD2070B;
        Mon, 26 Aug 2019 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566853928;
        bh=DRGrMvHxWrkglbTzM6C9hc0YIL+j6duH1WM/iEkc2gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/fGsTi/dYNVA26v6IqlSqGJsi5Xn1feW4c61rGjFoA9qQ9qu3IK5y2tijiI9NXe5
         m1ovUU5BA6x4KaVh2WuwdUW0YwXFPotV/eSIJKtLAJUhHTMJ3MjwLJBa+uOUz52GnB
         64t82tpSAL1IUZsXKp1JnffC/gFyEciZaJfgFAkQ=
Date:   Mon, 26 Aug 2019 23:12:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 29/38] posix-cpu-timers: Switch thread group sampling
 to array
Message-ID: <20190826211205.GD14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.988426956@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.988426956@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:16PM +0200, Thomas Gleixner wrote:
> That allows more simplifications in various places.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
