Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11AD7272
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 11:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfJOJqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 05:46:02 -0400
Received: from foss.arm.com ([217.140.110.172]:33852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:46:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EE1A28;
        Tue, 15 Oct 2019 02:46:01 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776CD3F68E;
        Tue, 15 Oct 2019 02:46:00 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:45:58 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
        Julien Grall <julien.grall@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
Message-ID: <20191015094557.GU27757@arm.com>
References: <20191014102113.16546-1-julien.grall@arm.com>
 <20191014164313.hu2dnf5rokntzhhp@willie-the-truck>
 <223c22d0-cfe3-4aed-6a8f-b80e44cb6548@arm.com>
 <20191014172016.w6ehilts4nl5tfva@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014172016.w6ehilts4nl5tfva@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:20:17PM +0100, Will Deacon wrote:
> On Mon, Oct 14, 2019 at 05:57:46PM +0100, Suzuki K Poulose wrote:
> > On 14/10/2019 17:43, Will Deacon wrote:
> > > On Mon, Oct 14, 2019 at 11:21:13AM +0100, Julien Grall wrote:
> > > > The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
> > > > will hide the feature from the from userspace.
> > > 
> > > I don't understand this sentence.
> > > 
> > > > Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
> > > > lead to undefined behavior in userspace.
> > > 
> > > Undefined in what way? Generally, we can't stop exposing things that
> > > we've exposed previously in case somebody has started relying on them, so
> > > this needs better justification.
> > 
> > We still expose them with this patch, but zero them out, if the SVE is not
> > supported. When SVE is enabled, we expose them as usual.
> 
> Sure, but if userspace was relying on the non-zero values, it's now broken.
> 
> What's missing from the patch description is the fact that this register is
> RAZ is SVE is not supported. Given that we get both the SVE HWCAP and
> PFR0.SVE field correct when the CONFIG option is disabled, then it's only
> very dodgy userspace which would parse the information in ZFR0 for this
> configuration and I think we can make this change as a bug fix. I'll try to
> write something sensible.

There is no SVE2 hardware yet.  On SVE(1) hardware, ZFR0 is still
reserved and all zero.

In theory userspace could look at the ZFR0 fields and deduce that SVE2 is 
valiable even when the kernel was built with SVE, but I think it highly
unlikely that any software is doing this today.

i.e., I'm pretty sure this horse is still in the stable, and I'd like to
see the door closed ;)

Cheers
---Dave
