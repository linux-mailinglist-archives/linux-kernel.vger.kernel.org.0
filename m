Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA7259C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfEUVR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 17:17:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:42952 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfEUVR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:17:27 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 09C8A6D9;
        Tue, 21 May 2019 21:17:27 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RFC 0/2] docs: Deal with some Sphinx deprecation warnings
Date:   Tue, 21 May 2019 15:17:12 -0600
Message-Id: <20190521211714.1395-1-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sphinx folks are deprecating some interfaces in the upcoming 2.0
release; one immediate result of that is a bunch of warnings that show up
when building with 1.8.  These two patches make those warnings go away,
but at a cost:

 - It introduces a couple of Sphinx version checks, which are always
   ugly, but the alternative would be to stop supporting versions
   before 1.7.  For now, I think we can carry that cruft.

 - The second patch causes the build to fail horribly on newer
   Sphinx installations.  The change to switch_source_input() seems
   to make the parser much more finicky, increasing warnings and
   eventually failing the build altogether.  In particular, it will
   scream about problems in .rst files that are not included in the
   TOC tree at all.  The complaints appear to be legitimate, but it's
   a bunch of stuff to clean up.

I've tested these with 1.4 and 1.8, but not various versions in between.

Jonathan Corbet (2):
  doc: Cope with Sphinx logging deprecations
  doc: Cope with the deprecation of AutoReporter

 Documentation/sphinx/kerneldoc.py | 48 ++++++++++++++++++++++++-------
 Documentation/sphinx/kernellog.py | 28 ++++++++++++++++++
 Documentation/sphinx/kfigure.py   | 38 +++++++++++++-----------
 3 files changed, 87 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/sphinx/kernellog.py

-- 
2.21.0

