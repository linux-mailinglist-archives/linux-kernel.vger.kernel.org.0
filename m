Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B56096C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 00:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfHTWYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 18:24:14 -0400
Received: from verein.lst.de ([213.95.11.211]:60411 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730501AbfHTWYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:24:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E13A868B20; Wed, 21 Aug 2019 00:24:07 +0200 (CEST)
Date:   Wed, 21 Aug 2019 00:24:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 02/12] powerpc/ps3: replace __ioremap() by
 ioremap_prot()
Message-ID: <20190820222407.GA18433@lst.de>
References: <cover.1566309262.git.christophe.leroy@c-s.fr> <36bff5d875ff562889c5e12dab63e5d7c5d1fbd8.1566309262.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bff5d875ff562889c5e12dab63e5d7c5d1fbd8.1566309262.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:07:10PM +0000, Christophe Leroy wrote:
> __ioremap() is similar to ioremap_prot() except that ioremap_prot()
> does a few sanity changes in addition.
> 
> The flags used by PS3 are not impacted by those changes so for
> PS3 both functions are equivalent.
> 
> At the same time, drop parts of the comment that have been invalid
> since commit e58e87adc8bf ("powerpc/mm: Update _PAGE_KERNEL_RO")
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
