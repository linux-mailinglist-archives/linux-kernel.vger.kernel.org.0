Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F014C295
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 23:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgA1WE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 17:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1WE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:04:56 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99CD21739;
        Tue, 28 Jan 2020 22:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580249096;
        bh=b+RXMSIEBrzzUUg96t0fh1UCu115VqLcpTvvRE2t3/g=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=xevb0mJo6byby6Pr5sWwGJdb3P4WzMkJrJlkIpDKWpcroknINcv8Af8eVgPazGR+n
         ZcLqZg+2qHGLs+BszRQx563rGEyfbX6mTUzcU73cEyVKnB1AapmkPZ3/TgI7mBBm3R
         43SmeT9cIamVaNSoLz73SPXRrxOekpVxAt0fPhhQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200102231101.11834-3-michael@walle.cc>
References: <20200102231101.11834-1-michael@walle.cc> <20200102231101.11834-3-michael@walle.cc>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/3] clk: fsl-sai: new driver
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 14:04:55 -0800
Message-Id: <20200128220455.D99CD21739@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2020-01-02 15:11:01)
> With this driver it is possible to use the BCLK pin of the SAI module as
> a generic clock output. This is esp. useful if you want to drive a clock
> to an audio codec. Because the output only allows integer divider values
> the audio codec needs an integrated PLL.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Applied to clk-next

