Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD26584E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 16:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfF0Ovl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jun 2019 10:51:41 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35525 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0Ovl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:51:41 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 305CC240019;
        Thu, 27 Jun 2019 14:51:37 +0000 (UTC)
Date:   Thu, 27 Jun 2019 16:51:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the nand tree with Linus' tree
Message-ID: <20190627165129.3b2c1264@xps13>
In-Reply-To: <20190604105418.58da18b2@canb.auug.org.au>
References: <20190604105418.58da18b2@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> wrote on Tue, 4 Jun 2019
10:54:18 +1000:

> Hi all,
> 
> Today's linux-next merge of the nand tree got a conflict in:
> 
>   Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> 
> between commit:
> 
>   a5f2246fb913 ("dt: bindings: mtd: replace references to nand.txt with nand-controller.yaml")
> 
> from Linus' tree and commit:
> 
>   33cc5bd0b87a ("dt-bindings: mtd: brcmnand: Make nand-ecc-strength and nand-ecc-step-size optional")
> 
> from the nand tree.
> 
> I fixed it up (the latter included the changes from the former, so I
> just used that) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.
> 

Can you please share the fix? I might want to include it in the final
PR.


Thanks,
Miquèl
