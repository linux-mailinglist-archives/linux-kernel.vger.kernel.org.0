Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1912A17B2E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgCFA1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCFA1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:44 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3M1TFtz9sSZ; Fri,  6 Mar 2020 11:27:43 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 030e347430957f6f7f29db9099368f8b86c0bf76
In-Reply-To: <b30b2eae6960502eaf0d9e36c60820b839693c33.1580542939.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/32s: Don't flush all TLBs when flushing one page
Message-Id: <48YT3M1TFtz9sSZ@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:43 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-01 at 08:04:31 UTC, Christophe Leroy wrote:
> When flushing any memory range, the flushing function
> flushes all TLBs.
> 
> When (start) and (end - 1) are in the same memory page,
> flush that page instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/030e347430957f6f7f29db9099368f8b86c0bf76

cheers
