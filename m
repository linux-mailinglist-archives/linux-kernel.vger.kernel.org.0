Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2BA10A43E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKZS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 13:56:31 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:49620 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfKZS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:56:30 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id WiwU210015USYZQ06iwUMP; Tue, 26 Nov 2019 19:56:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZg0h-0002Hb-Sp; Tue, 26 Nov 2019 19:56:27 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZg0h-0000GU-QJ; Tue, 26 Nov 2019 19:56:27 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] docs: device-mapper: Add dm-clone to documentation index
Date:   Tue, 26 Nov 2019 19:56:27 +0100
Message-Id: <20191126185627.970-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the dm-clone documentation was added, it was not added to the
documentation index, leading to a warning when building the
documentation:

    Documentation/admin-guide/device-mapper/dm-clone.rst: WARNING: document isn't included in any toctree

Fixes: 7431b7835f554f86 ("dm: add clone target")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/admin-guide/device-mapper/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
index 4872fb6d29524593..ec62fcc8eeceed83 100644
--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -8,6 +8,7 @@ Device Mapper
     cache-policies
     cache
     delay
+    dm-clone
     dm-crypt
     dm-dust
     dm-flakey
