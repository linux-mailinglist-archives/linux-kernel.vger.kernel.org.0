Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93179948E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbfHVNJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:09:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388969AbfHVNJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGv5YRdz9sPl; Thu, 22 Aug 2019 23:09:11 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 415480dce2ef03bb8335deebd2f402f475443ce0
In-Reply-To: <80432f71194d7ee75b2f5043ecf1501cf1cca1f3.1566196646.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Doug Crawford <doug.crawford@intelight-its.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/603: fix handling of the DIRTY flag
Message-Id: <46DlGv5YRdz9sPl@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:11 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 06:40:25 UTC, Christophe Leroy wrote:
> If a page is already mapped RW without the DIRTY flag, the DIRTY
> flag is never set and a TLB store miss exception is taken forever.
> 
> This is easily reproduced with the following app:
> 
> void main(void)
> {
> 	volatile char *ptr = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 
> 	*ptr = *ptr;
> }
> 
> When DIRTY flag is not set, bail out of TLB miss handler and take
> a minor page fault which will set the DIRTY flag.
> 
> Fixes: f8b58c64eaef ("powerpc/603: let's handle PAGE_DIRTY directly")
> Cc: stable@vger.kernel.org
> Reported-by: Doug Crawford <doug.crawford@intelight-its.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/415480dce2ef03bb8335deebd2f402f475443ce0

cheers
