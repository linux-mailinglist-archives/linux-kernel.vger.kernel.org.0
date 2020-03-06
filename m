Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98C17B2ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgCFA1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:47 -0500
Received: from ozlabs.org ([203.11.71.1]:60705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgCFA1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:46 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3N3R0Nz9sSm; Fri,  6 Mar 2020 11:27:43 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e1347a020b81fe47c80cd277bfaa61295a9482a4
In-Reply-To: <12f4f4f0ff89aeab3b937fc96c84fb35e1b2517e.1580748445.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Slenderize _tlbia() for powerpc 603/603e
Message-Id: <48YT3N3R0Nz9sSm@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:43 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-03 at 16:47:37 UTC, Christophe Leroy wrote:
> _tlbia() is a function used only on 603/603e core, ie on CPUs which
> don't have a hash table.
> 
> _tlbia() uses the tlbia macro which implements a loop of 1024 tlbie.
> 
> On the 603/603e core, flushing the entire TLB requires no more than
> 32 tlbie.
> 
> Replace tlbia by a loop of 32 tlbie.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1347a020b81fe47c80cd277bfaa61295a9482a4

cheers
