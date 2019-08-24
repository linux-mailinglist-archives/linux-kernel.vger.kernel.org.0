Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807089C02B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfHXUlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 16:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHXUls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:41:48 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E25120850;
        Sat, 24 Aug 2019 20:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566679308;
        bh=HefwpWi/5mvxMqfzEVIQylA0rs9qcvEDqB4ppJLhKFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8UbKxVgaYnfanghOV0kOlJGiP967SILqbwkIgTs6HCkQbE7sgc7oqU5lrz+A4ciG
         yraNYVmmpXbxnzVs8tuzNY9lhdyDlqrI9Ghy3LvpnZcYXgEdpApoj4W+EBTCrgcloU
         S9bnHIf0UrugrpmakSCF1+a5HPANygChz/JHODkk=
Date:   Sat, 24 Aug 2019 22:41:35 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: gpcv2: Print the correct error code
Message-ID: <20190824204134.GK16308@X250.getinternet.no>
References: <ceab1bb4984d0a4f59a580cd9956c1fd6d6a78f3.1566405120.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceab1bb4984d0a4f59a580cd9956c1fd6d6a78f3.1566405120.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:33:04PM +0200, Guido Günther wrote:
> The current code prints 'ret' (thus 0) while it should use 'err'.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks.
