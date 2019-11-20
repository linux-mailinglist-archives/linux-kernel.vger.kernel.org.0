Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41553104635
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 22:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKTVzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 16:55:04 -0500
Received: from mail.manjaro.org ([176.9.38.148]:47858 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfKTVzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:55:04 -0500
X-Greylist: delayed 1160 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 16:55:04 EST
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 80DBC36CEEA7;
        Wed, 20 Nov 2019 22:35:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X2oyrMKWTOPv; Wed, 20 Nov 2019 22:35:40 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/1] drm/panel: simple: Add support for BOE NV140FHM-N49 panel to panel-simple
Date:   Wed, 20 Nov 2019 22:34:39 +0100
Message-Id: <20191120213440.924563-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the 14 inch BOE NV140FHM-N49 eDP panel to
the panel-simple driver. This panel is used by the Pinebook Pro.

Tobias Schramm (1):
  drm/panel: simple: Add support for BOE NV140FHM-N49 panel to
    panel-simple

 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.24.0

