Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F17AED30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbfIJOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:36:34 -0400
Received: from verein.lst.de ([213.95.11.211]:59688 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfIJOge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:36:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC9FD68AFE; Tue, 10 Sep 2019 16:36:30 +0200 (CEST)
Date:   Tue, 10 Sep 2019 16:36:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Message-ID: <20190910143630.GA6794@lst.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvmzhjcr2d4.fsf@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:18:15AM +0200, Andreas Schwab wrote:
> > How so?  Wіth OF and a stdout path you just set earlycon on the
> > command line without any arguments and it will be found.
> 
> Doesn't work for me.
> 
> [    0.000000] Malformed early option 'earlycon'

That functionality is implemented by param_setup_earlycon and
early_init_dt_scan_chosen_stdout.  Check why those aren't built into
your kernel.
