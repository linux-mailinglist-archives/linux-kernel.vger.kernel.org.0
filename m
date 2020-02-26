Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71416F4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 02:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgBZBLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 20:11:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbgBZBLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:11:10 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B243722464;
        Wed, 26 Feb 2020 01:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582679470;
        bh=rjupCGwxw7zOnxBHoDIJMEt8I2FYeBBqHK17L7uhGYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGhs0a6QLHHnPq/xFMnROfP4NZUiltFYXpYdlHpLcT5gw9hXQn3upwnX4A8HM5/9I
         yLBbi2iHmGaSvy13xqoQulpPPCYmpGOahNM3irVeffUkW2kr3beCCaIDhBbg3gG1PB
         lZouvkB+I2p91OgoDNimJgM3ExjpJtvTjMmco+9U=
Date:   Wed, 26 Feb 2020 02:11:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 03/10] x86/entry/32: Force MCE through do_mce()
Message-ID: <20200226011107.GG9599@lenoir>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.428188397@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225220216.428188397@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:36:39PM +0100, Thomas Gleixner wrote:
> Remove the pointless difference between 32 and 64 bit to make further
> unifications simpler.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
