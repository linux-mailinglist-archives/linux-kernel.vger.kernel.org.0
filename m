Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208A7D5B43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 08:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfJNGTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 02:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNGTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:19:52 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB8020854;
        Mon, 14 Oct 2019 06:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571033991;
        bh=G3j79Lr1xNDLJ1DZYooCMhYnk2SpMlhTRuB05XZTAZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vqMBWKBv5wMMlKQRyLwibF7IThEe5J/kd4Ka2k3MCrCrk044Qr3UxvEykUO4KJh2A
         zX5Am2AhoaK48PbKepzLZCeuqdAGpuEO670ySVDUx2VCDwmoCa6rX9t3MVTBDX93Cj
         CtQOuEm7exBDrrhJijqGKHhK1LrU68E3M8jJNMsc=
Date:   Mon, 14 Oct 2019 14:19:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2 1/2] arm64: dts: ls1028a: Update the clock providers for the
 Mali DP500
Message-ID: <20191014061930.GB12262@dragon>
References: <20190920083419.5092-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920083419.5092-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:34:18PM +0800, Wen He wrote:
> In order to maximise performance of the LCD Controller's 64-bit AXI
> bus, for any give speed bin of the device, the AXI master interface
> clock(ACLK) clock can be up to CPU_frequency/2, which is already
> capable of optimal performance. In general, ACLK is always expected
> to be equal to CPU_frequency/2. APB slave interface clock(PCLK) and
> Main processing clock(PCLK) both are tied to the same clock as ACLK.
> 
> This change followed the LS1028A Architecture Specification Manual.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Applied, thanks.
