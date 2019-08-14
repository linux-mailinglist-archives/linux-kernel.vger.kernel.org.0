Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189148D7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfHNQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNQXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:23:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E81208C2;
        Wed, 14 Aug 2019 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565799792;
        bh=tN017jx7D3mqg2uTVkRp7Eusfnr22JSYqNHhZgC5KJY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oFCxzkNDOTeh1H6184ZWtl/56xl35DazBAlo6hqrFwDwf1P2hDOmpbVbwjbydjksB
         m+nToyVCXv3TJ4yMoq7C/JFpW46MeYdgczjPNUpLb5wLL5+rqwy3SD58FcycXeCxQU
         /4Ghn8g7Hbp3mYhUkPbDmxh41idiKRP4Pmeo0WFk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814002402.18154-1-sboyd@kernel.org>
References: <20190814002402.18154-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: socfpga: deindent code to proper indentation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 09:23:11 -0700
Message-Id: <20190814162312.85E81208C2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-13 17:24:02)
> This code is indented oddly, causing checkpatch to complain. Indent it
> properly.
>=20
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

