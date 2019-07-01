Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB158C34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF0U5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 16:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0U5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:57:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DAF22075E;
        Thu, 27 Jun 2019 20:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561669023;
        bh=6SwJC37GCqSvZUlaUhRiy7DG00rYsYmII/3PWle/kFU=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=pnfrN9orlr/OwdxPyJvm143GzHwF6MzUrCMtXLgNUkkDsjZFnkdizTI9a/HUQiF/k
         vXA8LBQChoI0qAtvL51nAgECprbEkc1xt61DILEECBR7rKuScSZSKST/YwTv0R7Lfd
         LLbwIl53n6RFq3kpLV33zfnspgOzoIO1NHIOUfzE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190517132020.31081-1-mike.looijmans@topic.nl>
References: <20190424090216.18417-1-mike.looijmans@topic.nl> <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com> <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl> <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com> <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl> <20190507140413.28335-1-mike.looijmans@topic.nl> <20190513203146.GA24085@bogus> <20190517132020.31081-1-mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: clock: Add silabs,si5341
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Mike Looijmans <mike.looijmans@topic.nl>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 13:57:02 -0700
Message-Id: <20190627205703.0DAF22075E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-05-17 06:20:20)
> Adds the devicetree bindings for the Si5341 and Si5340 chips from
> Silicon Labs. These are multiple-input multiple-output clock
> synthesizers.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---

Applied to clk-next

