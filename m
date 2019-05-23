Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9228C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbfEWVTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 17:19:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43507 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbfEWVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:19:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so3769427pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mPZbZy5W6TvTMZ2rRqZtQoG8zcRtTAtXl0w7I9OmsQ=;
        b=lb3Q3VCg/m5117JLuMa++JSdLvUGL28gMgBpbCyPzainZo4R3yf4FezR3ton+QBWBw
         qbeUryIWnJ9EGSDWTVYxazT+GKhtA4PQ8IkI88idnCrVl9ABOgf+CprD4PwCxIY/PqkG
         dGeRnERPTtsc7zs8hF2gN4WFv+YtuuI3kpCPAUMO8JYEfqtKOyf2xL+Aa/kMTW2MqPZJ
         LDjpO72fc3/0lYdTAynbfbGvjsfyZjkr1iqa5UcQCwQGfe956GQR9J8QTyqisW7eQygv
         irTUjf7y5dKeCnUj+QeYsppmE/YYlpufepBl+z44jiWSRr5kzZvrIqj+3ONbJggMDFLp
         KAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mPZbZy5W6TvTMZ2rRqZtQoG8zcRtTAtXl0w7I9OmsQ=;
        b=phgTj0LD7F+qzTPpOn568hZHwZe7Vg+/R2fezlboiRThnIYqfBEdnomzjrZ52zaF2o
         qkeqTwwJrkQ58qywh/vfunp3sC5h+/jwPwXZv7p7SYEuiNbK+py2TfFBG5Xh4DVOMw1q
         neZyCX00SKS+q7PLOYI62fIW+Uv7jNqhviKesHvMyTTv4aUcuIkm+Z0yLTGd1xYWMsh0
         y82qDhiQH73gCgeyaJ4uXurEea5yEuKgCzL8xeL7k7ZteyFETqLs28XQz0gGYK+SzOfR
         dHBze6zycKYroKaHD9VswN1Q57J0vbSNT1w6fH/O8ju3hkgo3idE6I3sywFdDBKOOeAp
         Xp3Q==
X-Gm-Message-State: APjAAAVxeMFkbU9AFCcjCXcyb8Ba9+7BBK5lU/RiQG9suiEtlvjoDNX7
        dV3xJwcAY2EK2vKR8DtClos9QA==
X-Google-Smtp-Source: APXvYqxQNjLfbHXgT+sdqJIbUkJkB8mHB9tn8FD82DR8EhIiruAY6NJjRaQU9tkKBoJLN+Z8vmgFzw==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr99748450pgg.195.1558646357415;
        Thu, 23 May 2019 14:19:17 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id t5sm234092pgn.80.2019.05.23.14.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:19:16 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2 2/2] tools: PCI: Fix compiler warning in pcitest
Date:   Thu, 23 May 2019 14:18:01 -0700
Message-Id: <1558646281-12676-3-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
References: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compiler warning in pcitest:

pcitest.c: In function main:
pcitest.c:214:4: warning: too many arguments for
format [-Wformat-extra-args]
    "usage: %s [options]\n"

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Fixes: fbca0b284bd0 ("tools: PCI: Add 'h' in optstring of getopt()")
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 tools/pci/pcitest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 6dce894667f6..6f1303104d84 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -223,7 +223,7 @@ int main(int argc, char **argv)
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
-			"\t-s <size>		Size of buffer {default: 100KB}\n",
+			"\t-s <size>		Size of buffer {default: 100KB}\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;
-- 
2.7.4

