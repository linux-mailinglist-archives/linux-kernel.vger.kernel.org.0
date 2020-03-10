Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0F17EE55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 03:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCJCDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 22:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgCJCDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:03:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BFB24654;
        Tue, 10 Mar 2020 02:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583805818;
        bh=oPMLCIJ1bcq7nkitNI1MzG6WRhQMYsY4zOVlzRAPCCY=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=oYYhlTdKI24CnKhViDPzDNkW/ja77pMwy05zklcJ0uXOVBYq+1fjbdZYO/kU3xlUn
         6f+3YMskKQFVmw9ozsIofjOI6yqoCX1W1oAfKdHiwcJdsptPGG773cYmt4ScHzjoId
         vmYgtFVjGWqTZgYOoMVg6Bdp8aaqcP8Q6zK7xutk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200310002218.DF8F280307C8@mail.baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru> <20200310002218.DF8F280307C8@mail.baikalelectronics.ru>
Subject: Re: [PATCH 0/5] clk: Add Baikal-T1 SoC Clock Control Unit support
From:   Stephen Boyd <sboyd@kernel.org>
To:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paulburton@kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 19:03:37 -0700
Message-ID: <158380581761.149997.14282326995500288620@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Semin (2020-03-09 17:21:26)
>=20
> It appears our corporate email server changes the Message-Id field of=20
> messages passing through it. Due to that the emails threading gets to be
> broken. I'll resubmit the properly structured patchset as soon as our sys=
tem
> administrator fixes the problem. Sorry for the inconvenience caused by it.
>=20

Please trim replies. I had to scroll and that made my life super hard! :P=20

Anyway, I see a thread so maybe my MUA figured it out. I can wait for it
to be sorted on the corporate end though.
