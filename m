Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F555B04EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 22:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfIKUis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 16:38:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfIKUis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:38:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DD8FB28D82F
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, kernel@collabora.com, krisman@collabora.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/3] docs: scsi: fix typo
Date:   Wed, 11 Sep 2019 17:37:33 -0300
Message-Id: <20190911203735.1332398-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Busses" is the third person conjugation of verb "to buss" in the
present tense. "Buses" is the plural of bus, as in "serial bus".

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/driver-api/scsi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/scsi.rst b/Documentation/driver-api/scsi.rst
index 64b231d125e0..349ac8a55214 100644
--- a/Documentation/driver-api/scsi.rst
+++ b/Documentation/driver-api/scsi.rst
@@ -18,7 +18,7 @@ optical drives, test equipment, and medical devices) to a host computer.
 
 Although the old parallel (fast/wide/ultra) SCSI bus has largely fallen
 out of use, the SCSI command set is more widely used than ever to
-communicate with devices over a number of different busses.
+communicate with devices over a number of different buses.
 
 The `SCSI protocol <http://www.t10.org/scsi-3.htm>`__ is a big-endian
 peer-to-peer packet based protocol. SCSI commands are 6, 10, 12, or 16
-- 
2.23.0

