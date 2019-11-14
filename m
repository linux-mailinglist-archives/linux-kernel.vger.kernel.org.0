Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7CFC220
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKNJIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:08:00 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfKNJH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:57 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxk6wMPz9sRs; Thu, 14 Nov 2019 20:07:54 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3b05a1e517e1a8cfda4866ec31d28b2bc4fee4c4
In-Reply-To: <20191021142309.28105-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/security: Fix debugfs data leak on 32-bit
Message-Id: <47DFxk6wMPz9sRs@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:54 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 14:23:09 UTC, Geert Uytterhoeven wrote:
> "powerpc_security_features" is "unsigned long", i.e. 32-bit or 64-bit,
> depending on the platform (PPC_FSL_BOOK3E or PPC_BOOK3S_64).  Hence
> casting its address to "u64 *", and calling debugfs_create_x64() is
> wrong, and leaks 32-bit of nearby data to userspace on 32-bit platforms.
> 
> While all currently defined SEC_FTR_* security feature flags fit in
> 32-bit, they all have "ULL" suffixes to make them 64-bit constants.
> Hence fix the leak by changing the type of "powerpc_security_features"
> (and the parameter types of its accessors) to "u64".  This also allows
> to drop the cast.
> 
> Fixes: 398af571128fe75f ("powerpc/security: Show powerpc_security_features in debugfs")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b05a1e517e1a8cfda4866ec31d28b2bc4fee4c4

cheers
