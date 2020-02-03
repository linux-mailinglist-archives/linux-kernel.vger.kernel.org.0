Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35108150FA6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 19:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgBCSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 13:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgBCSd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:33:58 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8895C2082E;
        Mon,  3 Feb 2020 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580754837;
        bh=SUWjS2utIKZaz04OD1tSXhOYAJcs1L5cO7U7KGG005w=;
        h=In-Reply-To:References:From:To:Subject:Cc:Date:From;
        b=EoClibf02ha3vh+LKKOBjpPoJy34N6IoYhy1bLK9AzZR4QwlWsc76KI63C8OlcXjL
         WeCWZx0h1+Osn+z+DO036ASGnS8xVFB8z+7CY43DoAV0bumz8Q+FOXOnG3ciu7si5q
         R3fAPPM4u0cT9e3iFJaqowaA7nxw1H4sDTLHpwDg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200203052507.93215-2-sboyd@kernel.org>
References: <20200203052507.93215-1-sboyd@kernel.org> <20200203052507.93215-2-sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] dt/bindings: clk: fsl,plldig: Drop 'bindings' from schema id
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wen He <wen.he_1@nxp.com>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 10:33:56 -0800
Message-Id: <20200203183357.8895C2082E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-02-02 21:25:07)
> Having 'bindings' in here causes a warning when checking the schema.
>=20
>  Documentation/devicetree/bindings/clock/fsl,plldig.yaml:
>  $id: relative path/filename doesn't match actual path or filename
>          expected: http://devicetree.org/schemas/clock/fsl,plldig.yaml#
>=20
> Remove it.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

