Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6134356BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfFZO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:29:27 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:57243 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfFZO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:29:25 -0400
Received: from h2730561.stratoserver.net (h2730561.stratoserver.net [85.214.29.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 27A291F42E;
        Wed, 26 Jun 2019 16:29:23 +0200 (CEST)
From:   =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>,
        Sabrina Gaube <sabrina-gaube@web.de>
Subject: [PATCH 1/2] staging: rts5208: Rewrite redundant if statement to improve code style
Date:   Wed, 26 Jun 2019 16:28:56 +0200
Message-Id: <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
References: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit uses the fact that

    if (a) {
            if (b) {
                    ...
            }
    }

can instead be written as

    if (a && b) {
            ...
    }

without any change in behavior, allowing to decrease the indentation
of the contained code block and thus reducing the average line length.

Signed-off-by: Tobias Nießen <tobias.niessen@stud.uni-hannover.de>
Signed-off-by: Sabrina Gaube <sabrina-gaube@web.de>
---
 drivers/staging/rts5208/sd.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index b3f829ed1019..a06045344301 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4507,20 +4507,19 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			sd_lock_state, sd_card->sd_lock_status);
 		if (sd_lock_state ^ (sd_card->sd_lock_status & SD_LOCKED)) {
 			sd_card->sd_lock_notify = 1;
-			if (sd_lock_state) {
-				if (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) {
-					sd_card->sd_lock_status |= (
-						SD_UNLOCK_POW_ON | SD_SDR_RST);
-					if (CHK_SD(sd_card)) {
-						retval = reset_sd(chip);
-						if (retval != STATUS_SUCCESS) {
-							sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
-							goto sd_execute_write_cmd_failed;
-						}
+			if (sd_lock_state &&
+			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
+				sd_card->sd_lock_status |= (
+					SD_UNLOCK_POW_ON | SD_SDR_RST);
+				if (CHK_SD(sd_card)) {
+					retval = reset_sd(chip);
+					if (retval != STATUS_SUCCESS) {
+						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
+						goto sd_execute_write_cmd_failed;
 					}
-
-					sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
 				}
+
+				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
 			}
 		}
 	}
-- 
2.17.0

