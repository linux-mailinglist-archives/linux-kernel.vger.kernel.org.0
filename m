Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53800B3A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfIPMWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 08:22:53 -0400
Received: from verein.lst.de ([213.95.11.211]:44549 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfIPMWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:22:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90C2E68B05; Mon, 16 Sep 2019 14:22:49 +0200 (CEST)
Date:   Mon, 16 Sep 2019 14:22:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Andreas Schwab <schwab@suse.de>, Christoph Hellwig <hch@lst.de>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Message-ID: <20190916122249.GA30058@lst.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de> <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> <mvm7e68fo2g.fsf@suse.de> <alpine.DEB.2.21.9999.1909160513100.9917@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909160513100.9917@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 05:18:57AM -0700, Paul Walmsley wrote:
> I support Christoph's plan to add generic implicit earlycon support.

I'm not planning to add it, it exist already.  You just need a DT that
sets the stdout node up properly, and a earlycon driver using
OF_EARLYCON_DECLARE like the sifive uart driver.

The DT here for example works perfectly fine:

http://git.infradead.org/users/hch/riscv.git/commitdiff/f10e64873eafc68516b8884c06b9290b9887633b
