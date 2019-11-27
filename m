Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5010AC22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfK0IrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 03:47:01 -0500
Received: from verein.lst.de ([213.95.11.211]:44944 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0IrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:47:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 39BBF68AFE; Wed, 27 Nov 2019 09:46:58 +0100 (CET)
Date:   Wed, 27 Nov 2019 09:46:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] powerpc/32: drop unused ISA_DMA_THRESHOLD
Message-ID: <20191127084657.GA24133@lst.de>
References: <20191125092033.20014-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125092033.20014-1-rppt@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:20:33AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The ISA_DMA_THRESHOLD variable is set by several platforms but never
> referenced.
> Remove it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
