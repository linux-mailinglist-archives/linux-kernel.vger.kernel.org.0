Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9754A1606BE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 22:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBPVg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 16:36:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34218 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPVg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 16:36:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sjoerd)
        with ESMTPSA id 7268B290C1D
Received: by beast.luon.net (Postfix, from userid 1000)
        id F0AC13E1EED; Sun, 16 Feb 2020 22:36:24 +0100 (CET)
From:   Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To:     linux-um@lists.infradead.org
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: Avoid NULL ptr deference if transport is unset
Date:   Sun, 16 Feb 2020 22:36:24 +0100
Message-Id: <20200216213624.800463-1-sjoerd.simons@collabora.co.uk>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the transport option of a vec isn't set strncmp ends up being
called on a NULL pointer. Better not do that.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/um/drivers/vector_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 0ff86391f77d..ca90666c0b61 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -198,6 +198,9 @@ static int get_transport_options(struct arglist *def)
 	long parsed;
 	int result = 0;
 
+	if (transport == NULL)
+		return -EINVAL;
+
 	if (vector != NULL) {
 		if (kstrtoul(vector, 10, &parsed) == 0) {
 			if (parsed == 0) {
-- 
2.25.0

