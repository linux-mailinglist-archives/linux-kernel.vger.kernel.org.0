Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3022A10BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 19:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfEARDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 13:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfEARDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:03:48 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261CB20835;
        Wed,  1 May 2019 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556730228;
        bh=BBvwoNEHVRq6c/XWJXO2zRZ6ZBCo20OJ+aAG/Lv8KEw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=0gtlaiv6NrICHtxforyV7oISLK86EyMix5IUOatqtwQ4kcZeGdpRed8mVTYeLb1S3
         foVvw/4MYzmnzg9+rks40rohOWflkP2KHZAL9EYhuoRYXNDeCG9zIODbT2xcYqgoAW
         HD932Ci7ImLSuvL3t9y+sbDPcxVCvsnPbxKT5vKo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB3PR0402MB3916F59134DB9CF9837B43C1F53B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556589033-6080-1-git-send-email-Anson.Huang@nxp.com> <155664820799.168659.12393223246835475198@swboyd.mtv.corp.google.com> <DB3PR0402MB3916F59134DB9CF9837B43C1F53B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH] clk: imx: pllv3: Fix fall through build warning
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Message-ID: <155673022723.168659.16788237682007828514@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 01 May 2019 10:03:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-05-01 02:33:46)
> Hi, Stephen
>         I saw Gustavo already sent out a patch to fix these two warnings,=
 so I will NOT sent the patch again, thanks.

So I will apply that patch instead? Can you send your reviewed-by tag
then?

