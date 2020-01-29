Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6614C585
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgA2FRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:30 -0500
Received: from ozlabs.org ([203.11.71.1]:33401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:28 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDj4pFyz9sRs; Wed, 29 Jan 2020 16:17:25 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 39413ae009674c6ba745850515b551bbb9d6374b
In-Reply-To: <05105deeaf63bc02151aea2cdeaf525534e0e9d4.1574790198.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ravi.bangoria@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow any address range size.
Message-Id: <486sDj4pFyz9sRs@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:25 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-26 at 17:43:29 UTC, Christophe Leroy wrote:
> Unlike standard powerpc, Powerpc 8xx doesn't have SPRN_DABR, but
> it has a breakpoint support based on a set of comparators which
> allow more flexibility.
> 
> Commit 4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint")
> implemented breakpoints by emulating the DABR behaviour. It did
> this by setting one comparator the match 4 bytes at breakpoint address
> and the other comparator to match 4 bytes at breakpoint address + 4.
> 
> Rewrite 8xx hw_breakpoint to make breakpoints match all addresses
> defined by the breakpoint address and length by making full use of
> comparators.
> 
> Now, comparator E is set to match any address greater than breakpoint
> address minus one. Comparator F is set to match any address lower than
> breakpoint address plus breakpoint length. Addresses are aligned
> to 32 bits.
> 
> When the breakpoint range starts at address 0, the breakpoint is set
> to match comparator F only. When the breakpoint range end at address
> 0xffffffff, the breakpoint is set to match comparator E only.
> Otherwise the breakpoint is set to match comparator E and F.
> 
> At the same time, use registers bit names instead of hardcoded values.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39413ae009674c6ba745850515b551bbb9d6374b

cheers
