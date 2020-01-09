Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6731354B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 09:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgAIIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 03:48:59 -0500
Received: from mail.manjaro.org ([176.9.38.148]:46310 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgAIIs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:48:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 1D01636E4E4F;
        Thu,  9 Jan 2020 09:48:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YfbeHlYlYRpT; Thu,  9 Jan 2020 09:48:55 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/1] Regression in analogix_anx78xx
Date:   Thu,  9 Jan 2020 09:48:00 +0100
Message-Id: <20200109084801.3117-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ff1e8fb68ea0 ("drm/bridge: analogix-anx78xx: Avoid drm_dp_link helpers")
stores the max link rate in a u8, overflowing it.
This will probably prevent the link training from working properly.

I've not tested this patch beyond a simple compile test since I do not own
any devices containing an anx78xx. So please test!

Tobias

Tobias Schramm (1):
  drm/bridge: anx78xx: fix integer type used for storing dp link rate

 drivers/gpu/drm/bridge/analogix-anx78xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.24.1

