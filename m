Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754819070E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfHPRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfHPRhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:37:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD2F205F4;
        Fri, 16 Aug 2019 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565977026;
        bh=3211moOdEoax3Ux0E0nVz+1fI/L2wdR4tSaRDOLKgK8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=txrPkUyxFz9MhSYZBaa7oJQZljvsq9h6O60vhot5n0OSovNZGtgpRQQWG4VL8lKY8
         esvIHKsxEMPadja4wUiFsbeQjFW5vFk5nvlykD1jDyPK73ETl9XYqzFFBt4fb1bfRm
         WyLTZV6BR/l3nilxsWFAMOJ2WwM8jFe36QpdzLt4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815042500.9519-1-sboyd@kernel.org>
References: <20190815042500.9519-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: composite: Drop unused clk.h include
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:37:05 -0700
Message-Id: <20190816173706.3DD2F205F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-14 21:25:00)
> This include isn't used. Drop it.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

