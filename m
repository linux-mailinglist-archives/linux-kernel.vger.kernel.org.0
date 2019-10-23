Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB0E1C92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405881AbfJWN14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:27:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405872AbfJWN1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:27:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 339D1C4DD676861ED316;
        Wed, 23 Oct 2019 21:27:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:27:38 +0800
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] audit: remove redundant condition check in kauditd_thread()
Message-ID: <7869bb43-5cb1-270a-07d1-31574595e13e@huawei.com>
Date:   Wed, 23 Oct 2019 21:27:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning is found by the code analysis tool:
  "the condition 'if(ac && rc < 0)' is redundant: ac"

The @ac variable has been checked before. It can't be a null pointer
here, so remove the redundant condition check.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..193f3a1f4425 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -830,7 +830,7 @@ static int kauditd_thread(void *dummy)
 		rc = kauditd_send_queue(sk, portid,
 					&audit_hold_queue, UNICAST_RETRIES,
 					NULL, kauditd_rehold_skb);
-		if (ac && rc < 0) {
+		if (rc < 0) {
 			sk = NULL;
 			auditd_reset(ac);
 			goto main_queue;
@@ -840,7 +840,7 @@ static int kauditd_thread(void *dummy)
 		rc = kauditd_send_queue(sk, portid,
 					&audit_retry_queue, UNICAST_RETRIES,
 					NULL, kauditd_hold_skb);
-		if (ac && rc < 0) {
+		if (rc < 0) {
 			sk = NULL;
 			auditd_reset(ac);
 			goto main_queue;
-- 
2.7.4.3

