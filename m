Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE6518DC72
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 01:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgCUATq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 20:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbgCUATq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:19:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A64120658;
        Sat, 21 Mar 2020 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584749985;
        bh=8xvBxIIQydZTAAeg1xjxOXL/CZLRUP+mS861uvfSts8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R6F8yDLDdPfFPiBQs2JnncDBfQbNyp5l8iea78ARUFuKoWXQ6m/e9lrIUxcTWs+vj
         IWuBOa7leMCrekmsK8xj3KRHH8vJXY02u76jNSJikwkzz8w0YJSLHSQzRY7itZKSeu
         88XrbwfFKUFqFFgbY7/8tYfKOOkaFLPyFshrvdSM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200214145934.53648-1-alexandre.belloni@bootlin.com>
References: <20200214145934.53648-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] clk: at91: add at91rm9200 pmc driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Fri, 20 Mar 2020 17:19:44 -0700
Message-ID: <158474998460.125146.8220232566389840354@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2020-02-14 06:59:33)
> Add a driver for the PMC clocks of the at91rm9200.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

But please migrate to new way of specifying clk parents at some point.
