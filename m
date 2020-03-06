Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BF17C429
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 18:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCFRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 12:20:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726738AbgCFRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583515236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uwrl3oe97pFZn/wML/S/JPMSdDgVGgrRboifkZ08h6c=;
        b=BwK1Sllvr5Pr/4tb24rasJs1Cbiw4Emysg+BBIkiH8Jx+lvAYD1Efsft3rZ94ZNsDHt6EE
        IGyplXecVzl2ZIZNwn12TZuck7bs9q89IPB/d4MtbHVv2Sd1+E/HgnyCs35u0qowehaqyn
        pMrv+Yw0s1kP+USlrjpmOftY3yHt6KA=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400--JoIdaBLM1yx0ekBHL8RdQ-1; Fri, 06 Mar 2020 12:20:33 -0500
X-MC-Unique: -JoIdaBLM1yx0ekBHL8RdQ-1
Received: by mail-yw1-f70.google.com with SMTP id r10so4257584ywa.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uwrl3oe97pFZn/wML/S/JPMSdDgVGgrRboifkZ08h6c=;
        b=YhztT3SMMoz334PbeMufypTuEhn9WrpZvSjI0wV+UgIU/bzpn7i/ZYMxxoVBb1bHtQ
         PhxClakXDFUBssKs0Q0FuvDhYLYBiHWgrqabQOXinZ127UC+6SwbJQpYMlu7sOcwLqU4
         tHEwSRDMtZRQmCj+rXxO70y5OLx5mKd5LhKnsFLRmO0szn4NdM42YBiKIuJIXYhIOq5A
         lWzs03ZHan8Y7fYbZR6bYiAqXGqDzFDIDMIzzZ+Q/VAm/+YjChUlInVdRJqFC8SsH9S6
         GdrjOagqWTETLQZ1EwUOiTgVRJ53d742VcXaRoCPTpJ/JTmlUMIUWjHe1kKVP4zIuqHi
         BcQA==
X-Gm-Message-State: ANhLgQ2IRaL9zAAusighvFr/Lj25sIpCIlWXMONqFpGiqz/HcA9PEoPA
        FCkmEyRW3NX+0lywV2fGdWzX7mWCs7C+NhYuGESou1JtHPAKZbCuFArrKYK2ykZD+ONlUKoOGRu
        EGVLJZ9IwFJ+pqfhNTEd6ZTFb
X-Received: by 2002:a81:b343:: with SMTP id r64mr5067974ywh.278.1583515233229;
        Fri, 06 Mar 2020 09:20:33 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuh5lov3x+5mGO6K3WwK0zEsVPC2hKw98/TcIrSfkgIJz5hcwEG0Ilr7zyVjT0dE5RhRI3rTg==
X-Received: by 2002:a81:b343:: with SMTP id r64mr5067945ywh.278.1583515232913;
        Fri, 06 Mar 2020 09:20:32 -0800 (PST)
Received: from redhat.redhat.com (c-71-63-171-240.hsd1.or.comcast.net. [71.63.171.240])
        by smtp.gmail.com with ESMTPSA id y77sm7887218ywg.66.2020.03.06.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 09:20:31 -0800 (PST)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     thomas.lendacky@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     gary.hook@amd.com, erdemaktas@google.com, rientjes@google.com,
        brijesh.singh@amd.com, npmccallum@redhat.com, bsd@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Connor Kuehl <ckuehl@redhat.com>
Subject: [PATCH 1/1] crypto: ccp: use file mode for sev ioctl permissions
Date:   Fri,  6 Mar 2020 09:20:10 -0800
Message-Id: <20200306172010.1213899-2-ckuehl@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306172010.1213899-1-ckuehl@redhat.com>
References: <20200306172010.1213899-1-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using CAP_SYS_ADMIN which is restricted to the root user,
check the file mode for write permissions before executing commands that
can affect the platform. This allows for more fine-grained access
control to the SEV ioctl interface. This would allow a SEV-only user
or group the ability to administer the platform without requiring them
to be root or granting them overly powerful permissions.

For example:

chown root:root /dev/sev
chmod 600 /dev/sev
setfacl -m g:sev:r /dev/sev
setfacl -m g:sev-admin:rw /dev/sev

In this instance, members of the "sev-admin" group have the ability to
perform all ioctl calls (including the ones that modify platform state).
Members of the "sev" group only have access to the ioctls that do not
modify the platform state.

This also makes opening "/dev/sev" more consistent with how file
descriptors are usually handled. By only checking for CAP_SYS_ADMIN,
the file descriptor could be opened read-only but could still execute
ioctls that modify the platform state. This patch enforces that the file
descriptor is opened with write privileges if it is going to be used to
modify the platform state.

This flexibility is completely opt-in, and if it is not desirable by
the administrator then they do not need to give anyone else access to
/dev/sev.

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 drivers/crypto/ccp/sev-dev.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e467860f797d..416b80938a3e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -283,11 +283,11 @@ static int sev_get_platform_state(int *state, int *error)
 	return rc;
 }
 
-static int sev_ioctl_do_reset(struct sev_issue_cmd *argp)
+static int sev_ioctl_do_reset(struct sev_issue_cmd *argp, bool writable)
 {
 	int state, rc;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!writable)
 		return -EPERM;
 
 	/*
@@ -331,12 +331,12 @@ static int sev_ioctl_do_platform_status(struct sev_issue_cmd *argp)
 	return ret;
 }
 
-static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *argp)
+static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	int rc;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!writable)
 		return -EPERM;
 
 	if (sev->state == SEV_STATE_UNINIT) {
@@ -348,7 +348,7 @@ static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *argp)
 	return __sev_do_cmd_locked(cmd, NULL, &argp->error);
 }
 
-static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp)
+static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_pek_csr input;
@@ -356,7 +356,7 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp)
 	void *blob = NULL;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!writable)
 		return -EPERM;
 
 	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
@@ -539,7 +539,7 @@ static int sev_update_firmware(struct device *dev)
 	return ret;
 }
 
-static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp)
+static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_pek_cert_import input;
@@ -547,7 +547,7 @@ static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp)
 	void *pek_blob, *oca_blob;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!writable)
 		return -EPERM;
 
 	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
@@ -698,7 +698,7 @@ static int sev_ioctl_do_get_id(struct sev_issue_cmd *argp)
 	return ret;
 }
 
-static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp)
+static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_pdh_cert_export input;
@@ -708,7 +708,7 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp)
 
 	/* If platform is not in INIT state then transition it to INIT. */
 	if (sev->state != SEV_STATE_INIT) {
-		if (!capable(CAP_SYS_ADMIN))
+		if (!writable)
 			return -EPERM;
 
 		ret = __sev_platform_init_locked(&argp->error);
@@ -801,6 +801,7 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 	struct sev_issue_cmd input;
 	int ret = -EFAULT;
+	bool writable = file->f_mode & FMODE_WRITE;
 
 	if (!psp_master || !psp_master->sev_data)
 		return -ENODEV;
@@ -819,25 +820,25 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	switch (input.cmd) {
 
 	case SEV_FACTORY_RESET:
-		ret = sev_ioctl_do_reset(&input);
+		ret = sev_ioctl_do_reset(&input, writable);
 		break;
 	case SEV_PLATFORM_STATUS:
 		ret = sev_ioctl_do_platform_status(&input);
 		break;
 	case SEV_PEK_GEN:
-		ret = sev_ioctl_do_pek_pdh_gen(SEV_CMD_PEK_GEN, &input);
+		ret = sev_ioctl_do_pek_pdh_gen(SEV_CMD_PEK_GEN, &input, writable);
 		break;
 	case SEV_PDH_GEN:
-		ret = sev_ioctl_do_pek_pdh_gen(SEV_CMD_PDH_GEN, &input);
+		ret = sev_ioctl_do_pek_pdh_gen(SEV_CMD_PDH_GEN, &input, writable);
 		break;
 	case SEV_PEK_CSR:
-		ret = sev_ioctl_do_pek_csr(&input);
+		ret = sev_ioctl_do_pek_csr(&input, writable);
 		break;
 	case SEV_PEK_CERT_IMPORT:
-		ret = sev_ioctl_do_pek_import(&input);
+		ret = sev_ioctl_do_pek_import(&input, writable);
 		break;
 	case SEV_PDH_CERT_EXPORT:
-		ret = sev_ioctl_do_pdh_export(&input);
+		ret = sev_ioctl_do_pdh_export(&input, writable);
 		break;
 	case SEV_GET_ID:
 		pr_warn_once("SEV_GET_ID command is deprecated, use SEV_GET_ID2\n");
-- 
2.24.1

