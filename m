Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B146313E01E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 17:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgAPQaE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jan 2020 11:30:04 -0500
Received: from mailoutvs15.siol.net ([185.57.226.206]:53052 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbgAPQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:30:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3C276523A5E;
        Thu, 16 Jan 2020 17:30:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id A6PWpPq6coxW; Thu, 16 Jan 2020 17:30:01 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id ED29A523AA7;
        Thu, 16 Jan 2020 17:30:00 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id D3BA1523A85;
        Thu, 16 Jan 2020 17:29:59 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Date:   Thu, 16 Jan 2020 17:29:59 +0100
Message-ID: <4499867.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20200116122700.2wy2wrgvmyvudj2t@gilmour.lan>
References: <20200115193441.172902-1-jernej.skrabec@siol.net> <20200116122700.2wy2wrgvmyvudj2t@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne četrtek, 16. januar 2020 ob 13:27:00 CET je Maxime Ripard napisal(a):
> Hi Jernej,
> 
> On Wed, Jan 15, 2020 at 08:34:41PM +0100, Jernej Skrabec wrote:
> > Tanix TX6 has 32 GiB eMMC. Add a node for it.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> Did you forget to send the other two patches?

There are none. This is just mistake with "git format-patch -3".

This patch was tested separately and it works.

Best regards,
Jernej


