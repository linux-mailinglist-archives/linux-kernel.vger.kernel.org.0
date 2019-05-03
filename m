Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1890812847
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfECG7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:53 -0400
Received: from ozlabs.org ([203.11.71.1]:40339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfECG7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKY110Nz9sPY; Fri,  3 May 2019 16:59:28 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c9e0fc33b8be52a7134ed0ee79b6a1e332e1b9d0
X-Patchwork-Hint: ignore
In-Reply-To: <20190430182739.21961-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, aneesh.kumar@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: remove the __kernel_io_end export
Message-Id: <44wNKY110Nz9sPY@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:28 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-30 at 18:27:39 UTC, Christoph Hellwig wrote:
> This export was added in this merge window, but without any actual
> user, or justification for a modular user.
> 
> Fixes: a35a3c6f6065 ("powerpc/mm/hash64: Add a variable to track the end of IO mapping")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c9e0fc33b8be52a7134ed0ee79b6a1e3

cheers
