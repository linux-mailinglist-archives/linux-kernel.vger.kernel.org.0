Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1243C5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404638AbfFKILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 04:11:45 -0400
Received: from verein.lst.de ([213.95.11.211]:49067 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404272AbfFKILp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:11:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A40C568B02; Tue, 11 Jun 2019 10:11:17 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:11:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: binfmt_flat cleanups and RISC-V support
Message-ID: <20190611081117.GA22110@lst.de>
References: <20190610212015.9157-1-hch@lst.de> <4f000219-4baf-b03e-9003-26482640d3de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f000219-4baf-b03e-9003-26482640d3de@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:05:45AM +0100, Vladimir Murzin wrote:
> I'm wondering if you have a branch with these changes so I can give
> it a try on ARM NOMMU platforms?


    git://git.infradead.org/users/hch/riscv.git riscv-flat
