Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239A563708
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGINge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:36:34 -0400
Received: from verein.lst.de ([213.95.11.211]:42984 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfGINge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:36:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6772227A81; Tue,  9 Jul 2019 15:36:31 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:36:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68k: don't select ARCH_HAS_DMA_PREP_COHERENT for
 nommu or coldfire
Message-ID: <20190709133631.GA2201@lst.de>
References: <20190708175101.19990-1-hch@lst.de> <CAMuHMdVrAVYWvQCh7AF1O7SRbuZb9fQp9fi0yQyZMeaOpfHyEw@mail.gmail.com> <20190708212325.GA17641@lst.de> <CAMuHMdVqCOwxG1ru-wvgDmtNfezgR92qBOVhtEJjaLrXAjaE+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVqCOwxG1ru-wvgDmtNfezgR92qBOVhtEJjaLrXAjaE+A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:08:02AM +0200, Geert Uytterhoeven wrote:
> OK, will do, after a cycle in next.

Thanks.  I'll watch your PRs so that I can send the dma-mapping one
right after this.

> I assume you just forgot to add your SoB, and I can add it?

Yes.  And just for the record:

Signed-off-by: Christoph Hellwig <hch@lst.de>
