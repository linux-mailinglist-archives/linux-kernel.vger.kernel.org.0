Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC0FAE63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKMKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 05:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKMKYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:24:03 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4396D222C1;
        Wed, 13 Nov 2019 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573640643;
        bh=ORAZV8c4f8R1ApOoI1BE23utHyso6gzFfy189+ri230=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkoHFrFWIiShRIxqfVRikTkXJR1MkCX3YKD7VP6IqjiC0eaULmNoE6thsfbO8PhJE
         d4CJg+0i1o9DCtJY45bD6btuwqIMxflnQGbSND873mf5Eg7Sw6+WXy18q8xrqtPNpc
         ljRNRVOL8dd0qgB+vr6RukkEejxwPA6HkawFMS4k=
Date:   Wed, 13 Nov 2019 10:23:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincent Whitchurch <rabinv@axis.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read
 hazard
Message-ID: <20191113102357.GA25875@willie-the-truck>
References: <20191112130244.16630-1-vincent.whitchurch@axis.com>
 <20191112160855.GA22025@arrakis.emea.arm.com>
 <20191112180034.GB19889@willie-the-truck>
 <20191112182249.GB22025@arrakis.emea.arm.com>
 <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:39:01AM -0800, Linus Torvalds wrote:
> On Tue, Nov 12, 2019 at 10:22 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > OK, so this includes changing test_bit() to perform a READ_ONCE.
> 
> That's not going to happen.

Ok, I'll stick my neck out here, but if test_bit() is being used to read
a bitmap that is being concurrently modified (e.g. by set_bit() which boils
down to atomic_long_or()), then why isn't READ_ONCE() required? Right now,
test_bit takes a 'const volatile unsigned long *addr' argument, so I don't
see that you'll get a change in codegen except on alpha and, with this
erratum, arm32.

Will
