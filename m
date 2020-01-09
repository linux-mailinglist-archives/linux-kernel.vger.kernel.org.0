Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80050135351
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 07:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgAIGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 01:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgAIGju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:39:50 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF052053B;
        Thu,  9 Jan 2020 06:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578551990;
        bh=PzkmDwuLxg6i1Lv7mg1bZi42vACHL6CpISAFG/lE7II=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZdTpy6H9hUgnvR8ew1cTmAEURZTbZVGreLozb8akRHKWW9iRilK0MJaYA2HEe4lh
         OX/9Hb8Klj2J1ZGqS6KObwrhUFdoOH89tQe/CmRzYZl7GTmgxJczpsS7UpWJHtRGnW
         DJrjIZ+geEv8FWFEx4gJY9d7UwFoWGdQVp1/ew20=
Date:   Thu, 9 Jan 2020 14:39:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add support for Thor96 board
Message-ID: <20200109063940.GA4456@T480>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20200109033342.GA3281@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109033342.GA3281@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:03:42AM +0530, Manivannan Sadhasivam wrote:
> Hi Shawn,
> 
> On Wed, Oct 30, 2019 at 02:31:20PM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This patchset adds support for Thor96 board from Einfochips. This board is
> > one of the 96Boards Consumer Edition platform powered by the NXP i.MX8MQ
> > SoC.
> > 
> > Following are the features supported currently:
> > 
> > 1. uSD
> > 2. WiFi/BT
> > 3. Ethernet
> > 4. EEPROM (M24256)
> > 5. NOR Flash (W25Q256JW)
> > 6. 2xUSB3.0 ports and 1xUSB2.0 port at HS expansion
> > 
> > More information about this board can be found in Arrow website:
> > https://www.arrow.com/en/products/i.imx8-thor96/arrow-development-tools
> > 
> > Link to 96Boards CE Specification: https://linaro.co/ce-specification
> > 
> > Expecting patch 1 to go through LED/Rob's tree, 4 through MTD tree
> > and 2,3 through Freescale tree.
> > 
> 
> Any update here? Patch 4 is already merged.

Just applied patch #2 and #3.  For patch #1, it should go via LED or DT
tree, I think.

Shawn
