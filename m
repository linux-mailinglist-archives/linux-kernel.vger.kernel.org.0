Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A27B3A10
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfIPMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 08:15:23 -0400
Received: from verein.lst.de ([213.95.11.211]:44492 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfIPMPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:15:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1F0E68B05; Mon, 16 Sep 2019 14:15:18 +0200 (CEST)
Date:   Mon, 16 Sep 2019 14:15:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Message-ID: <20190916121518.GA29881@lst.de>
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de> <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de> <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> <mvm7e68fo2g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvm7e68fo2g.fsf@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 02:00:39PM +0200, Andreas Schwab wrote:
> > Try:
> >
> >     earlycon=sifive,0x10010000
> 
> That's not what Christoph wants.

Well, what I want is auto selection if the device tree uses the
stdout-path.  My Kendryte DT uses that and it works like a charm.  If
it doesn't work for you on the U54 board chances are that your DT
doesn't have the right settings and you have to use the line that
Paul posted.
