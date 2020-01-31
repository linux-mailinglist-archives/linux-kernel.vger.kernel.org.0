Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A194C14EDED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 14:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAaNvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 08:51:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46293 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgAaNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:51:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so3344595pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 05:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=He0nwyLyvw8iwRh/ZM4DB0MP2DrbC25Y5VstWb++R0I=;
        b=tE7FqOa9X+oQPmznxweZVv2qyRcf0/JugZZGlB2MA3aM6IF2Hu5FI6D7wqXRqjVEQD
         2G7e+iVbfqSzRuqWhkHbb9N9KJ4CE91lJQAQnS8ZRlVAANadb2zOOlAfu3cBGgPId5DD
         B2A6RiQNLK5VXoiDIfuoGHxRmHP7IVyscHnIWFYAlkHzw3shmqxRLPw1zM8dkWdwERWC
         ksppFFi3CkNCdJoVXPBTh2idBnD+U1Y4Bb49iy+F4rrO9DEMaiGinEcllwR7lKDnt6UV
         8uRn3n5ryxJSD1sIzc1qSUjs/Ts+QGgm0gfAuG715xnxO7zE6cBAjaNCrLKxYNemMpvq
         KOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=He0nwyLyvw8iwRh/ZM4DB0MP2DrbC25Y5VstWb++R0I=;
        b=Pl0G1TduS2EdS/aQ6r5vuqPq9QYbxURAiJk7N3Y12OrxT4hZ2Rr2C3j/viLaykh5I4
         u9LWIu1Ex8a9Nm+f+F0ypJF4V4FPVwWrDI/t0czMIqrI8ztZwRb2KZ0O5xbqxNrH4bws
         BQInx5unwkMTD3rSU08Url5zhIxaHwrXV8uPYTQYL7yaPFoSKtTsf9hiKUjjwf9OgkQ1
         DQoycTKehmIvtR3bWoQQlBkitCIhF3BBEIKFFtkmuWVuP8HJBWZGeISQYCiGqgyi8r/u
         YlLCQ6Kh5LWP1i9TFQFwFXkO+GTPoZCLBHb9q4ORopUtIIbN4m3vGQNdf2gkVZ7ilDCr
         CYsw==
X-Gm-Message-State: APjAAAX8bni/whc3zAp7tdPJQIXFTkUa2LEPEgOW2L+dSLnabFP9qVor
        wCHqVdCjYvueTIHk1owVn8WT
X-Google-Smtp-Source: APXvYqy5LZSlMkiilbIqBbUxFlacGHVsLLF+GwjvEEutoE5I/XH11sWpO8lja0CHUyIEyeYoXLeDYg==
X-Received: by 2002:a62:ed0b:: with SMTP id u11mr10513356pfh.46.1580478661096;
        Fri, 31 Jan 2020 05:51:01 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id p3sm10625632pfg.184.2020.01.31.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 05:51:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 12/16] bus: mhi: core: Add uevent support for module autoloading
Date:   Fri, 31 Jan 2020 19:20:05 +0530
Message-Id: <20200131135009.31477-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uevent support to MHI bus so that the client drivers can be autoloaded
by udev when the MHI devices gets created. The client drivers are
expected to provide MODULE_DEVICE_TABLE with the MHI id_table struct so
that the alias can be exported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c       |  9 +++++++++
 include/linux/mod_devicetable.h   |  1 +
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 4d0e5bbb3389..711ddc661530 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1247,6 +1247,14 @@ void mhi_driver_unregister(struct mhi_driver *mhi_drv)
 }
 EXPORT_SYMBOL_GPL(mhi_driver_unregister);
 
+static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
+					mhi_dev->chan_name);
+}
+
 static int mhi_match(struct device *dev, struct device_driver *drv)
 {
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
@@ -1273,6 +1281,7 @@ struct bus_type mhi_bus_type = {
 	.name = "mhi",
 	.dev_name = "mhi",
 	.match = mhi_match,
+	.uevent = mhi_uevent,
 };
 
 static int __init mhi_init(void)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index be15e997fe39..f10e779a3fd0 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -821,6 +821,7 @@ struct wmi_device_id {
 	const void *context;
 };
 
+#define MHI_DEVICE_MODALIAS_FMT "mhi:%s"
 #define MHI_NAME_SIZE 32
 
 /**
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 054405b90ba4..fe3f4a95cb21 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -231,5 +231,8 @@ int main(void)
 	DEVID(wmi_device_id);
 	DEVID_FIELD(wmi_device_id, guid_string);
 
+	DEVID(mhi_device_id);
+	DEVID_FIELD(mhi_device_id, chan);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index c91eba751804..cae6a4e471b5 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1335,6 +1335,15 @@ static int do_wmi_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: mhi:S */
+static int do_mhi_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD_ADDR(symval, mhi_device_id, chan);
+	sprintf(alias, MHI_DEVICE_MODALIAS_FMT, *chan);
+
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1407,6 +1416,7 @@ static const struct devtable devtable[] = {
 	{"typec", SIZE_typec_device_id, do_typec_entry},
 	{"tee", SIZE_tee_client_device_id, do_tee_entry},
 	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
+	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.17.1

