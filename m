Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FCF485C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfFQOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:41:25 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:50378 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFQOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:41:25 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id RqhQ200013XaVaC01qhQ53; Mon, 17 Jun 2019 16:41:24 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsp1-0002KX-U0; Mon, 17 Jun 2019 16:41:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsp1-0001S6-SE; Mon, 17 Jun 2019 16:41:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] tools/firmware: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:41:22 +0200
Message-Id: <20190617144122.5541-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/firmware/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/firmware/Makefile b/tools/firmware/Makefile
index d329825aa31be379..cfb297e6ef5ae43e 100644
--- a/tools/firmware/Makefile
+++ b/tools/firmware/Makefile
@@ -10,4 +10,4 @@ all: ihex2fw
 clean:
 	$(RM) ihex2fw
 
-.PHONY: all clean
\ No newline at end of file
+.PHONY: all clean
-- 
2.17.1

