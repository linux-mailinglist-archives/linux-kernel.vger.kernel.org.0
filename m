Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4913AC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgANOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:43:25 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:38835 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1579013004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PX5tKIG5LXYHZbMQPwsn5YEgEtw9pEZTLwOmysNDEoE=;
  b=e2dt+FBOyJyZyW2EsVlJX9pZ99Cuj8N14jNhhnqsWEPuHqPeMbqv3t1m
   a8ukOZljzbffz56/dXjDAyhRAfcign9ODYT4WdSLLOI1qy3i1yusjvD9C
   oJ5bkeLP/n5T8YfamXW3DjDoCsZTILC5JWxw1UhevOkeFj6WVjAQAkYNf
   c=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 49J5zOfg9xKLaJyx/dhs14KVSqFaKzjQwyeiUpCMFrCu4tEUyLgS9TZN3HqZy3U+k5nOHW5JDr
 pjXmzQ/wg2GyRcWc6qXEr6WapcX1zZfh9gFaeWDA5rzsAhYg9S5wmuGnXtlQ9ZJQ5wifBVFqmw
 uwseuO3h2SpVsY2uIDiApfk9YJuzjKWnqO01lMWoOYSYIRfYD2MgbfmA6hO0aw3bPDZ+L8n3NB
 VBsTd0eudHXd4QNVnYMTsUrQKyonzCthpOSYB7liYwV6l2lJ6BuciFNuSp+xE/XCoIGHT61y+f
 8hM=
X-SBRS: 2.7
X-MesageID: 11479794
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,433,1571716800"; 
   d="scan'208";a="11479794"
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
To:     <fcoe-devel@open-fcoe.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        Igor Druzhinin <igor.druzhinin@citrix.com>
Subject: [PATCH RESEND 1/2] scsi: libfc: free response frame from GPN_ID
Date:   Tue, 14 Jan 2020 14:43:19 +0000
Message-ID: <1579013000-14570-2-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579013000-14570-1-git-send-email-igor.druzhinin@citrix.com>
References: <1579013000-14570-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fc_disc_gpn_id_resp() should be the last function using it so free it
here to avoid memory leak.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 drivers/scsi/libfc/fc_disc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 9c5f7c9..2b865c6 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -628,6 +628,8 @@ static void fc_disc_gpn_id_resp(struct fc_seq *sp, struct fc_frame *fp,
 	}
 out:
 	kref_put(&rdata->kref, fc_rport_destroy);
+	if (!IS_ERR(fp))
+		fc_frame_free(fp);
 }
 
 /**
-- 
2.7.4

