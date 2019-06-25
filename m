Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADE355570
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfFYRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 13:05:29 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34048 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfFYRF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:05:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6D9A8FB03;
        Tue, 25 Jun 2019 19:05:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YQAMMWVAO5To; Tue, 25 Jun 2019 19:05:19 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 48F9B48E30; Tue, 25 Jun 2019 19:05:19 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: [PATCH 0/4] drm/panel: jh057n0090: Add regulators and drop magic value in init
Date:   Tue, 25 Jun 2019 19:05:15 +0200
Message-Id: <cover.1561482165.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the omission of regulators for the recently added panel and make
sure all dsi commands start with a command instead of one having a magic
constant (which already caused confusion).

Also adds a mail alias to the panel's MAINTAINER entry to reduce the bus
factor.

To: Thierry Reding <thierry.reding@gmail.com>,Sam Ravnborg <sam@ravnborg.org>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,Rob Herring <robh+dt@kernel.org>,Mark Rutland <mark.rutland@arm.com>,Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,"David S. Miller" <davem@davemloft.net>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,Nicolas Ferre <nicolas.ferre@microchip.com>,"Paul E. McKenney" <paulmck@linux.ibm.com>,dri-devel@lists.freedesktop.org,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org,Purism Kernel Team <kernel@puri.sm>


Guido Günther (4):
  MAINTAINERS: Add Purism mail alias as reviewer for their devkit's
    panel
  drm/panel: jh057n0090: Don't use magic constant
  dt-bindings: display/panel: jh057n0090: Document power supply
    properties
  drm/panel: jh057n0090: Add regulator support

 .../display/panel/rocktech,jh057n00900.txt    |  5 +++++
 MAINTAINERS                                   |  1 +
 .../drm/panel/panel-rocktech-jh057n00900.c    | 22 ++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.20.1

