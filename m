Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5042E12842
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfECG7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:32 -0400
Received: from ozlabs.org ([203.11.71.1]:34865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfECG70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:26 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKT1g95z9sDn; Fri,  3 May 2019 16:59:25 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 57e0491b58fa2a217029b696511499008852a642
X-Patchwork-Hint: ignore
In-Reply-To: <809c41e209068baf1045edbf154cc8d25c520d1e.1556296364.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] powerpc/32s: drop Hash_end
Message-Id: <44wNKT1g95z9sDn@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:25 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 16:36:36 UTC, Christophe Leroy wrote:
> Hash_end has never been used, drop it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/57e0491b58fa2a217029b69651149900

cheers
