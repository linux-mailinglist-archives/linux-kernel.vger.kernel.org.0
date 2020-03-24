Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418BC191410
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgCXPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:19:39 -0400
Received: from v6.sk ([167.172.42.174]:58108 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgCXPTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:19:39 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id B77AF60EEC;
        Tue, 24 Mar 2020 15:19:37 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] drm: Add support for Chrontel CH7033 VGA/DVI Encoder
Date:   Tue, 24 Mar 2020 16:19:28 +0100
Message-Id: <20200324151931.449985-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
chained to this message is another spin of a driver for CH7033.
Only cosmetic changes since the previous version [1]. Please take a look.

[1] https://lore.kernel.org/lkml/20200314101627.336939-1-lkundrak@v3.sk/
 
Thanks,
Lubo



