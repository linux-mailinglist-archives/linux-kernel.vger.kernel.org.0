Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EEE1283F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfECG71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:27 -0400
Received: from ozlabs.org ([203.11.71.1]:34027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfECG7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:23 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKP6y15z9sPV; Fri,  3 May 2019 16:59:21 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d1720adff3783a2ba7c128e304a385d18962835b
X-Patchwork-Hint: ignore
In-Reply-To: <20190416094831.7264-2-anju@linux.vnet.ibm.com>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v4 1/5] powerpc/include: Add data structures and macros for IMC trace mode
Message-Id: <44wNKP6y15z9sPV@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:21 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 09:48:27 UTC, Anju T Sudhakar wrote:
> Add the macros needed for IMC (In-Memory Collection Counters) trace-mode
> and data structure to hold the trace-imc record data.
> Also, add the new type "OPAL_IMC_COUNTERS_TRACE" in 'opal-api.h', since
> there is a new switch case added in the opal-calls for IMC.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d1720adff3783a2ba7c128e304a385d1

cheers
