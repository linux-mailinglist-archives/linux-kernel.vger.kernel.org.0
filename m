Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECB13397
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfECSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 14:25:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34524 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfECSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 14:25:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so3110028pgt.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/bmY+EZ6xV0W0SpIYyFyIDSPu4iDN/leFZKV35/9Vc=;
        b=m7r8+vcXgU2Jzs3FITtKSxn3MZ0/Ui0kiBxk1JUrg+f9GJCZqLzVOs28Xuo7YABkcp
         HkZI4irETyZws53pUubSxSy2M0164P9FJYKzN3EKqiuCufrWsFAhpnuhF8CGmvuEEFdo
         RYdVxSMizwoP6PdkcyTua4mYxoeSqRh/dtQfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/bmY+EZ6xV0W0SpIYyFyIDSPu4iDN/leFZKV35/9Vc=;
        b=QHujNjDFFjEssDMKo6kv8Ij7q4JRde4z1DfYzMzD77P8yIXBX3TabJ9xS3ynGui5pl
         TrvNbz9ynqin8ndkc2zeotUIOL48IZP3t6GaCzt6rLpEXfWBMX0WaI0PaTpPjAzZWbmg
         Z9bPmWzvrE5P+QcWoMz+cUhn+tU3wST2SesZ8n+RhJ6iJsxNF1LgIB8RZcstRQlv0aW7
         oEQgdPvEw5sdkVkZkMLChZ4cDWg/N2E0XdcP1SSwkXocEvuSTxfGplCPxZfq+evIBiyM
         lQTQ0/gygoTahtOtz0k45K4tqVLmKiosUpoUP5lRkVmBIWqmQVL11oGFLHOihcGlGByl
         /xWQ==
X-Gm-Message-State: APjAAAXs0CUb3RjzVxNTMsw24mVABUKUlcMcUDlc9x4T06EpzvQEGSuq
        T9RZ3KwL1/xEgSk7ZKTTgsfauURMulI=
X-Google-Smtp-Source: APXvYqxXomx3NaQybucA9CD70Lvpm4yE4KqrBRott1+Bcq0msUt/U7YHgaagq201nzW7ilNHNeShKw==
X-Received: by 2002:a63:5110:: with SMTP id f16mr12391491pgb.107.1556907932139;
        Fri, 03 May 2019 11:25:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n188sm4110093pfn.64.2019.05.03.11.25.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 11:25:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        gregkh@linuxfoundation.org, Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Gregorczyk?= <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: [PATCH] kheaders: Move from proc to sysfs
Date:   Fri,  3 May 2019 14:24:59 -0400
Message-Id: <20190503182459.159121-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kheaders archive consisting of the kernel headers used for compiling
bpf programs is in /proc. However there is concern that moving it here
will make it permanent. Let us move it to /sys/kernel as discussed [1].

[1] https://lore.kernel.org/patchwork/patch/1067310/#1265969

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
This patch applies on top of the previous patch that was applied to the
driver tree:
https://lore.kernel.org/patchwork/patch/1067310/

 kernel/kheaders.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 70ae6052920d..6a16f8f6898d 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -8,9 +8,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/proc_fs.h>
+#include <linux/kobject.h>
 #include <linux/init.h>
-#include <linux/uaccess.h>
 
 /*
  * Define kernel_headers_data and kernel_headers_data_end, within which the
@@ -31,39 +30,32 @@ extern char kernel_headers_data;
 extern char kernel_headers_data_end;
 
 static ssize_t
-ikheaders_read_current(struct file *file, char __user *buf,
-		      size_t len, loff_t *offset)
+ikheaders_read(struct file *file,  struct kobject *kobj,
+	       struct bin_attribute *bin_attr,
+	       char *buf, loff_t off, size_t len)
 {
-	return simple_read_from_buffer(buf, len, offset,
-				       &kernel_headers_data,
-				       &kernel_headers_data_end -
-				       &kernel_headers_data);
+	memcpy(buf, &kernel_headers_data + off, len);
+	return len;
 }
 
-static const struct file_operations ikheaders_file_ops = {
-	.read = ikheaders_read_current,
-	.llseek = default_llseek,
+static struct bin_attribute kheaders_attr __ro_after_init = {
+	.attr = {
+		.name = "kheaders.tar.xz",
+		.mode = S_IRUGO,
+	},
+	.read = &ikheaders_read,
 };
 
 static int __init ikheaders_init(void)
 {
-	struct proc_dir_entry *entry;
-
-	/* create the current headers file */
-	entry = proc_create("kheaders.tar.xz", S_IRUGO, NULL,
-			    &ikheaders_file_ops);
-	if (!entry)
-		return -ENOMEM;
-
-	proc_set_size(entry,
-		      &kernel_headers_data_end -
-		      &kernel_headers_data);
-	return 0;
+	kheaders_attr.size = (&kernel_headers_data_end -
+			      &kernel_headers_data);
+	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
 
 static void __exit ikheaders_cleanup(void)
 {
-	remove_proc_entry("kheaders.tar.xz", NULL);
+	sysfs_remove_bin_file(kernel_kobj, &kheaders_attr);
 }
 
 module_init(ikheaders_init);
-- 
2.21.0.1020.gf2820cf01a-goog
