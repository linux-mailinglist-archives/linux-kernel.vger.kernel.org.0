Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8971337
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbfGWHrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 03:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388536AbfGWHrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:47:06 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9DC218BE;
        Tue, 23 Jul 2019 07:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563868025;
        bh=9oyXOwjjQfRkmBnzkflTCxxZW8XXgu2VWsi9uaQNOBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OL0cl/KK/IF0BukMfF9W8GDqFOcwP+U2iDVnpFrL+cnMacDlMA24O2us7o/i2JhLz
         obZ8e/Zbzva0hVmJCzlON4oRwPlgMgfZ2iEQVskivmwkHpvSQwEiV51CJZx+jRVNCx
         xPcjkwN0BCswql6r5iEZY+BucpWKHEi9kJaznj2w=
Date:   Tue, 23 Jul 2019 15:46:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] firmware: imx: Add DSP IPC protocol interface
Message-ID: <20190723074633.GJ15632@dragon>
References: <20190718081943.10272-1-daniel.baluta@nxp.com>
 <CAEnQRZDwBBR5qQT9NQX7c6kyrjp2Mw_so=QgkARw-gUgj3VeEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZDwBBR5qQT9NQX7c6kyrjp2Mw_so=QgkARw-gUgj3VeEA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:44:09AM +0300, Daniel Baluta wrote:
> Just realized that for this patch I forgot to add [PATCH v3]. Shawn,
> should I resend?

No need.

Shawn
