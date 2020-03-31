Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4261F19A04A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgCaU57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 16:57:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731098AbgCaU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585688276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qXwJ6P01usnj3n8GpAUGcfZ6SN4qPkwbrrUG0deRB5k=;
        b=BdNnGkFMPR2iTd0aYUaEuwFF0hH+PVgHUvZKoZzIjp0JxKkT3G/SOn8jtvANusvn94jbky
        lq+iu6cVKAB0TlxqoHnp4ZuhwhNTFKtK0iQi0MQ26tgLkVzXILPltpGzQjEkS9aDSot8XN
        cBhHv8Q4MnEYQbJJ6CauX0bMQH2kpR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Dif1_LD1PJSp7HZe4pV2Ng-1; Tue, 31 Mar 2020 16:57:49 -0400
X-MC-Unique: Dif1_LD1PJSp7HZe4pV2Ng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D22468018D1;
        Tue, 31 Mar 2020 20:57:46 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B05D97B19;
        Tue, 31 Mar 2020 20:57:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     "Pankaj Bharadiya" <pankaj.laxminarayan.bharadiya@intel.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        "Mikita Lipski" <mikita.lipski@amd.com>,
        "David Airlie" <airlied@linux.ie>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David Francis" <david.francis@amd.com>,
        linux-kernel@vger.kernel.org,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        "Bhawanpreet Lakha" <bhawanpreet.lakha@amd.com>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Wenjing Liu" <wenjing.liu@amd.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Rodrigo Siqueira" <rodrigo.siqueira@amd.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>
Subject: [PATCH 0/4] drm/dp_mst: Remove ->destroy_connector() callback
Date:   Tue, 31 Mar 2020 16:57:33 -0400
Message-Id: <20200331205740.135525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This finishes up the work that Pankaj Bharadiya started in:

https://patchwork.freedesktop.org/series/74412/

And allows us to entirely remove ->destroy_connector()

Lyude Paul (4):
  drm/amd/amdgpu_dm/mst: Remove unneeded edid assignment when destroying
    connectors
  drm/amd/amdgpu_dm/mst: Remove ->destroy_connector() callback
  drm/amd/amdgpu_dm/mst: Stop printing extra messages in
    dm_dp_add_mst_connector()
  drm/dp_mst: Remove drm_dp_mst_topology_cbs.destroy_connector

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 45 +++++--------------
 drivers/gpu/drm/drm_dp_mst_topology.c         | 16 ++-----
 include/drm/drm_dp_mst_helper.h               |  2 -
 3 files changed, 15 insertions(+), 48 deletions(-)

--=20
2.25.1

