Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68ABB104420
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 20:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfKTTST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 14:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfKTTST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:18:19 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5C420855;
        Wed, 20 Nov 2019 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574277498;
        bh=7UC1p05lqHNeIwWrK44s+QdCnsy4ZgEBXbsj/3SOi4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9kcqFrnoKUkALPWQpNkZnUzLHHed0WfD+0gr4OxoB3q1iaUI7GT/g/h7g0AbYoQJ
         IUrK+68/Hpw1yEIyq7upZ1+LkOCX11du/YcD1GM2XksuoSYP0yWYOFbjo37YbyBXoI
         s8xnNCm8dmr+NZqua13pcMtSbgOPzMpoYcpK9lUE=
Date:   Wed, 20 Nov 2019 19:18:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pavel Labath <labath@google.com>,
        Pratyush Anand <panand@redhat.com>, mka@chromium.org,
        kinaba@google.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
Message-ID: <20191120191813.GD4799@willie-the-truck>
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 11:12:26AM -0700, Douglas Anderson wrote:
> This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
> watchpoint addresses") but ported to arm32, which has the same
> problem.
> 
> This problem was found by Android CTS tests, notably the
> "watchpoint_imprecise" test [1].  I tested locally against a copycat
> (simplified) version of the test though.
> 
> [1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
>  1 file changed, 70 insertions(+), 26 deletions(-)

Sorry for taking so long to look at this. After wrapping my head around the
logic again, I think it looks fine, so please put it into the patch system
with my Ack:

Acked-by: Will Deacon <will@kernel.org>

One interesting difference between the implementation here and the arm64
code is that I think if you have multiple watchpoints, all of which fire
with a distance != 0, then arm32 will actually report them all whereas
you'd only get one on arm64.

Will
