Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79C21515A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 07:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgBDGGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 01:06:09 -0500
Received: from verein.lst.de ([213.95.11.211]:59358 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgBDGGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:06:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFC7568BFE; Tue,  4 Feb 2020 07:06:04 +0100 (CET)
Date:   Tue, 4 Feb 2020 07:06:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com, x86@kernel.org,
        hch@lst.de
Subject: Re: [PATCH v2] x86/PCI: ensure to_pci_sysdata usage is available
 to !CONFIG_PCI
Message-ID: <20200204060604.GA31675@lst.de>
References: <20200203200942.GA130652@google.com> <20200203215306.172000-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203215306.172000-1-Jason@zx2c4.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:53:06PM +0100, Jason A. Donenfeld wrote:
> Recently, the helper to_pci_sysdata was added inside of the CONFIG_PCI
> guard, but it is used from inside of a CONFIG_NUMA guard, which does not
> require CONFIG_PCI. This breaks builds on !CONFIG_PCI machines. This
> commit makes that function available in all configurations.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: aad6aa0cd674 ("x86/PCI: Add to_pci_sysdata() helper")
> Cc: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
