Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695A315B4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgBLXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgBLXdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:33:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D7E20578;
        Wed, 12 Feb 2020 23:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550388;
        bh=b9wkkGs5vusSYEpW5WxBoVJJlRyrfYZNb33I5l2fp/w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZtLujdCL8r3ejsmysKydkXGKgaeTM1xp1xJ3LIn3rLbWQucq7SoG7tuSInKmwZWX9
         UbX5xS9TtFfvM4O7KZ3F9oFLxua7QEQ/uFzUribxBaqDcfc/oJDr+PFMUW3dOX9ZfD
         XEQHk7r5jv/icTZwcfAokxBOc85KRWId4upWGAPI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200117210529.17490-1-alexandre.belloni@bootlin.com>
References: <20200117210529.17490-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] clk: at91: add at91sam9g45 pmc driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Date:   Wed, 12 Feb 2020 15:33:07 -0800
Message-ID: <158155038715.184098.9864434667513148223@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2020-01-17 13:05:29)
> Add a driver for the PMC clocks of the at91sam9g45 family.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
