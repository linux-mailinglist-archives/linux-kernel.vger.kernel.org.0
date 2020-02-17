Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3138A16093A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 04:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBQDtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 22:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgBQDtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:49:06 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6B3206E2;
        Mon, 17 Feb 2020 03:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581911346;
        bh=I9tH1uPwP9k8hna9VlZsQhTYgToiCLium69V90L8L94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qauHQ8NQsKt8i2lcBxEMdERol6YlVgubroXNjstrgtkz85l0pswccPislTilvoHDR
         VOS1y9vJPnmO2TqxHTNpIHYstlDBLRT37wTRRjMjd1KaiWpxKMhK5kUGlxVxMQJMhU
         R3iDumt6HSeg1FlS1J714fO4RuM2XFinYrp0R4Mw=
Date:   Mon, 17 Feb 2020 11:48:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx25-pinfunc: add another cspi3 config
Message-ID: <20200217034858.GA5395@dragon>
References: <20200204215229.32485-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204215229.32485-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 10:52:29PM +0100, Martin Kaiser wrote:
> This patch adds defines for another cspi3 configuration.
> The defines have been tested on an out-of-tree board.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
