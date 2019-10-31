Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36443EB1F4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfJaOAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:00:32 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37664 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfJaOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:00:31 -0400
Received: by mail-pl1-f179.google.com with SMTP id p13so2751986pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwkM+SzsoiF7YKIoK9DIXcbGL7DR7Z0spQKLzLaNHZQ=;
        b=lwu1b6fl86TKE/CMp25S7IhlXjiw3/P2BxSE+VrP/HwDLSRhME76dbmwTxC8BpTHT/
         KlbWpTvNZ8LGCVHZxHYfeVb4PzGeDIRDSQUUNVT1cYlyd90gf/aDu7vQzFlm37hEcFxc
         KPvQpjyuaoCttslC+3jrhjI35gwN4wAyqx8axXPj3wJRQiyABZJvWFci2ShCan+zXbN6
         zPYtL7Np1pNM3HzRTzv6xjj+EHoeRQVR8NLL/jBkKjtl1pqhL2OOqXYI2ujSL1Or0oV2
         CRt4RrD958u8atB+0vrOw3fWVyDb6Z1aeIY4m9ANwue1KimAXpvJ6WG+RN5eP5GQdHY/
         2jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwkM+SzsoiF7YKIoK9DIXcbGL7DR7Z0spQKLzLaNHZQ=;
        b=K1dRe5/4KZhx1l6CIIfouCTCDRT+9O9i+B7V8hkKCs4Jt5hO6g3PZ7o+20PV+RbCtl
         SzxXXqG/in9MvBAD2XHsOp/wp8zUoPUedL0FKZ+OXKa+UB47D7/bjurP42yoNQ+aXSje
         ibFXETggbAjKNhA4norRE8vWRUmhS/iBCWhrCC14VCzC40rm9kSPP+wJwJSQ9lTwQnFK
         H4CST65+hzPjPubokA7x/dwzAYmviD2FhaslnrF5SAGZ9vtZwz3S5fXb025X8y5BOdnF
         5U0L2hO75S1mTuku4dzObU2WXh5D4g1vJQMwJScs4opG5vUF7NZifKDmu23BN0HZSO9i
         beEg==
X-Gm-Message-State: APjAAAXufQWGyMd6ygnSKo/2aK3ClIgeLQSjJW3LBCnvJViNllRO3m8E
        6FaQEz/Xaa4Z46/cgvX+mHHmhg==
X-Google-Smtp-Source: APXvYqw09qKkn7Bgw5qiGynPfr7slN+fXXwxh/UBQthSfTfEmpqgT8eYadae9P4L6lIIRwbq16G6sg==
X-Received: by 2002:a17:902:a5c2:: with SMTP id t2mr6758983plq.258.1572530431038;
        Thu, 31 Oct 2019 07:00:31 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id i16sm3522441pfa.184.2019.10.31.07.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 07:00:30 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com
Cc:     corbet@lwn.net, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v3 7/7] MAINTAINERS: Add entry for TEE based Trusted Keys
Date:   Thu, 31 Oct 2019 19:28:43 +0530
Message-Id: <1572530323-14802-8-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d0..08d0282 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9059,6 +9059,15 @@ F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
 F:	include/keys/trusted.h
 
+KEYS-TEE-TRUSTED
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	Documentation/security/keys/tee-trusted.rst
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted_tee.c
+
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-- 
2.7.4

