Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF41B8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfEMOq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 10:46:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45583 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbfEMOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:46:57 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hQCEB-0000AL-2b; Mon, 13 May 2019 16:46:55 +0200
Message-ID: <1557758814.4442.9.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/4] Add reset controller support for BM1880 SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, haitao.suo@bitmain.com,
        darren.tsao@bitmain.com, alec.lin@bitmain.com
Date:   Mon, 13 May 2019 16:46:54 +0200
In-Reply-To: <20190513140637.GA19120@Mani-XPS-13-9360>
References: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
         <1557745589.4442.5.camel@pengutronix.de>
         <20190513140637.GA19120@Mani-XPS-13-9360>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 19:36 +0530, Manivannan Sadhasivam wrote:
> Hi Philipp,
> 
> On Mon, May 13, 2019 at 01:06:29PM +0200, Philipp Zabel wrote:
> > Hi,
> > 
> > On Sat, 2019-05-11 at 00:15 +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This patchset adds reset controller support for Bitmain BM1880 SoC.
> > > BM1880 SoC has only one reset controller and the reset-simple driver
> > > has been reused here.
> > > 
> > > This patchset has been tested on 96Boards Sophon Edge board.
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > Changes in v3:
> > > 
> > > * Removed the clk-rst part as it turned out be the clock gating register set.
> > 
> > Thank you, I'd like to pick up patches 1, 3, and 4.
> > 
> > Since patch 2 depends on patch 1, you could either temporarily replace
> > the constants with their numerical value, until patch 1 is merged, or I
> > could provide a stable branch that contains patch 1 after v5.2-rc1.
> > 
> 
> I can use the numerical value in meantime, please pick those patches and I'll
> take the dts through arm-soc tree.

Done.

regards
Philipp
