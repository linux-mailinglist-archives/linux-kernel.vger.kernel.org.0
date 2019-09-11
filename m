Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E44AF6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 09:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfIKH1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 03:27:45 -0400
Received: from krieglstein.org ([188.68.35.71]:45160 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfIKH1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:27:44 -0400
Received: from dabox.localnet (gateway.hbm.com [213.157.30.2])
        by krieglstein.org (Postfix) with ESMTPSA id 3079A401B1;
        Wed, 11 Sep 2019 09:27:43 +0200 (CEST)
From:   Tim Sander <tim@krieglstein.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtd raw nand denali.c broken for Intel/Altera Cyclone V
Date:   Wed, 11 Sep 2019 09:27:42 +0200
Message-ID: <2810592.g4EWBO4qaL@dabox>
Organization: Sander and Lightning
In-Reply-To: <CAK7LNARCPwqY+YmUzsHkABpshzzS3tC=fDgp4vZjVgBwS+LKJw@mail.gmail.com>
References: <5143724.5TqzkYX0oI@dabox> <9bb2fb0e-a9e7-c389-f9b7-42367485ff83@kernel.org> <CAK7LNARCPwqY+YmUzsHkABpshzzS3tC=fDgp4vZjVgBwS+LKJw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am Mittwoch, 11. September 2019, 04:37:46 CEST schrieb Masahiro Yamada:
> - Does the SOCFPGA boot ROM support the NAND boot mode?
Cyclone V HPS TRM Section "A3 Booting and Configuration" lists QSPI, SD/MMC and 
Nand as bootsource.

> - If so, which value does it use for SPARE_AREA_SKIP_BYTES?
I have no idea about this one.

Tim


