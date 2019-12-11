Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E513111A697
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfLKJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:16:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfLKJQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:16:40 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE58214AF;
        Wed, 11 Dec 2019 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576055800;
        bh=kOERCDjA00aG8Ioga+ne2Tj7EeKJabiHflhZVyi4e10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCuTKGDstLhwyH6nYr4xaDdAtGMJHSs3zygvBjfCESAPG1VH0oEh7xCT0xUFent04
         ltKTQTEWfkcdZe+a0Gbcc0ETgWEbaKXazF5vaTslmStBrW1KcQwlpVoCf8B0KB3+rG
         6lYgkRrsYWCvoJBn3dGPb8m8gq+Ax4WVPFC42sPM=
Date:   Wed, 11 Dec 2019 17:16:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Yuantian Tang <andy.tang@nxp.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: ls1028a: fix typo in TMU calibration
 data
Message-ID: <20191211091630.GV15858@dragon>
References: <20191209234350.18994-1-michael@walle.cc>
 <20191209234350.18994-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209234350.18994-2-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:43:46AM +0100, Michael Walle wrote:
> The temperature sensor may jump backwards because there is a wrong
> calibration value. Both values have to be monotonically increasing.
> Fix it.
> 
> This was tested on a custom board.
> 
> Fixes: 571cebfe8e2b ("arm64: dts: ls1028a: Add Thermal Monitor Unit node")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Tang Yuantian <andy.tang@nxp.com>

Applied, thanks.
