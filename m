Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C426EFEF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfGTQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 12:03:35 -0400
Received: from mailoutvs36.siol.net ([185.57.226.227]:53080 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726482AbfGTQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 12:03:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6EE635207E5;
        Sat, 20 Jul 2019 18:03:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id N2-Axw94Gu4C; Sat, 20 Jul 2019 18:03:32 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 22AFF52066B;
        Sat, 20 Jul 2019 18:03:32 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id ED72F520CD1;
        Sat, 20 Jul 2019 18:03:29 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] drm/sun4i: Add support for color encoding and range
Date:   Sat, 20 Jul 2019 18:03:29 +0200
Message-ID: <10088719.p65GSun1Qg@jernej-laptop>
In-Reply-To: <20190720054255.vyma2lyiu2tohl74@flea>
References: <20190713120346.30349-1-jernej.skrabec@siol.net> <20190720054255.vyma2lyiu2tohl74@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 20. julij 2019 ob 07:42:55 CEST je Maxime Ripard napisal(a):
> On Sat, Jul 13, 2019 at 02:03:43PM +0200, Jernej Skrabec wrote:
> > In order to correctly convert image between YUV and RGB, you have to
> > know color encoding and color range. This patch set adds appropriate
> > properties and considers them when choosing CSC conversion matrix for
> > DE2 and DE3.
> > 
> > Note that this is only the half of needed changes when using HDMI output.
> > DW HDMI bridge driver has to be extended to have a property to select
> > limited (TVs) or full (PC monitors) range. But that will be done at a
> > later time.
> > 
> > Please take a look.
> 
> Sorry for the delay, I applied all three.

No problem. Thanks!

Best regards,
Jernej



