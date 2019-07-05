Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03451603C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfGEKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 06:03:55 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48121 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGEKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:03:55 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 244761C0005;
        Fri,  5 Jul 2019 10:03:48 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] checkpatch: DT bindings vendor prefixes file yas been translated into yaml
Date:   Fri,  5 Jul 2019 12:03:45 +0200
Message-Id: <20190705100345.29269-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extension is now .yaml instead of .txt.

Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bb28b178d929..9a3163020d67 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3027,7 +3027,7 @@ sub process {
 			my @compats = $rawline =~ /\"([a-zA-Z0-9\-\,\.\+_]+)\"/g;
 
 			my $dt_path = $root . "/Documentation/devicetree/bindings/";
-			my $vp_file = $dt_path . "vendor-prefixes.txt";
+			my $vp_file = $dt_path . "vendor-prefixes.yaml";
 
 			foreach my $compat (@compats) {
 				my $compat2 = $compat;
-- 
2.19.1

