Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4599589C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 20:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfF0SWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 14:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfF0SWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:22:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D274720644;
        Thu, 27 Jun 2019 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561659756;
        bh=n60tYciFZ/rJjYb/1k+C2pWN3/F6CRA6F5z90rAb65k=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=E8nmK2zzxL74/hvLttnn9Mj59gGHrsvRd9F1cHH0d6FnOpmhYMCeYa8/78C+bywPP
         4diOqXEYmZTrmTIWQUHKBWVGxgONk3IKatkCs/SjO0mPPtXWuB1jUbGzEVnVEOAZlQ
         XEdJNT2JdveWMHAK98k838m2Vp5+UVt3vcfFqdPQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561650825-11213-2-git-send-email-claudiu.beznea@microchip.com>
References: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com> <1561650825-11213-2-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/7] clk: at91: sckc: add support to free slow oscillator
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 11:22:35 -0700
Message-Id: <20190627182236.D274720644@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2019-06-27 08:53:39)
> Add support to free slow oscillator resources.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

