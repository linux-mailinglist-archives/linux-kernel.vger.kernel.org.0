Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC475515E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfFYORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 10:17:02 -0400
Received: from mail.intenta.de ([178.249.25.132]:28384 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYORC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:17:02 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 10:17:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=mJlPfSkpI779CY+9JAH0jj86uoiwu0wyCkk8KI2WfiE=;
        b=d0q2bEjQJE2TygXNNfiz+huBzdmhBgB0yiW9nfIfG40l6rOBViCdcRXObmtvNQDPbKQxSz7UnLao3itC18ElskcAtXS4TutpTk8+sOOdoBSlMejuk0zfcX2TdlcwydFh0WajpCPbxZSduFaZ5YRA744AGHPAz6j+KsjFwMWXPDRwubATJd8bIWc6xm5NTNuYpCQEKuLrZhqXBryUzzGakL1WMYigxEiIeWPZDoPLp0ga4PCd2dRCBMHhX8CkVUDnC05EcH9B1OyjlE6tF9TZv7R5kfjwPeSAiXGR0ue8aQ1ZBd5ztWFF6NoPQ/0HrU0mmbj64EVtdpKZJDeQ9JSE9A==;
X-CTCH-RefID: str=0001.0A0C020D.5D122B8E.0089,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Tue, 25 Jun 2019 16:11:26 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Message-ID: <20190625141126.ggmxjcmdh76lguds@laureti-dev>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
 <20190625044630.31717-2-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190625044630.31717-2-naga.sureshkumar.relli@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the quick update.

On Tue, Jun 25, 2019 at 06:46:30AM +0200, Naga Sureshkumar Relli wrote:
> -> Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.

I tested the v17 series with the MT29F2G08ABAEAWP. I can now mount
existing jffs2 volumes without issues.

When running nandtest on a 64MB area, I no longer see lots of
consecutive errors. However I see few (4-8) single byte errors for
random locations on about half the runs. In comparison, I couldn't
reproduce these on the older driver on v4.14.

When writing random 1MB files on a fresh jffs2 filesystem and reading
them back after umounting and mounting the filesystem, I got one faulty
file in 50 attempts.

So this driver mostly works for me, but I suspect that something
(possibly the tested hardware) doesn't fully work yet. To say more, I'll
need long term testing results. In the mean time, I'm in favour of
merging the driver.

Helmut
