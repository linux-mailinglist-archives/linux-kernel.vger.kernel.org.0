Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E5EB44B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 16:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfJaP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 11:56:12 -0400
Received: from verein.lst.de ([213.95.11.211]:51735 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfJaP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:56:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47DC668BE1; Thu, 31 Oct 2019 16:56:09 +0100 (CET)
Date:   Thu, 31 Oct 2019 16:56:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de, yash.shah@sifive.com
Subject: Re: [PATCH] riscv: separate MMIO functions into their own header
 file
Message-ID: <20191031155608.GB7270@lst.de>
References: <alpine.DEB.2.21.9999.1910291053450.1601@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910291053450.1601@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it would be a better idea to move the kernel virtual address
space layout out of pgtable.h into a new header, as pgtable.h pull a lot
of stuff in.
