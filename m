Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAB79AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbfG2VPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388767AbfG2VPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF05A2073F;
        Mon, 29 Jul 2019 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434932;
        bh=2Zs67whJ+85SJ2uOz8DdSbMk8H9EJiYZv9dXUnkcVnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJLvRHmdvhLeHQ2Z/I/zfmOofTcEZeorPnUntzGI0Y+myD4HEgydqQNNUP2fo6fmC
         +nezygGcrrNjARB1Cf0q+L56TemGOoIxeib9Qeomgl1W6elYkHdYz/WwOhJMaJ6Xjx
         hoBXbmvoqQuMR46bg5GJ40Aj87su3QeghFRZBS7E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Vincent Bernat <vincent@bernat.ch>
Subject: [PATCH 08/12] tools headers UAPI: Sync if_link.h with the kernel
Date:   Mon, 29 Jul 2019 18:14:55 -0300
Message-Id: <20190729211456.6380-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes in:

  07a4ddec3ce9 ("bonding: add an option to specify a delay between peer notifications")

And silence this build warning:

  Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vincent Bernat <vincent@bernat.ch>
Link: https://lkml.kernel.org/n/tip-3liw4exxh8goc0rq9xryl2kv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7d113a9602f0..4a8c02cafa9a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -695,6 +695,7 @@ enum {
 	IFLA_VF_IB_NODE_GUID,	/* VF Infiniband node GUID */
 	IFLA_VF_IB_PORT_GUID,	/* VF Infiniband port GUID */
 	IFLA_VF_VLAN_LIST,	/* nested list of vlans, option for QinQ */
+	IFLA_VF_BROADCAST,	/* VF broadcast */
 	__IFLA_VF_MAX,
 };
 
@@ -705,6 +706,10 @@ struct ifla_vf_mac {
 	__u8 mac[32]; /* MAX_ADDR_LEN */
 };
 
+struct ifla_vf_broadcast {
+	__u8 broadcast[32];
+};
+
 struct ifla_vf_vlan {
 	__u32 vf;
 	__u32 vlan; /* 0 - 4095, 0 disables VLAN filter */
-- 
2.21.0

