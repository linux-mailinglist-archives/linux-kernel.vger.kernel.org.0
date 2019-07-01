Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA84AF16
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 02:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFSAiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 20:38:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFSAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:38:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so8610071pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bAA7Iv6CnrCeifP2aG7kS9Z8x5uPv9BIfdgSK9PbnqA=;
        b=I9IiVzVeALSA4kcf+/maRv777/NKbSNAmfg3irJ/EqDxJKiD9e4zRl9A24+Cwm/I7h
         m3PT8QWnXzb3e/vWTdmJJPCxHehZ9VBV98THDWfdjRXKi+Hk/qNmheFibDvPkQ2L5R9I
         MGlcx64lE80y3MJEaC+30id40o66M7zBhfbFAOg0l9KSSZT8a/mMCak/MEb+udf+LgxV
         FyuK6WimhQTfTQkY5QZDliRUfP/wufhYsPHyxPBv4sObukcuN173TnOQed4aZp35k6Kf
         aaAy18oHolwHIIQedPvlRvcM0EMXbWMT9KpDnZAmzZp86OYAL0leJtepRsCUXYQGYI6C
         PA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bAA7Iv6CnrCeifP2aG7kS9Z8x5uPv9BIfdgSK9PbnqA=;
        b=IjbCU6QBF7Y0Pyenz/0ERy0yhhdYD++Uf2mbd2h/6TV02EuRYYZAjBs810ONELqEzP
         Xy9dojWXo9GlTg6suKSCDJQZutsd8zcvXjHGQ7h3PfNuUOhx0x7++yYvJVBob431yJB7
         lE4cKkXUO7xKhhpSK/pJ65S2vH88aCfQeYXXLexJGNu8q3BMRRWK1z/+ihrOu/b/nwjZ
         Nhvl3KBoKafEUmO6qpKrEOCX/XtDOMP4hb5t0uBARkiv/3oYtoW/YjCKRkoBW0N1lbXy
         xKgPbmao1bNq3BcqEjNJ87a0FpyjXSssZwNOnu7EBcYu4HNOG04YunYOOw6RxLWdFbJ0
         DkKw==
X-Gm-Message-State: APjAAAWwUyKlpphdA46eJf+vxbEHwiOFYLEncrKlwwHsR760a+IRgEq3
        E/0xqXT95+rvASOHCm7A3fc=
X-Google-Smtp-Source: APXvYqzFZgIy8rv3ts6tIg2xPdQ5vI1HfznpT5bx/4cDNVZPUBTzFkCXHFLGjyzt9q6KbmoJfWAWSg==
X-Received: by 2002:a65:534c:: with SMTP id w12mr5221251pgr.431.1560904693879;
        Tue, 18 Jun 2019 17:38:13 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id x26sm14217860pfq.69.2019.06.18.17.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jun 2019 17:38:13 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v4 2/3] staging: rtl8723bs: Resolve the checkpatch error: else should follow close brace '}'
Date:   Tue, 18 Jun 2019 17:37:33 -0700
Message-Id: <3faf32eea0b1e877c1a79e0ab431d11bb76d5793.1560903975.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560903975.git.shobhitkukreti@gmail.com>
References: <20190618070019.GA20601@kroah.com>
 <cover.1560903975.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1560903975.git.shobhitkukreti@gmail.com>
References: <cover.1560903975.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up the code to resolve the checkpatch error else should follow
close brace '}' from the following files:

mlme_linux.c
recv_linux.c
sdio_intf.c

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  6 ++----
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 21 +++++++--------------
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  9 +++------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 4bccfd6..52a5b31 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -48,8 +48,7 @@ void rtw_os_indicate_connect(struct adapter *adapter)
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		rtw_cfg80211_ibss_indicate_connect(adapter);
-	}
-	else
+	} else
 		rtw_cfg80211_indicate_connect(adapter);
 
 	rtw_indicate_wx_assoc_event(adapter);
@@ -104,8 +103,7 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
 
-	}
-	else {
+	} else {
 		/* reset values in securitypriv */
 		/* if (adapter->mlmepriv.fw_state & WIFI_STATION_STATE) */
 		/*  */
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 17c5199..746f074 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -62,15 +62,13 @@ _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8
 	if (sub_skb) {
 		skb_reserve(sub_skb, 12);
 		skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
-	}
-	else {
+	} else {
 		sub_skb = rtw_skb_clone(prframe->u.hdr.pkt);
 		if (sub_skb) {
 			sub_skb->data = pdata + ETH_HLEN;
 			sub_skb->len = nSubframe_Length;
 			skb_set_tail_pointer(sub_skb, nSubframe_Length);
-		}
-		else {
+		} else {
 			DBG_871X("%s(): rtw_skb_clone() Fail!!!\n", __func__);
 			return NULL;
 		}
@@ -142,8 +140,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 						return;
 					}
 				}
-			}
-			else {
+			} else {
 				/*  to APself */
 				/* DBG_871X("to APSelf\n"); */
 				DBG_COUNTER(padapter->rx_logs.os_indicate_ap_self);
@@ -182,24 +179,21 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 
 	if (psecuritypriv->last_mic_err_time == 0) {
 		psecuritypriv->last_mic_err_time = jiffies;
-	}
-	else {
+	} else {
 		cur_time = jiffies;
 
 		if (cur_time - psecuritypriv->last_mic_err_time < 60*HZ) {
 			psecuritypriv->btkip_countermeasure = true;
 			psecuritypriv->last_mic_err_time = 0;
 			psecuritypriv->btkip_countermeasure_time = cur_time;
-		}
-		else {
+		} else {
 			psecuritypriv->last_mic_err_time = jiffies;
 		}
 	}
 
 	if (bgroup) {
 		key_type |= NL80211_KEYTYPE_GROUP;
-	}
-	else {
+	} else {
 		key_type |= NL80211_KEYTYPE_PAIRWISE;
 	}
 
@@ -209,8 +203,7 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 	memset(&ev, 0x00, sizeof(ev));
 	if (bgroup) {
 	    ev.flags |= IW_MICFAILURE_GROUP;
-	}
-	else {
+	} else {
 	    ev.flags |= IW_MICFAILURE_PAIRWISE;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index c60f13c..9c408d9 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -88,8 +88,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
 		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
-	}
-	else {
+	} else {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_cnt++;
 		dvobj->irq_alloc = 1;
 	}
@@ -115,8 +114,7 @@ static void sdio_free_irq(struct dvobj_priv *dvobj)
             if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
 				DBG_871X_LEVEL(_drv_err_,"%s: sdio_release_irq FAIL(%d)!\n", __func__, err);
-            }
-            else
+            } else
 		dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
             sdio_release_host(func);
         }
@@ -232,8 +230,7 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 			if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
 				DBG_8192C(KERN_ERR "%s: sdio_release_irq(%d)\n", __func__, err);
-			}
-			else
+			} else
 				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
 		}
 
-- 
2.7.4

