Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0E16BA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgBYHQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 02:16:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:17888 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYHQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:16:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 23:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="230068129"
Received: from plaxmina-desktop.iind.intel.com ([10.145.162.62])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2020 23:16:25 -0800
From:   Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To:     jani.nikula@linux.intel.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        ville.syrjala@linux.intel.com, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        mripard@kernel.org, mihail.atanassov@arm.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     pankaj.laxminarayan.bharadiya@intel.com,
        linux-kernel@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: [RFC][PATCH 2/5] drm/drm-kms.rst: Add Scaling filter property documentation
Date:   Tue, 25 Feb 2020 12:35:42 +0530
Message-Id: <20200225070545.4482-3-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for newly introduced KMS scaling filter property.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 Documentation/gpu/drm-kms.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 906771e03103..7b71a1e3edda 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -509,6 +509,12 @@ Variable Refresh Properties
 .. kernel-doc:: drivers/gpu/drm/drm_connector.c
    :doc: Variable refresh properties
 
+Scaling Filter Property
+-----------------------
+
+.. kernel-doc:: drivers/gpu/drm/drm_plane.c
+   :doc: Scaling filter property
+
 Existing KMS Properties
 -----------------------
 
-- 
2.23.0

