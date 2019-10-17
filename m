Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAADB1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406381AbfJQQKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 12:10:43 -0400
Received: from verein.lst.de ([213.95.11.211]:42517 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfJQQKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:10:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 23D1C68BE1; Thu, 17 Oct 2019 18:10:39 +0200 (CEST)
Date:   Thu, 17 Oct 2019 18:10:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for RISC-V
Message-ID: <20191017161038.GA9953@lst.de>
References: <alpine.DEB.2.21.9999.1910091252160.11044@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910091252160.11044@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:53:50PM -0700, Paul Walmsley wrote:
> 
> Kernels booting on RISC-V can specify "earlycon" with no options on
> the Linux command line, and the generic DT earlycon support will query
> the "chosen/stdout-path" property (if present) to determine which
> early console device to use.  Document this appropriately in the
> admin-guide.

Jon already applied a patch from me removing the bogus arch restrictions
on the earlycon without arguments documentation, so this should not
be required.
