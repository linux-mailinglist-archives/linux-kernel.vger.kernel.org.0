Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95883C728
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404939AbfFKJUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 05:20:39 -0400
Received: from verein.lst.de ([213.95.11.211]:49580 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404919AbfFKJUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:20:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A0DE768B02; Tue, 11 Jun 2019 11:20:07 +0200 (CEST)
Date:   Tue, 11 Jun 2019 11:20:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 15/15] riscv: add binfmt_flat support
Message-ID: <20190611092007.GA23387@lst.de>
References: <20190610212015.9157-1-hch@lst.de> <20190610212015.9157-16-hch@lst.de> <d8d81820-8f0d-d5d0-fa3d-3376ddcc5358@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8d81820-8f0d-d5d0-fa3d-3376ddcc5358@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:16:43AM +0100, Vladimir Murzin wrote:
> On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> > Use the generic support with arguments are on the stack.  Same as arm
> > and m68k.
> 
> Out of curiosity, what is reason for keeping arguments on the stack?
> 
> ARM port of uClibc has following comment around manipulating of argv/argc:
> 
>         /*
>          * uClinux/arm stacks look a little different from normal
>          * MMU-full Linux/arm stacks (for no good reason)
>          */
> 
> So I though it is kind of legacy.

I just copied m68k and arm.  But dropping this makes the uclinux
crt1 code simpler, so I'll drop the flag for the next version.
