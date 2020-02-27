Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B42B172BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgB0WpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbgB0WpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:45:06 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FE8246A1;
        Thu, 27 Feb 2020 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582843505;
        bh=KE6d1FyD4vCuDWtt9ILqMivwZIi6i5fxzq6HNRIt1oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yUSHmQpLA/ur/9DuxTjQYlNR2kkODsyBeWrbG59d1FHIPfmOZnaY+W5S1khI/H4xz
         lExwDtKgXzcNkEz/5ktZWbWn5MNNYwUs1EMj69IPyI5txOkLr0iAC2qoJ+8ctPPDkQ
         no4vauhKQg6ij8MSZPfFDbbTrVeVAXRaxoAUeZoA=
Date:   Thu, 27 Feb 2020 23:45:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/8] x86/entry/64: Trace irqflags unconditionally on when
 returing to user space
Message-ID: <20200227224502.GC21795@lenoir>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.295289073@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225221305.295289073@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:08:02PM +0100, Thomas Gleixner wrote:
> User space cannot longer disable interrupts so trace return to user space
> unconditionally as IRQS_ON.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
