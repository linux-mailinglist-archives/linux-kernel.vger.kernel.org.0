Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9E90732
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfHPRrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfHPRrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:47:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD5B205F4;
        Fri, 16 Aug 2019 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565977644;
        bh=ZQTka4AK12egDIr2nKoEw6cy762BJxPfN0PZ5PqXjSc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GqQnTgtqB0r0jj5XwhlQtVLCS3CxeEaK46hHSnlmTflisbkMPZOc7RqQ98oUJnmLe
         4fNI9iq0B1kCb+7lOcT4hlTOMjBQPtU13nK6JkDjjtRTUJaSPoRBfEqNFhKdThoPE2
         TGNk5B7EUk8QMUOxMeXblp71w435G3Y3bMwvKj6I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815101613.22872-1-wen.he_1@nxp.com>
References: <20190815101613.22872-1-wen.he_1@nxp.com>
Subject: Re: [v2 1/3] dt/bindings: clk: Add YAML schemas for LS1028A Display Clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-devel@linux.nxdi.nxp.com, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:47:23 -0700
Message-Id: <20190816174724.5CD5B205F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-15 03:16:11)
> LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Displ=
ay
> output interface. Add a YAML schema for this.
>=20
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---

Patch looks good. Please send multi-patch series with a cover letter
next time when you resend and pick up Rob's review.

> change in v2:
>         - Convert bindings to YAML format
>=20
