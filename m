Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE97492467
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfHSNKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfHSNKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:10:48 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0416C2086C;
        Mon, 19 Aug 2019 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566220247;
        bh=efgMIFqbDub5AwYwoCwk6l2PFpmusRxRiQTqU1CB5XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZyi85pST9l8iaCgZUCUoS2J5F5RXdWTLtK/ebZtddL0C53Hgr9mw0Fjh8fXHOweN
         mJlCAxk706p3+QtP8GMgHJ2IQmu+JHVI6WT/FZPxADhkQJLQpJkXqjEm62Tt7J9cPj
         AM5eeH0z1Fni93ZYLW4fXEeARzf9ZMmuLcdJXCU8=
Date:   Mon, 19 Aug 2019 15:10:35 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaobo.xie@nxp.com,
        jiafei.pan@nxp.com, yangbo.lu@nxp.com,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: Re: [PATCH v5] arm64: dts: ls1028a: Add esdhc node in dts
Message-ID: <20190819131033.GH5999@X250>
References: <20190815033901.18696-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815033901.18696-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:39:01AM +0800, Yinbo Zhu wrote:
> From: Ashish Kumar <Ashish.Kumar@nxp.com>
> 
> This patch is to add esdhc node and enable SD UHS-I,
> eMMC HS200 for ls1028ardb/ls1028aqds board.
> 
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied, thanks.
