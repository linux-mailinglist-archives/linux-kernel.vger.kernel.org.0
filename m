Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FB1A9E9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 03:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfELBZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 21:25:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54448 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfELBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:36 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so15169744ite.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+nUFC6cQZFpp93OxhMjcDjllvqEhXm9UXJsgqoN5M8=;
        b=E7CHoWWnRQG59dHc5bUpoWUurm4hXo08RZmITK2SNTmiK50TGKto2egX8/xK7wHQPU
         ToGztGT+rmQ2Bit5wy2gjUWoJQyF5OG8VuRqJynHgBDOwB9eF9iB1/CZ31LTVE3wFJCm
         F/RZFS6r6105PQg0bArYNKu5DCxRA+fcCrfgy6PDRNn8UlxBogrUiTvSZQ0NrfjAW5xu
         GVerLROy40zPEgVZ3YVsLZEAvvtrpkrwVo1Dd+40ieBq034K1gn6o3zSAIXbvC2EaDoM
         1FYrjWXwPBwEePDGpbkng6H9rQkTtkFnWQu7GQoSl4t+UMDiLCgP5MGOfOt1mgC5guQW
         dBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+nUFC6cQZFpp93OxhMjcDjllvqEhXm9UXJsgqoN5M8=;
        b=n+6i++tUM2elcHaW45JWCkzaMlmqfc5e4n/ZGTFEfKB25rGDu7JH4UhmRT65SIhLzI
         wdpB/mtFcUIc3cZ59HDULSdQMUszLI6+Xth1s6yCKZfP5V5AgcfcVgpEIYHdakzOPLmE
         HVp3fdTRHGGmFC0jL3+D9WQ76cXL7QR7FUaJMWdB2UjMaPA3TofZT6ZVB0a/UMyqFyIF
         RNm/Yjmg/77UkwHRygybsldnB6GR55TAM21J/kz9RFfbzHC1f+Ixywwtp2AZhd46hwtP
         2VCrzqrehDBl2oHRnQnJ6ggCZuNmOjzKnm8UXGT/jWKm5e6KYb+l8k8Ow5cKZ1zq5t7T
         ohNg==
X-Gm-Message-State: APjAAAWJ+g8qB8ABoC+YB1TZE5nvCCFdg0HBd0OqjkOGZNPnTSlh2Jur
        DIM+1kDNxY9KsvfdwTw71bBopg==
X-Google-Smtp-Source: APXvYqx2oL+gPbPYVww6vDwWfPBI9Hxp8YCt7SKvi5CfQ4kS37kIzym47XGPiOJkZOWvFW7uyUTAlw==
X-Received: by 2002:a24:9d46:: with SMTP id f67mr13250586itd.58.1557624334635;
        Sat, 11 May 2019 18:25:34 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:34 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 05/18] soc: qcom: ipa: configuration data
Date:   Sat, 11 May 2019 20:24:55 -0500
Message-Id: <20190512012508.10608-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines configuration data that is used to specify some
of the details of IPA hardware supported by the driver.  It is built
as Device Tree match data, discovered at boot time.  Initially the
driver only supports the Qualcomm SDM845 SoC.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sdm845.c | 245 +++++++++++++++++++++++++++
 drivers/net/ipa/ipa_data.h        | 267 ++++++++++++++++++++++++++++++
 2 files changed, 512 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_data-sdm845.c
 create mode 100644 drivers/net/ipa/ipa_data.h

diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
new file mode 100644
index 000000000000..62c0f25f5161
--- /dev/null
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/log2.h>
+
+#include "gsi.h"
+#include "ipa_data.h"
+#include "ipa_endpoint.h"
+
+/* Differentiate Boolean from numerical options */
+#define NO	0
+#define YES	1
+
+/* Endpoint configuration for the SDM845 SoC. */
+static const struct gsi_ipa_endpoint_data gsi_ipa_endpoint_data[] = {
+	{
+		.ee_id		= GSI_EE_AP,
+		.channel_id	= 4,
+		.endpoint_id	= IPA_ENDPOINT_AP_COMMAND_TX,
+		.toward_ipa	= YES,
+		.channel = {
+			.tlv_count	= 20,
+			.wrr_priority	= YES,
+			.tre_count	= 256,
+			.event_count	= 512,
+		},
+		.endpoint = {
+			.seq_type	= IPA_SEQ_DMA_ONLY,
+			.config = {
+				.dma_mode	= YES,
+				.dma_endpoint	= IPA_ENDPOINT_AP_LAN_RX,
+			},
+		},
+	},
+	{
+		.ee_id		= GSI_EE_AP,
+		.channel_id	= 5,
+		.endpoint_id	= IPA_ENDPOINT_AP_LAN_RX,
+		.toward_ipa	= NO,
+		.channel = {
+			.tlv_count	= 8,
+			.tre_count	= 256,
+			.event_count	= 256,
+		},
+		.endpoint = {
+			.seq_type	= IPA_SEQ_INVALID,
+			.config = {
+				.checksum	= YES,
+				.aggregation	= YES,
+				.status_enable	= YES,
+				.rx = {
+					.pad_align	= ilog2(sizeof(u32)),
+				},
+			},
+		},
+	},
+	{
+		.ee_id		= GSI_EE_AP,
+		.channel_id	= 3,
+		.endpoint_id	= IPA_ENDPOINT_AP_MODEM_TX,
+		.toward_ipa	= YES,
+		.channel = {
+			.tlv_count	= 16,
+			.tre_count	= 512,
+			.event_count	= 512,
+		},
+		.endpoint = {
+			.support_flt	= YES,
+			.seq_type	=
+				IPA_SEQ_2ND_PKT_PROCESS_PASS_NO_DEC_UCP,
+			.config = {
+				.checksum	= YES,
+				.qmap		= YES,
+				.status_enable	= YES,
+				.tx = {
+					.delay	= YES,
+					.status_endpoint =
+						IPA_ENDPOINT_MODEM_AP_RX,
+				},
+			},
+		},
+	},
+	{
+		.ee_id		= GSI_EE_AP,
+		.channel_id	= 6,
+		.endpoint_id	= IPA_ENDPOINT_AP_MODEM_RX,
+		.toward_ipa	= NO,
+		.channel = {
+			.tlv_count	= 8,
+			.tre_count	= 256,
+			.event_count	= 256,
+		},
+		.endpoint = {
+			.seq_type	= IPA_SEQ_INVALID,
+			.config = {
+				.checksum	= YES,
+				.qmap		= YES,
+				.aggregation	= YES,
+				.rx = {
+					.aggr_close_eof	= YES,
+				},
+			},
+		},
+	},
+	{
+		.ee_id		= GSI_EE_MODEM,
+		.channel_id	= 1,
+		.endpoint_id	= IPA_ENDPOINT_MODEM_COMMAND_TX,
+		.toward_ipa	= YES,
+		.endpoint = {
+			.seq_type	= IPA_SEQ_PKT_PROCESS_NO_DEC_UCP,
+		},
+	},
+	{
+		.ee_id		= GSI_EE_MODEM,
+		.channel_id	= 0,
+		.endpoint_id	= IPA_ENDPOINT_MODEM_LAN_TX,
+		.toward_ipa	= YES,
+		.endpoint = {
+			.support_flt	= YES,
+		},
+	},
+	{
+		.ee_id		= GSI_EE_MODEM,
+		.channel_id	= 3,
+		.endpoint_id	= IPA_ENDPOINT_MODEM_LAN_RX,
+		.toward_ipa	= NO,
+	},
+	{
+		.ee_id		= GSI_EE_MODEM,
+		.channel_id	= 4,
+		.endpoint_id	= IPA_ENDPOINT_MODEM_AP_TX,
+		.toward_ipa	= YES,
+		.endpoint = {
+			.support_flt	= YES,
+		},
+	},
+	{
+		.ee_id		= GSI_EE_MODEM,
+		.channel_id	= 2,
+		.endpoint_id	= IPA_ENDPOINT_MODEM_AP_RX,
+		.toward_ipa	= NO,
+	},
+};
+
+static const struct ipa_resource_src ipa_resource_src[] = {
+	{
+		.type = IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS,
+		.limits[IPA_RESOURCE_GROUP_LWA_DL] = {
+			.min = 1,
+			.max = 63,
+		},
+		.limits[IPA_RESOURCE_GROUP_UL_DL] = {
+			.min = 1,
+			.max = 63,
+		},
+	},
+	{
+		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS,
+		.limits[IPA_RESOURCE_GROUP_LWA_DL] = {
+			.min = 10,
+			.max = 10,
+		},
+		.limits[IPA_RESOURCE_GROUP_UL_DL] = {
+			.min = 10,
+			.max = 10,
+		},
+	},
+	{
+		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_BUFF,
+		.limits[IPA_RESOURCE_GROUP_LWA_DL] = {
+			.min = 12,
+			.max = 12,
+		},
+		.limits[IPA_RESOURCE_GROUP_UL_DL] = {
+			.min = 14,
+			.max = 14,
+		},
+	},
+	{
+		.type = IPA_RESOURCE_TYPE_SRC_HPS_DMARS,
+		.limits[IPA_RESOURCE_GROUP_LWA_DL] = {
+			.min = 0,
+			.max = 63,
+		},
+		.limits[IPA_RESOURCE_GROUP_UL_DL] = {
+			.min = 0,
+			.max = 63,
+		},
+	},
+	{
+		.type = IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES,
+		.limits[IPA_RESOURCE_GROUP_LWA_DL] = {
+			.min = 14,
+			.max = 14,
+		},
+		.limits[IPA_RESOURCE_GROUP_UL_DL] = {
+			.min = 20,
+			.max = 20,
+		},
+	},
+};
+
+static const struct ipa_resource_dst ipa_resource_dst[] = {
+	{
+		.type = IPA_RESOURCE_TYPE_DST_DATA_SECTORS,
+		.limits[IPA_RESOURCE_GROUP_LWA_DL] = {
+			.min = 4,
+			.max = 4,
+		},
+		.limits[IPA_RESOURCE_GROUP_UL_DL] = {
+			.min = 4,
+			.max = 4,
+		},
+	},
+	{
+		.type = IPA_RESOURCE_TYPE_DST_DPS_DMARS,
+		.limits[IPA_RESOURCE_GROUP_LWA_DL] = {
+			.min = 2,
+			.max = 63,
+		},
+		.limits[IPA_RESOURCE_GROUP_UL_DL] = {
+			.min = 1,
+			.max = 63,
+		},
+	},
+};
+
+/* Resource configuration for the SDM845 SoC. */
+static const struct ipa_resource_data ipa_resource_data = {
+	.resource_src		= ipa_resource_src,
+	.resource_src_count	= ARRAY_SIZE(ipa_resource_src),
+	.resource_dst		= ipa_resource_dst,
+	.resource_dst_count	= ARRAY_SIZE(ipa_resource_dst),
+};
+
+/* Configuration data for the SDM845 SoC. */
+const struct ipa_data ipa_data_sdm845 = {
+	.endpoint_data		= gsi_ipa_endpoint_data,
+	.endpoint_data_count	= ARRAY_SIZE(gsi_ipa_endpoint_data),
+	.resource_data		= &ipa_resource_data,
+};
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
new file mode 100644
index 000000000000..f7669f73efc3
--- /dev/null
+++ b/drivers/net/ipa/ipa_data.h
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+#ifndef _IPA_DATA_H_
+#define _IPA_DATA_H_
+
+#include <linux/types.h>
+
+#include "ipa_endpoint.h"
+
+/**
+ * DOC: IPA/GSI Configuration Data
+ *
+ * Boot-time configuration data is used to define the configuration of the
+ * IPA and GSI resources to use for a given platform.  This data is supplied
+ * via the Device Tree match table, associated with a particular compatible
+ * string.  The data defines information about resources, endpoints, and
+ * channels.  For endpoints and channels, the configuration data defines how
+ * these hardware entities are initially configured, but in almost all cases,
+ * this configuration never changes.
+ *
+ * Resources are data structures used internally by the IPA hardware.  The
+ * configuration data defines the number (or limits of the number) of various
+ * types of these resources.
+ *
+ * Endpoint configuration data defines properties of both IPA endpoints and
+ * GSI channels.  A channel is a GSI construct, and represents a single
+ * communication path between the IPA and a particular execution environment
+ * (EE), such as the AP or Modem.  Each EE has a set of channels associated
+ * with it, and each channel has an ID unique for that EE.  Only GSI channels
+ * associated with the AP are of concern to this driver.
+ *
+ * An endpoint is an IPA construct representing a single channel anywhere
+ * within the system.  As such, an IPA endpoint ID maps directly to an
+ * (EE, channel_id) pair.  Generally, this driver is concerned with only
+ * endpoints associated with the AP, however this will change when support
+ * for routing (etc.) is added.  IPA endpoint and GSI channel configuration
+ * data are defined together, establishing the endpoint_id->(EE, channel_id)
+ * mapping.
+ *
+ * Endpoint configuration data consists of three parts:  properties that
+ * are common to IPA and GSI (EE ID, channel ID, endpoint ID, and direction);
+ * properties associated with the GSI channel; and properties associated with
+ * the IPA endpoint.
+ */
+
+/**
+ * struct gsi_channel_data - GSI channel configuration data
+ * @tlv_count:		number of entries in channel's TLV FIFO
+ * @wrr_priority:	whether channel gets priority (AP command TX only)
+ * @tre_count:		number of TREs in the channel ring
+ * @event_count:	number of slots in the associated event ring
+ *
+ * A GSI channel is a unidirectional means of transferring data to or from
+ * (and through) the IPA.  A GSI channel has a fixed number of "transfer
+ * elements" (TREs) that specify individual commands.  A set of commands
+ * are provided to a GSI channel, and when they complete the GSI generates
+ * an event (and an interrupt) to signal their completion.  These event
+ * structures are managed in a fixed-size event ring.
+ *
+ * Each GSI channel is fed by a FIFO if type/length/value (TLV) structures,
+ * and the number of entries in this FIFO limits the number of TREs that can
+ * be included in a single transaction.
+ *
+ * The GSI does weighted round-robin servicing of its channels, and it's
+ * possible to adjust a channel's priority of service.  Only the AP command
+ * TX channel specifies that it should get priority.
+ */
+struct gsi_channel_data {
+	u32 tlv_count;
+
+	u32 wrr_priority;
+	u32 tre_count;
+	u32 event_count;
+};
+
+/**
+ * struct ipa_endpoint_tx_data - configuration data for TX endpoints
+ * @delay:		whether endpoint starts in delay mode
+ * @status_endpoint:	endpoint to which status elements are sent
+ *
+ * Delay mode prevents an endpoint from transmitting anything, even if
+ * commands have been presented to the hardware.  Once the endpoint exits
+ * delay mode, queued transfer commands are sent.
+ *
+ * The @status_endpoint is only valid if the endpoint's @status_enable
+ * flag is set.
+ */
+struct ipa_endpoint_tx_data {
+	u32 delay;
+	enum ipa_endpoint_id status_endpoint;
+};
+
+/**
+ * struct ipa_endpoint_rx_data - configuration data for RX endpoints
+ * @pad_align:	power-of-2 boundary to which packet payload is aligned
+ * @aggr_close_eof: whether aggregation closes on end-of-frame
+ *
+ * With each packet it transfers, the IPA hardware can perform certain
+ * transformations of its packet data.  One of these is adding pad bytes
+ * to the end of the packet data so the result ends on a power-of-2 boundary.
+ *
+ * It is also able to aggregate multiple packets into a single receive buffer.
+ * Aggregation is "open" while a buffer is being filled, and "closes" when
+ * certain criteria are met.  One of those criteria is the sender indicating
+ * a "frame" consisting of several transfers has ended.
+ */
+struct ipa_endpoint_rx_data {
+	u32 pad_align;
+	u32 aggr_close_eof;
+};
+
+/**
+ * struct ipa_endpoint_config_data - IPA endpoint hardware configuration
+ * @checksum:		whether checksum offload is enabled
+ * @qmap:		whether endpoint uses QMAP protocol
+ * @aggregation:	whether endpoint supports aggregation
+ * @dma_mode:		whether endpoint operates in DMA mode
+ * @dma_endpoint:	peer endpoint, if operating in DMA mode
+ * @status_enable:	whether status elements are generated for endpoint
+ * @tx:			TX-specific endpoint information (see above)
+ * @rx:			RX-specific endpoint information (see above)
+ */
+struct ipa_endpoint_config_data {
+	u32 checksum;
+	u32 qmap;
+	u32 aggregation;
+	u32 dma_mode;
+	enum ipa_endpoint_id dma_endpoint;
+	u32 status_enable;
+	union {
+		struct ipa_endpoint_tx_data tx;
+		struct ipa_endpoint_rx_data rx;
+	};
+};
+
+/**
+ * struct ipa_endpoint_data - IPA endpoint configuration data
+ * @support_flt:	whether endpoint supports filtering
+ * @seq_type:		hardware sequencer type used for endpoint
+ * @config:		hardware configuration (see above)
+ *
+ * Not all endpoints support the IPA filtering capability.  A filter table
+ * defines the filters to apply for those endpoints that support it.  The
+ * AP is responsible for initializing this table, and it must include entries
+ * for non-AP endpoints.  For this reason we define *all* endpoints used
+ * in the system, and indicate whether they support filtering.
+ *
+ * The remaining endpoint configuration data applies only to AP endpoints.
+ * The IPA hardware is implemented by sequencers, and the AP must program
+ * the type(s) of these sequencers at initialization time.  The remaining
+ * endpoint configuration data is defined above.
+ */
+struct ipa_endpoint_data {
+	u32 support_flt;
+	/* The rest are specified only for AP endpoints */
+	enum ipa_seq_type seq_type;
+	struct ipa_endpoint_config_data config;
+};
+
+/**
+ * struct gsi_ipa_endpoint_data - GSI channel/IPA endpoint data
+ * ee:		GSI execution environment ID
+ * channel_id:	GSI channel ID
+ * endpoint_id:	IPA endpoint ID
+ * toward_ipa:	direction of data transfer
+ * gsi:		GSI channel configuration data (see above)
+ * ipa:		IPA endpoint configuration data (see above)
+ */
+struct gsi_ipa_endpoint_data {
+	u32 ee_id;
+	u32 channel_id;
+	enum ipa_endpoint_id endpoint_id;
+	u32 toward_ipa;
+
+	struct gsi_channel_data channel;
+	struct ipa_endpoint_data endpoint;
+};
+
+/** enum ipa_resource_group - IPA resource group */
+enum ipa_resource_group {
+	IPA_RESOURCE_GROUP_LWA_DL,	/* currently not used */
+	IPA_RESOURCE_GROUP_UL_DL,
+	IPA_RESOURCE_GROUP_MAX,
+};
+
+/** enum ipa_resource_type_src - source resource types */
+enum ipa_resource_type_src {
+	IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS,
+	IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS,
+	IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_BUFF,
+	IPA_RESOURCE_TYPE_SRC_HPS_DMARS,
+	IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES,
+};
+
+/** enum ipa_resource_type_dst - destination resource types */
+enum ipa_resource_type_dst {
+	IPA_RESOURCE_TYPE_DST_DATA_SECTORS,
+	IPA_RESOURCE_TYPE_DST_DPS_DMARS,
+};
+
+/**
+ * struct ipa_resource_limits - minimum and maximum resource counts
+ * @min:	minimum number of resources of a given type
+ * @max:	maximum number of resources of a given type
+ */
+struct ipa_resource_limits {
+	u32 min;
+	u32 max;
+};
+
+/**
+ * struct ipa_resource_src - source endpoint group resource usage
+ * @type:	source group resource type
+ * @limits:	array of limits to use for each resource group
+ */
+struct ipa_resource_src {
+	enum ipa_resource_type_src type;
+	struct ipa_resource_limits limits[IPA_RESOURCE_GROUP_MAX];
+};
+
+/**
+ * struct ipa_resource_dst - destination endpoint group resource usage
+ * @type:	destination group resource type
+ * @limits:	array of limits to use for each resource group
+ */
+struct ipa_resource_dst {
+	enum ipa_resource_type_dst type;
+	struct ipa_resource_limits limits[IPA_RESOURCE_GROUP_MAX];
+};
+
+/**
+ * struct ipa_resource_data - IPA resource configuration data
+ * @resource_src:	source endpoint group resources
+ * @resource_src_count:	number of entries in the resource_src array
+ * @resource_dst:	destination endpoint group resources
+ * @resource_dst_count:	number of entries in the resource_dst array
+ *
+ * In order to manage quality of service between endpoints, certain resources
+ * required for operation are allocated to groups of endpoints.  Generally
+ * this information is invisible to the AP, but the AP is responsible for
+ * programming it at initialization time, so we specify it here.
+ */
+struct ipa_resource_data {
+	const struct ipa_resource_src *resource_src;
+	u32 resource_src_count;
+	const struct ipa_resource_dst *resource_dst;
+	u32 resource_dst_count;
+};
+
+/**
+ * struct ipa_data - combined IPA/GSI configuration data
+ * @resource_data:		IPA resource configuration data
+ * @endpoint_data:		IPA endpoint/GSI channel data
+ * @endpoint_data_count:	number of entries in endpoint_data array
+ */
+struct ipa_data {
+	const struct ipa_resource_data *resource_data;
+	const struct gsi_ipa_endpoint_data *endpoint_data;
+	u32 endpoint_data_count;	/* # entries in endpoint_data[] */
+};
+
+extern const struct ipa_data ipa_data_sdm845;
+
+#endif /* _IPA_DATA_H_ */
-- 
2.20.1

