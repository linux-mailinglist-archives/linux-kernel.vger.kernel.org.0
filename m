Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5930E361AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfFEQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 12:54:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfFEQyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621C0374;
        Wed,  5 Jun 2019 09:54:05 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 708623F5AF;
        Wed,  5 Jun 2019 09:54:03 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:54:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>
Subject: Re: [PATCH v4 0/4] ptrace: cleanup PTRACE_SYSEMU handling and add
 support for arm64
Message-ID: <20190605165400.GF50849@arrakis.emea.arm.com>
References: <20190523090618.13410-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523090618.13410-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:06:14AM +0100, Sudeep Holla wrote:
> Sudeep Holla (4):
>   ptrace: move clearing of TIF_SYSCALL_EMU flag to core
>   x86: simplify _TIF_SYSCALL_EMU handling
>   arm64: add PTRACE_SYSEMU{,SINGLESTEP} definations to uapi headers
>   arm64: ptrace: add support for syscall emulation

I queued patches 1, 3 and 4 through the arm64 tree. There is no
dependency on patch 2 (just general clean-)up; happy to take it as well
or it can go in via the x86 tree.

Thanks.

-- 
Catalin
