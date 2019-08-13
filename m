Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 849BB8BD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 17:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfHMPhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 11:37:11 -0400
Received: from verein.lst.de ([213.95.11.211]:58149 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbfHMPhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:37:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FB1368B02; Tue, 13 Aug 2019 17:37:07 +0200 (CEST)
Date:   Tue, 13 Aug 2019 17:37:07 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/17] riscv: clear the instruction cache and all
 registers when booting
Message-ID: <20190813153707.GA8686@lst.de>
References: <20190624054311.30256-1-hch@lst.de> <20190624054311.30256-17-hch@lst.de> <78919862d11f6d56446f8fffd8a1a8c601ea5c32.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78919862d11f6d56446f8fffd8a1a8c601ea5c32.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:26:18PM +0000, Atish Patra wrote:
> That means it should be done for S-mode as well. Right ?

For S-mode the bootloader/sbi should take care of it.
