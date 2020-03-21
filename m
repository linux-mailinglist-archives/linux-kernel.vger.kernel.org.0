Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2F18DD35
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgCUBYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:24:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF0B720752;
        Sat, 21 Mar 2020 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753891;
        bh=3Gvii+Cx3jPfn3YMShf1slVelDTAR8E8J6N+9AYJeps=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bR0MpNwovvuClGfmHY549DED1jvxeG3+RKu2RZtuaP2xcGjpIQcOxN0HtuNpBf213
         J9ibZTKxxGVlIut6V6zbCW9wekc4caGljPCudND9J6C4OOTKXaLAmR2ZnFMfN9Fio4
         oYeDwB1RujmzJEDBSPwZMH1vLVZAu/Cev4dMzPeU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-7-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-7-lkundrak@v3.sk>
Subject: Re: [PATCH v2 06/17] dt-bindings: clock: Add MMP3 compatible string
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:24:51 -0700
Message-ID: <158475389106.125146.9384124617803697337@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:43)
> This binding describes the PMUs that are found on MMP3 as well. Add the
> compatible strings and adjust the description.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> ---

Applied to clk-next
