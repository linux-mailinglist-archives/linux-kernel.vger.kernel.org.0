Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3DE191BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 22:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgCXVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 17:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgCXVIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:08:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1E22074D;
        Tue, 24 Mar 2020 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585084095;
        bh=Ts2q4lc5rS0zE3p9NKfuZ3OCIDyXTdzeBDRNZoAYpTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dcbn27CTP2jdEE8Ft12vQNu+KMxtzPKAyV+xeoInVKlIwjJB9hsf+U831sbsfiY9s
         79yCeVkuICil1S4IFAkNrKNbTMyHP2iMAWtYIjJJIG5KnsML5NtKNjADY/lmxvnjTc
         vpdD56t4J55t5JoPQSl+f0JSXuFSCmOpP/2m/gK8=
Date:   Tue, 24 Mar 2020 21:08:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 17/21] linux/bit_spinlock.h: Include linux/processor.h
Message-ID: <20200324210808.GA19527@willie-the-truck>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-18-will@kernel.org>
 <20200324162820.GD2518046@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324162820.GD2518046@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:28:20PM +0100, Greg KH wrote:
> On Tue, Mar 24, 2020 at 03:36:39PM +0000, Will Deacon wrote:
> > Needed for cpu_relax().
> 
> Is this needed now, or for the next patch?  And if for next patch, why
> not just add it then?

If the next patch correctly included linux/list_bl.h like it was supposed
to, then yes, it's needed there. I'll sort that out and fold this in for
v2.

Cheers,

Will
