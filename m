Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E197C1CC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfENP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 11:59:33 -0400
Received: from verein.lst.de ([213.95.11.211]:46573 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENP7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:59:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 6C0AC68B05; Tue, 14 May 2019 17:59:11 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        info@olimex.com
Subject: [PATCH 0/4] Add missing device nodes for Olimex Teres-I
Message-Id: <20190514155911.6C0AC68B05@newverein.lst.de>
Date:   Tue, 14 May 2019 17:59:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

based on Maxime's sunxi-dt64-for-5.2, here is what I found so far
still missing in the device tree. Those bits and pieces have already
been submitted but were not yet applied. Currently I also have the
uart1 for bluetooth here, but I'm unsure about the bindings for the
in-kernel btuart.

	  Torsten
