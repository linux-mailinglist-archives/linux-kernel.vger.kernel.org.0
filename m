Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E17570C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 20:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 14:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZSg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:36:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA53A216FD;
        Wed, 26 Jun 2019 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561574218;
        bh=rPjrA5UKDItDDeBvMzrvupA/HE7q5dkO/2GejoVYEsU=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=pyiZmAQTWwmV9IucQm5qJLcRgqCJyBirwquRA9A0YFbOVE7WcEhB0PDd0LFoFh5Ux
         Q83RYbitSQbtdPIkzJtkHGO+01GyWUg6bJwAIrpsMyR9912CITIh7IHLBXagIsyHaJ
         FKm1pvMRlGh1yefdXwX/3Iz7HKwi3ncOw+5djHXA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1558433454-27971-5-git-send-email-claudiu.beznea@microchip.com>
References: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com> <1558433454-27971-5-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 4/4] clk: at91: sckc: add support for SAM9X60
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:36:58 -0700
Message-Id: <20190626183658.BA53A216FD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2019-05-21 03:11:33)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add support for SAM9X60's slow clock.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

FYI, this patch is base64 encoded and causes my MUA to have lots of
pain. It would be nice if you could send plain text emails, otherwise it
takes me a few more seconds to extract the patch. Of course, it reminds
me that I need to fix my MUA so maybe this is OK!

