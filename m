Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B768A179809
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 19:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgCDSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 13:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbgCDSgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:36:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A164920866;
        Wed,  4 Mar 2020 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583347014;
        bh=Q5zcdnLn8aFwGuFTh/7DkOTC8NTckx4eSzDvY5E0y1E=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=JYWYXyHbGO/ncCPzgBkUUpnpRqfBeqCVjch7d8VxsH0SW8CVnm2AsGQBp9GrQMAZh
         182YlsgWwKCaR/1pMuiu1HzWBb9TXYbQUJqj11/pj1k9qkGSYtj/E65zUDFjDiR8K7
         8a+pB2yya/d2xJb3a+7CgGkZaoBNKVPGgIi4+cCY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 715BC3522731; Wed,  4 Mar 2020 10:36:54 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:36:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     chris@chris-wilson.co.uk, joe@perches.com, hch@infradead.org,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        torvalds@linux-foundation.org, mingo@kernel.org, kernel-team@fb.com
Subject: [PATCH] Make drm_dp_mst_dsc_aux_for_port() safe for old compilers
Message-ID: <20200304183654.GA9011@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older compilers either want two extra pairs of curly braces around the
initializer for local variable "desc", or they want a single pair of
curly braces with nothing inside.  Current Linux-kernel practice favors
the latter, so this commit makes it so.

This is a fix for a regression introduced into v5.6-rc1.

Fixes: 5b03f9d86880 ("drm/dp_mst: Add new quirk for Synaptics MST hubs")
Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 20cdaf3..b123f60 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -5396,7 +5396,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_port *immediate_upstream_port;
 	struct drm_dp_mst_port *fec_port;
-	struct drm_dp_desc desc = { 0 };
+	struct drm_dp_desc desc = { };
 	u8 endpoint_fec;
 	u8 endpoint_dsc;
 
