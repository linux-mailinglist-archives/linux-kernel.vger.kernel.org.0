Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08E7103A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 13:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfKTMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 07:54:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727644AbfKTMyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:54:21 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9690A185A7C5B051E633;
        Wed, 20 Nov 2019 20:54:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 20:54:10 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
        <luben.tuikov@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/2] fix inappropriate use of declaring variable 'static' in fixed31_32.h
Date:   Wed, 20 Nov 2019 21:15:31 +0800
Message-ID: <20191120131533.12720-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch remove two set but not used variable.

The second patch make the variables in fixed31_32.h 'global'
instead of 'static'.

yu kuai (2):
  drm/amd/display: remove set but not used variable 'dc_fixpt_e' and
    'dc_fixpt_pi'
  drm/amd/display: make various variables in fixed31_32.h 'global'
    instead of 'static'

 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/fixed31_32.c | 13 +++++++++++++
 .../gpu/drm/amd/display/include/fixed31_32.h   | 18 ++++++++----------
 3 files changed, 22 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/fixed31_32.c

-- 
2.17.2

