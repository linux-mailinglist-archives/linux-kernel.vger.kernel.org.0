Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9B1A9DE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 03:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfELBLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 21:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfELBLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:11:19 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA242146F;
        Sun, 12 May 2019 01:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557623479;
        bh=iG8fgnEYMhqAKMijlWzlWDLzsbg1bOrP7g8QIT+TX6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UP512JCupvKJXhpAAHUrLqbcKYJBnSHi906QHDT3AFBiERRthFoE1lzL8vaMgthS/
         7q4XJmeWlMSslBJckcrop4E5j9pNnsMwULvSXtujhMF0K5n/feC9abJ73v9+JOgoHI
         iGVr0XfYdP9URiJsYX0qvF74SRcYbUFUfNAPR+xY=
Date:   Sun, 12 May 2019 09:10:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Message-ID: <20190512011047.GK15856@dragon>
References: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
 <20190510032917.GG15856@dragon>
 <DB3PR0402MB391661070B9F664C9E9577B0F50C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167B660667C2322E7787E2F50C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39167B660667C2322E7787E2F50C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 12:27:18PM +0000, Anson Huang wrote:
> Hi, Shawn
> 	I have resent this patch with "Content-Transfer-Encoding: quoted-printable", can you check if you can apply the patch correctly, if yes, please let me know and I will resend all patches maintained by you with this encoding type. Patch: https://patchwork.kernel.org/patch/10938725/
> 

Yes, it worked.  Thanks.

Shawn
