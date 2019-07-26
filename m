Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D7772F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfGZUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 16:45:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:52176 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfGZUpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:45:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EE6BE2B7;
        Fri, 26 Jul 2019 20:45:15 +0000 (UTC)
Date:   Fri, 26 Jul 2019 14:45:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/features/locking: update lists
Message-ID: <20190726144515.29c5227a@lwn.net>
In-Reply-To: <20190723132203.51814-1-mark.rutland@arm.com>
References: <20190723132203.51814-1-mark.rutland@arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 14:22:03 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> The locking feature lists don't match reality as of v5.3-rc1:
> 
> * arm64 moved to queued spinlocks in commit:
> 
>   c11090474d70590170cf5fa6afe85864ab494b37
> 
>   ("arm64: locking: Replace ticket lock implementation with qspinlock")
> 
> * xtensa moved to queued spinlocks and rwlocks in commit:
> 
>   579afe866f52adcd921272a224ab36733051059c
> 
>   ("xtensa: use generic spinlock/rwlock implementation")
> 
> * architecture-specific rwsem support was removed in commit:
> 
>   46ad0840b1584b92b5ff2cc3ed0b011dd6b8e0f1
> 
>   ("locking/rwsem: Remove arch specific rwsem files")
> 
> So update the feature lists accordingly, and remove the now redundant
> rwsem-optimized list.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Applied, thanks.

jon
