Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DD70B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfGVVcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbfGVVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:32:16 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B79B21900;
        Mon, 22 Jul 2019 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831135;
        bh=4ePKRVOjuk0pdWmx57Jr5AQcVG8sUyMlkiLelXx84UU=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=Qry+PWBd926llkTs47Y1tV3OpEOjUw9u7ySLBx4LyW+s/RNEWYd+7XCZcWVbnzgvd
         pRua+Q7cWTp1cp6QJala2Xc5wxa4kurCzy4CCoSK5R4f4nMkd/i0MfbyLiJTYulo0x
         kikV7uMfILBA+IHveio5Z7NYYXW7seS4wCy+tHGw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190625091002.27567-1-codrin.ciubotariu@microchip.com>
References: <20190625091002.27567-1-codrin.ciubotariu@microchip.com>
Subject: Re: [RESEND][PATCH] clk: at91: generated: Truncate divisor to GENERATED_MAX_DIV + 1
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:32:14 -0700
Message-Id: <20190722213215.9B79B21900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2019-06-25 02:10:02)
> In clk_generated_determine_rate(), if the divisor is greater than
> GENERATED_MAX_DIV + 1, then the wrong best_rate will be returned.
> If clk_generated_set_rate() will be called later with this wrong
> rate, it will return -EINVAL, so the generated clock won't change
> its value. Do no let the divisor be greater than GENERATED_MAX_DIV + 1.
>=20
> Fixes: 8c7aa6328947 ("clk: at91: clk-generated: remove useless divisor lo=
op")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---

Applied to clk-fixes

