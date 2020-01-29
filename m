Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FA14C58F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgA2FRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:40 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgA2FRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:33 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDq372qz9sRh; Wed, 29 Jan 2020 16:17:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6ad4afc97bc6c5cca9786030492ddfab871ce79e
In-Reply-To: <20200106042957.26494-1-yingjie_bai@126.com>
To:     yingjie_bai@126.com, Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jason Yan <yanaijie@huawei.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Bai Yingjie <byj.tea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v3 1/2] powerpc32/booke: consistently return phys_addr_t in __pa()
Message-Id: <486sDq372qz9sRh@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:31 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-06 at 04:29:53 UTC, yingjie_bai@126.com wrote:
> From: Bai Yingjie <byj.tea@gmail.com>
> 
> When CONFIG_RELOCATABLE=y is set, VIRT_PHYS_OFFSET is a 64bit variable,
> thus __pa() returns as 64bit value.
> But when CONFIG_RELOCATABLE=n, __pa() returns 32bit value.
> 
> When CONFIG_PHYS_64BIT is set, __pa() should consistently return as
> 64bit value irrelevant to CONFIG_RELOCATABLE.
> So we'd make __pa() consistently return phys_addr_t, which is 64bit
> when CONFIG_PHYS_64BIT is set.
> 
> Signed-off-by: Bai Yingjie <byj.tea@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6ad4afc97bc6c5cca9786030492ddfab871ce79e

cheers
