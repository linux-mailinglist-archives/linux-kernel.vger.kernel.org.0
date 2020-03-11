Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59218130A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 09:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgCKIev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 04:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgCKIev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:34:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E216420828;
        Wed, 11 Mar 2020 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583915691;
        bh=MXW2z5LPp0WQucUkJT7tI/HgnXFy6BLbj6K20XcMANg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8TBtGrwq/ozgqTAaonxpvDixFBdqsY1wNC8Bk1qH6SheUDDFmbU3oHSYgPWjgVjP
         MSWROiFHvc2W+1Rcnq+ClqGiGBoVRv8HPIIPSkK8qiWTkypgNUHMDIEyd3kIDAKnUa
         IfKVPWLEV7xr8WkkdxNmmTX0e1PSQgj6x33ArmUo=
Date:   Wed, 11 Mar 2020 16:34:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: lx2160ardb: Update FSPI node properties
Message-ID: <20200311083442.GE29269@dragon>
References: <1583217512-27994-1-git-send-email-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583217512-27994-1-git-send-email-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:08:31PM +0530, Kuldeep Singh wrote:
> Update fspi node compatibles of LX2160A-RDB to "jedec,spi-nor" for
> automatic detection of flash.
> 
> This also helps in fixing below warning:
> spi-nor spi0.0: found mt35xu512aba, expected m25p80
> spi-nor spi0.1: found mt35xu512aba, expected m25p80
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>

Applied both, thanks.
