Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0288812F470
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 06:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgACF4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 00:56:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43318 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgACF4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:56:14 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 09E5D2010C33;
        Thu,  2 Jan 2020 21:56:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09E5D2010C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578030973;
        bh=9uLF2XVVkhvefoka1wfW3xsgfz7pEhNReOdjQQXf7jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4R6JmxTyVME4HUc36czcHQF8hHrmA9hyRUOwR9i2v/03vQtElA1xqEdNfFaOx4ZA
         CRJk0qrRF4+dcrgJWhyI7k7g15+X3lYEjBRt4QZ3RpJSUoaSLSHHiQorDZzLvaTWZo
         jyJJyzqhzr85fCCie18qC7je9vyxXIrfKBsiDb9w=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v6 1/3] IMA: Define workqueue for early boot key measurements
Date:   Thu,  2 Jan 2020 21:56:06 -0800
Message-Id: <20200103055608.22491-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103055608.22491-1-nramas@linux.microsoft.com>
References: <20200103055608.22491-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Measuring keys requires a custom IMA policy to be loaded.
Keys created or updated before a custom IMA policy is loaded should
be queued and the keys should be processed after a custom policy
is loaded.

This patch defines workqueue for queuing keys when a custom IMA policy
has not yet been loaded.

A flag namely ima_process_keys is used to check if the key should be
queued or should be processed immediately.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 115 +++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f06238e41a7c..97f8a4078483 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,6 +205,21 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
+#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_key_entry {
+	struct list_head list;
+	void *payload;
+	size_t payload_len;
+	char *keyring_name;
+};
+void ima_process_queued_keys(void);
+#else
+static inline void ima_process_queued_keys(void) {}
+#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index fea2e7dd3b09..1d56f003f1a7 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -14,6 +14,121 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
+/*
+ * Flag to indicate whether a key can be processed
+ * right away or should be queued for processing later.
+ */
+static bool ima_process_keys;
+
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_SPINLOCK(ima_keys_lock);
+static LIST_HEAD(ima_keys);
+
+static void ima_free_key_entry(struct ima_key_entry *entry)
+{
+	if (entry) {
+		kfree(entry->payload);
+		kfree(entry->keyring_name);
+		kfree(entry);
+	}
+}
+
+static struct ima_key_entry *ima_alloc_key_entry(
+	struct key *keyring,
+	const void *payload, size_t payload_len)
+{
+	int rc = 0;
+	struct ima_key_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry) {
+		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
+		entry->keyring_name = kstrdup(keyring->description,
+					      GFP_KERNEL);
+		entry->payload_len = payload_len;
+	}
+
+	if ((entry == NULL) || (entry->payload == NULL) ||
+	    (entry->keyring_name == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&entry->list);
+
+out:
+	if (rc) {
+		ima_free_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+static bool ima_queue_key(struct key *keyring, const void *payload,
+			  size_t payload_len)
+{
+	bool queued = false;
+	struct ima_key_entry *entry;
+
+	entry = ima_alloc_key_entry(keyring, payload, payload_len);
+	if (!entry)
+		return false;
+
+	spin_lock(&ima_keys_lock);
+	if (!ima_process_keys) {
+		list_add_tail(&entry->list, &ima_keys);
+		queued = true;
+	}
+	spin_unlock(&ima_keys_lock);
+
+	if (!queued)
+		ima_free_key_entry(entry);
+
+	return queued;
+}
+
+/*
+ * ima_process_queued_keys() - process keys queued for measurement
+ *
+ * This function sets ima_process_keys to true and processes queued keys.
+ * From here on keys will be processed right away (not queued).
+ */
+void ima_process_queued_keys(void)
+{
+	struct ima_key_entry *entry, *tmp;
+	bool process = false;
+
+	if (ima_process_keys)
+		return;
+
+	/*
+	 * Since ima_process_keys is set to true, any new key will be
+	 * processed immediately and not be queued to ima_keys list.
+	 * First one setting the ima_process_keys flag to true will
+	 * process the queued keys.
+	 */
+	spin_lock(&ima_keys_lock);
+	if (!ima_process_keys) {
+		ima_process_keys = true;
+		process = true;
+	}
+	spin_unlock(&ima_keys_lock);
+
+	if (!process)
+		return;
+
+	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
+		process_buffer_measurement(entry->payload, entry->payload_len,
+					   entry->keyring_name, KEY_CHECK, 0,
+					   entry->keyring_name);
+		list_del(&entry->list);
+		ima_free_key_entry(entry);
+	}
+}
+
 /**
  * ima_post_key_create_or_update - measure asymmetric keys
  * @keyring: keyring to which the key is linked to
-- 
2.17.1

