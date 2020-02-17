Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F71613DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 14:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgBQNqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 08:46:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39394 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbgBQNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581947194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cf8YgMTUEKRaWnswbL5aVh8i50xAm7xMMhVzr6GLwJg=;
        b=c4j+vvF1MuTIwYHtIwJEbEPRujlRdCsRqZaUqhBfhROeL+f8XBNYWhUnpgOCuUy8kNxb9/
        CZ4XfBQXKko0Px1aAzKFrK1IctBUeVcX/s+atybMlS+2dMWoNukpVky93XLoxRvWIt066m
        qfIWpXaErN1jec7Wu5DkKX7jpcBLn5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-9xOsY9kYMTmCI711DNcdBg-1; Mon, 17 Feb 2020 08:46:32 -0500
X-MC-Unique: 9xOsY9kYMTmCI711DNcdBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 987D1107ACC4;
        Mon, 17 Feb 2020 13:46:30 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83D0410013A1;
        Mon, 17 Feb 2020 13:46:29 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/mce_amd: Output Scalable MCA processor warning once
Date:   Mon, 17 Feb 2020 08:46:27 -0500
Message-Id: <20200217134627.19765-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning is output for every virtual cpu in a guest on an EPYC 2
system.  The warning only needs to be logged one time.

Output the warning only once.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index ea980c556f2e..8874b7722b2f 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1239,7 +1239,7 @@ static int __init mce_amd_init(void)
=20
 	case 0x17:
 	case 0x18:
-		pr_warn("Decoding supported only on Scalable MCA processors.\n");
+		pr_warn_once("Decoding supported only on Scalable MCA processors.\n");
 		return -EINVAL;
=20
 	default:
--=20
2.21.1

