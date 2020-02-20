Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72111165ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 11:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBTKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 05:00:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45963 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBTKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:00:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so1670377pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STguu8hQLWj9WVWj4qpf0JO+0y2RGkENLnYzyuJ11Rs=;
        b=YL4hhtPuavqZ7PcvFuIq9Cw4zsOE64AqsTSZP+jvQ0zUpOYzfFU69SqfK/6oiqG0M+
         j6qIaMapA0Z+g1Zd6sBqzUiwfTBGRSksAMOjO1MqAFy1i4hRM/5iTHybz6zA121kphes
         TFZdfLdNYsNyVYDkeBWis5LJdaFdLTghDSX5R8QUXVwGSb54YOjAmMiAivQgY9GH04Rw
         rPp3vFpOtaClY4Dwr4fq5hoyMdxX9ha1WRhjbs3eMGH5zlsWH+utBXWRyhWh/CaKj+aF
         g2KhAe9ipdtFSdRv3KbO5AVt9m8XnMmK1nVOSotyzVcZsw8emc6/EgJbcrPxobir5HXg
         rCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STguu8hQLWj9WVWj4qpf0JO+0y2RGkENLnYzyuJ11Rs=;
        b=nlXsMzaCXz8O1fTJe8pufzH0Z64lMuNauiZHXqF73W24WtqNgOwfMBXuBsbQJm14Us
         aqQXU3WOvlFe6bEFTCyqHwYQGM5qw2dUjMgbP+SVfnwDQYQtgfG78RPEvBsdCkpyw3Z+
         kEqu4Gqo96aj0jAJlRQh0X6ZMH0v7d9xnd5pshVYdQEx0q1Ggv91jUcco2I/hcPvNE7K
         n07bQV42kVGPzHvqexuzKAF4hncgcf07Z17QMp0pgt52gLhvd1fEUnAM0qvE6LdmnGlh
         4Eg4ifd7Tmni2kgJoW0t54gXJwGt/mRVgz22XJ2vIpD+xjPEvg4d/uJkN+xwkyGryzxm
         14TA==
X-Gm-Message-State: APjAAAWGY3ALSogmReNmcsuZzxAnK35AFbBq60ujTzgegDfL1LFt7e51
        hwzh56HvtJUN/ykU9TNEWp+8
X-Google-Smtp-Source: APXvYqzIhVsM1bc4+ADXxV137lBirL8qk0uEpkNeSBG5Rlzd8KBB+SS8Q6nO4UOIXVWtUSQ3l14DZw==
X-Received: by 2002:a63:3688:: with SMTP id d130mr32724734pga.422.1582192809970;
        Thu, 20 Feb 2020 02:00:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:315:9501:edda:4222:88ae:442f])
        by smtp.gmail.com with ESMTPSA id b3sm2678644pjo.30.2020.02.20.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:00:09 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 12/16] bus: mhi: core: Add uevent support for module autoloading
Date:   Thu, 20 Feb 2020 15:28:50 +0530
Message-Id: <20200220095854.4804-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
References: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uevent support to MHI bus so that the client drivers can be autoloaded
by udev when the MHI devices gets created. The client drivers are
expected to provide MODULE_DEVICE_TABLE with the MHI id_table struct so
that the alias can be exported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/init.c       |  9 +++++++++
 include/linux/mod_devicetable.h   |  1 +
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 7bfffa9a5ad1..5fb756ca335e 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1210,6 +1210,14 @@ void mhi_driver_unregister(struct mhi_driver *mhi_drv)
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
@@ -1236,6 +1244,7 @@ struct bus_type mhi_bus_type = {
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

