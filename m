Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68711103BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfKTNid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfKTNia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:30 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1895522528;
        Wed, 20 Nov 2019 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257109;
        bh=G9PzUqw1T/+8vNPt+Nsu3iMbzun+ZSZJWMpTWmAM/+o=;
        h=From:To:Cc:Subject:Date:From;
        b=JtrIKfBOrr1/LGEzRpdB2y90AMiS3EgtmjvEIi7orMhUciWU/2XVNOpkkLzVtEz0L
         G6cTTxmbXadqUThLb3wMPh+8D+bGEXPbzDDuFUNkKYA5uiFz8S4q3eGAqJ1aGGYpZK
         uJiLosc572wfUZ0ch85vcxqKwVCOC6hD/iEfDdCQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH] w1: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:26 +0800
Message-Id: <20191120133826.12964-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/w1/slaves/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index 687753889c34..32b8a757744e 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -71,8 +71,8 @@ config W1_SLAVE_DS2805
 	help
 	  Say Y here if you want to use a 1-wire
 	  is a 112-byte user-programmable EEPROM is
-          organized as 7 pages of 16 bytes each with 64bit
-          unique number. Requires OverDrive Speed to talk to.
+	  organized as 7 pages of 16 bytes each with 64bit
+	  unique number. Requires OverDrive Speed to talk to.
 
 config W1_SLAVE_DS2430
 	tristate "256b EEPROM family support (DS2430)"
-- 
2.17.1

