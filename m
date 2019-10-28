Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B4E70CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfJ1Lw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 07:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbfJ1Lw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:52:57 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BEB1214D9;
        Mon, 28 Oct 2019 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572263577;
        bh=8hJIjJ+E1m4Pah5tqGcOg9p22uWWbGt4oxsXkgRt41c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1O2hMHl5Eb6yDgwV6YAT1XyKM9RjSxMVU1knnHxtWZR1B7oVbkc1B7CmbmrXHVDm3
         l0zcoTxLtYU9MZmUNcijVKBvHXa7nhKJgxKv50L/4HaXvoAkpnAfHyIEgVzgDhDOvi
         EfeObR+r6I0GjvN/r8qlqZQ7gI89UZBF+j4SP7RM=
Date:   Mon, 28 Oct 2019 19:52:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH trivial] ARM: dts: imx53: Spelling
 s/configration/configuration/
Message-ID: <20191028115233.GF16985@dragon>
References: <20191024144443.27761-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024144443.27761-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 04:44:43PM +0200, Geert Uytterhoeven wrote:
> Fix misspelling of "configuration".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.
