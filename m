Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9049799483
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbfHVNI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:08:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731794AbfHVNI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:08:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGZ4Y5hz9sP3; Thu, 22 Aug 2019 23:08:54 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 658d029df0bce6472c94b724ca54d74bc6659c2e
In-Reply-To: <f8cdc3f1c66ad3c43ebc568abcc6c39ed4676284.1561737231.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/hw_breakpoint: move instruction stepping out of hw_breakpoint_handler()
Message-Id: <46DlGZ4Y5hz9sP3@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:08:54 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 15:55:52 UTC, Christophe Leroy wrote:
> On 8xx, breakpoints stop after executing the instruction, so
> stepping/emulation is not needed. Move it into a sub-function and
> remove the #ifdefs.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/658d029df0bce6472c94b724ca54d74bc6659c2e

cheers
