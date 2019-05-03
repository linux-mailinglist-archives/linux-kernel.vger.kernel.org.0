Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3175B12844
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfECG7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:35 -0400
Received: from ozlabs.org ([203.11.71.1]:44797 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfECG7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKc0KZFz9sPd; Fri,  3 May 2019 16:59:31 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1e496391a8452101308a23b7395cdd4983b6e5bd
X-Patchwork-Hint: ignore
In-Reply-To: <f4003df27f480c533b311dc9515f13fdaa962563.1490869145.git.joe@perches.com>
To:     Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv/ioda2: Add __printf format/argument verification
Message-Id: <44wNKc0KZFz9sPd@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:31 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2017-03-30 at 10:19:25 UTC, Joe Perches wrote:
> Fix fallout too.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1e496391a8452101308a23b7395cdd49

cheers
