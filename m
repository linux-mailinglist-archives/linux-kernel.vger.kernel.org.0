Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD96C175
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfGQT0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 15:26:42 -0400
Received: from foss.arm.com ([217.140.110.172]:50276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQT0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:26:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330DF337;
        Wed, 17 Jul 2019 12:26:40 -0700 (PDT)
Received: from tuskha01.cambridge.arm.com (tuskha01.cambridge.arm.com [10.1.196.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECAD93F71A;
        Wed, 17 Jul 2019 12:26:38 -0700 (PDT)
From:   Tushar Khandelwal <tushar.khandelwal@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tushar.2nov@gmail.com, morten_bp@live.dk, jassisinghbrar@gmail.com,
        nd@arm.com, Morten Borup Petersen <morten.petersen@arm.com>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] mailbox: arm_mhuv2: add arm mhuv2 driver
Date:   Wed, 17 Jul 2019 20:26:14 +0100
Message-Id: <20190717192616.1731-3-tushar.khandelwal@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717192616.1731-1-tushar.khandelwal@arm.com>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Borup Petersen <morten.petersen@arm.com>

This commit adds a driver for the ARM MHUv2 (Message Handling Unit).
The driver registers itself as a mailbox controller within the common
mailbox framework.

This commit implements the single-word transport protocol;
In single-word mode, the mailbox controller will provide a mailbox for each
channel window available in the MHU device.
Transmitting and receiving data through the mailbox framework in
single-word mode is done through a struct arm_mbox_msg.

Signed-off-by: Morten Borup Petersen <morten.petersen@arm.com>
Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Cc: jassisinghbrar@gmail.com
Cc: devicetree@vger.kernel.org
---
 drivers/mailbox/Kconfig                  |   7 +
 drivers/mailbox/Makefile                 |   2 +
 drivers/mailbox/arm_mhu_v2.c             | 735 +++++++++++++++++++++++
 include/linux/mailbox/arm-mbox-message.h |  37 ++
 4 files changed, 781 insertions(+)
 create mode 100644 drivers/mailbox/arm_mhu_v2.c
 create mode 100644 include/linux/mailbox/arm-mbox-message.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index e63d29a95e76..6808bba5bf9b 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -15,6 +15,13 @@ config ARM_MHU
 	  The controller has 3 mailbox channels, the last of which can be
 	  used in Secure mode only.
 
+config ARM_MHU_V2
+	tristate "ARM MHUv2 Mailbox"
+	depends on ARM_AMBA
+	help
+	  Say Y here if you want to build the ARM MHUv2 controller driver,
+	  which provides unidirectional mailboxes between processing elements.
+
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index f15788ccc572..6edef52d74bb 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
 
 obj-$(CONFIG_ARM_MHU)		+= arm_mhu.o
 
+obj-$(CONFIG_ARM_MHU_V2)	+= arm_mhu_v2.o
+
 obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
 
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
diff --git a/drivers/mailbox/arm_mhu_v2.c b/drivers/mailbox/arm_mhu_v2.c
new file mode 100644
index 000000000000..a0af683b83a2
--- /dev/null
+++ b/drivers/mailbox/arm_mhu_v2.c
@@ -0,0 +1,735 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arm Message Handling Unit Version 2 (MHUv2) driver
+ *
+ * An MHU device may function in one of three transport protocol modes
+ * (single-word, multi-word and doorbell).
+ * This transport protocol should be specified in the device tree entry for the
+ * device. The transport protocol determines how the underlying hardware
+ * resources of the device are utilized when transmitting data.
+ *
+ * The arm MHUv2 driver registers as a mailbox controller with the common
+ * mailbox framework. Each mailbox channel represents a separate virtual
+ * communication channel through the MHU device.
+ * The number of registered mailbox channels is dependent on both the
+ * underlying hardware - mainly the number of channel windows within each MHU
+ * frame, as well as the selected transport protocol.
+ *
+ * Copyright (C) 2019 Arm Ltd.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/amba/bus.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/arm-mbox-message.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+
+/* Maximum number of channel windows */
+#define MHUV2_CHANNEL_MAX 124
+/* Number of combined interrupt status registers */
+#define MHUV2_CMB_INT_ST_REG_CNT 4
+#define MHUV2_CH_UNKNOWN -1
+
+/* Channel window status register type */
+typedef u32 mhuv2_stat_reg_t;
+#define MHUV2_STAT_BYTES sizeof(mhuv2_stat_reg_t)
+#define MHUV2_STAT_BITS (MHUV2_STAT_BYTES * __CHAR_BIT__)
+
+#define LSB_MASK(n) ((1 << (n)) - 1)
+
+#ifndef PAD
+#define _PADLINE(line) pad##line
+#define _XSTR(line) _PADLINE(line)
+#define PAD _XSTR(__LINE__)
+#endif
+
+/* ====== Arm MHUv2 register defines ====== */
+
+/* Register Message Handling Unit Configuration fields */
+struct MHU_CFG_t {
+	u32 NUM_CH : 7;
+	u32 PAD : 25;
+} __packed;
+
+/* Register Implementer Identification fields */
+struct IIDR_t {
+	u32 IMPLEMENTER : 12;
+	u32 REVISION : 4;
+	u32 VARIANT : 4;
+	u32 PRODUCT_ID : 12;
+} __packed;
+
+/* Register Architecture Identification Register fields */
+struct AIDR_t {
+	u32 ARCH_MINOR_REV : 4;
+	u32 ARCH_MAJOR_REV : 4;
+	u32 PAD : 24;
+} __packed;
+
+/* register Interrupt Status fields */
+struct INT_ST_t {
+	u32 NR2R : 1;
+	u32 R2NR : 1;
+	u32 PAD : 30;
+} __packed;
+
+/* Register Interrupt Clear fields */
+struct INT_CLR_t {
+	u32 NR2R : 1;
+	u32 R2NR : 1;
+	u32 PAD : 30;
+} __packed;
+
+/* Register Interrupt Enable fields */
+struct INT_EN_t {
+	u32 R2NR : 1;
+	u32 NR2R : 1;
+	u32 CHCOMB : 1;
+	u32 PAD : 29;
+} __packed;
+
+/* Sender Channel Window fields */
+struct mhu2_send_channel_reg {
+	mhuv2_stat_reg_t STAT;
+	u8 PAD[0xC - 0x4];
+	mhuv2_stat_reg_t STAT_SET;
+	u8 PAD[0x20 - 0x10];
+} __packed;
+
+/* Sender frame register fields */
+struct mhu2_send_frame_reg {
+	struct mhu2_send_channel_reg channel[MHUV2_CHANNEL_MAX];
+	struct MHU_CFG_t MHU_CFG;
+	u32 RESP_CFG;
+	u32 ACCESS_REQUEST;
+	u32 ACCESS_READY;
+	struct INT_ST_t INT_ST;
+	struct INT_CLR_t INT_CLR;
+	struct INT_EN_t INT_EN;
+	u32 RESERVED0;
+	u32 CHCOMB_INT_ST[MHUV2_CMB_INT_ST_REG_CNT];
+	u8 PAD[0xFC8 - 0xFB0];
+	struct IIDR_t IIDR;
+	struct AIDR_t AIDR;
+} __packed;
+
+/* Receiver Channel Window fields */
+struct mhu2_recv_channel_reg {
+	mhuv2_stat_reg_t STAT;
+	mhuv2_stat_reg_t STAT_PEND;
+	mhuv2_stat_reg_t STAT_CLEAR;
+	u8 RESERVED0[0x10 - 0x0C];
+	mhuv2_stat_reg_t MASK;
+	mhuv2_stat_reg_t MASK_SET;
+	mhuv2_stat_reg_t MASK_CLEAR;
+	u8 PAD[0x20 - 0x1C];
+} __packed;
+
+/* Receiver frame register fields */
+struct mhu2_recv_frame_reg {
+	struct mhu2_recv_channel_reg channel[MHUV2_CHANNEL_MAX];
+	struct MHU_CFG_t MHU_CFG;
+	u8 RESERVED0[0xF90 - 0xF84];
+	struct INT_ST_t INT_ST;
+	struct INT_CLR_t INT_CLR;
+	struct INT_EN_t INT_EN;
+	u32 PAD;
+	mhuv2_stat_reg_t CHCOMB_INT_ST[MHUV2_CMB_INT_ST_REG_CNT];
+	u8 RESERVED2[0xFC8 - 0xFB0];
+	struct IIDR_t IIDR;
+	struct AIDR_t AIDR;
+} __packed;
+
+/* ====== Arm MHUv2 device tree property identifiers ====== */
+
+static const char *const mhuv2_protocol_dt_identifiers[] = { "single-word",
+							     "multi-word",
+							     "doorbell" };
+
+static const char *const mhuv2_frame_dt_identifiers[] = { "receiver",
+							  "sender" };
+
+/* ====== Arm MHUv2 data structures ====== */
+
+enum mhuv2_transport_protocol { SINGLE_WORD, MULTI_WORD, DOORBELL };
+
+enum mhuv2_frame { RECEIVER_FRAME, SENDER_FRAME };
+
+/**
+ * Arm MHUv2 operations
+ *
+ * Each transport protocol must provide an implementation of the operations
+ * presented in this structure.
+ * Most operations present a struct mbox_chan* as argument. This channel will
+ * correspond to one of the virtual channels within the MHU device. What
+ * constitutes a channel within the MHU device is dependent on the transport
+ * protocol.
+ */
+struct arm_mhuv2;
+struct mhuv2_ops {
+	int (*read_data)(struct arm_mhuv2 *mhuv2, struct mbox_chan *chan,
+			 struct arm_mbox_msg *msg);
+	int (*clear_data)(struct arm_mhuv2 *mhuv2, struct mbox_chan *chan,
+			  struct arm_mbox_msg *msg);
+	int (*send_data)(struct arm_mhuv2 *mhuv2, struct mbox_chan *chan,
+			 const struct arm_mbox_msg *msg);
+	int (*setup)(struct arm_mhuv2 *mhuv2);
+	int (*last_tx_done)(struct arm_mhuv2 *mhuv2, struct mbox_chan *chan);
+	struct mbox_chan *(*get_active_mbox_chan)(struct arm_mhuv2 *mhuv2);
+};
+
+/**
+ * Arm MHUv2 mailbox channel information
+ *
+ * A channel contains a notion of its index within the array of mailbox channels
+ * which a mailbox controller allocates.
+ */
+struct arm_mhuv2_mbox_chan_priv {
+	u32 ch_idx;
+};
+
+#define mhuv2_chan_idx(_chanptr)                                               \
+	(((struct arm_mhuv2_mbox_chan_priv *)(_chanptr)->con_priv)->ch_idx)
+
+/**
+ * Arm MHUv2 mailbox controller data
+ *
+ * @reg:	Base address of the register mapping region
+ * @protocol:	Transport protocol, derived from device tree
+ * @frame:	Frame type, derived from device tree
+ * @irq:	Interrupt, only valid for receiver frames
+ * @mbox:	Mailbox controller belonging to the MHU frame
+ * @ops:	Pointer to transport-protocol specific operations
+ * @dev:	Device to which it is attached
+ */
+struct arm_mhuv2 {
+	union {
+		struct mhu2_send_frame_reg __iomem *send;
+		struct mhu2_recv_frame_reg __iomem *recv;
+	} reg;
+	enum mhuv2_transport_protocol protocol;
+	enum mhuv2_frame frame;
+	unsigned int irq;
+	struct mbox_controller mbox;
+	struct mhuv2_ops *ops;
+	struct device *dev;
+};
+
+#define mhu2_from_mbox_ctrl(_mbox) container_of(_mbox, struct arm_mhuv2, mbox)
+#define mhu2_from_mbox_chan(_chan) mhu2_from_mbox_ctrl(_chan->mbox)
+
+/* Macro for reading a bitfield within a physically mapped packed struct */
+#define readl_relaxed_bitfield(_regptr, _field)                                \
+	({                                                                     \
+		mhuv2_stat_reg_t _regval;                                      \
+		BUILD_BUG_ON(sizeof(*(_regptr)) > sizeof(typeof(_regval)));    \
+		_regval = readl_relaxed((_regptr));                            \
+		(*(typeof((_regptr)))(&_regval))._field;                       \
+	})
+
+/* Macro for writing a bitfield within a physically mapped packed struct */
+#define writel_relaxed_bitfield(_value, _regptr, _field)                       \
+	({                                                                     \
+		mhuv2_stat_reg_t _regval;                                      \
+		BUILD_BUG_ON(sizeof(*_regptr) > sizeof(typeof(_regval)));      \
+		_regval = readl_relaxed(_regptr);                              \
+		(*(typeof(_regptr))(&_regval))._field = _value;                \
+		writel_relaxed(_regval, _regptr);                              \
+	})
+
+static inline int __find_set_bit(uint32_t val)
+{
+	const uint32_t trailing_zeros = __builtin_ctz(val);
+	return trailing_zeros == 32 ? -1 : trailing_zeros;
+}
+
+/**
+ * Get index of a set bit within the combined interrupt status registers
+ *
+ * The function will calculate the index being the offset from the LSB of the
+ * first combined interrupt status register.
+ *
+ */
+static inline int mhuv2_combint_idx(struct arm_mhuv2 *mhuv2)
+{
+	int ch_idx = 0;
+	int set_bit_index, reg_idx;
+
+	for (reg_idx = 0; reg_idx < MHUV2_CMB_INT_ST_REG_CNT; reg_idx++) {
+		mhuv2_stat_reg_t stat_reg;
+
+		stat_reg =
+			readl_relaxed(&mhuv2->reg.recv->CHCOMB_INT_ST[reg_idx]);
+		set_bit_index = __find_set_bit(stat_reg);
+		if (set_bit_index == -1) {
+			ch_idx += MHUV2_STAT_BITS;
+		} else {
+			ch_idx += set_bit_index;
+			break;
+		}
+	}
+	return (ch_idx >= (MHUV2_CMB_INT_ST_REG_CNT * MHUV2_STAT_BITS) ?
+			MHUV2_CH_UNKNOWN :
+			ch_idx);
+}
+
+/* ================ Single word transport protocol operations =============== */
+static inline int mhuv20_get_non_zero_ch_idx(struct arm_mhuv2 *mhuv2)
+{
+	/* Locate a channel window with a non-zero STAT register */
+	int ch_idx;
+	int ch = MHUV2_CH_UNKNOWN;
+
+	for (ch_idx = 0;
+	     ch_idx < readl_relaxed_bitfield(&mhuv2->reg.recv->MHU_CFG, NUM_CH);
+	     ch_idx++) {
+		if (readl_relaxed(&mhuv2->reg.recv->channel[ch].STAT)) {
+			ch = ch_idx;
+			break;
+		}
+	}
+	return ch;
+}
+
+static inline int mhuv2_get_non_zero_ch_idx(struct arm_mhuv2 *mhuv2)
+{
+	/* Identify index of channel window containing non-zero data */
+	switch (readl_relaxed_bitfield(&mhuv2->reg.recv->AIDR,
+				       ARCH_MINOR_REV)) {
+	case 1:
+		return mhuv2_combint_idx(mhuv2);
+	default:
+		return mhuv20_get_non_zero_ch_idx(mhuv2);
+	}
+}
+
+static inline int mhuv2_read_data_single_word(struct arm_mhuv2 *mhuv2,
+					      struct mbox_chan *chan,
+					      struct arm_mbox_msg *msg)
+{
+	const u32 ch_idx = mhuv2_chan_idx(chan);
+
+	msg->data = kzalloc(MHUV2_STAT_BYTES, GFP_KERNEL);
+	if (!msg->data)
+		return -ENOMEM;
+
+	*(mhuv2_stat_reg_t *)msg->data =
+		readl_relaxed(&mhuv2->reg.recv->channel[ch_idx].STAT);
+	msg->len = MHUV2_STAT_BYTES;
+	return 0;
+}
+
+static inline int mhuv2_clear_data_single_word(struct arm_mhuv2 *mhuv2,
+					       struct mbox_chan *chan,
+					       struct arm_mbox_msg *msg)
+{
+	const u32 ch_idx = mhuv2_chan_idx(chan);
+
+	writel_relaxed(readl_relaxed(&mhuv2->reg.recv->channel[ch_idx].STAT),
+		       &mhuv2->reg.recv->channel[ch_idx].STAT_CLEAR);
+	return 0;
+}
+
+static inline int mhuv2_send_data_single_word(struct arm_mhuv2 *mhuv2,
+					      struct mbox_chan *chan,
+					      const struct arm_mbox_msg *msg)
+{
+	const u32 ch_idx = mhuv2_chan_idx(chan);
+	int bytes_left = msg->len;
+	char *data = msg->data;
+
+	if (ch_idx >= readl_relaxed_bitfield(&mhuv2->reg.recv->MHU_CFG, NUM_CH))
+		return -ENODEV;
+
+	while (bytes_left > 0) {
+		mhuv2_stat_reg_t word = *(mhuv2_stat_reg_t *)(data);
+
+		if (bytes_left < MHUV2_STAT_BYTES)
+			word &= LSB_MASK(bytes_left * __CHAR_BIT__);
+
+		if (!word) {
+			dev_err(mhuv2->dev,
+				"Data transmitted in single-word mode must be non-zero\n");
+			return -EINVAL;
+		}
+		writel_relaxed(word,
+			       &mhuv2->reg.send->channel[ch_idx].STAT_SET);
+		while (readl_relaxed(&mhuv2->reg.send->channel[ch_idx].STAT))
+			continue;
+		bytes_left -= MHUV2_STAT_BYTES;
+		data += MHUV2_STAT_BYTES;
+	}
+
+	return 0;
+}
+
+static inline int mhuv2_last_tx_done_single_word(struct arm_mhuv2 *mhuv2,
+						 struct mbox_chan *chan)
+{
+	const u32 ch_idx = mhuv2_chan_idx(chan);
+
+	return readl_relaxed(&mhuv2->reg.send->channel[ch_idx].STAT) == 0;
+}
+
+static inline int mhuv2_setup_single_word(struct arm_mhuv2 *mhuv2)
+{
+	int i;
+	const u32 channel_windows =
+		readl_relaxed_bitfield(mhuv2->frame == RECEIVER_FRAME ?
+					       &mhuv2->reg.recv->MHU_CFG :
+					       &mhuv2->reg.send->MHU_CFG,
+				       NUM_CH);
+
+	mhuv2->mbox.num_chans = channel_windows;
+	mhuv2->mbox.chans =
+		devm_kzalloc(mhuv2->dev,
+			     mhuv2->mbox.num_chans * sizeof(struct mbox_chan),
+			     GFP_KERNEL);
+
+	for (i = 0; i < mhuv2->mbox.num_chans; i++) {
+		mhuv2->mbox.chans[i].con_priv =
+			devm_kzalloc(mhuv2->dev,
+				     sizeof(struct arm_mhuv2_mbox_chan_priv),
+				     GFP_KERNEL);
+		mhuv2_chan_idx(&mhuv2->mbox.chans[i]) = i;
+	}
+
+	if (mhuv2->frame == RECEIVER_FRAME) {
+		/* Ensure all status registers are unmasked */
+		for (i = 0; i < channel_windows; i++) {
+			writel_relaxed(0x0,
+				       &mhuv2->reg.recv->channel[i].MASK_SET);
+		}
+	}
+
+	return 0;
+}
+
+static inline struct mbox_chan *
+	mhuv2_get_active_mbox_chan_single_word(struct arm_mhuv2 *mhuv2)
+{
+	const u32 ch_idx = mhuv2_get_non_zero_ch_idx(mhuv2);
+
+	if (ch_idx >= mhuv2->mbox.num_chans) {
+		dev_err(mhuv2->dev,
+			"Invalid active channel in single word mode\n");
+		return ERR_PTR(-EINVAL);
+	}
+	return &mhuv2->mbox.chans[ch_idx];
+}
+
+static const struct mhuv2_ops mhuv2_single_word_ops = {
+	.read_data = mhuv2_read_data_single_word,
+	.clear_data = mhuv2_clear_data_single_word,
+	.send_data = mhuv2_send_data_single_word,
+	.setup = mhuv2_setup_single_word,
+	.last_tx_done = mhuv2_last_tx_done_single_word,
+	.get_active_mbox_chan = mhuv2_get_active_mbox_chan_single_word,
+};
+/* ========================================================================== */
+
+/*
+ * MHUv2 receiver interrupt service routine
+ *
+ * This routine will be called whenever a reception interrupt is raised on the
+ * MHU device. Given that an MHU device may manage multiple mailboxes, it is
+ * up to the protocol-specific operations to determine:
+ * - What is the active mailbox channel
+ * - Read the data within the MHU corresponding to the channel
+ * - Clear the data within the MHU corresponding to the channel
+ *
+ * These operations must also ensure to not overwrite any data which may belong
+ * to a different mailbox channel. For instance, if data is received in two
+ * channel windows in single-word mode, the ISR will read and clear the data
+ * from one of these channel windows within a pass. This will result in a status
+ * register being non-zero upon returning from this routine, which in turn
+ * will keep the interrupt asserted for a second round.
+ */
+static irqreturn_t mhuv2_rx_interrupt(int irq, void *data)
+{
+	struct arm_mbox_msg msg;
+	int status;
+	struct arm_mhuv2 *mhuv2 = data;
+	struct mbox_chan *chan = mhuv2->ops->get_active_mbox_chan(mhuv2);
+
+	msg.data = NULL;
+	msg.len = 0;
+
+	status = mhuv2->ops->read_data(mhuv2, chan, &msg);
+	if (status != 0)
+		goto rx_exit;
+
+	if (!chan->cl) {
+		dev_warn(
+			mhuv2->dev,
+			"Warning: Received data on channel not currently attached to a mailbox client\n");
+	} else {
+		mbox_chan_received_data(chan, (void *)&msg);
+	}
+
+	status = mhuv2->ops->clear_data(mhuv2, chan, &msg);
+
+rx_exit:
+	kfree(msg.data);
+
+	return status == 0 ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static bool mhuv2_last_tx_done(struct mbox_chan *chan)
+{
+	struct arm_mhuv2 *mhuv2 = mhu2_from_mbox_chan(chan);
+
+	return mhuv2->ops->last_tx_done(mhuv2, chan);
+}
+
+static int mhuv2_send_data(struct mbox_chan *chan, void *data)
+{
+	struct arm_mhuv2 *mhuv2 = mhu2_from_mbox_chan(chan);
+	struct arm_mbox_msg *msg = data;
+	int ret;
+
+	if (!mhuv2->ops->last_tx_done(mhuv2, chan))
+		return -EBUSY;
+
+	ret = mhuv2->ops->send_data(mhuv2, chan, msg);
+	return ret;
+}
+
+static int mhuv2_startup(struct mbox_chan *chan)
+{
+	struct arm_mhuv2 *mhuv2 = mhu2_from_mbox_ctrl(chan->mbox);
+
+	writel_relaxed(0x1, &mhuv2->reg.send->ACCESS_REQUEST);
+	while (!readl_relaxed(&mhuv2->reg.send->ACCESS_READY))
+		continue;
+
+	return 0;
+}
+
+static void mhuv2_shutdown(struct mbox_chan *chan)
+{
+	struct arm_mhuv2 *mhuv2 = mhu2_from_mbox_ctrl(chan->mbox);
+
+	writel_relaxed(0x0, &mhuv2->reg.send->ACCESS_REQUEST);
+}
+
+static int mhuv2_recv_startup(struct mbox_chan *chan)
+{
+	return 0;
+}
+
+static void mhuv2_recv_shutdown(struct mbox_chan *chan)
+{
+}
+
+static int mhuv2_recv_send_data(struct mbox_chan *chan, void *data)
+{
+	dev_err(chan->mbox->dev,
+		"Trying to transmit on a receiver MHU frame\n");
+	return -EIO;
+}
+
+static bool mhuv2_recv_last_tx_done(struct mbox_chan *chan)
+{
+	dev_err(chan->mbox->dev, "Trying to Tx poll on a receiver MHU frame\n");
+	return true;
+}
+
+static const struct mbox_chan_ops mhuv2_receiver_ops = {
+	.send_data = mhuv2_recv_send_data,
+	.startup = mhuv2_recv_startup,
+	.shutdown = mhuv2_recv_shutdown,
+	.last_tx_done = mhuv2_recv_last_tx_done,
+};
+
+static const struct mbox_chan_ops mhuv2_sender_ops = {
+	.send_data = mhuv2_send_data,
+	.startup = mhuv2_startup,
+	.shutdown = mhuv2_shutdown,
+	.last_tx_done = mhuv2_last_tx_done,
+};
+
+static struct mbox_chan *mhuv2_mbox_of_xlate(struct mbox_controller *ctrl,
+					     const struct of_phandle_args *pa)
+{
+	struct mbox_chan *chan;
+
+	if (pa->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	if (pa->args[0] >= ctrl->num_chans)
+		return ERR_PTR(-ENOENT);
+
+	chan = &ctrl->chans[pa->args[0]];
+	return chan;
+}
+
+static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int err;
+	struct device *dev = &adev->dev;
+	const struct device_node *np = dev->of_node;
+	struct arm_mhuv2 *mhuv2;
+	const char *str;
+
+	/* Allocate memory for device */
+	mhuv2 = devm_kzalloc(dev, sizeof(*mhuv2), GFP_KERNEL);
+	if (!mhuv2)
+		return -ENOMEM;
+
+	mhuv2->dev = dev;
+
+	/* Retrieve MHU frame specifier from device tree node */
+	err = of_property_read_string(np, "mhu-frame", &str);
+	if (err) {
+		dev_err(dev, "Probe failed: MHU frame not specified.");
+		return -ENODEV;
+	} else if (strcmp(str, mhuv2_frame_dt_identifiers[SENDER_FRAME]) == 0) {
+		mhuv2->frame = SENDER_FRAME;
+	} else if (strcmp(str, mhuv2_frame_dt_identifiers[RECEIVER_FRAME]) ==
+		   0) {
+		mhuv2->frame = RECEIVER_FRAME;
+	} else {
+		dev_err(dev,
+			"Probe failed; '%s' is not a valid MHU frame specifier\n",
+			str);
+		return -ENODEV;
+	}
+
+	/* Retrieve transport protocol specifier from device tree node */
+	err = of_property_read_string(np, "mhu-protocol", &str);
+	if (err) {
+		dev_err(dev,
+			 "Probe failed: no transport protocol specified\n");
+		return -ENODEV;
+	} else if (strcmp(str, mhuv2_protocol_dt_identifiers[SINGLE_WORD]) ==
+		   0) {
+		mhuv2->protocol = SINGLE_WORD;
+	} else if (strcmp(str, mhuv2_protocol_dt_identifiers[MULTI_WORD]) ==
+		   0) {
+		mhuv2->protocol = MULTI_WORD;
+	} else if (strcmp(str, mhuv2_protocol_dt_identifiers[DOORBELL]) == 0) {
+		mhuv2->protocol = DOORBELL;
+	} else {
+		dev_err(dev,
+			"Probe failed: '%s' is not a valid transport protocol specifier\n",
+			str);
+		return -ENODEV;
+	}
+
+	/* Get MHU type specific properties from device tree */
+	if (mhuv2->frame == RECEIVER_FRAME) {
+		mhuv2->reg.recv = (struct mhu2_recv_frame_reg *)of_iomap(
+			(struct device_node *)np, 0);
+		if (!mhuv2->reg.recv)
+			goto io_fail;
+		mhuv2->irq = adev->irq[0];
+	} else {
+		mhuv2->reg.send = (struct mhu2_send_frame_reg *)of_iomap(
+			(struct device_node *)np, 0);
+		if (!mhuv2->reg.send)
+			goto io_fail;
+	}
+
+	/* Assign transport protocol-specific operations */
+	switch (mhuv2->protocol) {
+	case SINGLE_WORD:
+		mhuv2->ops = &mhuv2_single_word_ops;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	/* Mailbox controller setup */
+	mhuv2->mbox.dev = dev;
+	mhuv2->mbox.txdone_irq = false;
+	mhuv2->mbox.txdone_poll = true;
+	mhuv2->mbox.txpoll_period = 1;
+	mhuv2->mbox.of_xlate = mhuv2_mbox_of_xlate;
+	mhuv2->mbox.ops = mhuv2->frame == SENDER_FRAME ? &mhuv2_sender_ops :
+							 &mhuv2_receiver_ops;
+	/*
+	 * Transport protocol specific setup
+	 * Setup function _must_ allocate mailbox channels according to the
+	 * number of channels provided in the given transport protocol mode.
+	 */
+	err = mhuv2->ops->setup(mhuv2);
+	if (err)
+		return err;
+
+	/* Request an interrupt if this is a receiver frame */
+	if (mhuv2->frame == RECEIVER_FRAME) {
+		err = request_irq(mhuv2->irq, mhuv2_rx_interrupt, IRQF_SHARED,
+				  "mhuv2_link", mhuv2);
+		if (err) {
+			dev_err(dev, "unable to acquire IRQ %d\n", mhuv2->irq);
+			return err;
+		}
+		/*
+		 * For minor version 1 and forward, the combined interrupt of
+		 * the receiver frame must be explicitly enabled during startup.
+		 */
+		if (readl_relaxed_bitfield(&mhuv2->reg.recv->AIDR,
+					   ARCH_MINOR_REV) > 0) {
+			writel_relaxed_bitfield(1, &mhuv2->reg.recv->INT_EN,
+						CHCOMB);
+		}
+	}
+
+	amba_set_drvdata(adev, mhuv2);
+
+	err = mbox_controller_register(&mhuv2->mbox);
+	if (err) {
+		dev_err(dev, "failed to register ARM MHUv2 driver %d\n", err);
+		iounmap(mhuv2->frame == RECEIVER_FRAME ? mhuv2->reg.recv :
+							 mhuv2->reg.send);
+		return err;
+	}
+
+	dev_info(dev, "ARM MHUv2 %s frame (%s) Mailbox driver registered\n",
+		 mhuv2_frame_dt_identifiers[mhuv2->frame],
+		 mhuv2_protocol_dt_identifiers[mhuv2->protocol]);
+
+	return 0;
+
+io_fail:
+	dev_err(dev, "Probe failed: failed to map '%s' frame\n",
+		mhuv2_frame_dt_identifiers[mhuv2->frame]);
+	iounmap(mhuv2->frame == RECEIVER_FRAME ? mhuv2->reg.recv :
+						 mhuv2->reg.send);
+	return -ENOMEM;
+}
+
+static int mhuv2_remove(struct amba_device *adev)
+{
+	return 0;
+}
+
+static struct amba_id mhuv2_ids[] = {
+	{
+		.id = 0x4b0d1,
+		.mask = 0xfffff,
+	},
+	{
+		.id = 0xbb0d1,
+		.mask = 0xfffff,
+	},
+	{ 0, 0 },
+};
+MODULE_DEVICE_TABLE(amba, mhuv2_ids);
+
+static struct amba_driver arm_mhuv2_driver = {
+	.drv = {
+		.name	= "mhuv2",
+	},
+	.id_table	= mhuv2_ids,
+	.probe		= mhuv2_probe,
+	.remove		= mhuv2_remove,
+};
+module_amba_driver(arm_mhuv2_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ARM MHUv2 Driver");
+MODULE_AUTHOR("Morten Borup Petersen <morten.petersen@arm.com>");
diff --git a/include/linux/mailbox/arm-mbox-message.h b/include/linux/mailbox/arm-mbox-message.h
new file mode 100644
index 000000000000..112b4f927c1a
--- /dev/null
+++ b/include/linux/mailbox/arm-mbox-message.h
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arm Mailbox Message
+ *
+ * The Arm mailbox message structure is used to pass data- and length
+ * information between a mailbox client and mailbox controller, through the
+ * provided void* of the common mailbox frameworks send- and receive APIs.
+ *
+ * This will be utilized when a mailbox controller is able to transmit
+ * more than a single word within a transmission, allowing the controller
+ * to fully utilize its available resources.
+ * No message protocol is enforced through this structure - a utilizing mailbox
+ * client driver shall implement its own message protocol, which may then be
+ * transmitted through an arm_mbox_msg.
+ *
+ * Given a message protocol of size A and an arm_mbox_msg containing data of
+ * length B, a mailbox channel may callback with B < A. In this case, the
+ * message protocol driver must implement a state machine which allows for
+ * multiple callbacks that provides parts of a full message of size A. This
+ * state machine must account for, that the length of the arm_mbox_msg received
+ * may vary between callbacks based on the underlying hardware as well as the
+ * transmitted data.
+ *
+ * Copyright (C) 2019 Arm Ltd.
+ */
+
+#ifndef _LINUX_ARM_MBOX_MESSAGE_H_
+#define _LINUX_ARM_MBOX_MESSAGE_H_
+
+#include <linux/types.h>
+
+struct arm_mbox_msg {
+	void *data;
+	size_t len;
+};
+
+#endif /* _LINUX_ARM_MBOX_MESSAGE_H_ */
-- 
2.17.1

