Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A211212C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfLPRzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 12:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfLPRzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:55:44 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C60206B7;
        Mon, 16 Dec 2019 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518944;
        bh=1mV3/yNh0GSIc3le4APUDwgLnHAoG5ix4puzI6eZqdk=;
        h=In-Reply-To:References:To:From:Subject:Date:From;
        b=fGcixwDaIx9KQmcQ0FuaB2h1kXmJF52KbQSo+72cuAAZ12ydjmYtZR9/nC1Ni4f75
         TQbZGhEmrtrFr+1bzMU79jw16HsVPSU8DCJKfrOvsIp+RtX4PJz51qXFteOvQG61cb
         /C4/dDxXIc1M6hx7xf6Y1Zy+G7GTThMjiaR+qUZ0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <F2C21019-79F4-450F-A575-9621E5747C4E@walle.cc>
References: <20191205072653.34701-1-wen.he_1@nxp.com> <20191205072653.34701-2-wen.he_1@nxp.com> <20191212221817.B7FF1206DA@mail.kernel.org> <F2C21019-79F4-450F-A575-9621E5747C4E@walle.cc>
To:     Li Yang <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [v11 2/2] clk: ls1028a: Add clock driver for Display output interface
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 09:55:43 -0800
Message-Id: <20191216175543.F2C60206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2019-12-12 16:06:16)
> Am 12. Dezember 2019 23:18:16 MEZ schrieb Stephen Boyd <sboyd@kernel.org>:
> >Quoting Wen He (2019-12-04 23:26:53)
> >> Add clock driver for QorIQ LS1028A Display output interfaces(LCD,
> >DPHY),
> >> as implemented in TSMC CLN28HPM PLL, this PLL supports the
> >programmable
> >> integer division and range of the display output pixel clock's
> >27-594MHz.
> >>=20
> >> Signed-off-by: Wen He <wen.he_1@nxp.com>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >
> >Is Michael the author? SoB chain is backwards here.
>=20
> the original driver was from Wen. I've just supplied some code and
> the vco frequency stuff. so its basically a sob of us both.=20
>=20
> -michael=20

Ok. That's a Co-developed-by: tag then. Thanks for letting us know.

