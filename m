Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B329205C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHSJcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 05:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSJcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:32:13 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11BEC2087E;
        Mon, 19 Aug 2019 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566207132;
        bh=Vo9A2BOirgOsYxfqY9+1sJPZ4ZQf0l+rb0llwHP15sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kiOW7EaNeGiJb2plwSWrUzHjjVvdR55Fwp7tSiOgNamGqhHtrd/eW4wDlAaQhOLq3
         bHY05OQLwsdAvUwBZyNEj5axb4+p6ZEH0cLy9fgMC2zuVVqk3cTupXqnTilK1J2OFT
         ypJ3eeXdVOyIhgFP8zIZWs4oOnLxmiP5lGOhFeH0=
Date:   Mon, 19 Aug 2019 11:32:01 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        liviu.dudau@arm.com
Subject: Re: [v1 3/3] arm64: dts: ls1028a: Add properties node for Display
 output pixel clock
Message-ID: <20190819093159.GJ5999@X250>
References: <20190812100224.34502-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812100224.34502-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 06:02:24PM +0800, Wen He wrote:
> The LS1028A has a clock domain PXLCLK0 used for the Display output
> interface in the display core, independent of the system bus frequency,
> for flexible clock design. This display core has its own pixel clock.
> 
> This patch enable the pixel clock provider on the LS1028A.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Applied, thanks.
