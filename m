Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2E14C603
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2FoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgA2FoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:44:14 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 808842071E;
        Wed, 29 Jan 2020 05:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580276653;
        bh=NgC+68nCCh+o3ipJk49AAFsa+iYqq0dQPODSuJD9eoI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=NYvJjkFN6jE/ophtq1GUZgqQMtEhQYOgtyMe+OZ01gdV8tp/Za/uhoSe00Ex/73Xw
         oRTvJLzYWq1U+c6FxVx+MwXkWrdXxAIwNbTR2O4HyZptZBeIKrCTY6DLFftQxJFotK
         6B2FakppktBbxTFPP6y/f3Tijvu93nC8elpb2lxk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200120034937.128600-5-jian.hu@amlogic.com>
References: <20200120034937.128600-1-jian.hu@amlogic.com> <20200120034937.128600-5-jian.hu@amlogic.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v7 4/5] dt-bindings: clock: meson: add A1 peripheral clock controller bindings
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 21:44:12 -0800
Message-Id: <20200129054413.808842071E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian Hu (2020-01-19 19:49:36)
> Add the documentation to support Amlogic A1 peripheral clock driver,
> and add A1 peripheral clock controller bindings.
>=20
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---

Would be good to get Rob to ack/review this change. Please resend and
pick up the review tags from Rob on the first patch from the previous
round and fix my comments or respond to them on that previous round too.

>  .../bindings/clock/amlogic,a1-clkc.yaml       | 65 ++++++++++++
>  include/dt-bindings/clock/a1-clkc.h           | 98 +++++++++++++++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cl=
kc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
>=20
