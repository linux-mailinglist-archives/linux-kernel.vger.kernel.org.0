Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C28D3AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfJKIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 04:22:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfJKIWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:22:06 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46qLXX4HkYz9sP6; Fri, 11 Oct 2019 19:22:04 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4ab8a485f7bc69e04e3e8d75f62bdcac5f4ed02e
In-Reply-To: <20191001132928.72555-1-ldufour@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, sfr@linux.ibm.com,
        benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Remove confusing warning message.
Message-Id: <46qLXX4HkYz9sP6@ozlabs.org>
Date:   Fri, 11 Oct 2019 19:22:04 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 13:29:28 UTC, Laurent Dufour wrote:
> Since the commit 1211ee61b4a8 ("powerpc/pseries: Read TLB Block Invalidate
> Characteristics"), a warning message is displayed when booting a guest on
> top of KVM:
> 
> lpar: arch/powerpc/platforms/pseries/lpar.c pseries_lpar_read_hblkrm_characteristics Error calling get-system-parameter (0xfffffffd)
> 
> This message is displayed because this hypervisor is not supporting the
> H_BLOCK_REMOVE hcall and thus is not exposing the corresponding feature.
> 
> Reading the TLB Block Invalidate Characteristics should not be done if the
> feature is not exposed.
> 
> Fixes: 1211ee61b4a8 ("powerpc/pseries: Read TLB Block Invalidate Characteristics")
> Reported-by: Stephen Rothwell <sfr@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reapplied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4ab8a485f7bc69e04e3e8d75f62bdcac5f4ed02e

cheers
