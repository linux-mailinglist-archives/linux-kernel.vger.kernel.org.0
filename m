Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26ABD806D4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfHCOun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 10:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHCOun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:50:43 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CAC2075C;
        Sat,  3 Aug 2019 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564843842;
        bh=tkbSt5pmygtiBGqZMbLo4ne68Qstn/gKRYx/hNz9Sq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erVw3Ky60yjOL8fYvF+Qb0OQdYZUWDMbvEuTNB4Yu2+vQpRjhqv7i3aEnkhUUHVw1
         pT8ZIW72bxRGV4ea+UTrW7TE5O0kXzv+zhArx8VGtznlU+wPDpm1a+k4yNgNHGaUKc
         DTSUPAyPB2B0bVZBfadMSFt/o84SIC//qkvgKv2s=
Date:   Sat, 3 Aug 2019 16:50:36 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx: Cleanup style around assignment operator
Message-ID: <20190803145035.GN8870@X250.getinternet.no>
References: <20190727142640.23014-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727142640.23014-1-krzk@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 04:26:40PM +0200, Krzysztof Kozlowski wrote:
> Use a space before and after assignment operator to have consistent
> style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
