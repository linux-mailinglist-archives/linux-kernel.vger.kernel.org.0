Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15493EA311
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfJ3SML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 14:12:11 -0400
Received: from verein.lst.de ([213.95.11.211]:47118 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJ3SML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:12:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B551868B05; Wed, 30 Oct 2019 19:12:08 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:12:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shyam Saini <mayhs11saini@gmail.com>
Cc:     kernel-hardening@lists.openwall.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V2] kernel: dma: contigous: Make CMA parameters
 __initdata/__initconst
Message-ID: <20191030181208.GA19513@lst.de>
References: <20191020050322.2634-1-mayhs11saini@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020050322.2634-1-mayhs11saini@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to the dma-mapping for-next branch after fixing up the commit
message and an overly long line.
