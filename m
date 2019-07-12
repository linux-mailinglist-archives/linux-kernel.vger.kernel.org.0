Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A505675FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfGLUmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 16:42:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46078 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfGLUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:42:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so5297455plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UfopCKCD/U3scimCJ539JfCijiZlPDvdefwUoYerYYc=;
        b=YyK3fGOghGrzZIzEU3WLIopzhU8oX7JHvVA+pNlSBPxUFJ28vRI3SIazdlvJ0kYSB/
         lOPaRejOMaPp32GC+IprPgv61souwxkqOWQJHNSbSDZzvqSFjSKUjN3Bot0JPbgf6mBV
         QjuYxUsE6WBCvHLCqHyhNQVj7DhN19JIyZmFel2EW+YR65Uhmw1Hy/oQ99cqrdwL3DZJ
         XseB6WK0iPRXzIE0korofD3WszL17utLMo+PWvl6QJgdoWFa2Xm97+JHFNhbNdbpGFwE
         iiYc8MnCXRl0ZkvymLXDS0FfXtSwbCqPi/MdBEBO0uc5kUcM47pzBVG+qF9XwokoBeH4
         b0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UfopCKCD/U3scimCJ539JfCijiZlPDvdefwUoYerYYc=;
        b=EzyaAv1Mx1RP+xuFKBFa42X2ri9SMQQLrCrtyKZRV6AuKqrFLEHU7fJHaBLDCgiaBB
         9V4+8WQiw0yUWnzhpuiQv2vSs15c/kZZXZ30o/qL3xVPcEP9naAYRk9LA73zr4OcN1Uk
         3W1SUcrA9hMNGl4TiyT3sGdC/F3fhqMW7AR9N7f+sB0OFfXJJGD5SARfLJS4x8vieBB8
         Ng1omrDwgRjoQRUF2Z5tWGawIgFDIgLoiUz/CWECnaee+AIgNTiq0WNE66UxiGGAVS9w
         jqHJa+mdZGj0krmHqFej30JabkueyIHnUGWjFifY+6wtT91+csxn3aS5MVs3ytI7coSZ
         FAoA==
X-Gm-Message-State: APjAAAVJIXsISkrB7DcoZVVLA3uvn8wgUdOaQrNbRIVbTODTe5lT5Aqr
        mNR5ze3LqOEkIcukyxgDLaplDQ==
X-Google-Smtp-Source: APXvYqwR1BHl6+/pg0D3KYguhMpw9SQw8mIfRIvxpw0z72hsFTLmLDChrHPgIq0Xk6MvJXN/FGdfog==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr12833026plk.99.1562964120350;
        Fri, 12 Jul 2019 13:42:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x65sm10268625pfd.139.2019.07.12.13.41.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 13:41:59 -0700 (PDT)
Date:   Fri, 12 Jul 2019 13:41:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Herbert Xu <herbert@gondor.apana.org.au>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Cfir Cohen <cfir@google.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [patch v2] crypto: ccp - Fix SEV_VERSION_GREATER_OR_EQUAL
In-Reply-To: <e30eae0f-415b-842e-39c4-801227126367@amd.com>
Message-ID: <alpine.DEB.2.21.1907121341210.37390@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1907101426290.2777@chino.kir.corp.google.com> <e30eae0f-415b-842e-39c4-801227126367@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEV_VERSION_GREATER_OR_EQUAL() will fail if upgrading from 2.2 to 3.1, for
example, because the minor version is not equal to or greater than the
major.

Fix this and move to a static inline function for appropriate type
checking.

Fixes: edd303ff0e9e ("crypto: ccp - Add DOWNLOAD_FIRMWARE SEV command")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 v2: no need to check api_major >= maj after checking api_major > maj
     per Thomas

 drivers/crypto/ccp/psp-dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -24,10 +24,6 @@
 #include "sp-dev.h"
 #include "psp-dev.h"
 
-#define SEV_VERSION_GREATER_OR_EQUAL(_maj, _min)	\
-		((psp_master->api_major) >= _maj &&	\
-		 (psp_master->api_minor) >= _min)
-
 #define DEVICE_NAME		"sev"
 #define SEV_FW_FILE		"amd/sev.fw"
 #define SEV_FW_NAME_SIZE	64
@@ -47,6 +43,15 @@ MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during
 static bool psp_dead;
 static int psp_timeout;
 
+static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
+{
+	if (psp_master->api_major > maj)
+		return true;
+	if (psp_master->api_major == maj && psp_master->api_minor >= min)
+		return true;
+	return false;
+}
+
 static struct psp_device *psp_alloc_struct(struct sp_device *sp)
 {
 	struct device *dev = sp->dev;
@@ -588,7 +593,7 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 	int ret;
 
 	/* SEV GET_ID is available from SEV API v0.16 and up */
-	if (!SEV_VERSION_GREATER_OR_EQUAL(0, 16))
+	if (!sev_version_greater_or_equal(0, 16))
 		return -ENOTSUPP;
 
 	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
@@ -651,7 +656,7 @@ static int sev_ioctl_do_get_id(struct sev_issue_cmd *argp)
 	int ret;
 
 	/* SEV GET_ID available from SEV API v0.16 and up */
-	if (!SEV_VERSION_GREATER_OR_EQUAL(0, 16))
+	if (!sev_version_greater_or_equal(0, 16))
 		return -ENOTSUPP;
 
 	/* SEV FW expects the buffer it fills with the ID to be
@@ -1053,7 +1058,7 @@ void psp_pci_init(void)
 		psp_master->sev_state = SEV_STATE_UNINIT;
 	}
 
-	if (SEV_VERSION_GREATER_OR_EQUAL(0, 15) &&
+	if (sev_version_greater_or_equal(0, 15) &&
 	    sev_update_firmware(psp_master->dev) == 0)
 		sev_get_api_version();
 
