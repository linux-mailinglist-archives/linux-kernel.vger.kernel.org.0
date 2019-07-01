Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208C7589CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 20:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfF0SWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 14:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfF0SWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:22:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6793E2147A;
        Thu, 27 Jun 2019 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561659760;
        bh=OWVaDmVNtApgOpqHAmgc9fI+si0QgpxgVbTygDfbC5g=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=pzy1CMV5UoWSBwbJ8DIs+dNid1Fb8DuW3yB7SpL/Sp5Cfee5LCndMZLYfO63TFdaD
         jYXFEwyIj2Q45koz1zbZES2tZCs0OVDDJaLcrFZDscMllr/RdxfD+5jTER1ndh0GMS
         DeZFHH8S3zMdp53eNXzedrYBUNltAP6aRwDiEDz4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561650825-11213-3-git-send-email-claudiu.beznea@microchip.com>
References: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com> <1561650825-11213-3-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/7] clk: at91: sckc: add support to free slow rc oscillator
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 11:22:39 -0700
Message-Id: <20190627182240.6793E2147A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2019-06-27 08:53:40)
> Add support to free slow rc oscillator resources.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

