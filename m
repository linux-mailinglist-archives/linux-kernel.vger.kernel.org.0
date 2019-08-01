Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8367E4DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbfHAVju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 17:39:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38698 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389246AbfHAVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so32739368plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPjVOzxIWhoZ3jLWyfF8eHht0ZmcYW+YAayCLY421Ko=;
        b=bAFcHM5KTORiEFTKFSUQ+5+sIca8SaUzn3leRYT0Ei0ZsrKsFvUA3lZffQDpSAr2Jm
         hoTvRZneyQdSX03A734GsBP04VvIfBKL47LtsWwrikydtYva+Lj1KaRVdAl2Jkolz5l+
         o2YP/pVjOZ0XtkfyBMnV2BXHm5sdfjQFsMCT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPjVOzxIWhoZ3jLWyfF8eHht0ZmcYW+YAayCLY421Ko=;
        b=n24mP3L4Lt04eBckMot6S33WWuG/sqVFtAkSEh1NPlDboHBdl/X/NM2OQJk5F7Fgzt
         NomxsndDwhalrGc6JHzvUJ8EqZuDlJj3U6vvF9Mwb4uXzv6v19v6Z9xlKTzXC5ojqFll
         sd+yZW2R9EsSxg9LDpY47/LD1Fo8WIXcTE4hwL5xAtDn/tK2c/NWJ9J2fzp/0imuVLtE
         PH9sOfT+exEG8Z584xKAiLeTd/str07mgO2nKVwktS8Z3uehsvA8Mj3Esz9ZhTL7PQvT
         P7+yLRn7QaQKYstWGALtAoaOJoNzHHLfB1mUgxIfmHxbK1wcUm28C82EXA/8OMFfLh1K
         ETOQ==
X-Gm-Message-State: APjAAAVaUxtnJZUcu0wWfoehjAX3Wd8+myyCkHehN2Wfm3ioeagMOnT5
        zSAZd/brNoTcfQ9XyRMdDBvpi5UI
X-Google-Smtp-Source: APXvYqwzpOdKb1CkE9Av2YhdeBi81Sd7MLH0rkz7iJzyrLqIuBXqJGuSO49DxQvQP0BohWXdHyZ/6g==
X-Received: by 2002:a17:902:e4:: with SMTP id a91mr31494499pla.150.1564695585474;
        Thu, 01 Aug 2019 14:39:45 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:44 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: ['PATCH v2' 6/7] Restore docs "treewide: Rename rcu_dereference_raw_notrace() to _check()"
Date:   Thu,  1 Aug 2019 17:39:21 -0400
Message-Id: <20190801213922.158860-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
References: <20190801213922.158860-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This restores docs back in ReST format.
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a33b5fb331b4..0b222469d7ce 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1997,7 +1997,7 @@ Tracing and RCU
 ~~~~~~~~~~~~~~~
 
 It is possible to use tracing on RCU code, but tracing itself uses RCU.
-For this reason, ``rcu_dereference_raw_notrace()`` is provided for use
+For this reason, ``rcu_dereference_raw_check()`` is provided for use
 by tracing, which avoids the destructive recursion that could otherwise
 ensue. This API is also used by virtualization in some architectures,
 where RCU readers execute in environments in which tracing cannot be
-- 
2.22.0.770.g0f2c4a37fd-goog

