Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646865B656
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 10:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfGAIGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 04:06:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34691 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfGAIGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:06:45 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hhrKm-0007en-1Q; Mon, 01 Jul 2019 10:06:44 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hhrKk-0003dc-Sk; Mon, 01 Jul 2019 10:06:42 +0200
Date:   Mon, 1 Jul 2019 10:06:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: nvmem creates multiple devices with the same name
Message-ID: <20190701080642.4oxmw7c3rmwrt5ee@pengutronix.de>
References: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
 <a9ccac90-7b2f-41da-2ca9-ca3bba52781b@linaro.org>
 <20190521092107.zpdkkhaanzruhqui@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521092107.zpdkkhaanzruhqui@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:05:36 up 44 days, 14:23, 90 users,  load average: 0.31, 0.22,
 0.16
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Tue, May 21, 2019 at 11:21:07AM +0200, Sascha Hauer wrote:
> On Tue, May 21, 2019 at 10:02:32AM +0100, Srinivas Kandagatla wrote:
> > 
> > 
> > On 21/05/2019 09:56, Sascha Hauer wrote:
> > > . Are there any suggestions how to register the nvmem devices
> > > with a different name?
> > 
> > struct nvmem_config provides id field for this purpose, this will be used by
> > nvmem to set the device name space along with name field.
> 
> There's no way for a caller to know a unique name/id combination.
> The mtd layer could initialize the id field with the mtd number, but
> that would still not guarantee that another caller, like an EEPROM
> driver or such, doesn't use the same name/id combination.

This is still an unresolved issue. Do you have any input how we could
proceed here?

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
