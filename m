Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7AB54ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfFYM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 08:27:13 -0400
Received: from verein.lst.de ([213.95.11.211]:34415 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbfFYM1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:27:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9D66168B05; Tue, 25 Jun 2019 14:26:41 +0200 (CEST)
Date:   Tue, 25 Jun 2019 14:26:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Greer <mgreer@animalcreek.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Dale Farnsworth <dale@farnsworth.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: DMA coherency in drivers/tty/serial/mpsc.c
Message-ID: <20190625122641.GA4421@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Dale and Mark (I hope this reaches the right Mark),

I've started auditing all users of DMA_ATTR_NON_CONSISTENT ot prepare
for major API improvements in that area.

One of the odd users is the mpsc ѕerial driver, which allocates DMA
memory with the above flag, and then actually properly calls
dma_cache_sync.  So far, so good.  But it turns out it also has
"#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)"
ifdef blocks next to the dma_cache_sync calls that perform cache
maintainance for platforms that according to the ifdef claim to
be cache coherent.  According to the Kconfig the driver can
only build if the MV64X60 symbol is set, which is a ppc embedded 6xx
SOC, which appears to be configurable as either cache coherent, or
not.  But according to the code in the driver at least this device
always is not cache coherent.

It seems like we need to always mark that platform as potentially
not coherent, and then use the per-device flag to mark all device
except for this one as coherent.  Or did I miss anything?  Maybe
all this is actually dead code and can go away?

