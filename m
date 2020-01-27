Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D740414A014
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgA0Ivl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 03:51:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:31594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgA0Ivl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:51:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 00:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="231359133"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2020 00:51:38 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iw07O-000FEM-0l; Mon, 27 Jan 2020 16:51:38 +0800
Date:   Mon, 27 Jan 2020 16:51:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [RFC PATCH] rcuperf: mem_begin can be static
Message-ID: <20200127085112.4em4vfyydx6h6rf2@f53c9c00458a>
References: <20200115224225.246061-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115224225.246061-2-joel@joelfernandes.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: e4b6bfefb245 ("rcuperf: Measure memory footprint during kfree_rcu() test (v4)")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rcuperf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index c41f009acbbb5..4f642e7b25fa6 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -617,7 +617,7 @@ DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
 DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
 DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
 
-long long mem_begin;
+static long long mem_begin;
 
 static int
 kfree_perf_thread(void *arg)
