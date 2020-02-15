Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8070615FC33
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 02:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgBOBrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 20:47:53 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57518 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgBOBru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 20:47:50 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 690BE20B36F5;
        Fri, 14 Feb 2020 17:47:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 690BE20B36F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581731269;
        bh=tU7vvgQ5TRUvjtt9H5CouKqIQ8Q0T714eAJcnH0DQYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=US3S/ZBA4XP5+s0oFAbCzK/TsEy+xe5NhjVuGca14vaOK1KV2CjepxmEM/fy48JVz
         Sk2ifAHuRSY9aBoIcVYI/8bNvPsU8Fn549UDKOgrPhf1HvZxCRl8MWFIDddtdzYX3i
         NOcLs4ZWYgToFYIyLXbJJB7eMbycxKa8wICn1r2g=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] IMA: Remove duplicate pr_fmt definitions
Date:   Fri, 14 Feb 2020 17:47:09 -0800
Message-Id: <20200215014709.3006-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #define for formatting log messages, pr_fmt, is duplicated in the
files under security/integrity.

This change moves the definition to security/integrity/integrity.h and
removes the duplicate definitions in the other files under
security/integrity.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
---
 security/integrity/digsig.c                  | 2 --
 security/integrity/digsig_asymmetric.c       | 2 --
 security/integrity/evm/evm_crypto.c          | 2 --
 security/integrity/evm/evm_main.c            | 2 --
 security/integrity/evm/evm_secfs.c           | 2 --
 security/integrity/ima/ima_asymmetric_keys.c | 2 --
 security/integrity/ima/ima_crypto.c          | 2 --
 security/integrity/ima/ima_fs.c              | 2 --
 security/integrity/ima/ima_init.c            | 2 --
 security/integrity/ima/ima_kexec.c           | 1 -
 security/integrity/ima/ima_main.c            | 2 --
 security/integrity/ima/ima_policy.c          | 2 --
 security/integrity/ima/ima_queue.c           | 2 --
 security/integrity/ima/ima_queue_keys.c      | 2 --
 security/integrity/ima/ima_template.c        | 2 --
 security/integrity/ima/ima_template_lib.c    | 2 --
 security/integrity/integrity.h               | 6 ++++++
 17 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index ea1aae3d07b3..e9cbadade74b 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -6,8 +6,6 @@
  * Dmitry Kasatkin <dmitry.kasatkin@intel.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 55aec161d0e1..4e0d6778277e 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -6,8 +6,6 @@
  * Dmitry Kasatkin <dmitry.kasatkin@intel.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/err.h>
 #include <linux/ratelimit.h>
 #include <linux/key-type.h>
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index d485f6fc908e..35682852ddea 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -10,8 +10,6 @@
  *	 Using root's kernel master key (kmk), calculate the HMAC
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/export.h>
 #include <linux/crypto.h>
 #include <linux/xattr.h>
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index f9a81b187fae..d361d7fdafc4 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -11,8 +11,6 @@
  *	evm_inode_removexattr, and evm_verifyxattr
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/init.h>
 #include <linux/crypto.h>
 #include <linux/audit.h>
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index c11c1f7b3ddd..39ad1038d45d 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -10,8 +10,6 @@
  *	- Get the key and enable EVM
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/audit.h>
 #include <linux/uaccess.h>
 #include <linux/init.h>
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 7678f0e3e84d..aaae80c4e376 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -9,8 +9,6 @@
  *       create or update.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7967a6904851..423c84f95a14 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -10,8 +10,6 @@
  *	Calculates md5/sha1 file hash, template hash, boot-aggreate hash
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
 #include <linux/ratelimit.h>
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2000e8df0301..a71e822a6e92 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -12,8 +12,6 @@
  *	current measurement list and IMA statistics
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/fcntl.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 195cb4079b2b..567468188a61 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -11,8 +11,6 @@
  *             initialization and cleanup functions
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/init.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9e94eca48b89..121de3e04af2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -6,7 +6,6 @@
  * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
  * Mimi Zohar <zohar@linux.vnet.ibm.com>
  */
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index aac1c44fb11b..9d0abedeae77 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -15,8 +15,6 @@
  *	and ima_file_check.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 453427048999..c334e0dc6083 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -7,8 +7,6 @@
  *	- initialize default measure policy rules
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/fs.h>
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..8753212ddb18 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -15,8 +15,6 @@
  *       ever removed or changed during the boot-cycle.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/rculist.h>
 #include <linux/slab.h>
 #include "ima.h"
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index c87c72299191..cb3e3f501593 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -8,8 +8,6 @@
  *       Enables deferred processing of keys
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/workqueue.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 6aa6408603e3..062d9ad49afb 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -9,8 +9,6 @@
  *      Helpers to manage template descriptors.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/rculist.h>
 #include "ima.h"
 #include "ima_template_lib.h"
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 32ae05d88257..9cd1e50f3ccc 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -9,8 +9,6 @@
  *      Library of supported template fields.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include "ima_template_lib.h"
 
 static bool ima_template_hash_algo_allowed(u8 algo)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 73fc286834d7..298b73794d8b 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -6,6 +6,12 @@
  * Mimi Zohar <zohar@us.ibm.com>
  */
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/types.h>
 #include <linux/integrity.h>
 #include <crypto/sha.h>
-- 
2.17.1

