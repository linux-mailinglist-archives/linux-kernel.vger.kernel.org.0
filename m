Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39121308A5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfEaGhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 02:37:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35100 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfEaGhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so3592027plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qM4TRO7RGO2OHWNfeOV6qnzK1adlWFvgIGdmmIlZoQg=;
        b=BU0yQKmLJHu+FcfZLIg8DMoSKvvShatU9uAYACArFPZfZNfyrqNaI46ePh18bqp8lv
         aUU5ZnaATOqkQZrQMW/m9twosI5BnhpC1PKU537Esg28ddC3jukOBSR8wJhjO3Sc2oqJ
         EBGBjx+II2y2LndrrLMUaV6oD/uysclajyWi/SWLUcbpBfPr7hdDybGP/Y79ivjkJGB2
         0udNHq4wVh0I+W2JE70Dn/yidSK3xvkb4JgKH4pyuOihqs9wNb47ZH2HBN5V3dIaJo+Z
         MZqU1se7UoUCGMD/C7jU8prHACe0BStEuXz7fwtEcTs3GNsDg62jRTLvqHzZIsBEWD/X
         0SHw==
X-Gm-Message-State: APjAAAUs/8tmfafrTGB5xn3isMIh9GWMZXGelBRvqgHfTt3+3nih88Lb
        lozh3xJe3njuqph1S0vI95E=
X-Google-Smtp-Source: APXvYqzWGHujGyfLPeIxCfiUULnI9uLOj3OwWc8fFxs83AcSR6RW7rUhUD06OvJeyQPa5pAzVjP4UQ==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr178442plr.79.1559284628409;
        Thu, 30 May 2019 23:37:08 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:37:07 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>
Subject: [RFC PATCH v2 07/12] smp: Do not mark call_function_data as shared
Date:   Thu, 30 May 2019 23:36:40 -0700
Message-Id: <20190531063645.4697-8-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfd_data is marked as shared, but although it hold pointers to shared
data structures, it is private per core.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 6b411ee86ef6..f1a358f9c34c 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -33,7 +33,7 @@ struct call_function_data {
 	cpumask_var_t		cpumask_ipi;
 };
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct call_function_data, cfd_data);
+static DEFINE_PER_CPU(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
-- 
2.20.1

