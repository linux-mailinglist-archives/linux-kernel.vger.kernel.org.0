Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7258A06B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfHLOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfHLOLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:11:49 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5777220679;
        Mon, 12 Aug 2019 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565619108;
        bh=Pz8gnq2FA5s5y8w7DuRNIWBIHEt1e36T4KvhlqHuyEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttPOM1rdYoG6U/v/9W/edMZLYgYSBb7BKBPPILdPez4HT85g3uHCdEWIYnDGoINik
         IlrD6tEhYt1DDqYinHwjqTIAwwP5tc4V4KWEMXsaYpCGQIKclLwU1ql0Wl373+5jpe
         FAhbsqzgpQde6Nt5fESgj4DOStxi95M5pkbGJ3m4=
Date:   Mon, 12 Aug 2019 16:11:38 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Add Thermal Monitor Unit node
Message-ID: <20190812141137.GH27041@X250>
References: <20190806053507.37069-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806053507.37069-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:35:07PM +0800, Yuantian Tang wrote:
> The Thermal Monitoring Unit (TMU) monitors and reports the
> temperature from 2 remote temperature measurement sites
> located on ls1028a chip.
> Add TMU dts node to enable this feature.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

Applied, thanks.
