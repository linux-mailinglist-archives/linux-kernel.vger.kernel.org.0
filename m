Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C11357FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 12:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgAILbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 06:31:08 -0500
Received: from mail.manjaro.org ([176.9.38.148]:36516 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgAILbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:31:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 2CC2E36E4DF8;
        Thu,  9 Jan 2020 12:31:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XAqjcHmOUxfd; Thu,  9 Jan 2020 12:31:05 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [RESEND 0/1] Add support for BOE NV140FHM-N49 panel to panel-simple
Date:   Thu,  9 Jan 2020 12:29:51 +0100
Message-Id: <20200109112952.2620-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the 14 inch BOE NV140FHM-N49 eDP panel to
the panel-simple driver. The panel is used by the Pinebook Pro.

Resending with changed CCs due to lack of feedback.

Tobias Schramm (1):
  drm/panel: Add support for BOE NV140FHM-N49 panel to panel-simple

 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.24.1

