Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9C17B2EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCFA1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:54 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCFA1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:43 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3K1BwNz9sRY; Fri,  6 Mar 2020 11:27:40 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9e27086292aa880921a0f2b8501e5189d5efcf03
In-Reply-To: <8ee3bdbbdfdfc64ca7001e90c43b2aee6f333578.1580470482.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] powerpc/32: Warn and return ENOSYS on syscalls from kernel
Message-Id: <48YT3K1BwNz9sRY@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:40 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-31 at 11:34:54 UTC, Christophe Leroy wrote:
> Since commit b86fb88855ea ("powerpc/32: implement fast entry for
> syscalls on non BOOKE") and commit 1a4b739bbb4f ("powerpc/32:
> implement fast entry for syscalls on BOOKE"), syscalls from
> kernel are unexpected and can have catastrophic consequences
> as it will destroy the kernel stack.
> 
> Test MSR_PR on syscall entry. In case syscall is from kernel,
> emit a warning and return ENOSYS error.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e27086292aa880921a0f2b8501e5189d5efcf03

cheers
