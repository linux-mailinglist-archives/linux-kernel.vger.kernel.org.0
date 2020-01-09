Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD8135F02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 18:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgAIROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 12:14:12 -0500
Received: from www413.your-server.de ([88.198.28.140]:39444 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbgAIROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O3sWLg9hXmPWCaRpEux+8egZoPW0W6HONbIvuu6mIFE=; b=iZgh73mdaks3w6sVK2gpdKGd8E
        HEeg3ZiO/sVeOMs2VxQ2S8PqMBz2/oAX15QYPTXZoQu9eAsmxa4Wed0hcZGsRSZCZMpV49vtzqdtQ
        yyuoflGIhwqyPnL5VTozoaEgyKSi3H1x2NGYC7oIUgMae65s7Jb8THu6ec/CV1xxveDfhfhno3x3/
        eRoas/GgD4HaqdRSc0wxeus8ZGvDCkkmWNLIMqgZ7OlMOUDZogF1F+yCSBBum0Ab5KQlJfcj7WD0I
        W278M40RdkY5Ogg2iXGP1UnKiRFu9B1Vr5H7EJzdbTWOaIhpfT+n2gkGmu9xlObI7tSNnUlLGFoLn
        nsddFRSg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ipbNp-0002Un-F3; Thu, 09 Jan 2020 18:14:09 +0100
Received: from [24.134.37.229] (helo=192-168-0-109.rdsnet.ro)
        by sslproxy02.your-server.de with esmtpsa (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4.92)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ipbNp-000Dxc-66; Thu, 09 Jan 2020 18:14:09 +0100
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     intel-gvt-dev@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhiyuan.lv@intel.com, hang.yuan@intel.com,
        Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: [RFC PATCH 0/4] Support for out-of-tree hypervisor modules in i915/gvt
Date:   Thu,  9 Jan 2020 19:13:53 +0200
Message-Id: <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
References: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25689/Thu Jan  9 10:59:33 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series removes the dependency of i915/gvt hypervisor
backends on the driver internals of the i915 driver. Instead, we add a
small public API that hypervisor backends can use.

This enables out-of-tree hypervisor backends for the Intel graphics
virtualization and simplifies development. At the same time, it
creates at least a bit of a barrier to including more i915 internals
into kvmgt, which is nice in itself.

The first two patches are pretty much general cleanup and could be
merged without the rest.

Any feedback is welcome.

Julian Stecklina (4):
  drm/i915/gvt: make gvt oblivious of kvmgt data structures
  drm/i915/gvt: remove unused vblank_done completion
  drm/i915/gvt: define a public interface to gvt
  drm/i915/gvt: move public gvt headers out into global include

 drivers/gpu/drm/i915/gvt/Makefile             |   2 +-
 drivers/gpu/drm/i915/gvt/debug.h              |   2 +-
 drivers/gpu/drm/i915/gvt/display.c            |  26 ++
 drivers/gpu/drm/i915/gvt/display.h            |  27 --
 drivers/gpu/drm/i915/gvt/gtt.h                |   2 -
 drivers/gpu/drm/i915/gvt/gvt.h                |  65 +--
 drivers/gpu/drm/i915/gvt/gvt_public.c         | 154 +++++++
 drivers/gpu/drm/i915/gvt/kvmgt.c              | 413 ++++++++++--------
 drivers/gpu/drm/i915/gvt/mpt.h                |   3 -
 drivers/gpu/drm/i915/gvt/reg.h                |   2 -
 include/drm/i915_gvt.h                        | 104 +++++
 .../drm/i915_gvt_hypercall.h                  |  13 +-
 12 files changed, 537 insertions(+), 276 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gvt/gvt_public.c
 create mode 100644 include/drm/i915_gvt.h
 rename drivers/gpu/drm/i915/gvt/hypercall.h => include/drm/i915_gvt_hypercall.h (92%)

-- 
2.24.1

