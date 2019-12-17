Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBD122F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfLQO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 09:58:12 -0500
Received: from relay2.marples.name ([77.68.23.143]:60032 "EHLO
        relay2.marples.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:58:12 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 09:58:11 EST
Received: from mail.marples.name (cpc115040-bour7-2-0-cust370.15-1.cable.virginm.net [81.108.15.115])
        by relay2.marples.name (Postfix) with ESMTPS id 62A247A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:50:52 +0000 (UTC)
Received: from [10.73.1.30] (unknown [10.73.1.30])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.marples.name (Postfix) with ESMTPSA id D263D1CD553;
        Tue, 17 Dec 2019 14:48:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marples.name;
        s=mail; t=1576594131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yKLrOljADJd251/sjY/sg9T0uYP7Yoc26fkVr1L8qFc=;
        b=u56qz470AjUPEoEJc49mAj8vRRKL+MOMzk5K6aDGI+2z7nKGo1hjoJ1fwGe5+4iA/TryV8
        VMhz5+FeAp8EF5kgEsvyimOuKNHN/hXraYLhIuZ7ukiXrg1bGDFRUz8pzZQsO/9IYXG510
        hvxsclAkbYCZYohFziFOPk3X8Tqe5so=
To:     linux-kernel@vger.kernel.org
From:   Roy Marples <roy@marples.name>
Subject: [PATCH] netlink: Align NLA_ALIGNTO with the other ALIGNTO macros
Cc:     akpm@linux-foundation.org, trivial@kernel.org
Message-ID: <cf7912dd-3352-84d9-653a-86dcc1696a62@marples.name>
Date:   Tue, 17 Dec 2019 14:50:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids sign conversion errors.

Signed-off-by: Roy Marples <roy@marples.name>

diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index 0a4d73317759..c9ed05f14005 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -227,7 +227,7 @@ struct nlattr {
  #define NLA_F_NET_BYTEORDER    (1 << 14)
  #define NLA_TYPE_MASK          ~(NLA_F_NESTED | NLA_F_NET_BYTEORDER)

-#define NLA_ALIGNTO            4
+#define NLA_ALIGNTO            4U
  #define NLA_ALIGN(len)         (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
  #define NLA_HDRLEN             ((int) NLA_ALIGN(sizeof(struct nlattr)))

