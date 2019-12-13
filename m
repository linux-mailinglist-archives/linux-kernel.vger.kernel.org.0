Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8006211DBE4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 02:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfLMB4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 20:56:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40189 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfLMB4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:56:20 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so769043iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 17:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpJgpn5xWwVD9J6P9JsUIUWPTgZ7VxyS6OWeolrkzBI=;
        b=GFzm6ZniEqoDdzO+qsDrFCn2PlIlt4Kf5CvCuVwkcCzKJHi1qzv2Rly2Hu/ARaqshP
         BKY/7qK+vmWdEZX8nyAjOe5b89WLSu9YRd2qFBRCX1htrD9vZKfQkbHZkWC7dW8B3DL/
         YKb9dlHn9T6qvm2tQMYJvxVrb5y6G9v1wPfVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpJgpn5xWwVD9J6P9JsUIUWPTgZ7VxyS6OWeolrkzBI=;
        b=nx0XavUUuzFtNw9JKrDkMjc7yPwBTTOHd1iEj9YhtE95RV5Z9bdfGNUuNMeJ/6A6H+
         ta0BwM+5kdZjwaC14d1MiksqLbpxewO1QsxekgCqUO3w2Blo+UL6QRUi7qbnv2W0uH/s
         DXlh0sgR7HGOu1AKTqGrJ+UrAamXYa+zMTwhpafIWqv1no5wkSRQQjFbAjPeE1axrcGT
         M2dW3WlI+tIN0PuyUQ/XhNypf7zw2jfeGkGMjO01APVzi6JLnwE53g+A6sjRDDKga+C3
         FYc4uL5254mpQOhHp0B7EA/sfs2XNYGO5DS/OlRt4M2KrqUSIPJqcjeI6y9RJ66CZU3d
         QPiA==
X-Gm-Message-State: APjAAAXLz5xYejcZBy+jU3H9A/VNGNAdrpjcUOl7rZwCWuD62T10gsd4
        oIFqbKmiO5QxOSxrSjERRV4FXw==
X-Google-Smtp-Source: APXvYqznGK3WNdNstYWfdpigO3kQ1gScdYqkS3+WOfJTJh+/XlPm0/REhsuCLncgscsqVxIXlo71sw==
X-Received: by 2002:a5e:9608:: with SMTP id a8mr5549510ioq.18.1576202179412;
        Thu, 12 Dec 2019 17:56:19 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w28sm2274755ila.64.2019.12.12.17.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 17:56:18 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: livepatch: Fix it to do root uid check and skip
Date:   Thu, 12 Dec 2019 18:56:17 -0700
Message-Id: <20191213015617.23110-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

livepatch test configures the system and debug environment to run
tests. Some of these actions fail without root access and test
dumps several permission denied messages before it exits.

Fix it to check root uid and exit with skip code instead.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/livepatch/functions.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 31eb09e38729..014b587692f0 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -7,6 +7,9 @@
 MAX_RETRIES=600
 RETRY_INTERVAL=".1"	# seconds
 
+# Kselftest framework requirement - SKIP code is 4
+ksft_skip=4
+
 # log(msg) - write message to kernel log
 #	msg - insightful words
 function log() {
@@ -18,7 +21,16 @@ function log() {
 function skip() {
 	log "SKIP: $1"
 	echo "SKIP: $1" >&2
-	exit 4
+	exit $ksft_skip
+}
+
+# root test
+function is_root() {
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "skip all tests: must be run as root" >&2
+		exit $ksft_skip
+	fi
 }
 
 # die(msg) - game over, man
@@ -45,6 +57,7 @@ function pop_config() {
 }
 
 function set_dynamic_debug() {
+	is_root
         cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
 		file kernel/livepatch/* +p
 		func klp_try_switch_task -p
@@ -62,6 +75,7 @@ function set_ftrace_enabled() {
 #		 for verbose livepatching output and turn on
 #		 the ftrace_enabled sysctl.
 function setup_config() {
+	is_root
 	push_config
 	set_dynamic_debug
 	set_ftrace_enabled 1
-- 
2.20.1

