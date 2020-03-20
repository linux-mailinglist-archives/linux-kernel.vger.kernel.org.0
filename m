Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCE18C863
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 09:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCTH7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 03:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgCTH7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:59:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4336320767;
        Fri, 20 Mar 2020 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584691149;
        bh=Mszy2lxZVJLrMkR5k80DgVuQoQGtsJlqkm57nqwNUTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+8z5a+aty2pRVXUXTLoXOGEmyXZKGlIVJmT2cm3I2lFjhaBqLgIqFghjcTEfSSR5
         uzf8IbFWB2B8qBJpC+Yz3ASM9OMIMfPxOnwUd7g2gxv3ND36kQ/ew3nYzJgXc9+EcU
         /QFC9GEFfh3DrXP8v7UrOJqf6a5foKYDh0LaxR24=
Date:   Fri, 20 Mar 2020 07:59:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Tuan Phan <tuanphan@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
Message-ID: <20200320075904.GA2549@willie-the-truck>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319151646.GC4876@lakrids.cambridge.arm.com>
 <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:03:43PM -0700, Tuan Phan wrote:
>    Please find my comments below.
> 
>      On Mar 19, 2020, at 8:16 AM, Mark Rutland <[1]mark.rutland@arm.com>
>      wrote:
>      Hi Tuan,
> 
>      On Tue, Mar 17, 2020 at 05:29:38PM -0700, Tuan Phan wrote:
> 
>        DMC-620 PMU supports total 10 counters which each is
>        independently programmable to different events and can
>        be started and stopped individually.
> 
>      Looking at the TRM for DMC-620, the PMU registers are not in a separate
>      frame from the other DMC control registers, and start at offset 0xA00
>      (AKA 2560). I would generally expect that access to the DMC control
>      registers was restricted to the secure world; is that not the case on
>      your platform?
> 
>      I ask because if those are not restricted, the Normal world could
>      potentially undermine the Secure world through this (e.g. playing with
>      training settings, messing with the physical memory map, injecting RAS
>      errors). Have you considered this?
> 
>    => Only PMU registers can be accessed within normal world. I only pass
>    PMU registers (offset 0xA00) to kernel so shouldn’t be problem.

Just a stylistic thing since there's been a bit of back-and-forth on this
patch, but please can you fix your email client configuration so that the
replies are threaded properly? '=>' is non-standard and it's pretty
hard to spot in a mass of C code. You can look at
Documentation/process/email-clients.rst for some information about
configuring common clients.

Apologies if this comes across as pedantic, but it makes a surprising
difference in how easy it is to keep up with the thread (at least to me).

Will
