Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7781319B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAFUsf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Jan 2020 15:48:35 -0500
Received: from mail-oln040092067019.outbound.protection.outlook.com ([40.92.67.19]:25550
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbgAFUsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:48:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di5ixYcudkZr062bOUemDgyD7jSPaG8yfMqpMpXzSXcLMCyRNpXdvS2AmIb4oQrilP5JvkMHqXxO/2ncB3kZLanLsp8N2PN0BcOVldcRjcrrwFZFYdsis/1JgKB4qGmTqHO2Tffm2ZUGPqjlYO7jQDf+j4vRiQhpE7YDNro3T55La5cSuOJM0h/f0ibl3N2NCtTqMqDRmMpVDRiwAyDRBtwFIMmyxXN6zKc95dWC3xVoEyyiqRmB0eGlX+atYwPFMFJ3fyeiQ/N5O0E0dDh+KMIao/vtjgIEjuia28aBpqY3tkccX6wtddJxxxnNIOUWX1P3OUQDln+95GrN69ytYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n41m/2M+iw6l5qfWXkDro4mxMirnRAXDbA/Qn5mD7I=;
 b=Ox+XJH/lm0F1Xv9Zktw72xBpTa77urMvRQ9aRAoSdH5HvHS0MLDcbdEDXaj88JGRfu8mhy7Aq30bd9t31C7GNlshtBulzsDYYAhzcV9v2Z1kRiCQnFIq/ETjZvE6oMvRnTNg6wIzBigOZ1rqJVmuEwmtODywrZQlMX8PcwkmqoWVFryQA2LDgMTj0cgLGCpU2yj9g1nQAdVNNrn3MtpsiTKUAYTv743v+rtkCyaBp2pMyd8q2tXAcsrrJ8i1NMHKDF6qIeNcvYXu7e/Whp+//YNwIQWYYfLFE/e+4wxQDTuriNHXO8Sm9/10iUtTqtTXrSSMws517U6hKG/sm253Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (10.152.12.53) by VE1EUR02HT192.eop-EUR02.prod.protection.outlook.com
 (10.152.12.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 20:48:28 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.12.60) by
 VE1EUR02FT060.mail.protection.outlook.com (10.152.13.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 20:48:28 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 20:48:28 +0000
Received: from bionic.localdomain (98.128.173.80) by BEXP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 20:48:27 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
CC:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zheng Yang <zhengyang@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/15] drm/rockchip: dw-hdmi: require valid vpll clock rate on
 rk3228/rk3328
Thread-Topic: [PATCH 08/15] drm/rockchip: dw-hdmi: require valid vpll clock
 rate on rk3228/rk3328
Thread-Index: AQHVxNKmR0W4jadvKEivva24BcWyzA==
Date:   Mon, 6 Jan 2020 20:48:28 +0000
Message-ID: <HE1PR06MB40113EA5E91DEEE586D39815AC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20200106204812.5944-1-jonas@kwiboo.se>
In-Reply-To: <20200106204812.5944-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BEXP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::14)
 To HE1PR06MB4011.eurprd06.prod.outlook.com (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:A19395B89A6FDC5BAC83C828B43BC340A6BED94B82C857ED840F0AA645130AAF;UpperCasedChecksum:2215834707270EE1F4BDD38E5C7BA058E95F825CD6E175881542BFFD03ACCE68;SizeAsReceived:8182;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [jpV+WYEymag5cXeXiRWDP9ASJiKwaDQS]
x-microsoft-original-message-id: <20200106204812.5944-4-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6b4bedf2-9790-4191-7d7e-08d792e9c83a
x-ms-traffictypediagnostic: VE1EUR02HT192:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Otsz4tjX/uZXFCyS0p5O4I2pRY746/q74SJP0bxD/CJ9igdxd/GKbWDvBDHFrvPHAclC349UYOzMCaqPCDkeCP926NEYoxbVwzseeLR/CT82E/WGiYqYVYOKo//z1H95iKpAM4qQV8Haaj1PHdbXfMslGikhxV6oJMe5MWxO4hIdViSO3JaF7FQZHcQNbuY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4bedf2-9790-4191-7d7e-08d792e9c83a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 20:48:28.6292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3228/RK3328 can only support clock rates defined in the pre pll table.
Lets validate the mode clock rate against the pre pll config and filter
out any mode with a clock rate returning error from clk_round_rate().

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index fae38b323a0c..45fcdce3f27f 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -245,6 +245,22 @@ static void dw_hdmi_rockchip_encoder_disable(struct drm_encoder *encoder)
 {
 }
 
+static enum drm_mode_status
+dw_hdmi_rockchip_encoder_mode_valid(struct drm_encoder *encoder,
+				    const struct drm_display_mode *mode)
+{
+	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
+	long rate;
+
+	if (hdmi->vpll_clk) {
+		rate = clk_round_rate(hdmi->vpll_clk, mode->clock * 1000);
+		if (rate < 0)
+			return MODE_CLOCK_RANGE;
+	}
+
+	return MODE_OK;
+}
+
 static bool
 dw_hdmi_rockchip_encoder_mode_fixup(struct drm_encoder *encoder,
 				    const struct drm_display_mode *mode,
@@ -306,6 +322,7 @@ dw_hdmi_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
+	.mode_valid = dw_hdmi_rockchip_encoder_mode_valid,
 	.mode_fixup = dw_hdmi_rockchip_encoder_mode_fixup,
 	.mode_set   = dw_hdmi_rockchip_encoder_mode_set,
 	.enable     = dw_hdmi_rockchip_encoder_enable,
-- 
2.17.1

