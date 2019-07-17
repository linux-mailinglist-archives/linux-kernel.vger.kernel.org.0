Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDAD6BFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfGQQh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 12:37:57 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49015 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:37:56 -0400
X-Originating-IP: 91.163.65.175
Received: from localhost (91-163-65-175.subs.proxad.net [91.163.65.175])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C8C6C60005;
        Wed, 17 Jul 2019 16:37:53 +0000 (UTC)
Date:   Wed, 17 Jul 2019 18:37:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     "kishon@ti.com" <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Message-ID: <20190717163753.ti6swjfhm7fczcn4@flea>
References: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
 <20190711112039.leuvelpm7opeoaxq@flea>
 <678F3D1BB717D949B966B68EAEB446ED2FF5B22D@DGGEMM506-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED2FF5B22D@DGGEMM506-MBX.china.huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 17, 2019 at 06:36:09AM +0000, Zengtao (B) wrote:
> Hi Maxime:
>
> Thanks for your reply.
>
> >-----Original Message-----
> >From: Maxime Ripard [mailto:maxime.ripard@bootlin.com]
> >Sent: Thursday, July 11, 2019 7:21 PM
> >To: Zengtao (B) <prime.zeng@hisilicon.com>
> >Cc: kishon@ti.com; Chen-Yu Tsai <wens@csie.org>; Paul Kocialkowski
> ><paul.kocialkowski@bootlin.com>; Sakari Ailus <sakari.ailus@linux.intel.com>;
> >linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >Subject: Re: [PATCH] phy: Change the configuration interface param to void*
> >to make it more general
> >
> >* PGP Signed by an unknown key
> >
> >On Fri, Jul 12, 2019 at 02:04:08AM +0800, Zeng Tao wrote:
> >> The phy framework now allows runtime configurations, but only limited
> >> to mipi now, and it's not reasonable to introduce user specified
> >> configurations into the union phy_configure_opts structure. An simple
> >> way is to replace with a void *.
> >
> >I'm not sure why it's unreasonable?
> >
>
> The phy.h will need to include vendor specific phy headers

I'm not sure this is an issue.

> and the union phy_configure_opts will become more complex.

And this was the plan all along.

> I don't think this is a good solution to include all vendor specific
> phy configs into a single union structure.

The thing is, as Sakari have stated, this interface was meant as a
generic way to negotiate a configuration between a PHY consumer and a
PHY provider (ie, whatever sends data to the phy and the phy itself).

If you remove the explicit type check, then you need to have prior
knowledge (and agreement) on both sides, which breaks the initial
intent.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
