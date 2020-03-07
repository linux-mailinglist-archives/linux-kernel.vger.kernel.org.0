Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA2917CFBD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 20:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgCGTIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 14:08:09 -0500
Received: from [167.172.186.51] ([167.172.186.51]:41910 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgCGTII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 14:08:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 60641E00D1;
        Sat,  7 Mar 2020 19:08:24 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hO3c3OLp_9pF; Sat,  7 Mar 2020 19:08:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 29AA2E00D3;
        Sat,  7 Mar 2020 19:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dbpamSfDxU63; Sat,  7 Mar 2020 19:08:22 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4641CDFEC0;
        Sat,  7 Mar 2020 19:08:22 +0000 (UTC)
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


