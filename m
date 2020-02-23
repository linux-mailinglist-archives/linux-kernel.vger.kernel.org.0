Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE991695B4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 05:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgBWEI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 23:08:58 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37351 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbgBWEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:08:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id DDADE6BB5;
        Sat, 22 Feb 2020 23:08:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 23:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mt1X8dREzX4do
        0ThRJHRstZS6WLGhLbI7p3SnCBsQ3U=; b=TMGlE4POigBmvZZqJvJgD17nt4VRJ
        ZzWrui5sjOZlUadHFrDt3HlZzHxopq+TN67+vUFsaFe/FP9s2RO23HtMzplDVhMm
        Zt2f1eKg26S6rF8BMQS7MzwxZT0bCOulll4xjNvFEPhpC7x1N1eswnzABLEVBhn+
        hedeYk4yyNdc/C9No/H7m0LvpzR6Uq0voTfyjLjZZ9HmUSalMDgesSUYAnYFABHg
        L6GlWDIsrxKLe0sueTXwdP8VyI6hZJKYQYZG8tdEn7x7DvNkwYnLlV1Q5R95xgAx
        Sp+sAAl61HhRozL6VJKRdu5iYPFQKQdslsgStxJWcbSum3FAfGMzItYyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=mt1X8dREzX4do0ThRJHRstZS6WLGhLbI7p3SnCBsQ3U=; b=oHOsvaGH
        dCYMMXRi6FHRtKVhMH0KtPl53b9L91+oXCmupJHvRuOs9KDqLAe2x3A5xGFYi8bg
        l9pVWgfaBewT2FKkdiOY4Hn2k6xX/9fFRAQhd9Mm0qvHw/bPIBiPE+ETw3b4Nj/s
        c3pMUBxF00EFhvCS2AZ1/QcDUkjYg18RJiG/51PGWqone3gnhW05loTjZsmWyCd1
        Ys5o2dFOSjM90C9xyh3GsOZgvG/5cO1auJaaBjFr2cZW1LIagujjxbaQ6Vi+Q0AN
        KsR52e+oM+nZlf6+KW8cyKIfQgFm6XylT9+gQqYFg2msCpynJbXyxZ8I3C5fLTzY
        vvlsZvGYeUEuvw==
X-ME-Sender: <xms:1_pRXocguV6CX2kupnnXEnWrh-n8EjMPPl70Xuai2vbCvfEkJ4Anfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1_pRXrZ2o_PL3XQAMnr81fmYsj9KIuoEYUxn_PaqjikFGfYHgIhdMw>
    <xmx:1_pRXp_5w8HXR1atBkHUo1T8Lbd-YtTUYNcptl9x4jmOIHSYrRe6lA>
    <xmx:1_pRXnWmlQ9RqUQd0JWhxZ5TyDhJ0alY-o6gUkt5gcHD2BSs4uN7bQ>
    <xmx:1_pRXkOyFL49yfx6VRXuPoThvG9zynBkPkJAsBEA79WRWMdMu7j41Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 36D4B3280063;
        Sat, 22 Feb 2020 23:08:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 2/6] mailbox: sun6i-msgbox: Add a new mailbox driver
Date:   Sat, 22 Feb 2020 22:08:49 -0600
Message-Id: <20200223040853.2658-3-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223040853.2658-1-samuel@sholland.org>
References: <20200223040853.2658-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner sun6i, sun8i, sun9i, and sun50i SoCs contain a hardware
message box used for communication between the ARM CPUs and the ARISC
management coprocessor. This mailbox contains 8 unidirectional
4-message FIFOs.

Add a driver for it, so it can be used with the Linux mailbox framework.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/mailbox/Kconfig        |   9 +
 drivers/mailbox/Makefile       |   2 +
 drivers/mailbox/sun6i-msgbox.c | 326 +++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/mailbox/sun6i-msgbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ab4eb750bbdd..5a577a6734cf 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -227,4 +227,13 @@ config ZYNQMP_IPI_MBOX
 	  message to the IPI buffer and will access the IPI control
 	  registers to kick the other processor or enquire status.
 
+config SUN6I_MSGBOX
+	tristate "Allwinner sun6i/sun8i/sun9i/sun50i Message Box"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	default ARCH_SUNXI
+	help
+	  Mailbox implementation for the hardware message box present in
+	  various Allwinner SoCs. This mailbox is used for communication
+	  between the application CPUs and the power management coprocessor.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c22fad6f696b..2e4364ef5c47 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -48,3 +48,5 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
 
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
+
+obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
diff --git a/drivers/mailbox/sun6i-msgbox.c b/drivers/mailbox/sun6i-msgbox.c
new file mode 100644
index 000000000000..ccecf2e5941d
--- /dev/null
+++ b/drivers/mailbox/sun6i-msgbox.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2017-2019 Samuel Holland <samuel@sholland.org>
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define NUM_CHANS		8
+
+#define CTRL_REG(n)		(0x0000 + 0x4 * ((n) / 4))
+#define CTRL_RX(n)		BIT(0 + 8 * ((n) % 4))
+#define CTRL_TX(n)		BIT(4 + 8 * ((n) % 4))
+
+#define REMOTE_IRQ_EN_REG	0x0040
+#define REMOTE_IRQ_STAT_REG	0x0050
+#define LOCAL_IRQ_EN_REG	0x0060
+#define LOCAL_IRQ_STAT_REG	0x0070
+
+#define RX_IRQ(n)		BIT(0 + 2 * (n))
+#define RX_IRQ_MASK		0x5555
+#define TX_IRQ(n)		BIT(1 + 2 * (n))
+#define TX_IRQ_MASK		0xaaaa
+
+#define FIFO_STAT_REG(n)	(0x0100 + 0x4 * (n))
+#define FIFO_STAT_MASK		GENMASK(0, 0)
+
+#define MSG_STAT_REG(n)		(0x0140 + 0x4 * (n))
+#define MSG_STAT_MASK		GENMASK(2, 0)
+
+#define MSG_DATA_REG(n)		(0x0180 + 0x4 * (n))
+
+#define mbox_dbg(mbox, ...)	dev_dbg((mbox)->controller.dev, __VA_ARGS__)
+
+struct sun6i_msgbox {
+	struct mbox_controller controller;
+	struct clk *clk;
+	spinlock_t lock;
+	void __iomem *regs;
+};
+
+static bool sun6i_msgbox_last_tx_done(struct mbox_chan *chan);
+static bool sun6i_msgbox_peek_data(struct mbox_chan *chan);
+
+static inline int channel_number(struct mbox_chan *chan)
+{
+	return chan - chan->mbox->chans;
+}
+
+static inline struct sun6i_msgbox *to_sun6i_msgbox(struct mbox_chan *chan)
+{
+	return chan->con_priv;
+}
+
+static irqreturn_t sun6i_msgbox_irq(int irq, void *dev_id)
+{
+	struct sun6i_msgbox *mbox = dev_id;
+	uint32_t status;
+	int n;
+
+	/* Only examine channels that are currently enabled. */
+	status = readl(mbox->regs + LOCAL_IRQ_EN_REG) &
+		 readl(mbox->regs + LOCAL_IRQ_STAT_REG);
+
+	if (!(status & RX_IRQ_MASK))
+		return IRQ_NONE;
+
+	for (n = 0; n < NUM_CHANS; ++n) {
+		struct mbox_chan *chan = &mbox->controller.chans[n];
+
+		if (!(status & RX_IRQ(n)))
+			continue;
+
+		while (sun6i_msgbox_peek_data(chan)) {
+			uint32_t msg = readl(mbox->regs + MSG_DATA_REG(n));
+
+			mbox_dbg(mbox, "Channel %d received 0x%08x\n", n, msg);
+			mbox_chan_received_data(chan, &msg);
+		}
+
+		/* The IRQ can be cleared only once the FIFO is empty. */
+		writel(RX_IRQ(n), mbox->regs + LOCAL_IRQ_STAT_REG);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int sun6i_msgbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
+	int n = channel_number(chan);
+	uint32_t msg = *(uint32_t *)data;
+
+	/* Using a channel backwards gets the hardware into a bad state. */
+	if (WARN_ON_ONCE(!(readl(mbox->regs + CTRL_REG(n)) & CTRL_TX(n))))
+		return 0;
+
+	writel(msg, mbox->regs + MSG_DATA_REG(n));
+	mbox_dbg(mbox, "Channel %d sent 0x%08x\n", n, msg);
+
+	return 0;
+}
+
+static int sun6i_msgbox_startup(struct mbox_chan *chan)
+{
+	struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
+	int n = channel_number(chan);
+
+	/* The coprocessor is responsible for setting channel directions. */
+	if (readl(mbox->regs + CTRL_REG(n)) & CTRL_RX(n)) {
+		/* Flush the receive FIFO. */
+		while (sun6i_msgbox_peek_data(chan))
+			readl(mbox->regs + MSG_DATA_REG(n));
+		writel(RX_IRQ(n), mbox->regs + LOCAL_IRQ_STAT_REG);
+
+		/* Enable the receive IRQ. */
+		spin_lock(&mbox->lock);
+		writel(readl(mbox->regs + LOCAL_IRQ_EN_REG) | RX_IRQ(n),
+		       mbox->regs + LOCAL_IRQ_EN_REG);
+		spin_unlock(&mbox->lock);
+	}
+
+	mbox_dbg(mbox, "Channel %d startup complete\n", n);
+
+	return 0;
+}
+
+static void sun6i_msgbox_shutdown(struct mbox_chan *chan)
+{
+	struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
+	int n = channel_number(chan);
+
+	if (readl(mbox->regs + CTRL_REG(n)) & CTRL_RX(n)) {
+		/* Disable the receive IRQ. */
+		spin_lock(&mbox->lock);
+		writel(readl(mbox->regs + LOCAL_IRQ_EN_REG) & ~RX_IRQ(n),
+		       mbox->regs + LOCAL_IRQ_EN_REG);
+		spin_unlock(&mbox->lock);
+
+		/* Attempt to flush the FIFO until the IRQ is cleared. */
+		do {
+			while (sun6i_msgbox_peek_data(chan))
+				readl(mbox->regs + MSG_DATA_REG(n));
+			writel(RX_IRQ(n), mbox->regs + LOCAL_IRQ_STAT_REG);
+		} while (readl(mbox->regs + LOCAL_IRQ_STAT_REG) & RX_IRQ(n));
+	}
+
+	mbox_dbg(mbox, "Channel %d shutdown complete\n", n);
+}
+
+static bool sun6i_msgbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
+	int n = channel_number(chan);
+
+	/*
+	 * The hardware allows snooping on the remote user's IRQ statuses.
+	 * We consider a message to be acknowledged only once the receive IRQ
+	 * for that channel is cleared. Since the receive IRQ for a channel
+	 * cannot be cleared until the FIFO for that channel is empty, this
+	 * ensures that the message has actually been read. It also gives the
+	 * recipient an opportunity to perform minimal processing before
+	 * acknowledging the message.
+	 */
+	return !(readl(mbox->regs + REMOTE_IRQ_STAT_REG) & RX_IRQ(n));
+}
+
+static bool sun6i_msgbox_peek_data(struct mbox_chan *chan)
+{
+	struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
+	int n = channel_number(chan);
+
+	return readl(mbox->regs + MSG_STAT_REG(n)) & MSG_STAT_MASK;
+}
+
+static const struct mbox_chan_ops sun6i_msgbox_chan_ops = {
+	.send_data    = sun6i_msgbox_send_data,
+	.startup      = sun6i_msgbox_startup,
+	.shutdown     = sun6i_msgbox_shutdown,
+	.last_tx_done = sun6i_msgbox_last_tx_done,
+	.peek_data    = sun6i_msgbox_peek_data,
+};
+
+static int sun6i_msgbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_chan *chans;
+	struct reset_control *reset;
+	struct resource *res;
+	struct sun6i_msgbox *mbox;
+	int i, ret;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	chans = devm_kcalloc(dev, NUM_CHANS, sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+
+	for (i = 0; i < NUM_CHANS; ++i)
+		chans[i].con_priv = mbox;
+
+	mbox->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(mbox->clk)) {
+		ret = PTR_ERR(mbox->clk);
+		dev_err(dev, "Failed to get clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(mbox->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		dev_err(dev, "Failed to get reset control: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	/*
+	 * NOTE: We rely on platform firmware to preconfigure the channel
+	 * directions, and we share this hardware block with other firmware
+	 * that runs concurrently with Linux (e.g. a trusted monitor).
+	 *
+	 * Therefore, we do *not* assert the reset line if probing fails or
+	 * when removing the device.
+	 */
+	ret = reset_control_deassert(reset);
+	if (ret) {
+		dev_err(dev, "Failed to deassert reset: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto err_disable_unprepare;
+	}
+
+	mbox->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mbox->regs)) {
+		ret = PTR_ERR(mbox->regs);
+		dev_err(dev, "Failed to map MMIO resource: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	/* Disable all IRQs for this end of the msgbox. */
+	writel(0, mbox->regs + LOCAL_IRQ_EN_REG);
+
+	ret = devm_request_irq(dev, irq_of_parse_and_map(dev->of_node, 0),
+			       sun6i_msgbox_irq, 0, dev_name(dev), mbox);
+	if (ret) {
+		dev_err(dev, "Failed to register IRQ handler: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	mbox->controller.dev           = dev;
+	mbox->controller.ops           = &sun6i_msgbox_chan_ops;
+	mbox->controller.chans         = chans;
+	mbox->controller.num_chans     = NUM_CHANS;
+	mbox->controller.txdone_irq    = false;
+	mbox->controller.txdone_poll   = true;
+	mbox->controller.txpoll_period = 5;
+
+	spin_lock_init(&mbox->lock);
+	platform_set_drvdata(pdev, mbox);
+
+	ret = mbox_controller_register(&mbox->controller);
+	if (ret) {
+		dev_err(dev, "Failed to register controller: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	return 0;
+
+err_disable_unprepare:
+	clk_disable_unprepare(mbox->clk);
+
+	return ret;
+}
+
+static int sun6i_msgbox_remove(struct platform_device *pdev)
+{
+	struct sun6i_msgbox *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&mbox->controller);
+	/* See the comment in sun6i_msgbox_probe about the reset line. */
+	clk_disable_unprepare(mbox->clk);
+
+	return 0;
+}
+
+static const struct of_device_id sun6i_msgbox_of_match[] = {
+	{ .compatible = "allwinner,sun6i-a31-msgbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun6i_msgbox_of_match);
+
+static struct platform_driver sun6i_msgbox_driver = {
+	.driver = {
+		.name = "sun6i-msgbox",
+		.of_match_table = sun6i_msgbox_of_match,
+	},
+	.probe  = sun6i_msgbox_probe,
+	.remove = sun6i_msgbox_remove,
+};
+module_platform_driver(sun6i_msgbox_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Allwinner sun6i/sun8i/sun9i/sun50i Message Box");
+MODULE_LICENSE("GPL v2");
-- 
2.24.1

