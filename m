Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23311653B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 01:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBTAme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 19:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgBTAmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:42:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3605F2465D;
        Thu, 20 Feb 2020 00:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582159353;
        bh=t55/uABbK9O7ffaPzwW71TFFyFm0ZAYQaR7QPBbTp8Q=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=HHHnNOZc4rQFLxMgfF2r4UZarXcRCAgI/hcJxvES1h3JABM0Q64+rlrNdurHb+Iqq
         mWBJ8b+LqtCsfIkmVNQ64LoQmw0wZrGYMkZHJhrExikAEfGMZB51MTrJclueXTjPnW
         XlBgI+FBtnm2b+vPDz8h1cKmcFx4kFiy1fPr6jVE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0831B3520BB6; Wed, 19 Feb 2020 16:42:33 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:42:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: drm_dp_mst_topology.c and old compilers
Message-ID: <20200220004232.GA28048@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A box with GCC 4.8.3 compiler didn't like drm_dp_mst_topology.c.  The
following (lightly tested) patch makes it happy and seems OK for newer
compilers as well.

Is this of interest?

							Thanx, Paul

-----------------------------------------------------------------------

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 20cdaf3..232408a 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -5396,7 +5396,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_port *immediate_upstream_port;
 	struct drm_dp_mst_port *fec_port;
-	struct drm_dp_desc desc = { 0 };
+	struct drm_dp_desc desc = {{{ 0 }}};
 	u8 endpoint_fec;
 	u8 endpoint_dsc;
 
