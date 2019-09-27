Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78499C000B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfI0Haf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 03:30:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfI0Haf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:30:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9963B5FE;
        Fri, 27 Sep 2019 07:30:33 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     qla2xxx-upstream@qlogic.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2] scsi: qla2xxx: Remove WARN_ON_ONCE in qla2x00_status_cont_entry()
Date:   Fri, 27 Sep 2019 09:30:31 +0200
Message-Id: <20190927073031.62296-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 88263208dd23 ("scsi: qla2xxx: Complain if sp->done() is not
called from the completion path") introduced the WARN_ON_ONCE in
qla2x00_status_cont_entry(). The assumption was that there is only one
status continuations element. According to the firmware documentation
it is possible that multiple status continuations are emitted by the
firmware.

Fixes: 88263208dd23 ("scsi: qla2xxx: Complain if sp->done() is not
called from the completion path")
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---

changes v2:
 - add Fixes and Reviewed-by tags

 drivers/scsi/qla2xxx/qla_isr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 30fd2d355f3a..acef3d73983c 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2858,8 +2858,6 @@ qla2x00_status_cont_entry(struct rsp_que *rsp, sts_cont_entry_t *pkt)
 	if (sense_len == 0) {
 		rsp->status_srb = NULL;
 		sp->done(sp, cp->result);
-	} else {
-		WARN_ON_ONCE(true);
 	}
 }
 
-- 
2.16.4

