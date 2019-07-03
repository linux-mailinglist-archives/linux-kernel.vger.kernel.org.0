Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C175E697
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfGCO1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:27:16 -0400
Received: from ozlabs.org ([203.11.71.1]:52117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfGCO1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:27:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45f3Mt388Xz9sPD; Thu,  4 Jul 2019 00:27:06 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 63982618662e2a05e5c5c3e4247456d1d3467f32
In-Reply-To: <20190625145239.2759-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] powerpc/powernv: remove the unused pnv_pci_set_p2p function
Message-Id: <45f3Mt388Xz9sPD@ozlabs.org>
Date:   Thu,  4 Jul 2019 00:27:06 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 14:52:36 UTC, Christoph Hellwig wrote:
> This function has never been used anywhere in the kernel tree since it
> was added to the tree.  We also now have proper PCIe P2P APIs in the core
> kernel, and any new P2P support should be using those.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63982618662e2a05e5c5c3e4247456d1d3467f32

cheers
