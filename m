Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5897612E767
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 15:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgABOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 09:49:31 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:10820 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728528AbgABOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:49:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577976570; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=yaEmTej0js3FuB7EdcocLA416V4x2xwW3XHow1aQr+U=; b=YCRQ3h5I2IKFBhPxg6gCEDUIXgoUXZlXQwyoFRF8k1ic8YONKgyNGfqp7vNYIsCgvVZIQq4L
 J/ye2QjCDH7YTJQKxuIXqZeLPDXOC1l6Ohwey/dLbq32UBXXE06MZtpKV7GLD11GQggTTjL+
 uFELOlJSyTPNZ7hd/U43CnnjK98=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0e02f8.7faf2ba26618-smtp-out-n01;
 Thu, 02 Jan 2020 14:49:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B5A3C433A2; Thu,  2 Jan 2020 14:49:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDABCC433CB;
        Thu,  2 Jan 2020 14:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDABCC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        tientzu@chromium.org, seanpaul@chromium.org, rjliao@codeaurora.org,
        yshavit@google.com,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [RFC PATCH v1] Bluetooth: hci_qca: Collect controller memory dump during SSR
Date:   Thu,  2 Jan 2020 20:19:11 +0530
Message-Id: <20200102144911.8358-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will collect the ramdump of BT controller when hardware error event
received before rebooting the HCI layer. Before restarting a subsystem
or a process running on a subsystem, it is often required to request
either a subsystem or a process to perform proper cache dump and
software failure reason into a memory buffer which application
processor can retrieve afterwards. SW developers can often provide
initial investigation by looking into that debugging information.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 296 +++++++++++++++++++++++++++++++++++-
 1 file changed, 291 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b602ed01505b..9392cc7f9908 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/devcoredump.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
@@ -46,6 +47,7 @@
 #define IBS_BTSOC_TX_IDLE_TIMEOUT_MS	40
 #define IBS_HOST_TX_IDLE_TIMEOUT_MS	2000
 #define CMD_TRANS_TIMEOUT_MS		100
+#define MEMDUMP_TIMEOUT_MS		8000
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -53,12 +55,21 @@
 /* Controller debug log header */
 #define QCA_DEBUG_HANDLE	0x2EDC
 
+/* Controller dump header */
+#define QCA_SSR_DUMP_HANDLE		0x0108
+#define QCA_DUMP_PACKET_SIZE		255
+#define QCA_LAST_SEQUENCE_NUM		0xFFFF
+#define QCA_CRASHBYTE_PACKET_LEN	1096
+#define QCA_MEMDUMP_BYTE		0xFB
+
 enum qca_flags {
 	QCA_IBS_ENABLED,
 	QCA_DROP_VENDOR_EVENT,
 	QCA_SUSPENDING,
+	QCA_MEMDUMP_COLLECTION
 };
 
+
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
 	HCI_IBS_TX_ASLEEP,
@@ -81,11 +92,40 @@ enum hci_ibs_clock_state_vote {
 	HCI_IBS_RX_VOTE_CLOCK_OFF,
 };
 
+/* Controller memory dump states */
+enum qca_memdump_states {
+	QCA_MEMDUMP_IDLE,
+	QCA_MEMDUMP_COLLECTING,
+	QCA_MEMDUMP_COLLECTED,
+	QCA_MEMDUMP_TIMEOUT,
+};
+
+struct qca_memdump_data {
+	char *memdump_buf_head;
+	char *memdump_buf_tail;
+	u32 current_seq_no;
+	u32 received_dump;
+};
+
+struct qca_memdump_event_hdr {
+	__u8    evt;
+	__u8    plen;
+	__u16   opcode;
+	__u16   seq_no;
+	__u8    reserved;
+} __packed;
+
+
+struct qca_dump_size {
+	u32 dump_size;
+} __packed;
+
 struct qca_data {
 	struct hci_uart *hu;
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 	struct sk_buff_head tx_wait_q;	/* HCI_IBS wait queue	*/
+	struct sk_buff_head rx_memdump_q;	/* Memdump wait queue	*/
 	spinlock_t hci_ibs_lock;	/* HCI_IBS state lock	*/
 	u8 tx_ibs_state;	/* HCI_IBS transmit side power state*/
 	u8 rx_ibs_state;	/* HCI_IBS receive side power state */
@@ -95,14 +135,18 @@ struct qca_data {
 	u32 tx_idle_delay;
 	struct timer_list wake_retrans_timer;
 	u32 wake_retrans;
+	struct timer_list memdump_timer;
 	struct workqueue_struct *workqueue;
 	struct work_struct ws_awake_rx;
 	struct work_struct ws_awake_device;
 	struct work_struct ws_rx_vote_off;
 	struct work_struct ws_tx_vote_off;
+	struct work_struct ctrl_memdump_evt;
+	struct qca_memdump_data *qca_memdump;
 	unsigned long flags;
 	struct completion drop_ev_comp;
 	wait_queue_head_t suspend_wait_q;
+	enum qca_memdump_states memdump_state;
 
 	/* For debugging purpose */
 	u64 ibs_sent_wacks;
@@ -167,6 +211,7 @@ static int qca_regulator_enable(struct qca_serdev *qcadev);
 static void qca_regulator_disable(struct qca_serdev *qcadev);
 static void qca_power_shutdown(struct hci_uart *hu);
 static int qca_power_off(struct hci_dev *hdev);
+static void qca_controller_memdump(struct work_struct *work);
 
 static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
 {
@@ -474,6 +519,23 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
 		hci_uart_tx_wakeup(hu);
 }
 
+static void hci_memdump_timeout(struct timer_list *t)
+{
+	struct qca_data *qca = from_timer(qca, t, tx_idle_timer);
+	struct hci_uart *hu = qca->hu;
+	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
+	char *memdump_buf = qca_memdump->memdump_buf_tail;
+
+	bt_dev_err(hu->hdev, "clearing allocated memory due to memdump timeout");
+	/* Inject hw error event to reset the device and driver. */
+	hci_reset_dev(hu->hdev);
+	kfree(memdump_buf);
+	kfree(qca_memdump);
+	qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
+	del_timer(&qca->memdump_timer);
+	cancel_work_sync(&qca->ctrl_memdump_evt);
+}
+
 /* Initialize protocol */
 static int qca_open(struct hci_uart *hu)
 {
@@ -492,6 +554,7 @@ static int qca_open(struct hci_uart *hu)
 
 	skb_queue_head_init(&qca->txq);
 	skb_queue_head_init(&qca->tx_wait_q);
+	skb_queue_head_init(&qca->rx_memdump_q);
 	spin_lock_init(&qca->hci_ibs_lock);
 	qca->workqueue = alloc_ordered_workqueue("qca_wq", 0);
 	if (!qca->workqueue) {
@@ -504,7 +567,7 @@ static int qca_open(struct hci_uart *hu)
 	INIT_WORK(&qca->ws_awake_device, qca_wq_awake_device);
 	INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
 	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
-
+	INIT_WORK(&qca->ctrl_memdump_evt, qca_controller_memdump);
 	init_waitqueue_head(&qca->suspend_wait_q);
 
 	qca->hu = hu;
@@ -544,6 +607,7 @@ static int qca_open(struct hci_uart *hu)
 
 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
 	qca->tx_idle_delay = IBS_HOST_TX_IDLE_TIMEOUT_MS;
+	timer_setup(&qca->memdump_timer, hci_memdump_timeout, 0);
 
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
 	       qca->tx_idle_delay, qca->wake_retrans);
@@ -622,8 +686,10 @@ static int qca_close(struct hci_uart *hu)
 
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
+	skb_queue_purge(&qca->rx_memdump_q);
 	del_timer(&qca->tx_idle_timer);
 	del_timer(&qca->wake_retrans_timer);
+	del_timer(&qca->memdump_timer);
 	destroy_workqueue(qca->workqueue);
 	qca->hu = NULL;
 
@@ -900,6 +966,126 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
+static void qca_controller_memdump(struct work_struct *work)
+{
+	struct qca_data *qca = container_of(work, struct qca_data,
+					    ctrl_memdump_evt);
+	struct hci_uart *hu = qca->hu;
+	struct sk_buff *skb;
+	struct qca_memdump_event_hdr *cmd_hdr;
+	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
+	struct qca_dump_size *dump;
+	char *memdump_buf;
+	char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
+	u16 opcode, seq_no;
+	u32 dump_size;
+
+	while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
+
+		if (!qca_memdump) {
+			qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
+					      GFP_ATOMIC);
+			if (!qca_memdump)
+				return;
+
+			qca->qca_memdump = qca_memdump;
+		}
+
+		qca->memdump_state = QCA_MEMDUMP_COLLECTING;
+		cmd_hdr = (void *) skb->data;
+		opcode = __le16_to_cpu(cmd_hdr->opcode);
+		seq_no = __le16_to_cpu(cmd_hdr->seq_no);
+		skb_pull(skb, sizeof(struct qca_memdump_event_hdr));
+
+		if (!seq_no) {
+
+			/* This is the first frame of memdump packet from
+			 * the controller, Disable IBS to recevie dump
+			 * with out any interruption, ideally time required for
+			 * the controller to send the dump is 8 seconds. let us
+			 * start timer to handle this asynchronous activity.
+			 */
+			clear_bit(QCA_IBS_ENABLED, &qca->flags);
+			set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+			dump = (void *) skb->data;
+			dump_size = __le32_to_cpu(dump->dump_size);
+			if (!(dump_size)) {
+				bt_dev_err(hu->hdev, "Rx invalid memdump size");
+				kfree_skb(skb);
+				return;
+			}
+
+			bt_dev_info(hu->hdev, "QCA collecting dump of size:%u",
+				    dump_size);
+			mod_timer(&qca->memdump_timer, (jiffies +
+				  msecs_to_jiffies(MEMDUMP_TIMEOUT_MS)));
+
+			skb_pull(skb, sizeof(dump_size));
+			memdump_buf = vmalloc(dump_size);
+			qca_memdump->memdump_buf_head = memdump_buf;
+			qca_memdump->memdump_buf_tail = memdump_buf;
+		}
+
+		memdump_buf = qca_memdump->memdump_buf_tail;
+
+		/* If sequence no 0 is missed then there is no point in
+		 * accepting the other sequences.
+		 */
+		if (!memdump_buf) {
+			bt_dev_err(hu->hdev, "QCA: Discarding other packets");
+			kfree(qca_memdump);
+			kfree_skb(skb);
+			qca->qca_memdump = NULL;
+			return;
+		}
+
+		/* There could be chance of missing some packets from
+		 * the controller. In such cases let us store the dummy
+		 * packets in the buffer.
+		 */
+		while ((seq_no > qca_memdump->current_seq_no + 1) &&
+			seq_no != QCA_LAST_SEQUENCE_NUM) {
+			bt_dev_err(hu->hdev, "QCA controller missed packet:%d",
+				   qca_memdump->current_seq_no);
+			memcpy(memdump_buf, nullBuff, QCA_DUMP_PACKET_SIZE);
+			memdump_buf = memdump_buf + QCA_DUMP_PACKET_SIZE;
+			qca_memdump->received_dump += QCA_DUMP_PACKET_SIZE;
+			qca_memdump->current_seq_no++;
+		}
+
+		memcpy(memdump_buf, (unsigned char *) skb->data, skb->len);
+		memdump_buf = memdump_buf + skb->len;
+		qca_memdump->memdump_buf_tail = memdump_buf;
+		qca_memdump->current_seq_no = seq_no + 1;
+		qca_memdump->received_dump += skb->len;
+		qca->qca_memdump = qca_memdump;
+		kfree_skb(skb);
+		if (seq_no == QCA_LAST_SEQUENCE_NUM) {
+			bt_dev_info(hu->hdev, "QCA writing crash dump of size %d bytes",
+				   qca_memdump->received_dump);
+			memdump_buf = qca_memdump->memdump_buf_head;
+			dev_coredumpv(&hu->serdev->dev, memdump_buf,
+				      qca_memdump->received_dump, GFP_KERNEL);
+			del_timer(&qca->memdump_timer);
+			kfree(qca->qca_memdump);
+			qca->qca_memdump = NULL;
+			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
+		}
+	}
+
+}
+
+int qca_controller_memdump_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+
+	skb_queue_tail(&qca->rx_memdump_q, skb);
+	queue_work(qca->workqueue, &qca->ctrl_memdump_evt);
+
+	return 0;
+}
+
 static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
@@ -925,6 +1111,14 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 
 		return 0;
 	}
+	/* We receive chip memory dump as an event packet, With a dedicated
+	 * handler followed by a hardware error event. When this event is
+	 * received we store dump into a file before closing hci. This
+	 * dump will help in triaging the issues.
+	 */
+	if ((skb->data[0] == HCI_VENDOR_PKT) &&
+	    (get_unaligned_be16(skb->data + 2) == QCA_SSR_DUMP_HANDLE))
+		return qca_controller_memdump_event(hdev, skb);
 
 	return hci_recv_frame(hdev, skb);
 }
@@ -1203,6 +1397,91 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 	return ret;
 }
 
+static int qca_send_crashbuffer(struct hci_uart *hu)
+{
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(QCA_CRASHBYTE_PACKET_LEN, GFP_KERNEL);
+	if (!skb) {
+		bt_dev_err(hu->hdev, "Failed to allocate memory for skb packet");
+		return -ENOMEM;
+	}
+
+	/* We forcefully crash the controller, by sending 0xfb byte for
+	 * 1024 times. We also might have chance of losing data, To be
+	 * on safer side we send 1096 bytes to the SoC.
+	 */
+	memset(skb_put(skb, QCA_CRASHBYTE_PACKET_LEN), QCA_MEMDUMP_BYTE,
+	       QCA_CRASHBYTE_PACKET_LEN);
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+	bt_dev_info(hu->hdev, "crash the soc to collect controller dump");
+	skb_queue_tail(&qca->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	return 0;
+}
+
+static void qca_wait_for_dump_collection(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
+	char *memdump_buf = NULL;
+
+	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
+			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+
+	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
+		bt_dev_err(hu->hdev, "Clearing the buffers due to timeout");
+		if (qca_memdump)
+			memdump_buf = qca_memdump->memdump_buf_tail;
+		kfree(memdump_buf);
+		kfree(qca_memdump);
+		qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
+		del_timer(&qca->memdump_timer);
+		cancel_work_sync(&qca->ctrl_memdump_evt);
+	}
+}
+
+static void qca_hw_error(struct hci_dev *hdev, u8 code)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+
+	bt_dev_info(hdev, "mem_dump_status: %d", qca->memdump_state);
+
+	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
+		/* If hardware error event received for other than QCA
+		 * soc memory dump event, then we need to crash the SOC
+		 * and wait here for 8 seconds to get the dump packets.
+		 * This will block main thread to be on hold until we
+		 * collect dump.
+		 */
+		set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+		qca_send_crashbuffer(hu);
+		qca_wait_for_dump_collection(hdev);
+	} else if (qca->memdump_state == QCA_MEMDUMP_COLLECTING) {
+		/* Let us wait here until memory dump collected or
+		 * memory dump timer expired.
+		 */
+		bt_dev_info(hdev, "waiting for dump to complete");
+		qca_wait_for_dump_collection(hdev);
+	}
+}
+
+static void qca_cmd_timeout(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+
+	if (qca->memdump_state == QCA_MEMDUMP_IDLE)
+		qca_send_crashbuffer(hu);
+	else
+		bt_dev_info(hdev, "Dump collection is in process");
+}
+
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
@@ -1320,6 +1599,8 @@ static int qca_setup(struct hci_uart *hu)
 	if (!ret) {
 		set_bit(QCA_IBS_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
+		hu->hdev->hw_error = qca_hw_error;
+		hu->hdev->cmd_timeout = qca_cmd_timeout;
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		ret = 0;
@@ -1408,17 +1689,22 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, false);
 	qca_regulator_disable(qcadev);
+	hu->hdev->hw_error = NULL;
+	hu->hdev->cmd_timeout = NULL;
 }
 
 static int qca_power_off(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
 
-	/* Perform pre shutdown command */
-	qca_send_pre_shutdown_cmd(hdev);
-
-	usleep_range(8000, 10000);
+	/* Stop sending shutdown command if soc crashes. */
+	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
+		qca_send_pre_shutdown_cmd(hdev);
+		usleep_range(8000, 10000);
+	}
 
+	qca->memdump_state = QCA_MEMDUMP_IDLE;
 	qca_power_shutdown(hu);
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
