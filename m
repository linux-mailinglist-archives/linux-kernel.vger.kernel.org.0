Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C087641B55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 06:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfFLEp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 00:45:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36013 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfFLEpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:45:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so2961474pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OxCpi4+gevtN7ucdk6bcVquvNxwjqcqTsELIwsueTKU=;
        b=My80xZtOqD0Yim6s6jO8QAsLeq4McOfvTPwfIY6oQlHoNsGcpVtzsj4XUyIAbM1q78
         Vbpf8ECv1Y1zOsgdrfB1K/jRay5e9nxYNkHusRdyQfuRu7RNoPKKGaOP4BUvEDoVgDJM
         gV73IJ55wLJPix47k54Ukh9Ghd6r+gsdWzmkelbx7UHVprdZck9rjT7duaRJoGAF/QY/
         PbeLF4u3suv5oybVmskY6MUxvyI1w8I80P2uG6XdmXPVWa1hXjjCYosoZFmj78OC5ahA
         ifV3oJc6OCGiRlxy8ZecdUkrEE5WqntdhtmbocpsQYe0N8n9mQwCzAelMpmfUuUeKukJ
         d9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OxCpi4+gevtN7ucdk6bcVquvNxwjqcqTsELIwsueTKU=;
        b=WdlfX/qBD0r3f48eID0BPWZtnUqfS948ep//IMtyumJPfIKwG9gpyKGhAUOIa7ZODW
         +EOlkvwCTrjh2HGabNZws1wjoNy8u8pq8QT0RR+C5G0pfHodGb5wSMKhNylywioVt0BX
         ALdVtBQpgpE3j3KIBPkMVv7VXMRWnv2al6CK67+dF2rm8daiHraFAmwPHWFkMS9CoQJy
         fXYzbUe6uNYqWRJBsHNX+7UKAwqAetMC3RWidd/4UY7ZL6FbjyOJQCD8l/16ApxBfHAh
         NxvEcQUgga8r3X8je7cJ6IQozGscURt9QD83w9wHp6qFyKEKOzuSmYRa1H8GIvzuzSWY
         QXmg==
X-Gm-Message-State: APjAAAWhvduuR6MYYYkiCQGRIu4lIRgcFUNeaLERA9CG6I42xcu+I/6l
        HzdYy4kUSWca3+Dh1MeS8FzAHA==
X-Google-Smtp-Source: APXvYqzNwOdG4we/Z67Ou4hb5HglCDYhMa4O8sUQZIEx7O3WDug77Zad8rT3CdiIeyvw5NkBs8H3Iw==
X-Received: by 2002:a62:e315:: with SMTP id g21mr35445558pfh.225.1560314741069;
        Tue, 11 Jun 2019 21:45:41 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z126sm17129194pfb.100.2019.06.11.21.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 21:45:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/4] soc: qcom: Add AOSS QMP driver
Date:   Tue, 11 Jun 2019 21:45:34 -0700
Message-Id: <20190612044536.13940-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190612044536.13940-1-bjorn.andersson@linaro.org>
References: <20190612044536.13940-1-bjorn.andersson@linaro.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Always On Subsystem (AOSS) Qualcomm Messaging Protocol (QMP) driver
is used to communicate with the AOSS for certain side-channel requests,
that are not available through the RPMh interface.

The communication is a very simple synchronous mechanism of messages
being written in message RAM and a doorbell in the AOSS is rung. As the
AOSS has processed the message length is cleared and an interrupt is
fired by the AOSS as acknowledgment.

The driver exposes the QDSS clock as a clock and the low-power state
associated with the remoteprocs in the system as a set of power-domains.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v8:
- ret => time_left
- static const the clk_init_data

 drivers/soc/qcom/Kconfig     |  12 +
 drivers/soc/qcom/Makefile    |   1 +
 drivers/soc/qcom/qcom_aoss.c | 480 +++++++++++++++++++++++++++++++++++
 3 files changed, 493 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_aoss.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 880cf0290962..1ecd95a1c654 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -4,6 +4,18 @@
 #
 menu "Qualcomm SoC drivers"
 
+config QCOM_AOSS_QMP
+	tristate "Qualcomm AOSS Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on MAILBOX
+	depends on COMMON_CLK
+	select PM_GENERIC_DOMAINS
+	help
+	  This driver provides the means of communicating with and controlling
+	  the low-power state for resources related to the remoteproc
+	  subsystems as well as controlling the debug clocks exposed by the Always On
+	  Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
+
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ffe519b0cb66..eeb088beb15f 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_rpmh-rsc.o := -I$(src)
+obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
new file mode 100644
index 000000000000..5f885196f4d0
--- /dev/null
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Ltd
+ */
+#include <dt-bindings/power/qcom-aoss-qmp.h>
+#include <linux/clk-provider.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+
+#define QMP_DESC_MAGIC			0x0
+#define QMP_DESC_VERSION		0x4
+#define QMP_DESC_FEATURES		0x8
+
+/* AOP-side offsets */
+#define QMP_DESC_UCORE_LINK_STATE	0xc
+#define QMP_DESC_UCORE_LINK_STATE_ACK	0x10
+#define QMP_DESC_UCORE_CH_STATE		0x14
+#define QMP_DESC_UCORE_CH_STATE_ACK	0x18
+#define QMP_DESC_UCORE_MBOX_SIZE	0x1c
+#define QMP_DESC_UCORE_MBOX_OFFSET	0x20
+
+/* Linux-side offsets */
+#define QMP_DESC_MCORE_LINK_STATE	0x24
+#define QMP_DESC_MCORE_LINK_STATE_ACK	0x28
+#define QMP_DESC_MCORE_CH_STATE		0x2c
+#define QMP_DESC_MCORE_CH_STATE_ACK	0x30
+#define QMP_DESC_MCORE_MBOX_SIZE	0x34
+#define QMP_DESC_MCORE_MBOX_OFFSET	0x38
+
+#define QMP_STATE_UP			GENMASK(15, 0)
+#define QMP_STATE_DOWN			GENMASK(31, 16)
+
+#define QMP_MAGIC			0x4d41494c /* mail */
+#define QMP_VERSION			1
+
+/* 64 bytes is enough to store the requests and provides padding to 4 bytes */
+#define QMP_MSG_LEN			64
+
+/**
+ * struct qmp - driver state for QMP implementation
+ * @msgram: iomem referencing the message RAM used for communication
+ * @dev: reference to QMP device
+ * @mbox_client: mailbox client used to ring the doorbell on transmit
+ * @mbox_chan: mailbox channel used to ring the doorbell on transmit
+ * @offset: offset within @msgram where messages should be written
+ * @size: maximum size of the messages to be transmitted
+ * @event: wait_queue for synchronization with the IRQ
+ * @tx_lock: provides synchronization between multiple callers of qmp_send()
+ * @qdss_clk: QDSS clock hw struct
+ * @pd_data: genpd data
+ */
+struct qmp {
+	void __iomem *msgram;
+	struct device *dev;
+
+	struct mbox_client mbox_client;
+	struct mbox_chan *mbox_chan;
+
+	size_t offset;
+	size_t size;
+
+	wait_queue_head_t event;
+
+	struct mutex tx_lock;
+
+	struct clk_hw qdss_clk;
+	struct genpd_onecell_data pd_data;
+};
+
+struct qmp_pd {
+	struct qmp *qmp;
+	struct generic_pm_domain pd;
+};
+
+#define to_qmp_pd_resource(res) container_of(res, struct qmp_pd, pd)
+
+static void qmp_kick(struct qmp *qmp)
+{
+	mbox_send_message(qmp->mbox_chan, NULL);
+	mbox_client_txdone(qmp->mbox_chan, 0);
+}
+
+static bool qmp_magic_valid(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_MAGIC) == QMP_MAGIC;
+}
+
+static bool qmp_link_acked(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_MCORE_LINK_STATE_ACK) == QMP_STATE_UP;
+}
+
+static bool qmp_mcore_channel_acked(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_MCORE_CH_STATE_ACK) == QMP_STATE_UP;
+}
+
+static bool qmp_ucore_channel_up(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_UCORE_CH_STATE) == QMP_STATE_UP;
+}
+
+static int qmp_open(struct qmp *qmp)
+{
+	int ret;
+	u32 val;
+
+	if (!qmp_magic_valid(qmp)) {
+		dev_err(qmp->dev, "QMP magic doesn't match\n");
+		return -EINVAL;
+	}
+
+	val = readl(qmp->msgram + QMP_DESC_VERSION);
+	if (val != QMP_VERSION) {
+		dev_err(qmp->dev, "unsupported QMP version %d\n", val);
+		return -EINVAL;
+	}
+
+	qmp->offset = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_OFFSET);
+	qmp->size = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_SIZE);
+	if (!qmp->size) {
+		dev_err(qmp->dev, "invalid mailbox size\n");
+		return -EINVAL;
+	}
+
+	/* Ack remote core's link state */
+	val = readl(qmp->msgram + QMP_DESC_UCORE_LINK_STATE);
+	writel(val, qmp->msgram + QMP_DESC_UCORE_LINK_STATE_ACK);
+
+	/* Set local core's link state to up */
+	writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
+
+	qmp_kick(qmp);
+
+	ret = wait_event_timeout(qmp->event, qmp_link_acked(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "ucore didn't ack link\n");
+		goto timeout_close_link;
+	}
+
+	writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
+
+	qmp_kick(qmp);
+
+	ret = wait_event_timeout(qmp->event, qmp_ucore_channel_up(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "ucore didn't open channel\n");
+		goto timeout_close_channel;
+	}
+
+	/* Ack remote core's channel state */
+	writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_UCORE_CH_STATE_ACK);
+
+	qmp_kick(qmp);
+
+	ret = wait_event_timeout(qmp->event, qmp_mcore_channel_acked(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "ucore didn't ack channel\n");
+		goto timeout_close_channel;
+	}
+
+	return 0;
+
+timeout_close_channel:
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
+
+timeout_close_link:
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
+	qmp_kick(qmp);
+
+	return -ETIMEDOUT;
+}
+
+static void qmp_close(struct qmp *qmp)
+{
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
+	qmp_kick(qmp);
+}
+
+static irqreturn_t qmp_intr(int irq, void *data)
+{
+	struct qmp *qmp = data;
+
+	wake_up_interruptible_all(&qmp->event);
+
+	return IRQ_HANDLED;
+}
+
+static bool qmp_message_empty(struct qmp *qmp)
+{
+	return readl(qmp->msgram + qmp->offset) == 0;
+}
+
+/**
+ * qmp_send() - send a message to the AOSS
+ * @qmp: qmp context
+ * @data: message to be sent
+ * @len: length of the message
+ *
+ * Transmit @data to AOSS and wait for the AOSS to acknowledge the message.
+ * @len must be a multiple of 4 and not longer than the mailbox size. Access is
+ * synchronized by this implementation.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int qmp_send(struct qmp *qmp, const void *data, size_t len)
+{
+	long time_left;
+	int ret;
+
+	if (WARN_ON(len + sizeof(u32) > qmp->size))
+		return -EINVAL;
+
+	if (WARN_ON(len % sizeof(u32)))
+		return -EINVAL;
+
+	mutex_lock(&qmp->tx_lock);
+
+	/* The message RAM only implements 32-bit accesses */
+	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
+			 data, len / sizeof(u32));
+	writel(len, qmp->msgram + qmp->offset);
+	qmp_kick(qmp);
+
+	time_left = wait_event_interruptible_timeout(qmp->event,
+						     qmp_message_empty(qmp), HZ);
+	if (!time_left) {
+		dev_err(qmp->dev, "ucore did not ack channel\n");
+		ret = -ETIMEDOUT;
+
+		/* Clear message from buffer */
+		writel(0, qmp->msgram + qmp->offset);
+	} else {
+		ret = 0;
+	}
+
+	mutex_unlock(&qmp->tx_lock);
+
+	return ret;
+}
+
+static int qmp_qdss_clk_prepare(struct clk_hw *hw)
+{
+	static const char buf[QMP_MSG_LEN] = "{class: clock, res: qdss, val: 1}";
+	struct qmp *qmp = container_of(hw, struct qmp, qdss_clk);
+
+	return qmp_send(qmp, buf, sizeof(buf));
+}
+
+static void qmp_qdss_clk_unprepare(struct clk_hw *hw)
+{
+	static const char buf[QMP_MSG_LEN] = "{class: clock, res: qdss, val: 0}";
+	struct qmp *qmp = container_of(hw, struct qmp, qdss_clk);
+
+	qmp_send(qmp, buf, sizeof(buf));
+}
+
+static const struct clk_ops qmp_qdss_clk_ops = {
+	.prepare = qmp_qdss_clk_prepare,
+	.unprepare = qmp_qdss_clk_unprepare,
+};
+
+static int qmp_qdss_clk_add(struct qmp *qmp)
+{
+	static const struct clk_init_data qdss_init = {
+		.ops = &qmp_qdss_clk_ops,
+		.name = "qdss",
+	};
+	int ret;
+
+	qmp->qdss_clk.init = &qdss_init;
+	ret = clk_hw_register(qmp->dev, &qmp->qdss_clk);
+	if (ret < 0) {
+		dev_err(qmp->dev, "failed to register qdss clock\n");
+		return ret;
+	}
+
+	ret = of_clk_add_hw_provider(qmp->dev->of_node, of_clk_hw_simple_get,
+				     &qmp->qdss_clk);
+	if (ret < 0) {
+		dev_err(qmp->dev, "unable to register of clk hw provider\n");
+		clk_hw_unregister(&qmp->qdss_clk);
+	}
+
+	return ret;
+}
+
+static void qmp_qdss_clk_remove(struct qmp *qmp)
+{
+	of_clk_del_provider(qmp->dev->of_node);
+	clk_hw_unregister(&qmp->qdss_clk);
+}
+
+static int qmp_pd_power_toggle(struct qmp_pd *res, bool enable)
+{
+	char buf[QMP_MSG_LEN] = {};
+
+	snprintf(buf, sizeof(buf),
+		 "{class: image, res: load_state, name: %s, val: %s}",
+		 res->pd.name, enable ? "on" : "off");
+	return qmp_send(res->qmp, buf, sizeof(buf));
+}
+
+static int qmp_pd_power_on(struct generic_pm_domain *domain)
+{
+	return qmp_pd_power_toggle(to_qmp_pd_resource(domain), true);
+}
+
+static int qmp_pd_power_off(struct generic_pm_domain *domain)
+{
+	return qmp_pd_power_toggle(to_qmp_pd_resource(domain), false);
+}
+
+static const char * const sdm845_resources[] = {
+	[AOSS_QMP_LS_CDSP] = "cdsp",
+	[AOSS_QMP_LS_LPASS] = "adsp",
+	[AOSS_QMP_LS_MODEM] = "modem",
+	[AOSS_QMP_LS_SLPI] = "slpi",
+	[AOSS_QMP_LS_SPSS] = "spss",
+	[AOSS_QMP_LS_VENUS] = "venus",
+};
+
+static int qmp_pd_add(struct qmp *qmp)
+{
+	struct genpd_onecell_data *data = &qmp->pd_data;
+	struct device *dev = qmp->dev;
+	struct qmp_pd *res;
+	size_t num = ARRAY_SIZE(sdm845_resources);
+	int ret;
+	int i;
+
+	res = devm_kcalloc(dev, num, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
+				     GFP_KERNEL);
+	if (!data->domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		res[i].qmp = qmp;
+		res[i].pd.name = sdm845_resources[i];
+		res[i].pd.power_on = qmp_pd_power_on;
+		res[i].pd.power_off = qmp_pd_power_off;
+
+		ret = pm_genpd_init(&res[i].pd, NULL, true);
+		if (ret < 0) {
+			dev_err(dev, "failed to init genpd\n");
+			goto unroll_genpds;
+		}
+
+		data->domains[i] = &res[i].pd;
+	}
+
+	data->num_domains = i;
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, data);
+	if (ret < 0)
+		goto unroll_genpds;
+
+	return 0;
+
+unroll_genpds:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(data->domains[i]);
+
+	return ret;
+}
+
+static void qmp_pd_remove(struct qmp *qmp)
+{
+	struct genpd_onecell_data *data = &qmp->pd_data;
+	struct device *dev = qmp->dev;
+	int i;
+
+	of_genpd_del_provider(dev->of_node);
+
+	for (i = 0; i < data->num_domains; i++)
+		pm_genpd_remove(data->domains[i]);
+}
+
+static int qmp_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct qmp *qmp;
+	int irq;
+	int ret;
+
+	qmp = devm_kzalloc(&pdev->dev, sizeof(*qmp), GFP_KERNEL);
+	if (!qmp)
+		return -ENOMEM;
+
+	qmp->dev = &pdev->dev;
+	init_waitqueue_head(&qmp->event);
+	mutex_init(&qmp->tx_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	qmp->msgram = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(qmp->msgram))
+		return PTR_ERR(qmp->msgram);
+
+	qmp->mbox_client.dev = &pdev->dev;
+	qmp->mbox_client.knows_txdone = true;
+	qmp->mbox_chan = mbox_request_channel(&qmp->mbox_client, 0);
+	if (IS_ERR(qmp->mbox_chan)) {
+		dev_err(&pdev->dev, "failed to acquire ipc mailbox\n");
+		return PTR_ERR(qmp->mbox_chan);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
+			       "aoss-qmp", qmp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request interrupt\n");
+		goto err_free_mbox;
+	}
+
+	ret = qmp_open(qmp);
+	if (ret < 0)
+		goto err_free_mbox;
+
+	ret = qmp_qdss_clk_add(qmp);
+	if (ret)
+		goto err_close_qmp;
+
+	ret = qmp_pd_add(qmp);
+	if (ret)
+		goto err_remove_qdss_clk;
+
+	platform_set_drvdata(pdev, qmp);
+
+	return 0;
+
+err_remove_qdss_clk:
+	qmp_qdss_clk_remove(qmp);
+err_close_qmp:
+	qmp_close(qmp);
+err_free_mbox:
+	mbox_free_channel(qmp->mbox_chan);
+
+	return ret;
+}
+
+static int qmp_remove(struct platform_device *pdev)
+{
+	struct qmp *qmp = platform_get_drvdata(pdev);
+
+	qmp_qdss_clk_remove(qmp);
+	qmp_pd_remove(qmp);
+
+	qmp_close(qmp);
+	mbox_free_channel(qmp->mbox_chan);
+
+	return 0;
+}
+
+static const struct of_device_id qmp_dt_match[] = {
+	{ .compatible = "qcom,sdm845-aoss-qmp", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qmp_dt_match);
+
+static struct platform_driver qmp_driver = {
+	.driver = {
+		.name		= "qcom_aoss_qmp",
+		.of_match_table	= qmp_dt_match,
+	},
+	.probe = qmp_probe,
+	.remove	= qmp_remove,
+};
+module_platform_driver(qmp_driver);
+
+MODULE_DESCRIPTION("Qualcomm AOSS QMP driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

