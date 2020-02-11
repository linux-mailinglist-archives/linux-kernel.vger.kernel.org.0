Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC29158F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 14:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgBKNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 08:13:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36833 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgBKNNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:13:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3534780wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uc8xQCON5zDwR8DUMLyo3MIMMq2WPuIE9JxQ1gURZh8=;
        b=vCbyLf9VWyEXfKLjEe55OgreiTorLdlet6cpkzjqgxySZKumn1sFYmLj9u46YTXTM5
         C10ATKL3noqzpXBqonK2a+V9tZW/B9DutE0bifDGmfEuCjj1if8zk8Kb3FYLWn8i2+8S
         axXX7eVfj6It1jztvxpRbJcPSiQxzO8IYhd2jgp043VGQ70nNKiKsPRtxU/AzHsHMBv4
         0kGjGCHa5+3Sf1gp8X7kgGs+c+ZX4bQK6eZF2Sd+iDxOGvGRvYgqjUYMavUPd8JVgGvj
         eqf6oEJG9Ue3SUD47SWPTe5gtdpHt5ks/m0E8+GGajVB4UtLuPPxbHFGAvp6H9xtHr/Q
         PWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc8xQCON5zDwR8DUMLyo3MIMMq2WPuIE9JxQ1gURZh8=;
        b=h+fujp19Opu+oq1qYRdvBJU5Alip1rosXcOmPYPLKImFJO9py2qQBjVZPq9jSE/MM2
         m5tXedx6LXqRI1T5o2bFIgbQQijCa+j0d5XoXMdlAiVQiWvINwYhW6jCPG1J5hCEjW7e
         jkegsh9Zf/gR9ljPnYN7lBevXF+oZPksyRAHlzRyncEA3H2+PTIhpx8CoKi7N5SUSQbP
         9cMj3Qg/TVm3GGAY12nPNl6648d2bRWxZBWQ15wUUani567SLF8sblqv4RQHEvFfM+G6
         59BCqWHUXd3HZdXP71LkxuVnoPJpmDpGUkboeei8vW8UwquwRnvcZ2dRKA8saeMoOa+j
         kpfg==
X-Gm-Message-State: APjAAAW+uJ78RZL8HZoWPbADaLi0+bjFigrq+lZnvRkLIc1Ct+hcmhXc
        KPJKxNKliYrgr9w0ERuEpjrM+Q==
X-Google-Smtp-Source: APXvYqxzfbcatJyy+RYI1cefcr1daJmFQcMYqV3T4tUbL6cK8/4aHjxYt4gy3CW5BTPxHR6EPF93Og==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr5567366wmi.168.1581426782790;
        Tue, 11 Feb 2020 05:13:02 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id b21sm3873013wmd.37.2020.02.11.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:13:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/6] irq/domain: add a new callback to domain ops
Date:   Tue, 11 Feb 2020 14:12:37 +0100
Message-Id: <20200211131240.15853-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211131240.15853-1-brgl@bgdev.pl>
References: <20200211131240.15853-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the remove() callback to irq_domain_ops which can be used to
automatically dispose of any host data associated with the domain when
irq_domain_remove() is called.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqdomain.h | 3 +++
 kernel/irq/irqdomain.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 20d38621e2f8..fbc25f464f62 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -95,6 +95,8 @@ enum irq_domain_bus_token {
  * @unmap: Dispose of such a mapping
  * @xlate: Given a device tree node and interrupt specifier, decode
  *         the hardware irq number and linux irq type value.
+ * @remove: Free any custom resources associated with this domain. This is
+ *          called from irq_domain_remove() before any other code.
  *
  * Functions below are provided by the driver and called whenever a new mapping
  * is created or an old mapping is disposed. The driver can then proceed to
@@ -126,6 +128,7 @@ struct irq_domain_ops {
 	void (*debug_show)(struct seq_file *m, struct irq_domain *d,
 			   struct irq_data *irqd, int ind);
 #endif
+	void (*remove)(struct irq_domain *d);
 };
 
 extern struct irq_domain_ops irq_generic_chip_ops;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 039427c98af8..b391d2e65bdd 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -242,6 +242,9 @@ EXPORT_SYMBOL_GPL(__irq_domain_add);
  */
 void irq_domain_remove(struct irq_domain *domain)
 {
+	if (domain->ops->remove)
+		domain->ops->remove(domain);
+
 	mutex_lock(&irq_domain_mutex);
 	debugfs_remove_domain_dir(domain);
 
-- 
2.25.0

