Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3862917DAED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 04:32:23 -0400
Received: from v6.sk ([167.172.42.174]:34204 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIIcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:32:23 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D353260EEC;
        Mon,  9 Mar 2020 08:32:20 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 0/3] Add support for Chrontel CH7033 VGA/DVI Encoder
Date:   Sat,  7 Mar 2020 20:07:57 +0100
Message-Id: <20200307190800.142658-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

chained to this message is a driver for CH7033 along with device tree
binding docs. I'm hoping that it could perhaps make it into 5.7. Please
take a look.

Previous submission [1] contained the exact same patches as this one,
but at that time they relied on Laurent's omapdrm/bridge/devel branch tha=
t
has been merged since.

[1] https://lore.kernel.org/lkml/20200221162743.14141-1-lkundrak@v3.sk/

Tested to work well on MMP3-based Dell Wyse 3020. There's no datasheet or
programming manual available.

Thanks,
Lubo



