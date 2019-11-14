Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9550FC248
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfKNJJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:09:05 -0500
Received: from ozlabs.org ([203.11.71.1]:35501 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfKNJId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:33 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyR2yKrz9sRK; Thu, 14 Nov 2019 20:08:30 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3775026a654c15c92c8ac2d53f3fd14fdd1980df
In-Reply-To: <20181102211707.10229-1-linux@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh: ans-lcd: make anslcd_logo static and __initconst
Message-Id: <47DFyR2yKrz9sRK@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 21:17:06 UTC, Rasmus Villemoes wrote:
> This variable has no reason to have external linkage, and since it is
> only used in an __init function, it might as well be made __initconst
> also.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3775026a654c15c92c8ac2d53f3fd14fdd1980df

cheers
