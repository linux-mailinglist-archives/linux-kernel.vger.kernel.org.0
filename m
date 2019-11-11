Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928CEF7969
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 18:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKKRCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 12:02:53 -0500
Received: from utopia.booyaka.com ([74.50.51.50]:38904 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKRCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:02:52 -0500
Received: (qmail 30818 invoked by uid 1019); 11 Nov 2019 17:02:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2019 17:02:51 -0000
Date:   Mon, 11 Nov 2019 17:02:51 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Christoph Hellwig <hch@lst.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v6
In-Reply-To: <20191111094729.GA11878@lst.de>
Message-ID: <alpine.DEB.2.21.999.1911111702030.30304@utopia.booyaka.com>
References: <20191028121043.22934-1-hch@lst.de> <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com> <20191111094729.GA11878@lst.de>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, 11 Nov 2019, Christoph Hellwig wrote:

> what is the status of this series?

At the moment I'm waiting for acks from other maintainers.  Could you 
please chase those down?  It's the responsibility of the developer to do 
that.

- Paul
