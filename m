Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141D7197278
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgC3Cdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:33:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41046 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgC3Cde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so13899105qtv.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9u1d7Nq8RT0AOHNZvylOBJ81hqFkLhdoH0L2zGb794=;
        b=rxDfrhuk8LqW6ZnmW+LnImOtpzM2Zw9S69J/P+yG2hd6Vw5mMl8yBevuQ6ntcQkpt1
         6sS/aa7qsRAXfO8SA/uVHNRUM3XnlchLsYPPO6idkXfPZNHXzbwNfmaWP7vJXU7yG8GR
         cAXpIptCUsYctVOx9/SD1kmPf6JJ5CIL5InT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9u1d7Nq8RT0AOHNZvylOBJ81hqFkLhdoH0L2zGb794=;
        b=TYdcxqH/rInnAM99iMlN/MNOmLIgM0VK49oajPQB7+5Anwo9V+Vz3OOg/EvNpuBZoY
         pend074SMm+wlOz/LnfHV93EgnSJPDqvRJpCft6sY7+QJWheIFyl2AkwGFI9KPNdrKLY
         qYPAPkJ9mGMaYTS6yMonkTaSH7IlLoo1fuM3mSRyXrOP3y1kRWqmO0BYocNx/8gzssj3
         zIMpj6BRnRxYakkEK6eLMKBybYbjkSDFcTDCd7a+q5ocU286zRmae1DkYIV4HijCNKls
         ZsqBUxgvuxBtW8NiMqmkZztWfbpUtMAoc91+1nSGzme7uLtlOshJl5KJNGsJCUh3tsne
         Z7IA==
X-Gm-Message-State: ANhLgQ1S6ke77a1w8RrMCNAhkcVcQ4KtPkhWbY/U0NibopEhJbC5eV7z
        Z2EMi6QMYbPJKeYJwdxiAp01arH2Z34=
X-Google-Smtp-Source: ADFU+vtJ/nFZMvAXPR8p2akuS9nHt322wcY7VnnK+V09LMOq6oHXy/eGbZOe0mEFY2W1AiDcgsCNJg==
X-Received: by 2002:ac8:72ce:: with SMTP id o14mr10086333qtp.226.1585535612029;
        Sun, 29 Mar 2020 19:33:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 01/18] mm/list_lru.c: Rename kvfree_rcu() to local variant
Date:   Sun, 29 Mar 2020 22:32:31 -0400
Message-Id: <20200330023248.164994-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Rename kvfree_rcu() function to the kvfree_rcu_local()
one. The aim is to introduce the public API that would
conflict with this one.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/list_lru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f36..386424688f805 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -383,14 +383,14 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
 	struct list_lru_memcg *memcg_lrus;
 	/*
 	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu().
+	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
 	 */
 	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
 	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
 	kvfree(memcg_lrus);
 }
 
-static void kvfree_rcu(struct rcu_head *head)
+static void kvfree_rcu_local(struct rcu_head *head)
 {
 	struct list_lru_memcg *mlru;
 
@@ -429,7 +429,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu);
+	call_rcu(&old->rcu, kvfree_rcu_local);
 	return 0;
 }
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

