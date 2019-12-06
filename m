Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212771157E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLFTqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 14:46:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39980 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLFTqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:46:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so3130333plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+TIHDUl/gaSB2s++Av6uzUU3/05b++7i1oMNzp6aKg=;
        b=Xug22u2ByNpfbmWXu+F5GupDZJI8WlM2+UMRTHOyDFG7uH+qv0nuIXZFpCuBP7eQPn
         iAI5sPgNzJFKcvxzzzqRjI9uXhhuSKVuNoPABmYwmO+On6M3K/H63zIS+gG39IfMo22t
         qRJEyPTcyzeflFn0RFEAuuKaem51se/m2IXWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+TIHDUl/gaSB2s++Av6uzUU3/05b++7i1oMNzp6aKg=;
        b=dYp2h70I9vZSp2w1ReaNQuEaIjYcwToeTI0WEE5+CicZBSAixmS1EjLojBKyEEtJNB
         8tRPEFXZC1RaZdCN6Y5U9OXmASjOSJQ8jaEY+RaYNKAT3TfVcrFMJn7isT5IjCYsgJTW
         BkvPuHKT1raNPvnRBButyzIR8BqLI8meslRWZ0lpNQNIF4JGXbs8O42upRXjtBmaMJNF
         1MbaoEDKq/GbWJZIt1GloLAW1IOpWVbQtwyWmywBg4OBNzzJPGzo/TSsox/kS4g75Ow2
         vL7wOPC6s0R4Q548A1ERomgMARb8XTSEEATX7p6/48ZNf5OaUC5s06uKl377VjK83DoG
         0gJg==
X-Gm-Message-State: APjAAAXObnie0JGwMFUDcxgSB4LCbCAjIlwFJIGpALiIjDeCl3bnboEi
        1NStowj+oxFeTLIftlRRmE9T0g==
X-Google-Smtp-Source: APXvYqx0vjxbEVrq9rmPk06CY73exM6rTXXflVrGzMGcSpyvWUK6ZAARiCXCGmEjsGYD/DZPbCTscw==
X-Received: by 2002:a17:90a:1696:: with SMTP id o22mr17503179pja.78.1575661613283;
        Fri, 06 Dec 2019 11:46:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id u18sm16316204pgi.44.2019.12.06.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 11:46:52 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>, dan.carpenter@oracle.com,
        solar@openwall.com, wangqize888888888@gmail.com,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: drop most magic numbers from mwifiex_process_tdls_action_frame()
Date:   Fri,  6 Dec 2019 11:45:35 -0800
Message-Id: <20191206194535.150179-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 1e58252e334d ("mwifiex: Fix heap overflow in
mmwifiex_process_tdls_action_frame()"),
mwifiex_process_tdls_action_frame() already had too many magic numbers.
But this commit just added a ton more, in the name of checking for
buffer overflows. That seems like a really bad idea.

Let's make these magic numbers a little less magic, by
(a) factoring out 'pos[1]' as 'ie_len'
(b) using 'sizeof' on the appropriate source or destination fields where
    possible, instead of bare numbers
(c) dropping redundant checks, per below.

Regarding redundant checks: the beginning of the loop has this:

                if (pos + 2 + pos[1] > end)
                        break;

but then individual 'case's include stuff like this:

 			if (pos > end - 3)
 				return;
 			if (pos[1] != 1)
				return;

Note that the second 'return' (validating the length, pos[1]) combined
with the above condition (ensuring 'pos + 2 + length' doesn't exceed
'end'), makes the first 'return' (whose 'if' can be reworded as 'pos >
end - pos[1] - 2') redundant. Rather than unwind the magic numbers
there, just drop those conditions.

Fixes: 1e58252e334d ("mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
AFAICT, the existing commit (1e58252e334d) isn't wrong, per se -- just
very poorly styled -- so this probably doesn't need to go to -stable.
Not sure if it's a candidate for wireless-drivers (where the original
commit currently sites) vs. wireless-drivers-next.

 drivers/net/wireless/marvell/mwifiex/tdls.c | 75 ++++++++-------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 7caf1d26124a..f8f282ce39bd 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -894,7 +894,7 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 	u8 *peer, *pos, *end;
 	u8 i, action, basic;
 	u16 cap = 0;
-	int ie_len = 0;
+	int ies_len = 0;
 
 	if (len < (sizeof(struct ethhdr) + 3))
 		return;
@@ -916,7 +916,7 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 		pos = buf + sizeof(struct ethhdr) + 4;
 		/* payload 1+ category 1 + action 1 + dialog 1 */
 		cap = get_unaligned_le16(pos);
-		ie_len = len - sizeof(struct ethhdr) - TDLS_REQ_FIX_LEN;
+		ies_len = len - sizeof(struct ethhdr) - TDLS_REQ_FIX_LEN;
 		pos += 2;
 		break;
 
@@ -926,7 +926,7 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 		/* payload 1+ category 1 + action 1 + dialog 1 + status code 2*/
 		pos = buf + sizeof(struct ethhdr) + 6;
 		cap = get_unaligned_le16(pos);
-		ie_len = len - sizeof(struct ethhdr) - TDLS_RESP_FIX_LEN;
+		ies_len = len - sizeof(struct ethhdr) - TDLS_RESP_FIX_LEN;
 		pos += 2;
 		break;
 
@@ -934,7 +934,7 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 		if (len < (sizeof(struct ethhdr) + TDLS_CONFIRM_FIX_LEN))
 			return;
 		pos = buf + sizeof(struct ethhdr) + TDLS_CONFIRM_FIX_LEN;
-		ie_len = len - sizeof(struct ethhdr) - TDLS_CONFIRM_FIX_LEN;
+		ies_len = len - sizeof(struct ethhdr) - TDLS_CONFIRM_FIX_LEN;
 		break;
 	default:
 		mwifiex_dbg(priv->adapter, ERROR, "Unknown TDLS frame type.\n");
@@ -947,33 +947,33 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 
 	sta_ptr->tdls_cap.capab = cpu_to_le16(cap);
 
-	for (end = pos + ie_len; pos + 1 < end; pos += 2 + pos[1]) {
-		if (pos + 2 + pos[1] > end)
+	for (end = pos + ies_len; pos + 1 < end; pos += 2 + pos[1]) {
+		u8 ie_len = pos[1];
+
+		if (pos + 2 + ie_len > end)
 			break;
 
 		switch (*pos) {
 		case WLAN_EID_SUPP_RATES:
-			if (pos[1] > 32)
+			if (ie_len > sizeof(sta_ptr->tdls_cap.rates))
 				return;
-			sta_ptr->tdls_cap.rates_len = pos[1];
-			for (i = 0; i < pos[1]; i++)
+			sta_ptr->tdls_cap.rates_len = ie_len;
+			for (i = 0; i < ie_len; i++)
 				sta_ptr->tdls_cap.rates[i] = pos[i + 2];
 			break;
 
 		case WLAN_EID_EXT_SUPP_RATES:
-			if (pos[1] > 32)
+			if (ie_len > sizeof(sta_ptr->tdls_cap.rates))
 				return;
 			basic = sta_ptr->tdls_cap.rates_len;
-			if (pos[1] > 32 - basic)
+			if (ie_len > sizeof(sta_ptr->tdls_cap.rates) - basic)
 				return;
-			for (i = 0; i < pos[1]; i++)
+			for (i = 0; i < ie_len; i++)
 				sta_ptr->tdls_cap.rates[basic + i] = pos[i + 2];
-			sta_ptr->tdls_cap.rates_len += pos[1];
+			sta_ptr->tdls_cap.rates_len += ie_len;
 			break;
 		case WLAN_EID_HT_CAPABILITY:
-			if (pos > end - sizeof(struct ieee80211_ht_cap) - 2)
-				return;
-			if (pos[1] != sizeof(struct ieee80211_ht_cap))
+			if (ie_len != sizeof(struct ieee80211_ht_cap))
 				return;
 			/* copy the ie's value into ht_capb*/
 			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + 2,
@@ -981,59 +981,45 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 			sta_ptr->is_11n_enabled = 1;
 			break;
 		case WLAN_EID_HT_OPERATION:
-			if (pos > end -
-			    sizeof(struct ieee80211_ht_operation) - 2)
-				return;
-			if (pos[1] != sizeof(struct ieee80211_ht_operation))
+			if (ie_len != sizeof(struct ieee80211_ht_operation))
 				return;
 			/* copy the ie's value into ht_oper*/
 			memcpy(&sta_ptr->tdls_cap.ht_oper, pos + 2,
 			       sizeof(struct ieee80211_ht_operation));
 			break;
 		case WLAN_EID_BSS_COEX_2040:
-			if (pos > end - 3)
-				return;
-			if (pos[1] != 1)
+			if (ie_len != sizeof(pos[2]))
 				return;
 			sta_ptr->tdls_cap.coex_2040 = pos[2];
 			break;
 		case WLAN_EID_EXT_CAPABILITY:
-			if (pos > end - sizeof(struct ieee_types_header))
-				return;
-			if (pos[1] < sizeof(struct ieee_types_header))
+			if (ie_len < sizeof(struct ieee_types_header))
 				return;
-			if (pos[1] > 8)
+			if (ie_len > 8)
 				return;
 			memcpy((u8 *)&sta_ptr->tdls_cap.extcap, pos,
 			       sizeof(struct ieee_types_header) +
-			       min_t(u8, pos[1], 8));
+			       min_t(u8, ie_len, 8));
 			break;
 		case WLAN_EID_RSN:
-			if (pos > end - sizeof(struct ieee_types_header))
+			if (ie_len < sizeof(struct ieee_types_header))
 				return;
-			if (pos[1] < sizeof(struct ieee_types_header))
-				return;
-			if (pos[1] > IEEE_MAX_IE_SIZE -
+			if (ie_len > IEEE_MAX_IE_SIZE -
 			    sizeof(struct ieee_types_header))
 				return;
 			memcpy((u8 *)&sta_ptr->tdls_cap.rsn_ie, pos,
 			       sizeof(struct ieee_types_header) +
-			       min_t(u8, pos[1], IEEE_MAX_IE_SIZE -
+			       min_t(u8, ie_len, IEEE_MAX_IE_SIZE -
 				     sizeof(struct ieee_types_header)));
 			break;
 		case WLAN_EID_QOS_CAPA:
-			if (pos > end - 3)
-				return;
-			if (pos[1] != 1)
+			if (ie_len != sizeof(pos[2]))
 				return;
 			sta_ptr->tdls_cap.qos_info = pos[2];
 			break;
 		case WLAN_EID_VHT_OPERATION:
 			if (priv->adapter->is_hw_11ac_capable) {
-				if (pos > end -
-				    sizeof(struct ieee80211_vht_operation) - 2)
-					return;
-				if (pos[1] !=
+				if (ie_len !=
 				    sizeof(struct ieee80211_vht_operation))
 					return;
 				/* copy the ie's value into vhtoper*/
@@ -1043,10 +1029,7 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
 			if (priv->adapter->is_hw_11ac_capable) {
-				if (pos > end -
-				    sizeof(struct ieee80211_vht_cap) - 2)
-					return;
-				if (pos[1] != sizeof(struct ieee80211_vht_cap))
+				if (ie_len != sizeof(struct ieee80211_vht_cap))
 					return;
 				/* copy the ie's value into vhtcap*/
 				memcpy((u8 *)&sta_ptr->tdls_cap.vhtcap, pos + 2,
@@ -1056,9 +1039,7 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 			break;
 		case WLAN_EID_AID:
 			if (priv->adapter->is_hw_11ac_capable) {
-				if (pos > end - 4)
-					return;
-				if (pos[1] != 2)
+				if (ie_len != sizeof(u16))
 					return;
 				sta_ptr->tdls_cap.aid =
 					get_unaligned_le16((pos + 2));
-- 
2.24.0.393.g34dc348eaf-goog

