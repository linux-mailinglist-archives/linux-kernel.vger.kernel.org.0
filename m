Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA566EE0DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 14:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfKDNUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 08:20:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfKDNUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:20:11 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E3228FD945005EE6D30;
        Mon,  4 Nov 2019 21:20:09 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 21:20:02 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
        <luben.tuikov@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/7] fix various gcc warnings
Date:   Mon, 4 Nov 2019 21:27:19 +0800
Message-ID: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes various gcc warnings. 

yu kuai (7):
  drm/amdgpu: remove 4 set but not used variable in
    amdgpu_atombios_get_connector_info_from_object_table
  drm/amdgpu: add function parameter description in
    'amdgpu_device_set_cg_state'
  drm/amdgpu: add function parameter description in 'amdgpu_gart_bind'
  drm/amdgpu: remove set but not used variable 'dig_connector'
  drm/amdgpu: remove set but not used variable 'dig'
  drm/amdgpu: remove always false comparison in
    'amdgpu_atombios_i2c_process_i2c_ch'
  drm/amdgpu: remove set but not used variable 'mc_shared_chmap'

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 20 ++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c    |  5 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c        |  3 +--
 6 files changed, 5 insertions(+), 30 deletions(-)

-- 
2.7.4

